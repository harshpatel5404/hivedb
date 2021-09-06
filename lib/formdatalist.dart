import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hivedb/model/form_model.dart';

class FormDatalist extends StatefulWidget {
  const FormDatalist({Key? key}) : super(key: key);

  @override
  _FormDatalistState createState() => _FormDatalistState();
}

class _FormDatalistState extends State<FormDatalist> {
  List<FormModel> datalist = [];

  void getData() async {
    final box = await Hive.openBox<FormModel>('formdata');
    setState(() {
      datalist = box.values.toList();
      print(datalist[0].name);
      print(datalist[0].sanctiondate);
      print(datalist[1].name);
      print(datalist[1].sanctiondate);
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15),
        child: ListView.builder(
          itemCount: datalist.length,
          itemBuilder: (context, index) {
            FormModel getdata = datalist[index];
            var name = getdata.name;
            var sandate = getdata.sanctiondate;
            return InkWell(
              onTap: () async{
                final box =await Hive.openBox<FormModel>('formdata');
                box.deleteAt(index);
                
                setState(() {
                  datalist.removeAt(index);
                });
              },
              child: Card(
                elevation: 8,
                child: Container(
                  height: 80,
                  padding: EdgeInsets.all(15),
                  child: Stack(
                    children: <Widget>[
                    
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(name, style: TextStyle(fontSize: 18))),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: EdgeInsets.only(right: 45),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Salary: $name | Age: $sandate",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
