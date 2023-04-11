import 'package:flutter/material.dart';

class DemoPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    //Le widget Scaffold nous permet de bien structurer notre page
    return Scaffold(
      // le body est juste le corps d'une page
      body: _collumWidget()
    );
  }

  Widget _collumWidget(){
    return Column(
      children: [
        //Flexible permet de bien maitriser le container
        Flexible(child:_containerWidget()
        )
      ],
    );
  }
  // Une fonction qui renvoie un widget container pour
  Widget _containerWidget(){
    return Container(
      color: Colors.black,
      height: double.infinity,
      width: double.infinity,
      child: _logoText(),
    );
  }

  Widget _logoText(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: SizedBox()),
        Icon(
          Icons.account_circle,
          size: 160,
          color:Colors.deepOrange,
        ),
        Text("Fidele App",style: TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold
        )
        ),
        Expanded(child: SizedBox()),
        _buttonWidget(),
        SizedBox(height: 10,)
      ],
    );
  }

  Widget _buttonWidget(){
    return ElevatedButton(
        onPressed: (){},
        child: Text("Connexion"),
        style: ButtonStyle(

        ) ,

    );
  }

  Widget _centerWidget(){
    return Center(
        child: Text("Bonjour à tous !")
    );
  }
}