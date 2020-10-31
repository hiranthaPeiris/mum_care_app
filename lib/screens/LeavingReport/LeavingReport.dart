import 'package:flutter/material.dart';
import 'package:mun_care_app/RouteGenerator.dart';
void main()
{
   runApp(App());
}
class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LeavingReport(),
    );
  }
}
class LeavingReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.lightBlue,
         body: Container(
           child: ListView(
             children: <Widget>[
               Column(
                 children: <Widget>[
                   Container(
                     height:MediaQuery.of(context).copyWith().size.height/5,
                     width: MediaQuery.of(context).copyWith().size.width,

                     color: Colors.lightBlue,
                     child: Container(
                       child: Text('Leaving Residensial Area Report',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.center,),
                       padding: EdgeInsets.fromLTRB(
                           MediaQuery.of(context).size.width * 0.2,
                           MediaQuery.of(context).size.height * 0.06,
                           MediaQuery.of(context).size.width * 0.2,
                           MediaQuery.of(context).size.height * 0.04),
                     ),

                   ),
                   Container(
                     padding: EdgeInsets.fromLTRB(10 ,50, 10, 20),
                     height:MediaQuery.of(context).copyWith().size.height*(4/5),
                     width: MediaQuery.of(context).copyWith().size.width,
                     decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.only(
                         topLeft: Radius.circular(20.0),
                         topRight: Radius.circular(20.0),
                       ),
                     ),
                     child: Column(
                       children: <Widget>[
                         Container(
                           child: Column(
                             children: <Widget>[
                               Row(
                                 children: <Widget>[
                                   Expanded(flex: 10, child: Container()),
                                   Expanded(
                                     flex: 40,
                                     child: Padding(
                                       padding: const EdgeInsets.all(2.0),
                                       child: Container(
                                         height: 25,
                                         child: Text(
                                           "New MOH Area  -",
                                           textAlign: TextAlign.center,
                                           style: TextStyle(
                                             fontSize: 20,
                                           ),
                                         ),
                                       ),
                                     ),
                                   ),
                                   Expanded(
                                     flex: 40,
                                     child: Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Container(
                                           height: 25,
                                           decoration: BoxDecoration(
                                               borderRadius: BorderRadius.circular(0),
                                               boxShadow: [
                                                 new BoxShadow(
                                                     color: Colors.black,
                                                     blurRadius: 10.0),
                                               ],
                                               color: Colors.grey[300],
                                               border: Border.all(
                                                   color: Colors.black,
                                                   style: BorderStyle.solid,
                                                   width: 0.5)),
                                           child: mohDropDownMenu()),
                                     ),
                                   ),
                                   Expanded(flex: 5, child: Container()),
                                 ],
                               ),
                               Row(
                                 children: <Widget>[
                                   Expanded(flex: 10, child: Container()),
                                   Expanded(
                                       flex: 40,
                                       child: Padding(
                                         padding: const EdgeInsets.all(2.0),
                                         child: Container(
                                           height: 25,
                                           child: Text(
                                             "New PHM Area  -",
                                             textAlign: TextAlign.center,
                                             style: TextStyle(
                                               fontSize: 20,
                                             ),
                                           ),
                                         ),
                                       )),
                                   Expanded(
                                     flex: 40,
                                     child: Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Container(
                                           height: 25,
                                           decoration: BoxDecoration(
                                               borderRadius: BorderRadius.circular(0),
                                               boxShadow: [
                                                 new BoxShadow(
                                                     color: Colors.black,
                                                     blurRadius: 10.0),
                                               ],
                                               color: Colors.grey[300],
                                               border: Border.all(
                                                   color: Colors.black,
                                                   style: BorderStyle.solid,
                                                   width: 0.5)),
                                           child: phmDropDownMenu()),
                                     ),
                                   ),
                                   Expanded(flex: 5, child: Container()),
                                 ],
                               ),
                             ],
                           ),
                         ),
                         Container(
                           child: Padding(
                             padding: EdgeInsets.fromLTRB(
                                 MediaQuery.of(context).size.width * 0.05,
                                 MediaQuery.of(context).size.height * 0.005,
                                 MediaQuery.of(context).size.width * 0.05,
                                 MediaQuery.of(context).size.height * 0.005),
                             child: showTextField("Name ", "_Name"),
                           ),
                         ),
                         Container(
                           child: Padding(
                             padding: EdgeInsets.fromLTRB(
                                 MediaQuery.of(context).size.width * 0.05,
                                 MediaQuery.of(context).size.height * 0.0005,
                                 MediaQuery.of(context).size.width * 0.05,
                                 MediaQuery.of(context).size.height * 0.0005),
                             child: showTextField("NIC Number", "_NICnumber"),
                           ),
                         ),
                         Container(
                           child: Padding(
                             padding: EdgeInsets.fromLTRB(
                                 MediaQuery.of(context).size.width * 0.05,
                                 MediaQuery.of(context).size.height * 0.0005,
                                 MediaQuery.of(context).size.width * 0.05,
                                 MediaQuery.of(context).size.height * 0.0005),
                             child: showTextField("Eligible Family Number", "_EFsnumber"),
                           ),
                         ),
                         Container(
                           child: Padding(
                             padding: EdgeInsets.fromLTRB(
                                 MediaQuery.of(context).size.width * 0.05,
                                 MediaQuery.of(context).size.height * 0.005,
                                 MediaQuery.of(context).size.width * 0.05,
                                 MediaQuery.of(context).size.height * 0.005),
                             child: Row(
                               children: <Widget>[
                                 Expanded(
                                   flex: 20,
                                   child: Text(
                                     "Leaving Date",
                                     style: TextStyle(fontSize: 16),
                                   ),
                                 ),
                                 Container(
                                   padding: EdgeInsets.fromLTRB(
                                       MediaQuery.of(context).size.width * 0.05,
                                       MediaQuery.of(context).size.height * 0.05,
                                       MediaQuery.of(context).size.width * 0.5,
                                       MediaQuery.of(context).size.height * 0.05),
                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: <Widget>[
                                       /*Text(_dateDOB == null
                                        ? "Select DOB"
                                        : _dateDOB.year.toString() +
                                        "/" +
                                        _dateDOB.month.toString() +
                                        "/" +
                                        _dateDOB.day.toString()),*/
                                       SizedBox(
                                         width: 20,
                                       ),
                                       SizedBox(
                                         width: 30,
                                         height: 30,
                                         child: RaisedButton(
                                             padding: EdgeInsets.fromLTRB(0, 0, 50, 50),
                                             child: Text(
                                               "select",
                                               textAlign: TextAlign.justify,
                                               style: TextStyle(fontSize: 10),
                                             ),
                                             shape: RoundedRectangleBorder(
                                                 borderRadius: BorderRadius.circular(20),
                                                 side: BorderSide(
                                                   color: Color.fromARGB(500, 21, 166, 211),
                                                 )),
                                             onPressed: () {
                                               showDatePicker(
                                                   context: context,
                                                   initialDate: DateTime.now(),
                                                   firstDate: DateTime(1980),
                                                   lastDate: DateTime(2021))
                                                   .then((date) {
                                                 /*setState(() {
                                                _dateDOB = date;
                                              });*/
                                               });
                                             }),
                                       )
                                     ],
                                   ),
                                 )
                               ],
                             ),
                           ),
                         ),
                         Container(
                           padding: EdgeInsets.fromLTRB(
                               MediaQuery.of(context).size.width * 0.1,
                               MediaQuery.of(context).size.height * 0.005,
                               MediaQuery.of(context).size.width * 0.05,
                               MediaQuery.of(context).size.height * 0.005),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,

                             children: <Widget>[
                               Container(
                                 child: Align(
                                   alignment: Alignment.bottomLeft,
                                   child: ElevatedButton(
                                     onPressed: () {
                                       Navigator.pop(context);
                                     },
                                     child: Text('Back'),
                                   ),
                                 ),
                               ),
                               Container(
                                 child: Align(
                                   alignment: Alignment.bottomRight,

                                   child: ElevatedButton(

                                     child: Text('Submit'),
                                     onPressed: (){
                                     },

                                   ),

                                 ),
                               ),
                             ],
                           ),
                         ),
                       ],
                     ),
                   )
                 ],
               ),
             ],
           ),
         ),
      );
  }



  }

  String mohDropdownValue = 'Select Area';
  String phmDropdownValue = 'Select Area';

  Widget mohDropDownMenu() {
    return DropdownButton<String>(
      value: mohDropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 18,
      elevation: 36,
      isExpanded: true,
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
      items: <String>[
        'Select Area',
        'One',
        'Two',
        'five',
        'Four'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 0, 4),
            child: Text(
              value,
              textAlign: TextAlign.center,
            ),
          ),
        );
      }).toList(),
      onChanged: (String value) {
        /*setState(() {
          mohDropdownValue = value;
        });*/
      },
    );
  }

  Widget phmDropDownMenu() {
    return DropdownButton<String>(
      value: phmDropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 18,
      elevation: 36,
      isExpanded: true,
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
      items: <String>['Select Area', 'Five', 'Six', 'Seven', 'Eight']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 0, 4),
            child: Text(
              value,
              textAlign: TextAlign.center,
            ),
          ),
        );
      }).toList(),
      onChanged: (String value) {
       /* setState(() {
          phmDropdownValue = value;
        });*/
      },
    );
  }

  Widget showTextField(String hintText, String inputName) {
    return TextFormField(
      maxLines: 1,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      // ignore: missing_return
      validator: (input) {
        if (input.isEmpty) {
          return 'This can\'t be empty';
        }
      },
      onSaved: (input) => inputName = input,
    );
  }


