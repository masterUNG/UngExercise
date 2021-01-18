import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ungexercies/utility/my_style.dart';
import 'package:ungexercies/widget/show_catigory.dart';
import 'package:ungexercies/widget/show_graphp.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  List<String> titles = ['Catigory', 'Graphyic'];
  int index = 0;
  String nameLogin;
  Widget currentWidget = ShowCatigory();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findLogin();
  }

  Future<Null> findLogin() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) {
        setState(() {
          nameLogin = event.displayName;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[index]),
        backgroundColor: MyStyle().primartColor,
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            Column(
              children: [
                buildUserAccountsDrawerHeader(),
                buildMenuCatigory(),
                buildMenuGraphyic(),
              ],
            ),
            buildSingOut(),
          ],
        ),
      ),
      body: currentWidget,
    );
  }

  ListTile buildMenuCatigory() {
    return ListTile(
      onTap: () {
        setState(() {
          currentWidget = ShowCatigory();
        });
        Navigator.pop(context);
      },
      leading: Icon(
        Icons.category,
        size: 36,
        color: MyStyle().darkColor,
      ),
      title: MyStyle().titleH2Dark(titles[0]),
    );
  }

  ListTile buildMenuGraphyic() {
    return ListTile(
      onTap: () {
        setState(() {
          currentWidget = ShowGraphyic();
        });
        Navigator.pop(context);
      },
      leading: Icon(
        Icons.graphic_eq,
        size: 36,
        color: MyStyle().darkColor,
      ),
      title: MyStyle().titleH2Dark(titles[1]),
    );
  }

  UserAccountsDrawerHeader buildUserAccountsDrawerHeader() {
    return UserAccountsDrawerHeader(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            radius: 1,
            center: Alignment(-0.6, 0),
            colors: [Colors.white, MyStyle().darkColor],
          ),
        ),
        currentAccountPicture: MyStyle().showLogo(),
        accountName: MyStyle().titleH1(nameLogin == null ? '' : nameLogin),
        accountEmail: Text('Logined'));
  }

  Column buildSingOut() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ListTile(
          onTap: () async {
            await Firebase.initializeApp().then((value) async {
              await FirebaseAuth.instance.signOut().then((value) =>
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/authen', (route) => false));
            });
          },
          tileColor: Colors.red.shade700,
          leading: Icon(
            Icons.exit_to_app,
            size: 36,
            color: Colors.white,
          ),
          title: MyStyle().titleH2('Sign Out'),
          subtitle: MyStyle().titleH3White('Sign Out & Go to Login'),
        ),
      ],
    );
  }
}
