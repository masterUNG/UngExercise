import 'package:flutter/material.dart';
import 'package:ungexercies/models/sqlite_model.dart';
import 'package:ungexercies/utility/my_style.dart';
import 'package:ungexercies/utility/sqlite_helper.dart';

class ShowCart extends StatefulWidget {
  @override
  _ShowCartState createState() => _ShowCartState();
}

class _ShowCartState extends State<ShowCart> {
  List<SQLiteModel> sqliteModels = List();
  bool statusLoad = true;
  bool statusHaveData;
  List<List<String>> listUnitcodes = List();
  List<List<String>> listPrices = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readCart();
  }

  Future<Null> readCart() async {
    if (sqliteModels.length != 0) {
      sqliteModels.clear();
      listUnitcodes.clear();
      listPrices.clear();
    }

    try {
      await SQLiteHelper().readSQLite().then((value) {
        setState(() {
          statusLoad = false;
        });
        if (value.length != 0) {
          setState(() {
            sqliteModels = value;
            statusHaveData = true;

            List<String> unitcodes = List();
            List<String> prices = List();

            for (var item in sqliteModels) {
              unitcodes = createArrayFromString(item.unitcodes);
              listUnitcodes.add(unitcodes);

              prices = createArrayFromString(item.prices);
              listPrices.add(prices);
            }
          });
        } else {
          setState(() {
            statusHaveData = false;
          });
        }
      });
    } catch (e) {
      print('e readCart ==>> ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ตะกร้า ของฉัน'),
      ),
      body: statusLoad
          ? MyStyle().showProgress()
          : statusHaveData
              ? buildListView()
              : Center(
                  child: Text('ยังไม่มีของใน ตะกร้า เลยคะ'),
                ),
    );
  }

  ListView buildListView() {
    return ListView.builder(
      itemCount: sqliteModels.length,
      itemBuilder: (context, index) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 300,
                child: MyStyle().titleH2Dark(sqliteModels[index].name),
              ),
              IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    print('you delete id = ${sqliteModels[index].id}');
                    await SQLiteHelper()
                        .deleteDataById(sqliteModels[index].id)
                        .then((value) {
                      readCart();
                    });
                  })
            ],
          ),
          Row(
            children: [Text('header')],
          ),
          ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: listUnitcodes[index].length,
            itemBuilder: (context, index2) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(listUnitcodes[index][index2]),
                Text(listPrices[index][index2]),
              ],
            ),
          )
        ],
      ),
    );
  }

  List<String> createArrayFromString(String string) {
    List<String> strings;
    print('string ===>> $string');

    String result = string.substring(1, string.length - 1);
    print('result = $result');

    strings = result.split(',');
    int index = 0;
    for (var item in strings) {
      strings[index] = item.trim();
      index++;
    }

    return strings;
  }
}
