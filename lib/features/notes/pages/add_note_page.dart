import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/themes/themes.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/constants.dart';
import '../../../core/widgets/buttons/buttons.dart';
import '../../../core/widgets/inputs/inputs.dart';
import 'database_helper.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final _formKeyNote = GlobalKey<FormState>();

  var libelleController = TextEditingController();
  var contenuController = TextEditingController();

  @override
  void initState() {
    super.initState();
    requestStoragePermission();
  }

  Future<void> requestStoragePermission() async {
    var status = await Permission.storage.status;

    if (!status.isGranted) {
      status = await Permission.storage.request();

      if (status.isGranted) {
        print("✅ Permission de stockage accordée !");
      } else {
        print("❌ Permission de stockage refusée !");
        //  await openAppSettings(); // Redirige vers les paramètres de l'application
      }
    }

    // Pour Android 11+
    if (await Permission.manageExternalStorage.isDenied) {
      var manageStatus = await Permission.manageExternalStorage.request();

      if (manageStatus.isGranted) {
        print("✅ Permission de gestion des fichiers accordée !");
      } else {
        print("❌ Permission de gestion des fichiers refusée !");
        await openAppSettings(); // Redirige vers les paramètres
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ajouter une note")),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: SingleChildScrollView(
            child: Form(
              key: _formKeyNote,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(2.h),
                  InputText(
                    hintText: "Titre de la note",
                    keyboardType: TextInputType.text,
                    controller: libelleController,
                    validatorMessage: "Veuillez saisir au moins un mot",
                  ),
                  Gap(2.h),
                  InputText(
                    hintText: "Contenu...",
                    controller: contenuController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 10,
                    validatorMessage: "Veuillez saisir au moins un mot",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SubmitButton(
          AppConstants.btnSave,
          onPressed: () async {
            if (_formKeyNote.currentState!.validate()) {
            /*  Note nouvelleNote = Note(
                libelle: libelleController.text,
                contenu: contenuController.text,
              ); */

             /* await DatabaseHelper.instance.insertNote(nouvelleNote.toMap());*/

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: appCardGreen,
                  content: const Text("Note ajoutée avec succès !"),
                  duration: const Duration(milliseconds: 5000),
                  width: 320.0,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              );

              Navigator.pop(context, true);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: const Text("Veuillez remplir tous les champs"),
                  duration: const Duration(milliseconds: 5000),
                  width: 320.0,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
