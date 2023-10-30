import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:recardify/idea.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

class CreateIdea extends StatefulWidget {
    const CreateIdea({super.key});

    @override
    State<StatefulWidget> createState() => _CreateIdeaState();
}

class _CreateIdeaState extends State<CreateIdea> {
    int _count = 1; // number of steps to start with
    int _boxSize = 1;
    String _selectedValue = 'Small';
    static const _maxAllowedSteps = 10;
    static const _submitChannel = MethodChannel('recardify.dev/submit-idea'); // communicate to java code
    final List<TextEditingController> _controllersList = [];
    final List<ImageInfo?> _images = [null];
    final List<bool> _selectedImages = [false];
    final _materialsController = TextEditingController();
    final _titleController = TextEditingController();
    final _timeForCraftingController = TextEditingController();

    void _addStep() {
        // max steps count = 10
        if (_count == _maxAllowedSteps) {
            return;
        }

        setState(() {
            _count++;
        });
    }

    void _deleteStep() {
        // you cannot delete first step
        if (_count == 1) {
            return;
        }

        setState(() {
            _count--;
            _clearStepInput(_count - 1);
        });
    }

    void _preViewImage(int index) async {
        ImageInfo img = await ImageInfo.getImageFromCamera();
        bool imgSel = true;

        if (img.image == null) {
            imgSel = false;
        }

        setState(() {
            _images[index] = img;
            _selectedImages[index] = imgSel;
        });
    }

    void _collectData() {
        final idea = Idea(
            title: _titleController.text,
            timeForCrafting: int.parse(_timeForCraftingController.text),
            boxSize: _boxSize,
            rating: 0,
            timesRated: 0,
            materialsNeeded: <String>[],
            steps: <String>[],
            imagesBase64: <String>[]
        );

        _controllersList.forEach((controller) {
            if (controller.text.isNotEmpty) {
                idea.steps.add(controller.text);
            }
        });

        _images.forEach((image) {
            if (image != null) {
                print(image.imageBase64);
                idea.imagesBase64.add(image.imageBase64);
            }
        });

        if (idea.steps.isEmpty) {
            // pop-up
            return;
        }

        RegExp regex = RegExp(r'[^,]+');
        Iterable<RegExpMatch> matches = regex.allMatches(_materialsController.text);

        // Iterate through the matches and extract the text
        for (RegExpMatch match in matches) {
            String extractedText = match.group(0)!;
            idea.materialsNeeded.add(extractedText);
        }

        // check first if there are any symbols other than plain text, commas or whitespaces
        // regex for that: [^A-Za-z, \t]
        _submitIdea(idea.toJson());
    }

    Future<void> _submitIdea(Map<String, dynamic> idea) async {
        try {
            await _submitChannel.invokeMethod('submitIdea', json.encode(idea));
        } on PlatformException catch (e) {
            // pop-up for error
        }

        setState(() {
            _clearInput();
        });
    }

    // clear input while preserving first n fields
    void _clearInput() {
        for (int i = 0; i < _count; i++) {
            _clearStepInput(i);
        }

        _images[0] = null;
        _selectedImages[0] = false;
        _materialsController.text = '';
        _titleController.text = '';
        _selectedValue = 'Small';
        _timeForCraftingController.text = '';
    }

    void _clearStepInput(int index) {
        _controllersList[index].text = '';
        _images[index + 1] = null;
        _selectedImages[index + 1] = false;
    }

