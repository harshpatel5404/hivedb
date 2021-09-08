import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'formdatalist.dart';
import 'model/form_model.dart';

class Mainform extends StatefulWidget {
  Mainform({Key? key}) : super(key: key);

  @override
  _MainformState createState() => _MainformState();
}

class _MainformState extends State<Mainform> {
  var logindate;
  var santiondate;
  var disburdeddate;
  var _selectedStatus = "Success";
  var status;

  var numberInputFormatters = [
    new FilteringTextInputFormatter.allow(RegExp("[0-9]")),
  ];
  TextEditingController namecontroller = TextEditingController();
  TextEditingController loginamtcontroller = TextEditingController();
  TextEditingController sanctionamtcontroller = TextEditingController();
  TextEditingController disburdedamtcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Profile',
                style: TextStyle(fontSize: 25),
              ),
            ),
            ListTile(
              title: const Text('Form'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Mainform()));
              },
            ),
          
            ListTile(
              title: Text('Filter Data'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FormDatalist()));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Form'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextFormField(
                    controller: namecontroller,
                    decoration: InputDecoration(
                      labelText: "Name",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                      ),
                      hintText: "Name",
                    ),
                  ),
                  DateTimePicker(
                    timeLabelText: "Login date",
                    initialValue: '',
                    firstDate: DateTime(1950),
                    lastDate: DateTime((DateTime.now().year) + 1),
                    dateLabelText: 'Choose Login Date',
                    onChanged: (val) => {
                      logindate = val,
                      // print(logindate),
                    },
                  ),
                  
                  TextFormField(
                    controller: loginamtcontroller,
                    inputFormatters: numberInputFormatters,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Login Amount",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                      ),
                      hintText: "Login Amount",
                    ),
                  ),
                  Row(
                    children: [
                      Text("Status :  "),
                      DropdownButton(
                        value: _selectedStatus,
                        items: <String>["Success", "Failed", "Pending"]
                            .map((String value) {
                              
                          _selectedStatus = value;
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            
                            _selectedStatus = newValue.toString();
                            status = _selectedStatus;
                        
                          });
                        },
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: sanctionamtcontroller,
                    inputFormatters: numberInputFormatters,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Sanction Amount",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                      ),
                      hintText: "Sanction Amount",
                    ),
                  ),
                  DateTimePicker(
                    timeLabelText: "Sanction date",
                    initialValue: '',
                    firstDate: DateTime(1950),
                    lastDate: DateTime((DateTime.now().year) + 1),
                    dateLabelText: 'Choose Sanction Date',
                    onChanged: (val) => {
                      santiondate = val,
                    },
                  ),
                  DateTimePicker(
                    timeLabelText: "Disbursed date",
                    initialValue: '',
                    firstDate: DateTime(1950),
                    lastDate: DateTime((DateTime.now().year) + 1),
                    dateLabelText: 'Choose Disbursed Date',
                    onChanged: (val) => {
                      disburdeddate = val,
                    },
                  ),
                  TextFormField(
                    controller: disburdedamtcontroller,
                    inputFormatters: numberInputFormatters,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Disbursed Amount",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                      ),
                      hintText: "Disbursed Amount",
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                            print("select $status");
                        var getname = namecontroller.text;
                        var getlogindate = logindate.toString();
                        var getloginamt = loginamtcontroller.text;
                        var getstatus = status;
                        var getsanctionamt = sanctionamtcontroller.text;
                        var getsanctiondate = santiondate.toString();
                        var getdisdate = disburdeddate.toString();
                        var getdisbursedamt = disburdedamtcontroller.text;
                        print("get status $getstatus");
                        FormModel addFormdata = new FormModel(
                            name: getname,
                            logindate: getlogindate,
                            loginamt: getloginamt,
                            status: getstatus,
                            sanctionamt: getsanctionamt,
                            sanctiondate: getsanctiondate,
                            disburdeddate: getdisdate,
                            disburdedamt: getdisbursedamt);
                        var box = await Hive.openBox<FormModel>('formdata');
                        box.add(addFormdata);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => FormDatalist()));
                      },
                      child: Text("Submit"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
