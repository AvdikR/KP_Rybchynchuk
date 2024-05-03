// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_u_cread/models/currentUser.dart';
import 'package:what_u_cread/models/userModel.dart';
import 'package:what_u_cread/presentation/HomeScreen/home_screen.dart';
import 'package:what_u_cread/presentation/LoginScreen/login_screen.dart';
import 'package:what_u_cread/presentation/WelcomeScreen/welcome_screen.dart';

enum AuthStatus {
  unknown,
  notLoggedIn,
  loggedIn,
}

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  AuthStatus _authStatus = AuthStatus.unknown;
  String? currentUid;

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    //get the state, check current User, set AuthStatus based on state
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String _returnString = await _currentUser.onStartUp();
    if(_returnString == "success"){
      setState(() {
        _authStatus = AuthStatus.loggedIn;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    Widget retVal;

    switch (_authStatus){
      case AuthStatus.unknown:
      retVal = WelcomeScreen();
        break;
      case AuthStatus.notLoggedIn:
        //retVal = WelcomeScreen();
        retVal = LoginScreen();
        break; 
      case AuthStatus.loggedIn:
        retVal = HomeScreen();
        /*
        retVal = StreamProvider<UserModel>.value(
          value: DBStream().getCurrentUser(currentUid!), 
          initialData: UserModel(),
          child: LoggedIn(),
        );*/
        break;
    }
    return retVal;
  }  
}

class LoggedIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserModel _userStream = Provider.of<UserModel>(context);
    Widget retVal;

    if (_userStream != null) {
      retVal = HomeScreen(); // Призначення дочірнього екрана відповідно до стану потоку даних
    } else {
      retVal = WelcomeScreen();
    }
    
    return retVal;
  }
}