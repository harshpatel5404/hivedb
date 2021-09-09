import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hivedb/model/form_model.dart';
import 'package:hivedb/widgets/search_widget.dart';

class FormDatalist extends StatefulWidget {
  const FormDatalist({Key? key}) : super(key: key);

  @override
  _FormDatalistState createState() => _FormDatalistState();
}

class _FormDatalistState extends State<FormDatalist> {
  List<FormModel>? datalist;
  List<FormModel>? alllist;
  String query = '';
  var status = "Success";
  TextEditingController startcontroller = TextEditingController();
  TextEditingController endcontroller = TextEditingController();
  Text selectdate = Text("Select date");
  TextEditingController namecontroller = TextEditingController();
  Text selectamt = Text("Select Amt");
  Icon serch = Icon(Icons.search_sharp);
  bool isserch = true;
  bool isok = false;
  late DateTime firstdt;
  late DateTime enddt;

  void getData() async {
    final box = await Hive.openBox<FormModel>('formdata');
    setState(() {
      datalist = box.values.toList();
      alllist = datalist;
    });
  }

  List getDaysInBeteween(DateTime startDate, DateTime endDate) {
    List days = [];
    List totaldays = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(DateTime(startDate.year, startDate.month, startDate.day + i));
      var dy = days[i].toString();
      var day = dy.replaceAll("00:00:00.000", "");
      totaldays.add(day.trim());
    }
    return totaldays;
  }

  @override
  void initState() {
    getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void searchBook(String query) {
      final data = alllist!.where((formdata) {
        final name = formdata.name.toLowerCase();
        final searchstatus = formdata.status.toLowerCase();
        return name.contains(query) || searchstatus.contains(query);
      }).toList();
      setState(() {
        this.query = query;
        this.datalist = data;
      });
    }

    Widget buildSearch() => SearchWidget(
          text: query,
          hintText: 'Search',
          onChanged: searchBook,
        );

    String? startdate;
    String? enddate;
    AlertDialog datedialog = AlertDialog(
      title: Text('Select Date'),
      contentPadding: EdgeInsets.zero,
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                DateTimePicker(
                  timeLabelText: "Choose Start Date",
                  initialValue: '',
                  firstDate: DateTime(1950),
                  lastDate: DateTime((DateTime.now().year) + 1),
                  dateLabelText: 'Choose Start Date',
                  onChanged: (val) => {
                    startdate = val,
                  },
                ),
                DateTimePicker(
                  timeLabelText: "Choose End Date",
                  initialValue: '',
                  firstDate: DateTime(1950),
                  lastDate: DateTime((DateTime.now().year) + 1),
                  dateLabelText: 'Choose End Date',
                  onChanged: (val) => {
                    enddate = val,
                  },
                ),
              ],
            )
          ],
        ),
      ),
      actions: [
        FlatButton(
          textColor: Colors.amber,
          onPressed: () => Navigator.pop(context),
          child: Text('Cancal'),
        ),
        ElevatedButton(
          onPressed: () {
            isok = true;
            firstdt = DateTime.parse(startdate!);
            enddt = DateTime.parse(enddate!);
            var different = enddt.difference(firstdt).inDays;
             setState(() {
              selectdate = Text("$startdate - $enddate");
              Navigator.pop(context);
            });
          },
          child: Text('Ok'),
        ),
      ],
    );
    AlertDialog amtdialog = AlertDialog(
      title: Text('Select Amount'),
      contentPadding: EdgeInsets.zero,
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: startcontroller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Enter minimume amount",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    hintText: "Enter minimume amount",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: endcontroller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Enter Maximume amount",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                    hintText: "Enter Maximume amount",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        FlatButton(
          textColor: Colors.amber,
          onPressed: () => Navigator.pop(context),
          child: Text('Cancal'),
        ),
        FlatButton(
          textColor: Colors.amber,
          onPressed: () {
            isok = true;
            Navigator.pop(context);
            setState(() {
              selectamt =
                  Text(startcontroller.text + " - " + endcontroller.text);
            });
            startcontroller.clear();
            endcontroller.clear();
          },
          child: Text('Ok'),
        ),
      ],
    );

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildSearch(),
              Container(
                color: Colors.white,
                height: 100,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Status :  "),
                        DropdownButton(
                          value: status,
                          items: <String>["Success", "Failed", "Pending"]
                              .map((String value) {
                            status = value;
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              status = newValue.toString();
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {
                            showDialog<void>(
                                context: context,
                                builder: (context) => datedialog);
                          },
                          child: selectdate,
                        ),
                        TextButton(
                          onPressed: () {
                            showDialog<void>(
                                context: context,
                                builder: (context) => amtdialog);
                          },
                          child: selectamt,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    List alldays = getDaysInBeteween(firstdt, enddt);
     
                    final data = alllist!.where((formdata) {
                      final logindt = formdata.logindate.toLowerCase();
                      
                      return alldays.contains(logindt);
                    }).toList();

                    setState(() {
                      this.query = query;
                      this.datalist = data;
                    });
                  },
                  child: Text("Search")),
              Container(
                height: MediaQuery.of(context).size.height * 0.65,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: datalist!.length,
                  itemBuilder: (context, index) {
                    FormModel getdata = datalist![index];
                    var name = getdata.name;
                    var amt = getdata.loginamt;
                    var stats = getdata.status;
                    var dt = getdata.logindate;
                    return InkWell(
                      onTap: () async {
                        final box = await Hive.openBox<FormModel>('formdata');
                        box.deleteAt(index);
                        setState(() {
                          datalist!.removeAt(index);
                          alllist = datalist;
                        });
                      },
                      child: Card(
                        elevation: 8,
                        child: Container(
                          height: 100,
                          padding: EdgeInsets.all(5),
                          child: Stack(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Name: $name \nStatus : $stats \nAmount : $amt | Date : $dt",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
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
            ],
          ),
        ),
      ),
    );
  }
}
