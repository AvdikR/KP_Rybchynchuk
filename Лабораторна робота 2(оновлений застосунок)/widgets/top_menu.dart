// ignore_for_file: must_be_immutable, no_leading_underscores_for_local_identifiers, unused_local_variable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_u_cread/models/currentUser.dart';
import 'package:what_u_cread/presentation/LoginScreen/root/root.dart';
import 'package:what_u_cread/presentation/UserInterface/user_interface_screen.dart';

class TopMenu extends StatelessWidget {
  final Size size;
  final String? userName;

  TopMenu({
    Key? key,
    required this.size,
    this.userName,
  }) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
    width: double.infinity,
    height: size.height * 0.06,
    color: const Color.fromARGB(255, 180, 180, 180),
    child: LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                // Дії, які виконуються при натисканні на кнопку
                _showLeftSideMenu(context);
              },
              padding: EdgeInsets.zero,
              icon: Container(
                height: constraints.maxHeight * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.blueGrey, // Червоний колір
                    width: 1.5, // Товщина обводки
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.menu_sharp,
                    size: 35,
                    color: Color.fromRGBO(44, 44, 44, 1),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: constraints.maxWidth * 0.35,
            ),
            Container(
              height: constraints.maxHeight * 0.75,
              width: constraints.maxWidth * 0.3,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.white70, // Червоний колір
                  width: 1.5, // Товщина обводки
                ),
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "${userName}",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return UserInterface();
                    },
                  ),
                );
              },
              child: Container(
                height: constraints.maxHeight * 0.7,
                width: constraints.maxHeight * 0.7,
                decoration: BoxDecoration(
                  shape: BoxShape.circle, //Робить круглий контейнер
                  color: Colors.white,
                  border: Border.all(
                    color: const Color.fromARGB(255, 110, 2, 0),
                    width: 3,
                  ),
                  /*
                      borderRadius: BorderRadius.circular(
                        constraints.maxHeight * 0.3),*/
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/img_usericon.png'),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ),
  );
}

  void _showLeftSideMenu(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Color.fromARGB(255, 147, 147, 147).withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
        return Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.6, // Ширина вікна меню
            height: MediaQuery.of(context).size.height,
            color: Colors.blueGrey[50],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Menu",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[900],
                  ),
                ),
                SizedBox(height: 20),
                FractionallySizedBox(
                  widthFactor: 0.85,
                  child: ElevatedButton.icon(  
                    onPressed: () {
                    // Дії при натисканні на кнопку "Settings"
                    },
                    label: Text("Settings"),
                    icon: Icon(Icons.settings),
                  ),
                ),
                SizedBox(height: 10),
                FractionallySizedBox(
                  widthFactor: 0.85,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      // Дії при натисканні на кнопку "Sign Out"
                      CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
                      String _returnString = await _currentUser.signOut();
                      if(_returnString == "success"){
                        Navigator.pushAndRemoveUntil(
                          context, 
                          MaterialPageRoute(
                            builder: (context)=>Root(),
                          ), 
                          (route) => false,
                        );
                      }                  
                    },
                    label: Text("Sign Out"),
                    icon: Icon(Icons.exit_to_app )
                  ),
                ),
                SizedBox(height: 10),
                IconButton(
                  iconSize: 40,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.cancel_sharp),
                ),
              ],
            ),
          ),
        );
      },
      transitionBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(-1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }
}