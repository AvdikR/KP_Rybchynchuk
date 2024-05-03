import 'package:flutter/material.dart';
//import 'package:what_u_cread/presentation/HomeScreen/home_screen.dart';
import 'package:what_u_cread/presentation/LoginScreen/login_screen.dart';
import 'package:what_u_cread/widgets/rounded_button.dart';

class WelcomeScreen extends StatelessWidget{

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RichText(text: TextSpan(
              style: Theme.of(context).textTheme.displayMedium,
              children: [
                TextSpan(
                  text: "What",
                  ),
                TextSpan(
                  text: "U",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 127, 13, 5),
                    ),
                  ),
                TextSpan(
                  text: "Cread",
                )
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .6,
              child: RoundedButton(
                text: "Start reading",
                fontSize: 20,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context){
                        //return HomeScreen();
                        return LoginScreen();
                      }
                    ),
                  );
                },
              ),
            ),
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black87),
                children: [
                  TextSpan(
                    style: Theme.of(context).textTheme.bodySmall,
                    text: "as a user",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
