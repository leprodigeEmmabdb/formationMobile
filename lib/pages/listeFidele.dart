import 'package:flutter/material.dart';

class ListFidele extends StatefulWidget {
  const ListFidele({Key? key}) : super(key: key);

  @override
  State<ListFidele> createState() => _ListFideleState();
}

class _ListFideleState extends State<ListFidele> {
  List<Map> item = [
    {'title': 'Element 1', 'subtitle': 'Sous-titre 1'},
    {'title': 'Element 2', 'subtitle': 'Sous-titre 2'},
    {'title': 'Element 3', 'subtitle': 'Sous-titre 3'},
  ];

  final List<String> items = ['Item 1', 'Item 2', 'Item 3'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste fidèle"),
        backgroundColor: Colors.orange,
      ),
      body: listFidele(),
    );
  }


  Widget listFidele(){
    return ListView.builder(
        itemCount: item.length,
        itemBuilder: (ctx, i) {
          return ListTile(
            title: Text(item[i]['id']),
            subtitle: Text(item[i]['prenom']),
          );
        });
  }
}

