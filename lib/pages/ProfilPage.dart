import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:gestion_fidele/Widget/Chargement.dart';
import 'package:gestion_fidele/controllers/FideleCtrl.dart';
import 'package:gestion_fidele/controllers/UserCtrl.dart';
import 'package:gestion_fidele/pages/FidelePage.dart';
import 'package:gestion_fidele/pages/FormPage.dart';
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
    var fideleCtrl = context.watch<FideleCtrl>();
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
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.black54)),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Column(
                    children: [
                      Text("${name.text} ${firstname.text} ",style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),),
                      Text("Age ${age.text}",
                          style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 12,color: Colors.black)),
                    ],
                  ),

                ),
                _add(),
                SizedBox(
                  height: 20,
                ),

                SizedBox(
                  height: 20,
                ),

                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconApp() {
    return Icon(
      Icons.image,
      size: 100,
      color: Colors.orange,
    );
  }
  Widget _add(){
    var fideleCtrl = context.watch<FideleCtrl>();
    return Container(child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (_)=>FormPage(fidele_id: widget.fidele_id,)));
          },
          icon: Tooltip(
              message: "Editer",
              child: Icon(Icons.edit)),
        ),
        IconButton(
          onPressed: (){},
          icon: Tooltip(
              message: "Supprimer",
              child: Icon(Icons.delete)),
        )
      ],
    ));
  }
  Widget _buttonWidget(BuildContext ctx) {
    return Container(
      width: 500,
      height: 50,
      child: ElevatedButton(
        onPressed: _validateFormulaire,
        child: Text(widget.fidele_id==null? "Créer": "Modifier"),
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