import 'package:flutter/material.dart';
import 'package:ungexercies/utility/my_style.dart';

Future<Null> normalDialog(
    BuildContext context, String title, String message) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: ListTile(
        leading: MyStyle().showLogo(),
        title: MyStyle().titleH1Dark(title),
      ),
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyStyle().titleH3(message),
          ],
        ),
        Row(mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      ],
    ),
  );
}
