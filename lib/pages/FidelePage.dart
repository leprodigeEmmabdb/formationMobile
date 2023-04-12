import 'package:flutter/material.dart';
import 'package:gestion_fidele/controllers/FideleCtrl.dart';
import 'package:gestion_fidele/controllers/UserCtrl.dart';

import 'package:gestion_fidele/models/FidelModele.dart';
import 'package:gestion_fidele/utils/Constance.dart';
import 'package:provider/provider.dart';

import '../controllers/UserCtrl.dart';
import '../controllers/UserCtrl.dart';
import '../utils/Stockage.dart';
import 'FormPage.dart';
import 'LogiPage.dart';

class FidelePage extends StatefulWidget {
  const FidelePage({Key? key}) : super(key: key);

  @override
  State<FidelePage> createState() => _FidelePageState();
}

class _FidelePageState extends State<FidelePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var fideleCtrl = context.read<FideleCtrl>();
      fideleCtrl.recupererDataAPI();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    var fideleCtrl = context.watch<FideleCtrl>();

    return AppBar(
      title: Text(
        "Liste des Fideles (${fideleCtrl.fideles.length})",
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.orange,
      elevation: 0,
      actions: [
        IconButton(
            onPressed: () {
              var userCtrl = context.read<UserCtrl>();
              userCtrl.stockage?.remove(Stockage.userKey);
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => FormPage()));
            },
            color: Colors.black,
            icon: Tooltip(
                message: 'Ajouter',
                child: Icon(Icons.add))),
        IconButton(
            onPressed: () {
              var userCtrl = context.read<UserCtrl>();
              userCtrl.stockage?.remove(Stockage.userKey);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => LoginPage()));
            },
            color: Colors.black,
            icon: Tooltip(
                message: "Se deconnecter",
                child: Icon(Icons.exit_to_app)))
      ],
    );
  }

  Widget _body() {
    var userCtrl = context.watch<UserCtrl>();
    var fideleCtrl = context.watch<FideleCtrl>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("Connecté en tant que: ${userCtrl.user?.username}")),

        Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: fideleCtrl.fideles.length,
              itemBuilder: (ctx, i) {
                var f = fideleCtrl.fideles[i];
                //var f = FidelModele.fromJson(fidele);

                //  return Text("${f.id}");
                return ListTile(
                    title: Text("${f.nom}"),
                    subtitle: Text("${f.prenom}"),
                    trailing: Icon(Icons.arrow_right),
                    leading: f.image != null ? Image.network(
                        "${Constance.BASE_URL}/${f.image}") : Icon(Icons.error),
                    onLongPress: ()
                {},);
              }),
        ),
      ],
    );
  }
}
