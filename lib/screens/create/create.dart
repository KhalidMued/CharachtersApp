import 'package:flutter/material.dart';
import 'package:flutter_rpg/screens/home/home.dart';
import 'package:flutter_rpg/models/character.dart';
//import 'package:flutter/services.dart';
import 'package:flutter_rpg/models/vocation.dart';
import 'package:flutter_rpg/screens/create/vocation_card.dart';
import 'package:flutter_rpg/services/character_store.dart';
import 'package:flutter_rpg/shared/styled_button.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/shared/theme.dart';
import 'package:google_fonts/google_fonts.dart'; //To use google fonts
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final _nameController = TextEditingController();
  final _sloganController = TextEditingController();

  //Recommended when using TextEditingController, to free up memory when not needed.
  @override
  void dispose() {
    _nameController.dispose();
    _sloganController.dispose();
    super.dispose();
  }

  //Handling Vocatoin Selection
  Vocation selectedVocation = Vocation.ninja; //initial Value

  void updateVocation(Vocation vocatoin) {
    setState(() {
      selectedVocation = vocatoin;
    });
  }

  //Submit Handler
  void handleSubmit() {
    if (_nameController.text.trim().isEmpty) {
      //show error dialog
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const StyledHeading('Missing Character Name'),
              content:
                  const StyledText('Every Good RPG Character Needs a Name'),
              actions: [
                StyledButton(
                  onPressed: () {
                    Navigator.pop(ctx); //to close the Alert Dialog
                  },
                  child: const StyledHeading('Close'),
                )
              ],
              actionsAlignment: MainAxisAlignment.center,
            );
          });

      return;
    }
    if (_sloganController.text.trim().isEmpty) {
      //show error dialog
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const StyledHeading('Missing The Slogan'),
              content: const StyledText('Do Not Forget The Slogan'),
              actions: [
                StyledButton(
                  onPressed: () {
                    Navigator.pop(ctx); //to close the Alert Dialog
                  },
                  child: const StyledHeading('Close'),
                )
              ],
              actionsAlignment: MainAxisAlignment.center,
            );
          });
      return;
    }

    Provider.of<CharacterStore>(context, listen: false).addCharacter(Character(
      name: _nameController.text.trim(),
      slogan: _sloganController.text.trim(),
      id: uuid.v4(),
      vocation: selectedVocation,
    ));

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => const Home(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const StyledTitle('Your Characters'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //welcome message
              Center(
                child: Icon(Icons.code, color: AppColors.primaryColor),
              ),

              const Center(
                child: StyledHeading('Welcome New Player'),
              ),

              const Center(
                child: StyledText('Create a Name & Solgan for Your Character'),
              ),

              const SizedBox(height: 30),

              //Input for Name & Slogan

              TextField(
                controller: _nameController,
                style: GoogleFonts.kanit(
                    textStyle: Theme.of(context).textTheme.bodyMedium),
                cursorColor: AppColors.primaryColor,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_2),
                  label: StyledText('Character Name'),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: _sloganController,
                style: GoogleFonts.kanit(
                    textStyle: Theme.of(context).textTheme.bodyMedium),
                cursorColor: AppColors.primaryColor,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.chat),
                  label: StyledText('Character Slogan'),
                ),
              ),

              const SizedBox(height: 30),

              //Select Vocation Title
              Center(
                child: Icon(Icons.code, color: AppColors.primaryColor),
              ),

              const Center(
                child: StyledHeading('Choose a Vocation'),
              ),

              const Center(
                child: StyledText('This Determines Your Available Skills'),
              ),

              const SizedBox(height: 30),

              //Vocation Cards

              VocationCard(
                selected: selectedVocation == Vocation.junkie,
                onTap: updateVocation,
                vocation: Vocation.junkie,
              ),
              VocationCard(
                selected: selectedVocation == Vocation.ninja,
                onTap: updateVocation,
                vocation: Vocation.ninja,
              ),
              VocationCard(
                selected: selectedVocation == Vocation.raider,
                onTap: updateVocation,
                vocation: Vocation.raider,
              ),
              VocationCard(
                selected: selectedVocation == Vocation.wizard,
                onTap: updateVocation,
                vocation: Vocation.wizard,
              ),

              const SizedBox(height: 30),

              //Good Luck Message
              Center(
                child: Icon(Icons.code, color: AppColors.primaryColor),
              ),

              const Center(
                child: StyledHeading('Good Luck'),
              ),

              const Center(
                child: StyledText('And Enjoy the Journey...'),
              ),

              const SizedBox(height: 30),

              Center(
                child: StyledButton(
                  onPressed: handleSubmit,
                  child: const StyledHeading('Create Character'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