    @override
    Widget build(BuildContext context) {
        for (int j = 0; j < _count; j++) {
            _controllersList.add(TextEditingController());
            _selectedImages.add(false);
            _images.add(null);
        }

        return Scaffold(
            body: Center(
                child: ListView(
                    children: <Widget>[
                        Column(
                            children: <Widget>[
                                Center(
                                    child: Container(
                                        margin: const EdgeInsets.only(top: 20),
                                        child: const Text(
                                            'Create Your Idea',
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold
                                            )
                                        )
                                    )
                                ),
                                Container(
                                    margin: const EdgeInsets.only(top: 30),
                                    child:  Row(
                                        children: <Widget>[
                                            Expanded(
                                                child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: <Widget>[
                                                        const Text('Title', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                                        Container(
                                                            width: 100,
                                                            height: 50,
                                                            margin: const EdgeInsets.only(top: 5),
                                                            child: TextField(
                                                                controller: _titleController,
                                                                decoration: InputDecoration(
                                                                    filled: true,
                                                                    fillColor: const Color(0xffd5dcdc),
                                                                    labelText: 'Add Title',
                                                                    border: OutlineInputBorder(
                                                                        borderRadius: BorderRadius.circular(10) // Rounded corners
                                                                    )
                                                                )
                                                            )
                                                        )
                                                    ]
                                                )
                                            ),
                                            Expanded(
                                                child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: <Widget>[
                                                        const Text('Box Size', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                                        Container(
                                                            margin: const EdgeInsets.only(top: 5),
                                                            child: DropdownButton<String>(
                                                                value: _selectedValue,
                                                                items: ['Small', 'Medium', 'Large'].map<DropdownMenuItem<String>>((String value) {
                                                                    return DropdownMenuItem<String>(
                                                                        value: value,
                                                                        child: Text(value)
                                                                    );
                                                                }).toList(),
                                                                onChanged: (String? value) {
                                                                    setState(() {
                                                                        switch (value!) {
                                                                            case 'Small':
                                                                               _boxSize = 1;
                                                                               break;
                                                                            case 'Medium':
                                                                               _boxSize = 2;
                                                                                break;
                                                                            case 'Large':
                                                                               _boxSize = 3;
                                                                                break;
                                                                            default:
                                                                                break;
                                                                        }
                                                                        _selectedValue = value;
                                                                    });
                                                                }
                                                            )
                                                        )
                                                    ]
                                                )
                                            ),
                                            Expanded(
                                                child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: <Widget>[
                                                      const Text('Time for crafting', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                                      Container(
                                                          margin: const EdgeInsets.only(top: 5),
                                                          width: 100,
                                                          height: 50,
                                                          child: TextField(
                                                              controller: _timeForCraftingController,
                                                              decoration: InputDecoration(
                                                                  filled: true,
                                                                  fillColor: const Color(0xffd5dcdc),
                                                                  labelText: 'Add Time',
                                                                  border: OutlineInputBorder(
                                                                      borderRadius: BorderRadius.circular(10) // Rounded corners
                                                                  )
                                                              )
                                                          )
                                                      )
                                                    ]
                                                )
                                            )
                                        ]
                                    )
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center, // Center the children horizontally
                                    children: [
                                        Column(
                                            children: <Widget>[
                                                if (_selectedImages[0])
                                                    GestureDetector(
                                                        onTap: () async {
                                                            _preViewImage(0);
                                                        },
                                                        child: Container(
                                                            width: 150,
                                                            height: 150,
                                                            margin: const EdgeInsets.only(top: 30),
                                                            child: ClipRRect(
                                                                borderRadius: BorderRadius.circular(10), // Rounded corners
                                                                child: Image(
                                                                    image: _images[0]!.getImageProvider(), // Replace with your image asset
                                                                    width: 150, // Set the desired width
                                                                    height: 150, // Set the desired height
                                                                    fit: BoxFit.cover // Ensure the image covers the entire container
                                                                )
                                                            )
                                                        )
                                                    )
                                                else
                                                    Container(
                                                        width: 150,
                                                        height: 150,
                                                        margin: const EdgeInsets.only(top: 30),
                                                        decoration: BoxDecoration(
                                                            color: Color(0xffc0c49b),
                                                            borderRadius: BorderRadius.circular(10) // Rounded corners
                                                        ),
                                                        child: ElevatedButton(
                                                            onPressed: () async {
                                                                _preViewImage(0);
                                                            },
                                                            style: ButtonStyle(
                                                                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                                                                elevation: MaterialStateProperty.all(0) // No shadow
                                                            ),
                                                            child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: <Widget>[
                                                                    IconButton(
                                                                        onPressed: () async {
                                                                           _preViewImage(0);
                                                                        },
                                                                        icon: const Icon(Icons.add, size: 24, color: Colors.white)
                                                                    ),
                                                                    if (!_selectedImages[0])
                                                                        const Text('Add Image', style: TextStyle(color: Colors.white))
                                                                ]
                                                            )
                                                        )
                                                    )
                                            ]
                                        ),
                                        const SizedBox(
                                            width: 8
                                        ),
                                        Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[
                                                const Text('Materials Needed', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                                SizedBox(
                                                    width: 180,
                                                    height: 100,
                                                    child: TextField(
                                                        controller: _materialsController,
                                                        decoration: InputDecoration(
                                                            filled: true,
                                                            fillColor: const Color(0xffd5dcdc),
                                                            labelText: 'Add Materials',
                                                            border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(10) // Rounded corners
                                                            )
                                                        )
                                                    )
                                                )
                                            ]
                                        )
                                    ]
                                ),
                                for (int i = 1; i <= _count; i++)
                                    Container(
                                        margin: const EdgeInsets.only(top: 20),
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center, // Center the children horizontally
                                            children: [
                                                Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                        Text("Step $i", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                                        if (_selectedImages[i])
                                                            GestureDetector(
                                                                onTap: () async {
                                                                    _preViewImage(i);
                                                                },
                                                                child: Container(
                                                                    width: 100,
                                                                    height: 100,
                                                                    margin: const EdgeInsets.only(top: 15),
                                                                    child: ClipRRect(
                                                                        borderRadius: BorderRadius.circular(10), // Rounded corners
                                                                        child: Image(
                                                                            image: _images[i]!.getImageProvider(), // Replace with your image asset
                                                                            width: 150, // Set the desired width
                                                                            height: 150, // Set the desired height
                                                                            fit: BoxFit.cover // Ensure the image covers the entire container
                                                                        )
                                                                    )
                                                                )
                                                            )
                                                        else
                                                            Container(
                                                                width: 100,
                                                                height: 100,
                                                                margin: const EdgeInsets.only(top: 15),
                                                                decoration: BoxDecoration(
                                                                    color: Color(0xffc0c49b),
                                                                    borderRadius: BorderRadius.circular(10) // Rounded corners
                                                                ),
                                                                child: ElevatedButton(
                                                                    onPressed: () {
                                                                        _preViewImage(i);
                                                                    },
                                                                    style: ButtonStyle(
                                                                        backgroundColor: MaterialStateProperty.all(Colors.transparent),
                                                                        elevation: MaterialStateProperty.all(0) // No shadow
                                                                    ),
                                                                    child: Column(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: <Widget>[
                                                                          IconButton(
                                                                              onPressed: () {
                                                                                  _preViewImage(i);
                                                                              },
                                                                              icon: const Icon(Icons.add, size: 24, color: Colors.white)
                                                                          ),
                                                                          if (!_selectedImages[i])
                                                                              const Text('Add Image', style: TextStyle(fontSize: 12))
                                                                        ]
                                                                    )
                                                                )
                                                            )
                                                    ]
                                                ),
                                                const SizedBox(
                                                    width: 8
                                                ),
                                                Column(
                                                    children: <Widget>[
                                                      SizedBox(
                                                          width: 200,
                                                          height: 60,
                                                          child: TextField(
                                                              controller: _controllersList[i - 1],
                                                              decoration: InputDecoration(
                                                                  filled: true,
                                                                  fillColor: Color(0xffd5dcdc),
                                                                  labelText: 'Add Instructions',
                                                                  border: OutlineInputBorder(
                                                                      borderRadius: BorderRadius.circular(10) // Rounded corners
                                                                  )
                                                              )
                                                          )
                                                      )
                                                    ]
                                                )
                                            ]
                                        )
                                    ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                        IconButton(
                                            onPressed: () {
                                                _addStep();
                                            },
                                            icon: const Icon(Icons.add, size: 24, color: Color(0xffc0c49b))
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                                _addStep();
                                            },
                                            child: const Text('Add Step')
                                        ),
                                        IconButton(
                                            onPressed: () {
                                                _deleteStep();
                                            },
                                            icon: const Icon(Icons.delete, size: 24, color: Colors.red)
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                                _deleteStep();
                                            },
                                            child: const Text('Remove Step')
                                        )
                                    ]
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xffc0c49b), // Set the button's background color to blue
                                        foregroundColor: Colors.white, // Set the text color to white
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), // Adjust the button's border radius
                                        elevation: 5, // Add a slight elevation to the button
                                    ),
                                    onPressed: () {
                                        _collectData();
                                    },
                                    child: const Padding(
                                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                                        child: Text('Submit',
                                            style: TextStyle(
                                                fontSize: 18, // Adjust the text size
                                                fontWeight: FontWeight.bold // Make the text bold
                                            )
                                        )
                                    )
                                ),
                                const Row(
                                    children: <Widget>[
                                        SizedBox(
                                            width: 10,
                                            height: 20
                                        )
                                    ]
                                )
                            ]
                        )
                    ]
                )
            )
        );
    }
}

class ImageInfo {
    ImageProvider? image;
    String imageBase64 = '';

    ImageInfo({required this.image, required this.imageBase64});

    static Future<ImageInfo> getImageFromCamera() async {
        final image = await ImagePicker().pickImage(source: ImageSource.camera);

        if (image != null) {
            final imageFile = File(image.path);
            final Uint8List bytes = await imageFile.readAsBytes();
            final String base64StringImage = base64Encode(bytes);

            return ImageInfo(image: MemoryImage(bytes), imageBase64: base64StringImage);
        }

        return ImageInfo(image: null, imageBase64: '');
    }

    ImageProvider getImageProvider() {
        return image!;
    }
}