import 'package:flutter/material.dart';
import 'package:what_u_cread/presentation/LoginScreen/widgets/loginForm.dart';

class LoginScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Bitmap.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.all(20.0),
          children: <Widget>[
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
              style: Theme.of(context).textTheme.displaySmall,
              children: [
                TextSpan(
                  text: "What",
                  ),
                TextSpan(
                  text: "U",
                  style: TextStyle(fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(140, 10, 0, 5)),
                  ),
                TextSpan(
                  text: "Cread",
                )
                ],
              ),
            ),
            SizedBox(height: 20),
            LoginForm(),
          ],
        ),
      ),
    );
  }
}