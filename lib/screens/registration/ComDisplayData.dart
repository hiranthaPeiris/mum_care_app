import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ComGetIdDetails extends StatelessWidget {
  final String documentId;

  ComGetIdDetails(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('ComDatabase');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          return Scaffold(body:ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Padding(padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text('Registration Details',style: TextStyle(fontSize: 20),),
                    ),
                    Divider(height: 5,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex:10,
                            child: Container(),
                          ),
                          Expanded(
                            flex:40,
                            child: Text('MOH Area    :'),
                          ),
                          Expanded(
                            flex:40,
                            child: Text(" ${data['_mohDropDownValue']} ")
                            ),
                          Expanded(
                            flex:10,
                            child: Container(),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex:10,
                            child: Container(),
                          ),
                          Expanded(
                            flex:40,
                            child: Text('PHM Area    :'),
                          ),
                          Expanded(
                            flex:40,
                            child: Text(" ${data['_phmDropDownValue']} ")
                            ),
                          Expanded(
                            flex:10,
                            child: Container(),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex:40,
                            child: Text('Husband Name    :'),
                          ),
                          Expanded(
                            flex:60,
                            child: Text(" ${data['_husbandName']} "))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex:40,
                            child: Text('Wife Name   :'),
                          ),
                          Expanded(
                            flex:60,
                            child: Text(" ${data['_wifeName']} "))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex:40,
                            child: Text('Address   :'),
                          ),
                          Expanded(
                            flex:60,
                            child: Text(" ${data['_address']} "))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex:40,
                            child: Text('NIC Number   :'),
                          ),
                          Expanded(
                            flex:60,
                            child: Text(" ${data['_nic']} "))
                        ],
                      ),
                    ),
                    Divider(height: 2,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex:40,
                            child: Text('Date Of Birth   :'),
                          ),
                          Expanded(
                            flex:60,
                            child: Text(" ${data['_dateDOB']} "))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex:40,
                            child: Text('Contact Number   :'),
                          ),
                          Expanded(
                            flex:60,
                            child: Text(" ${data['_contactNumber']} "))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex:40,
                            child: Text('Email   :'),
                          ),
                          Expanded(
                            flex:60,
                            child: Text(" ${data['_email']} "))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex:40,
                            child: Text('Job   :'),
                          ),
                          Expanded(
                            flex:60,
                            child: Text(" ${data['_job']} "))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex:40,
                            child: Text('Education   :'),
                          ),
                          Expanded(
                            flex:60,
                            child: Text(" ${data['_eduDropDownValue']} "))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex:40,
                            child: Text('Marrage Date   :'),
                          ),
                          Expanded(
                            flex:60,
                            child: Text(" ${data['_dateMarrage']} "))
                        ],
                      ),
                    ),
                    Divider(height: 5,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                           Expanded(
                        flex: 40,
                        child: Text(
                          "Diseases",
                          style: TextStyle(
                              color: Color.fromARGB(500, 21, 166, 211),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          textAlign: TextAlign.center,
                        )),                   
                    Expanded(
                        flex: 20,
                        child: Text(
                          "Men's",
                          style: TextStyle(
                              color: Color.fromARGB(500, 21, 166, 211),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          textAlign: TextAlign.center,
                        )),
                    Expanded(
                        flex: 20,
                        child: Text(
                          "Women's",
                          style: TextStyle(
                              color: Color.fromARGB(500, 21, 166, 211),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          textAlign: TextAlign.center,
                        )),
                        ],
                      ),
                    ),
                    Divider(height: 5,),
                    
                    Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.05,
                  MediaQuery.of(context).size.height * 0.005,
                  MediaQuery.of(context).size.width * 0.03,
                  MediaQuery.of(context).size.height * 0.005),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(flex: 60, child: Text("01.Diabetes")),
                        Expanded(
                            flex: 20,
                            child: (data['m_desease1'])
                              ?
                              Container(                              
                                child:Text("Yes"),
                              )
                              :
                              Container(                              
                                child:Text("No"),
                              )                               
                        ),
                        Expanded(
                            flex: 20,
                            child: (data['w_desease1'])
                              ?
                              Container(                              
                                child:Text("Yes"),
                              )
                              :
                              Container(                              
                                child:Text("No"),
                              ),),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(flex: 60, child: Text("02.Hypertension")),
                        Expanded(
                            flex: 20,
                            child: (data['m_desease2'])
                              ?
                              Container(                              
                                child:Text("Yes"),
                              )
                              :
                              Container(                              
                                child:Text("No"),
                              ),),
                        Expanded(
                            flex: 20,
                            child: (data['w_desease2'])
                              ?
                              Container(                              
                                child:Text("Yes"),
                              )
                              :
                              Container(                              
                                child:Text("No"),
                              ),),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(flex: 60, child: Text("03.Cardiac Diseases")),
                        Expanded(
                            flex: 20,
                            child: (data['m_desease3'])
                              ?
                              Container(                              
                                child:Text("Yes"),
                              )
                              :
                              Container(                              
                                child:Text("No"),
                              )                               
                        ),
                        Expanded(
                            flex: 20,
                            child: (data['w_desease3'])
                              ?
                              Container(                              
                                child:Text("Yes"),
                              )
                              :
                              Container(                              
                                child:Text("No"),
                              )                               
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(flex: 60, child: Text("04.Renal Diseases")),
                        Expanded(
                            flex: 20,
                            child: (data['m_desease4'])
                              ?
                              Container(                              
                                child:Text("Yes"),
                              )
                              :
                              Container(                              
                                child:Text("No"),
                              )                               
                        ),
                        Expanded(
                            flex: 20,
                            child: (data['w_desease1'])
                              ?
                              Container(                              
                                child:Text("Yes"),
                              )
                              :
                              Container(                              
                                child:Text("No"),
                              )                               
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(flex: 60, child: Text("05.Hepatic Diseases")),
                        Expanded(
                            flex: 20,
                           child: (data['m_desease5'])
                              ?
                              Container(                              
                                child:Text("Yes"),
                              )
                              :
                              Container(                              
                                child:Text("No"),
                              )                               
                        ),
                        Expanded(
                            flex: 20,
                            child: (data['w_desease5'])
                              ?
                              Container(                              
                                child:Text("Yes"),
                              )
                              :
                              Container(                              
                                child:Text("No"),
                              )                               
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(flex: 60, child: Text("06.Psychiatric Illnesses")),
                        Expanded(
                            flex: 20,
                            child: (data['m_desease6'])
                              ?
                              Container(                              
                                child:Text("Yes"),
                              )
                              :
                              Container(                              
                                child:Text("No"),
                              )                               
                        ),
                        Expanded(
                            flex: 20,
                            child: (data['w_desease6'])
                              ?
                              Container(                              
                                child:Text("Yes"),
                              )
                              :
                              Container(                              
                                child:Text("No"),
                              )                               
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(flex: 60, child: Text("07.Epilepsy")),
                        Expanded(
                            flex: 20,
                            child: (data['m_desease7'])
                              ?
                              Container(                              
                                child:Text("Yes"),
                              )
                              :
                              Container(                              
                                child:Text("No"),
                              )                               
                        ),
                        Expanded(
                            flex: 20,
                            child: (data['w_desease7'])
                              ?
                              Container(                              
                                child:Text("Yes"),
                              )
                              :
                              Container(                              
                                child:Text("No"),
                              )                               
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(flex: 60, child: Text("08.Malignancies")),
                        Expanded(
                            flex: 20,
                            child: (data['m_desease8'])
                              ?
                              Container(                              
                                child:Text("Yes"),
                              )
                              :
                              Container(                              
                                child:Text("No"),
                              )                               
                        ),
                        Expanded(
                            flex: 20,
                            child: (data['w_desease8'])
                              ?
                              Container(                              
                                child:Text("Yes"),
                              )
                              :
                              Container(                              
                                child:Text("No"),
                              )                               
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(flex: 60, child: Text("09.Haematological Diseases")),
                        Expanded(
                            flex: 20,
                            child: (data['m_desease9'])
                              ?
                              Container(                              
                                child:Text("Yes"),
                              )
                              :
                              Container(                              
                                child:Text("No"),
                              )                               
                        ),
                        Expanded(
                            flex: 20,
                            child: (data['w_desease9'])
                              ?
                              Container(                              
                                child:Text("Yes"),
                              )
                              :
                              Container(                              
                                child:Text("No"),
                              )                               
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(flex: 60, child: Text("10.Tuberculosis")),
                        Expanded(
                            flex: 20,
                            child: (data['m_desease10'])
                              ?
                              Container(                              
                                child:Text("Yes"),
                              )
                              :
                              Container(                              
                                child:Text("No"),
                              )                               
                        ),
                        Expanded(
                            flex: 20,
                            child: (data['w_desease10'])
                              ?
                              Container(                              
                                child:Text("Yes"),
                              )
                              :
                              Container(                              
                                child:Text("No"),
                              )                               
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(flex: 60, child: Text("11.Thyroid Diseases")),
                        Expanded(
                            flex: 20,
                            child: (data['m_desease11'])
                              ?
                              Container(                              
                                child:Text("Yes"),
                              )
                              :
                              Container(                              
                                child:Text("No"),
                              )                               
                        ),
                        Expanded(
                            flex: 20,
                            child: (data['w_desease11'])
                              ?
                              Container(                              
                                child:Text("Yes"),
                              )
                              :
                              Container(                              
                                child:Text("No"),
                              )                               
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(flex: 60, child: Text("12.Bronchial Asthma")),
                        Expanded(
                            flex: 20,
                            child: (data['m_desease12'])
                              ?
                              Container(                              
                                child:Text("Yes"),
                              )
                              :
                              Container(                              
                                child:Text("No"),
                              )                               
                        ),
                        Expanded(
                            flex: 20,
                            child: (data['w_desease12'])
                              ?
                              Container(                              
                                child:Text("Yes"),
                              )
                              :
                              Container(                              
                                child:Text("No"),
                              )                               
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(flex: 60, child: Text("13.Previous DVT")),
                        Expanded( 
                            flex: 20,
                            child: (data['m_desease13'])
                              ?
                              Container(                              
                                child:Text("Yes"),
                              )
                              :
                              Container(                              
                                child:Text("No"),
                              )                               
                        ),
                        Expanded(
                            flex: 20,
                            child: (data['w_desease13'])
                              ?
                              Container(                              
                                child:Text("Yes"),
                              )
                              :
                              Container(                              
                                child:Text("No"),
                              )                               
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(flex: 60, child: Text("14.Surgeries other than LSCS")),
                        Expanded(
                            flex: 20,
                            child: (data['m_desease14'])
                              ?
                              Container(                              
                                child:Text("Yes"),
                              )
                              :
                              Container(                              
                                child:Text("No"),
                              )                               
                        ),
                        Expanded(
                            flex: 20,
                            child: (data['w_desease14'])
                              ?
                              Container(                              
                                child:Text("Yes"),
                              )
                              :
                              Container(                              
                                child:Text("No"),
                              )                               
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(flex: 60, child: Text("15.HIV")),
                        Expanded(
                            flex: 20,
                            child: (data['m_desease15'])
                              ?
                              Container(                              
                                child:Text("Yes"),
                              )
                              :
                              Container(                              
                                child:Text("No"),
                              )                               
                        ),
                        Expanded(
                            flex: 20,
                            child: (data['w_desease15'])
                              ?
                              Container(                              
                                child:Text("Yes"),
                              )
                              :
                              Container(                              
                                child:Text("No"),
                              )                               
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Divider(height: 5,),
            Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex:60,
                            child: Text('Have you got rubella imunization..? '),
                          ),
                          Expanded(
                            flex:20,
                            child: Text('....................'),
                          ),
                          Expanded(
                            flex:20,
                            child: Text(" ${data['_rubellaDropDownValue']} "))
                        ],
                      ),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex:60,
                            child: Text('Have you got formic acid in everyday..? '),
                          ),
                          Expanded(
                            flex:20,
                            child: Text('....................'),
                          ),
                          Expanded(
                            flex:20,
                            child: Text(" ${data['_formicDropDownValue']} "))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex:60,
                            child: Text('Consangunity..? '),
                          ),Expanded(
                            flex:20,
                            child: Text('....................'),
                          ),
                          Expanded(
                            flex:20,
                            child: Text(" ${data['_conDropDownValue']} "))
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ) );
        }

        return Text("Wait Few Second");
      },
    );
  }
}
