import 'package:flutter/material.dart';
import 'package:ungexercies/utility/my_style.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  double screen;

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: buildCreateAccount(),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.3),
            radius: 1.0,
            colors: [MyStyle().darkColor, MyStyle().lightColor],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildLogo(),
                MyStyle().titleH1('Ung Exercise'),
                buildUser(),
                buildPassword(),
                buildLogin(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildUser() {
    return Container(
      decoration: MyStyle().boxDecoration(),
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.7,
      child: TextField(
        style: TextStyle(color: MyStyle().darkColor),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().darkColor),
          hintText: 'User :',
          prefixIcon: Icon(
            Icons.perm_identity,
            color: MyStyle().darkColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: MyStyle().darkColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: MyStyle().lightColor),
          ),
        ),
      ),
    );
  }

  buildCreateAccount() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('No Account ?'),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/createAccount'),
            child: MyStyle().titleH2('Create Account'),
          ),
        ],
      );

  Container buildLogin() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.7,
      child: ElevatedButton(
        style: MyStyle().buttonStyle(),
        onPressed: () {},
        child: Text('Login'),
      ),
    );
  }

  Container buildPassword() {
    return Container(
      decoration: MyStyle().boxDecoration(),
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.7,
      child: TextField(
        style: TextStyle(color: MyStyle().darkColor),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().darkColor),
          hintText: 'Password :',
          prefixIcon: Icon(
            Icons.lock_open_outlined,
            color: MyStyle().darkColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: MyStyle().darkColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: MyStyle().lightColor),
          ),
        ),
      ),
    );
  }

  Container buildLogo() {
    return Container(
      width: screen * 0.35,
      child: MyStyle().showLogo(),
    );
  }
}
