import 'package:flutter/material.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

/*void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ); //material app
  }
}*/

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TimeOfDay _time = TimeOfDay.now();
  TimeOfDay picked1;
  Future<Null> _selectTime(BuildContext context) async {
    picked1 = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    setState(() {
      _time = picked1;
      print(_time);
    });
  }

  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  TextEditingController description = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController time = TextEditingController();
  TextEditingController venue = TextEditingController();
  TextEditingController motherName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //debugShowCheckedModeBanner:false;
    String dropdownValue = 'One';
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15),
              child: Text(
                'New Home Visits',
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              // child: Text('grg',
              // style: TextStyle(color: Colors.black, fontSize: 12)),
              height: 40.0,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              color: Colors.lightBlue,

              child: Text("Reminder-2",
                  style: TextStyle(color: Colors.black87, fontSize: 20)),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      TextFormField(
                        controller: description,
                        decoration: InputDecoration(
                          labelText: "Description",
                          hintText: "Enter the description",
                        ),
                      ),
                      TextFormField(
                        controller: date,
                        decoration: InputDecoration(
                          labelText: "Date",
                          hintText: "${selectedDate.toLocal()}".split(' ')[0],
                        ),
                        onTap: () => _selectDate(context),
                      ),
                      /*RaisedButton(
                        onPressed: () => _selectDate(context),
                        child: Text('Select date'),
                      ),*/
                      TextFormField(
                        controller: time,
                        decoration: InputDecoration(
                          labelText: "Time",
                          hintText: "${_time.hour}:${_time.minute}",
                        ),
                        onTap: () => _selectTime(context),
                      ),
                      /*TextFormField(
                        controller: description,
                        decoration: InputDecoration(
                          labelText: "Mother Name",
                          hintText: "Select the Mother Name",
                        ),
                      ),*/
                    ],
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: Row(
                children: <Widget>[
                  Container(
                    child: Text("Mother Name"),
                    alignment: Alignment.bottomLeft,
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 30,
                      elevation: 16,
                      style: TextStyle(color: Colors.deepPurple, fontSize: 20),
                      underline: Container(
                        height: 5,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                      items: <String>['One', 'Two', 'Free', 'Four']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50.0,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.bottomRight,
              child: RaisedButton(
                shape: StadiumBorder(),
                textColor: Colors.white,
                color: Colors.lightBlue,
                child: Text(
                  'Create',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
