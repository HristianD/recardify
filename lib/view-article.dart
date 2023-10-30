import 'package:flutter/material.dart';

class ViewArticle extends StatelessWidget {
    final int id;
    const ViewArticle({super.key, required this.id});

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Center(
                child: ListView(
                    children: <Widget>[
                        SizedBox(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                      width: 360,
                                      child: Column(
                                          children: <Widget>[
                                              const SizedBox(
                                                height: 30
                                              ),
                                              Center(
                                                  child: Text(_getArticleTitle(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25))
                                              ),
                                              const SizedBox(
                                                height: 30
                                              ),
                                              Center(
                                                  child: Text(_getArticleText(), style: const TextStyle(fontSize: 20))
                                              ),
                                              const SizedBox(
                                                height: 20
                                              ),
                                              Row(
                                                  children: <Widget>[
                                                      const Text('Source: '),
                                                      InkWell(
                                                          // onTap: () => launchUrl(Uri.parse(_getLink())),
                                                          child: Text(
                                                              _getSource(),
                                                              style: const TextStyle(decoration: TextDecoration.underline, color: Colors.blue)
                                                          )
                                                      )
                                                  ]
                                              ),
                                              const SizedBox(
                                                  height: 20
                                              )
                                          ]
                                      )
                                  )
                                ]
                            )
                        )
                    ]
                )
            )
        );
    }

    String _getArticleTitle() {
        String articleTitle = '';
        switch (id) {
            case 1:
                articleTitle = 'TOP TEN WATER SAVING TIPS';
                break;
            case 2:
                articleTitle = 'Climate change explained for children';
                break;
            case 3:
                articleTitle = '7 tips to recycle better';
                break;
            case 4:
                articleTitle = 'CAUSES AND EFFECTS OF CLIMATE CHANGE';
                break;
            case 5:
                articleTitle = 'Advantages and disadvantages of renewable energy';
                break;
        }

        return articleTitle;
    }

    String _getArticleText() {
        String articleText = '';
        switch (id) {
            case 1:
                articleText = 'Climate change is making extreme weather, including heatwaves, more frequent and more intense. In the UK we are experiencing more droughts, which contribute to water shortages. As well as helping to supply the water we use, our lakes, rivers and wetlands provide homes for thousands of precious species – and just like us, they all need water to survive. Here in the UK, 70% of our water supply comes from surface water, which means that the water we use in our daily lives takes directly from freshwater sources in nature. WWF is working with dishwashing brand Finish to replenish 500 million litres of freshwater in the UK, raise awareness of the importance of freshwater for nature to thrive and encourage people to take small everyday actions to reduce their water use. Governments and water companies can make the biggest difference to the way that our freshwater is used, but reducing your household water footprint is a great way to make an impact as an individual. Take a look at our top ten tips to save water and start making a difference. 1. SWITCH TO SHOWERS Switching from baths to showers is an easy way to save water. If you’re already a shower person, then try keeping your shower to 4 minutes or less. Lots of water companies will send you a shower timer for free – check with your provider to find out. 2. KEEP THE SPRINKLERS OFF If you have a garden then remember to keep the sprinklers off! There’s lots of ways to water your garden without them – invest in a water butt that collects water throughout the year for you to use, or try using cooking water instead. Your plants will benefit from the extra nutrients! 3. TURN OFF THE TAP Running taps waste as much as 6 litres of water a minute. So remember to turn off the tap when you\'re brushing your teeth, or try filling a bowl of water when rinsing vegetables or fruit to keep your veg clean and your water usage low! 4. FILL UP THE WASHING UP BOWL Another way of minimising running taps is to make sure that you’re filling a bowl when doing the washing up. Filling a bowl with water – and cleaning the cleanest items first – means you’re unlikely to need to change the water and will save a huge amount of water in comparison to washing everything under the tap. 5. MAKE SURE YOUR DISHWASHER IS FULL! Switching from handwashing to dishwashing saves 6000 litres a year – and not pre-rinsing your dishes before they go in saves another 1000 litres every year. Take a look at our dishwasher challenge to find out more. 6. USE LEFTOVER COOKING WATER or water from rinsing your veg – to water your plants or use on the garden. 7. FIXING LEAKS IS AN EASY WAY TO REDUCE YOUR WATER FOOTPRINT Check your taps for any leaks under the sink, or for any drips when the tap is fully off. Lots of water companies also give away free ‘leak strips’ which stick to the toilet bowl and change colour if your toilet is leaking water. Fixing a leaky loo is surprisingly easy and there are lots of how-to videos online. 8. FIT LOW FLOW AERATORS ON YOUR TAPS AND SHOWERS These cheap adaptors to your taps aerate your water supply, which means that you get the same water pressure but use much less water! Some water companies give these away for free, so it\'s worth checking with your water provider! 9. FILL UP A JUG OF COLD WATER Running the tap for cold water is a small everyday action that is really easy to change. Try making a habit of filling up a jug of water and putting it in the fridge every day so that you always have a supply of cold water without running the tap. 10. FILL UP THE KETTLE ONLY AS MUCH AS YOU NEED As a nation of tea drinkers, the kettle is always on. Filling up the kettle only as much as you need saves both water and energy, and most kettles have indicators letting you know how much water you need for each cup';
                break;
            case 2:
                articleText = 'Imagine the Earth like a big puzzle, and everything in it - the land, oceans, air, plants, and animals - is connected. This balance helps keep our planet just the right temperature for us to live comfortably. However, there\'s a problem. Humans have been doing things that release extra gases into the air, like when we burn fossil fuels (like coal, oil, and gas) for energy or drive cars. These extra gases, called greenhouse gases, are like a blanket around the Earth. They trap heat from the sun and make our planet warmer. This is what we call "global warming." As the Earth gets warmer, it causes a lot of changes. For example: Melting Ice: The ice at the North and South Poles is melting faster than it should. This can cause sea levels to rise, which can be a big problem for coastal cities and the creatures that live in the oceans. Extreme Weather: Weather patterns are becoming more unpredictable. We might see stronger hurricanes, hotter heatwaves, and more intense rainstorms. Habitat Loss: Many plants and animals depend on specific climates to survive. As things get hotter or more unpredictable, some habitats can disappear, making it hard for these creatures to survive. Trouble for Humans: Climate change can also affect us directly. It can lead to problems with growing food, finding clean water, and can even cause people to have to leave their homes because of things like rising sea levels. So, what can we do? We can all make small changes in our lives, like using less energy, driving less, and recycling more. Also, it\'s important to support bigger changes, like using more renewable energy (like solar and wind power) and helping to protect forests and oceans. Let me explain three main things you can do to help the world. We\'re going to talk about three big words: Recycling, Reusing, and Reducing. Here is a quick explanation of those three important words: 1. Recycling: Imagine if your old toys could turn into brand new ones! That\'s kind of what happens when we recycle. We collect things like plastic bottles, paper, and glass, and they get turned into new things. It\'s like magic! Remember to use the special bins for recycling. 2. Reusing: Have you ever turned an empty jar into a fancy pencil holder? That\'s reusing! Instead of throwing things away, we can find new ways to use them. Old clothes can become cool costumes, and glass jars can be used for all sorts of fun projects. Get creative! 3. Reducing: This one is like a challenge! We try to use less stuff, like water, paper, and electricity. Turning off lights when you leave a room or taking shorter showers are super ways to help. Plus, it saves energy and money! Remember, the order of these words is important! It\'s best to try to reduce first, then reuse, and finally, if you can\'t do either of those, recycle.';
                break;
            case 3:
                articleText = 'Recycling is a regional enterprise, and each city has different rules, which complicates things for residents who just want to know how to recycle correctly. The truth is that recycling is confusing. “There’s a lot of different rules, and even if there’s an understanding of what can be recycled, there may be different rules in different jurisdictions,” says Jeffrey Raymond, chief of communications and community affairs for Baltimore’s Department of Public Works. “In terms of communicating all this, we have to walk a line between getting people to make recycling as simple as possible, and not making it so intimidating and difficult that they don’t recycle at all.” Below are a few recycling best practices: 1. No bags. Like really, no bags. infographic of bag Grocery bags dissolve into potentially harmful microplastics and, in the case of ingestion or entanglement, hurt and kill animals. They’re pretty much the worst. Even though these bags are technically recyclable, you must go to a drop-off area to do that, not your curbside bin. Plastic bags are the number-one contaminant in recycling loads. Plastic bags act as “tanglers,” getting caught in machinery and shutting down the equipment. In some cases, like in Montgomery County, Maryland, when plastic bags full of recyclables arrive at the facility, workers are not allowed to open the bags, says Griselda Guillen of the county’s recycling center. That means the entire bag, even if it’s full of water bottles, is considered trash. Though grocery bags may be posterchildren of plastic pollution, sandwich bags, bubble wrap, plastic wrapping and other flimsy materials that don’t survive the poke test — where the plastics are soft enough to push your finger through it — are also prime candidates for commercial drop-off areas, not the residential recycling bin. This also means you shouldn’t bag your recyclables. Instead, dump them loosely right into your blue bins. Solution: Buy a couple canvas bags and get some reusable containers. 2. Small things are big problems Don’t recycle anything smaller than a credit card. That includes straws, bottle caps, coffee pods, plastic cutlery, paperclips, and a million other tiny things that creep into our daily lives. These objects are too small to be sorted and can jam the recycling equipment. At Montgomery County, Maryland’s Recycling Center, these contaminants can shut down machines 10–15 times a day, says Guillen. But what about plastic lids and metal bottlecaps? you might ask. Helen Lee of Alexandria, Virginia’s Resource Recovery Division points out that “if you put the plastic cap back on the bottle, it becomes bigger than a business card, so it would be captured [by the sorting equipment].” According to the Association of Plastic Recyclers, when plastics are grinded into pellets, the different numbered plastics have different weights and can be separated easily after that. That’s not so easy for metal bottlecaps, which tend to fall off glass bottles. You can sometimes bring these metal bottle caps to companies that take scrap. Solution: Be conscious of what you throw in that recycling bin. 3. Make sure it’s clean, empty and dry Food waste contaminates whole loads of recyclable material, rendering them useless and fast- tracking them to landfills. In the U.S., food waste contaminates 25 percent of our recycling loads. “The message we try to have residents remember is clean, empty and dry,” says Lee. But just how clean? “I always tend to tell people that their recyclable material should be clean enough to use again,” says Howard Lee of Washington, D.C.’s Office of Waste Diversion. “So, if you’re putting things in the bin and you’re concerned about rodents or rats or anything like that, then chances are your recyclables are not clean.” With that in mind, be wary of advertising at your local fast-food joint. I recently saw a paper taco bowl that read, “Please Recycle. We Care About the Environment.” That’s fake news. You can’t recycle something covered in salsa and beans. You may have better luck composting that bowl, but again, it’s complicated. You can also recycle pizza boxes... if they’re not covered in cheese and grease. If they are, you can always tear off the clean part and recycle that. Solution: Just as the rule states, make sure your recyclables are clean, empty and dry. It’ll take seconds and if everyone did it, it would save tons of recyclables going to the landfill. 4. Combined materials are trash Recycling only works when like materials are together. Unfortunately, items like plastic-coated coffee cups, laminated paper and paper-bubble wrap envelopes from the mail can’t ever be separated, which means they’re trash. Solution: Try to avoid buying nonrecyclable materials that can’t be separated. And when you can, shop local to cut down on the carbon footprint of your products. 5. Know your plastics Not all plastics are treated equally. Rigid plastics are recyclable, labeled by resin codes 1 through 7. Generally, the higher the number, the less recyclable it is. Most recycling centers will recycle plastics 1 and 2 without a problem. Past that, it gets tricky. Furthermore, a lot of plastic just isn’t recyclable curbside. As noted earlier, you can’t recycle plastic bags or films. Additionally, you can’t recycle anything that can tear like paper. That means no cracker bags, chip bags or cereal bags. “With plastics, it does get so confusing,” says Erin Hafner of Baltimore’s recycling program. “Clamshell containers, cutlery, plastic straws — all that stuff that ends up in the [recycling] bin.” And it shouldn’t. Solution: Check your city’s recycling website for the number the city takes. 6. Stop wishcycling When it comes to recycling, one of the worst things you can do is wishcycle. That’s when we optimistically put non-recyclable objects in recycling bins. When we do this, we contaminate whole loads of otherwise recyclable materials. “A lot of people wish that this material can be recycled, and it seems like it’s made out of the materials that could be recycled, but sometimes it’s not,” says Helen Lee. Cities have certain thresholds to meet when they send their recyclables to third-party waste management companies. If they surpass these thresholds — in other words, if there’s too much trash mixed into the recycling load — that entire load could end up in a landfill. So when you wishcycle, you screw up the entire system. Solution: Don’t wishcycle. 7. Teach yourself At the end of the day, we can’t know everything. There’s a bunch of stuff we accumulate over our lives — batteries, electronics, paint cans, toys, clothing, wood — and they, unfortunately, all have separate drop off centers or special instructions for recycling. Solution: Hit up your local recycling website, and teach yourself what you need to know. This article only gets you so far. Demand change Of course, you can change your individual behavior: Clean containers better, only recycle what’s recyclable and most importantly, reduce your overall use. “[Be] mindful of how you purchase products,” says Howard Lee. “Start with reducing the amount of waste you create. Once you’ve gotten the hang of reducing your waste — maybe not buying so many water bottles — you can start to reuse things that you have and recycle or compost before getting to a landfill.” But don’t let industry off the hook, either. Manufacturers and lobbyists have created a single-use empire built on this false narrative of recycling as the be-all-end-all solution to our consumption habits. Get mad. Make some noise. Demand solutions, not delays. That materials like plastics are unavoidable in our market economy is not your fault.';
                break;
            case 4:
                articleText = 'What causes climate change? And how does it relate to global warming? Learn about the impact and consequences of climate change and global warming for the environment and our lives. The planet is warming, from North Pole to South Pole. Since 1906, the global average surface temperature has increased by more than 1.6 degrees Fahrenheit (0.9 degrees Celsius)—even more in sensitive polar regions. And the impacts of rising temperatures aren’t waiting for some far-flung future–the effects of global warming are appearing right now. The heat is melting glaciers and sea ice, shifting precipitation patterns, and setting animals on the move. Many people think of global warming and climate change as synonyms, but scientists prefer to use “climate change” when describing the complex shifts now affecting our planet’s weather and climate systems. Climate change encompasses not only rising average temperatures but also extreme weather events, shifting wildlife populations and habitats, rising seas, and a range of other impacts. All of these changes are emerging as humans continue to add heat-trapping greenhouse gases to the atmosphere. Scientists already have documented these impacts of climate change: Ice is melting worldwide, especially at the Earth’s poles. This includes mountain glaciers, ice sheets covering West Antarctica and Greenland, and Arctic sea ice. In Montana\'s Glacier National Park the number of glaciers has declined to fewer than 30 from more than 150 in 1910. Much of this melting ice contributes to sea-level rise. Global sea levels are rising 0.13 inches (3.2 millimeters) a year. The rise is occurring at a faster rate in recent years and is predicted to accelerate in the coming decades. Rising temperatures are affecting wildlife and their habitats. Vanishing ice has challenged species such as the Adélie penguin in Antarctica, where some populations on the western peninsula have collapsed by 90 percent or more. As temperatures change, many species are on the move. Some butterflies, foxes, and alpine plants have migrated farther north or to higher, cooler areas. Precipitation (rain and snowfall) has increased across the globe, on average. Yet some regions are experiencing more severe drought, increasing the risk of wildfires, lost crops, and drinking water shortages. Some species—including mosquitoes, ticks, jellyfish, and crop pests—are thriving. Booming populations of bark beetles that feed on spruce and pine trees, for example, have devastated millions of forested acres in the U.S. Other effects could take place later this century, if warming continues. These include: Sea levels are expected to rise between 10 and 32 inches (26 and 82 centimeters) or higher by the end of the century. Hurricanes and other storms are likely to become stronger. Floods and droughts will become more common. Large parts of the U.S., for example, face a higher risk of decades-long "megadroughts" by 2100. Less freshwater will be available, since glaciers store about three-quarters of the world\'s freshwater. Some diseases will spread, such as mosquito-borne malaria (and the 2016 resurgence of the Zika virus). Ecosystems will continue to change: Some species will move farther north or become more successful; others, such as polar bears, won’t be able to adapt and could become extinct.';
                break;
            case 5:
                articleText = 'Advantages and disadvantages There are loads of awesome advantages of renewable energy - like the fact it will never run out! But it \'s also important to be aware of the downsides - for example, needing certain weather conditions to generate energy. Burning Questions What are the advantages of renewable energy? Renewable energy is a super-smart choice for humans and the environment. Here are some of the big benefits of using renewable sources for our energy supply: They \'ll never run out. That \'s right - these natural energy sources can replace themselves, making them sustainable and abundant natural resources. They don \'t damage our planet. These clean energy sources are non-pollutant, produce minimal or no waste products, and don \'t contribute to global warming - great news for the environment They \'re low-maintenance energy sources. Renewable energy facilities tend to require less maintenance than traditional generators. And as they come from natural, abundant resources, the operating costs are generally lower too. They \'re good news for regional areas. As most renewable energy projects are located in regional areas - away from the big cities - they can bring economic benefits to these places. For example, this could come from more people using local services. What are the disadvantages of renewable energy? As you can see, there are plenty of positives about using renewable energy. But what about any potential disadvantages? Here are some of the reasons why renewable energy can sometimes present problems: Unreliable weather can affect energy supply. As renewable energy often relies on certain weather conditions, this can impact the reliability of a constant energy supply. For example: Hydro generators need enough rain to fill dams for their supply of flowing water. Wind turbines need wind to turn their blades. Solar panels need clear skies and sunshine to get the heat needed to generate electricity. It \'s hard to produce the same amounts as non-renewable sources. It can be difficult to generate quantities of electricity that are as large as those produced by traditional fossil fuel generators. Is there anything we can do to overcome the problems of renewable energy? While we can \'t control the weather, reducing the amount of energy we use means we won \'t need such a big supply. Building more energy facilities can help meet our energy demands too. One thing that \'s clear is that having a balance of lots of different power sources is a good solution to our energy problems. Frontpage title: Causes and effects of climate change Frontpage text: Are you interested in renewable energy and want to know what the advantages and disadvantages of solar panels are?';
                break;
        }

        return articleText;
    }

    String _getSource() {
        String source = '';
        switch (id) {
            case 1:
                source = 'Here are our top ten water-saving tips | WWF';
                break;
            case 2:
                source = 'Written by Joris van den Broek';
                break;
            case 3:
                source = '7 Tips to Recycle Better - Earth Day';
                break;
            case 4:
                source = 'Global warming and climate change effects';
                break;
            case 5:
                source = 'Advantages and Disadvantages';
                break;
        }

        return source;
    }

    String _getLink() {
        String link = '';
        switch (id) {
            case 1:
                link = 'https://www.wwf.org.uk/what-can-i-do/top-ten-water-saving-tips';
                break;
            case 2:
                link = 'https://www.iberdrola.com/sustainability/recycling-for-kids';
                break;
            case 3:
                link = 'https://www.earthday.org/7-tips-to-recycle-better/';
                break;
            case 4:
                link = 'https://www.nationalgeographic.com/environment/article/global-warming-effects';
                break;
            case 5:
                link = 'https://www.solarschools.net/knowledge-bank/renewable-energy/advantages-disadvantages';
                break;
        }

        return link;
    }
}