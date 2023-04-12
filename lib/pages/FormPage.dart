import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:gestion_fidele/Widget/Chargement.dart';
import 'package:gestion_fidele/controllers/FideleCtrl.dart';
import 'package:gestion_fidele/controllers/UserCtrl.dart';
import 'package:gestion_fidele/pages/FidelePage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../Widget/ChampsSaisie.dart';
import '../Widget/Chargement.dart';
import '../controllers/FideleCtrl.dart';
import '../utils/Constance.dart';

class FormPage extends StatefulWidget {
  @override
  State<FormPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<FormPage> {
  Color fondcolor = Colors.white;

  String message = "";
  bool isVisible = false;
  var formKey = GlobalKey<FormState>();
  var name = TextEditingController();
  var password = TextEditingController();
  var firstname = TextEditingController();
  var age = TextEditingController();
  final ImagePicker picker = ImagePicker();
  XFile? imageSelectionner;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enregistrement"),
        backgroundColor: Colors.orange,
      ),
      backgroundColor: fondcolor,
      body: Stack(
        children: [_body(), Chargement(isVisible)],
      ),
    );
  }

  Widget _body() {
    var fideleCtrl = context.watch<FideleCtrl>();
    return Form(
      key: formKey,
      child: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _iconApp(),
                SizedBox(
                  height: 10,
                ),
                Text("Fidèle No. 0${fideleCtrl.fideles.length}",
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                SizedBox(
                  height: 20,
                ),

                ChampSaisie(
                    ctrl: name,
                    label: "nom",
                    required: true,
                    isPassword: false),
                SizedBox(
                  height: 20,
                ),
                ChampSaisie(
                  ctrl: firstname,
                  label: "prenome",
                  required: true,
                ),
                SizedBox(
                  height: 20,
                ),
                ChampSaisie(
                    ctrl: age,
                    label: "age",
                    required: true,
                    type: TextInputType.number),
                SizedBox(
                  height: 20,
                ),
                _buttonWidget(context),
                Text(
                  message,
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconApp() {
    return Container(
      child: IconButton(onPressed: () async{
        imageSelectionner= await picker.pickImage(source: ImageSource.gallery);
        if(imageSelectionner!=null){
          Directory directory= await getApplicationDocumentsDirectory();
          print(directory.path);
          print(imageSelectionner!.path);
          var a= imageSelectionner!.path.split("/");
          String filename=a.last;
          print(filename);
          imageSelectionner?.saveTo("${directory.path}/$filename");

        }

        setState(() {

        });

      }, color: Colors.orange, iconSize: 100,
          icon:imageSelectionner == null ?Image.network(
              "${Constance.BASE_URL}/assets/programmer.png"):Image.file(File(imageSelectionner !.path))
      ),
    );
  }

  Widget _buttonWidget(BuildContext ctx) {
    return Container(
      width: 500,
      height: 50,
      child: ElevatedButton(
        onPressed: _validateFormulaire,
        child: Text("Ajouter un fidele"),
        style: ElevatedButton.styleFrom(
            primary: Colors.orange,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16))),
      ),
    );
  }

//Widget _textError() {
//return Text(errorMsg, style: TextStyle(color: Colors.red, fontSize: 16));
//}

  void _validateFormulaire () async {
    print(firstname.text);
    print(firstname.text);
    print(firstname.text);
    FocusScope.of(context).requestFocus(new FocusNode());

    if(formKey.currentState?.validate()!=true){
      return;
    }

    Map dataAenvoyer={
      "Nom":firstname.text,
      "Prenom":name.text,
      "Age":int.parse(age.text),
      "Image":"",
    };


  }

}