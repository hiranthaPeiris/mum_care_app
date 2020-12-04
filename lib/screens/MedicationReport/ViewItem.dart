import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mun_care_app/helpers/Constants.dart';
import 'package:mun_care_app/helpers/Loading.dart';
import 'package:mun_care_app/models/MediModel.dart';

class ViewItem extends StatefulWidget {
  final QueryDocumentSnapshot documentSnapshot;
  const ViewItem({Key key, this.documentSnapshot}) : super(key: key);

  @override
  _ViewItemState createState() => _ViewItemState();
}

class _ViewItemState extends State<ViewItem> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String remarks;
  bool pending = false;

  @override
  Widget build(BuildContext context) {
    MediData mediData = MediData.fromSnapshot(widget.documentSnapshot);

    return pending
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: Builder(
              builder: (context) => Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: kBackground,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Medication Report",
                        style: TextStyle(
                            color: kTextColor,
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "by Mrs. ${mediData.name}",
                        style: TextStyle(color: kTextColor, fontSize: 16.0),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          )),
                      height: MediaQuery.of(context).size.height * 0.6,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                10.0, 15.0, 0.0, 10.0),
                            child: Text(
                              "Date of Medication: ${mediData.date}",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16.0),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 10.0),
                            child: Text(
                              "NIC: ${mediData.nic}",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16.0),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 10.0),
                            child: Text(
                              "Descrition: ${mediData.description}",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16.0),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 10.0),
                            child: Text(
                              "vaccine: ${mediData.vaccine}",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16.0),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 10.0),
                            child: Text(
                              "Mother Remarks: ${mediData.mumRemarks}",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16.0),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  remarks = value;
                                });
                              },
                              decoration: InputDecoration(labelText: 'Remarks'),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 20.0),
                            child: Row(
                              children: <Widget>[
                                FlatButton(
                                  shape: StadiumBorder(),
                                  child: Text(
                                    "Close",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  ),
                                  onPressed: () {
                                    //Put your code here which you want to execute on No button click.

                                    Navigator.of(context).pop();
                                  },
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                RaisedButton(
                                  shape: StadiumBorder(),
                                  color: kBackground,
                                  child: Text(
                                    "Submit",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  ),
                                  onPressed: () {
                                    dynamic rst = mediUpdate(
                                        widget.documentSnapshot, remarks);
                                    if (rst != null) {
                                      _displaySnackBar(context);
                                    }else{
                                      print("Error");
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  _displaySnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Successfully submited'),
      action: SnackBarAction(
        label: 'Go Back',
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      duration: Duration(seconds: 3),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }

  Future<dynamic> mediUpdate(
      QueryDocumentSnapshot documentSnapshot, String remarks) async {
    return await _firestore
        .collection('informMedical')
        .doc(documentSnapshot.id)
        .set({'_midwifeRemarks': remarks})
        .then((value) => print("updated"))
        .catchError((err) => print(err));
  }
}
