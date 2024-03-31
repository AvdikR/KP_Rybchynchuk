import 'package:flutter/material.dart';
import 'package:what_u_cread/core/app_export.dart';
import 'package:what_u_cread/presentation/UserInterface/user_interface_screen.dart';

class StartPage extends StatefulWidget{
  const StartPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage>{
  //int _userState = 0;
/*
  void _selectUserStateGuest(){
    setState(() {
      _userState = 1;
    });
  }

  void _selectUserStateOfficial(){
    setState(() {
      _userState = 2;
    });
  }
*/

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Read new book and create yours. This app can help with it.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 15.v),
            Text(
              'Log in as guest:' ,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(height: 5.v),
            FloatingActionButton(
           onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UserInterface()));
          },
        child: const Icon(Icons.add_moderator_outlined),
          ), 
          ],
        ),
      ), 
    );
  }
}