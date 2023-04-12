import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:gestion_fidele/Widget/Chargement.dart';
import 'package:gestion_fidele/controllers/FideleCtrl.dart';
import 'package:gestion_fidele/controllers/UserCtrl.dart';
import 'package:gestion_fidele/models/FidelModele.dart';
import 'package:gestion_fidele/pages/FidelePage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../Widget/ChampsSaisie.dart';
import '../Widget/Chargement.dart';
import '../controllers/FideleCtrl.dart';
import '../utils/Constance.dart';

class ProfilPage extends StatefulWidget {
  int? fidele_id;
  @override
  State<ProfilPage> createState() => _LoginPageState();
  ProfilPage({this.fidele_id});
}

class _LoginPageState extends State<ProfilPage> {
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
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var fideleCtrl = context.read<FideleCtrl>();
      var data=fideleCtrl.recupererDataAPI();
      var fidele=fideleCtrl.fideles.where((f) => f.id ==widget.fidele_id ).toList();
      if(fidele.length!=0){
        var tmp=fidele[0];
        firstname = TextEditingController(text: tmp.prenom);
        name = TextEditingController(text: tmp.nom);
        age = TextEditingController(text: tmp.age.toString());
        setState(() {

        });
      }

    });


  }

  @override
  Widget build(BuildContext context) {
    var userCtrl = context.read<UserCtrl>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil"),
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
    return Container(
      margin: EdgeInsets.all(50),
      child: Column(
        children: [
          Container(child: Text("data"),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red,
          ),
            alignment: Alignment.center,
          margin: EdgeInsets.all(55.0),
            padding: EdgeInsets.all(70.0),
          ),
          Container(child: Text("data"),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.blueGrey
            ),
            alignment: Alignment.center,
            //margin: EdgeInsets.all(55.0),
            padding: EdgeInsets.all(100.0),
      )
        ],
      ),
    );
  }

  Widget _iconApp() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.orange),
          borderRadius: BorderRadius.all(Radius.circular(50))
      ),
      child: Icon(
        Icons.person,
        size: 100,
        color: Colors.orange,
      ),
    );
  }
  Widget _presentation(String label, FidelModele f){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            child: Column(
              children: [
                Text(label),
                Text("data")
              ],
            )),
      ],
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