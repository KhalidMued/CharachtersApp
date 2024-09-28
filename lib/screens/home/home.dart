import 'package:flutter/material.dart';
import 'package:flutter_rpg/screens/home/character_card.dart';
import 'package:flutter_rpg/screens/create/create.dart';
import 'package:flutter_rpg/services/character_store.dart';
import 'package:flutter_rpg/shared/styled_button.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const StyledTitle('Your Characters'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              //wrap cuz out of bounds
              child: Consumer<CharacterStore>(builder: (context, value, child) {
                return ListView.builder(
                  //ListVuew is scrollable, based on the number of characters we have
                  itemCount: value.characters.length, //character length
                  itemBuilder: (_, index) {
                    //it will run based on the character length value
                    return CharacterCard(value.characters[index]);
                  }, //build widget tree, depend on counter
                );
              }),
            ),
            StyledButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => const CreateScreen(),
                    ));
              },
              child: const StyledHeading('Create New'),
            )
          ],
        ),
      ),
    );
  }
}
