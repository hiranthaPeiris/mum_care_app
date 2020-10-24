import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PreFamReg extends StatefulWidget {
  @override
  _PreFamRegState createState() => _PreFamRegState();
}

Widget showTextField(String hintText, String inputName,TextEditingController controller) {
  return TextFormField(
    maxLines: 1,
    controller: controller,
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

class ShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.blueAccent;

    var rect = Rect.fromLTWH(0, 0, size.width, size.height * 0.7);
    canvas.drawRect(rect, paint);
  }

  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _PreFamRegState extends State<PreFamReg> {
  int currentStep = 0;
  bool complete = false;

  TextEditingController myController12=new TextEditingController();
  TextEditingController myController13=new TextEditingController();
  TextEditingController myController14=new TextEditingController();
  TextEditingController myController15=new TextEditingController();
  TextEditingController myController16=new TextEditingController();
  TextEditingController myController17=new TextEditingController();
  TextEditingController myController18=new TextEditingController();
  TextEditingController myController19=new TextEditingController();
  TextEditingController myController20=new TextEditingController();
  TextEditingController myController21=new TextEditingController();
  TextEditingController myController22=new TextEditingController();
  String wombDropdownValue = "G1";

  bool diabetic_Yes = false;
  bool maleria_Yes = false;
  bool heartDisorders_Yes = false;
  bool kidneyDisorders_Yes = false;

  DateTime _dateDOB;
  DateTime _dateMarrage;

  Widget build(BuildContext context) {
    Widget wombDropDownMenu() {
      return DropdownButton<String>(
        value: wombDropdownValue,
        icon: Icon(Icons.arrow_downward),
        iconSize: 18,
        elevation: 36,
        isExpanded: true,
       // style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        items:
            <String>['G1', 'G2','G3','G4','G5','G6','G7'].map<DropdownMenuItem<String>>((String value) {
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
          setState(() {
            wombDropdownValue = value;
          });
        },
      );
    }

    List<Step> steps = [
      Step(
          title: const Text(
            "Step  1",
            style: TextStyle(
                fontSize: 10, color: Color.fromARGB(500, 21, 166, 211)),
          ),
          isActive: true,
          state: StepState.indexed,
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.height * 0.001,
                    MediaQuery.of(context).size.height * 0.01,
                    MediaQuery.of(context).size.width * 0.4,
                    MediaQuery.of(context).size.height * 0.03),
                child: Container(
                  child: Text(
                    "Registration",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(500, 21, 166, 211),
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                child: CustomPaint(
                  painter: ShapePainter(),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * 0.05,
                        MediaQuery.of(context).size.height * 0.016,
                        MediaQuery.of(context).size.width * 0.4,
                        MediaQuery.of(context).size.height * 0.01),
                    child: Text(
                      "Pregnency Family",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.05,
                      MediaQuery.of(context).size.height * 0.025,
                      MediaQuery.of(context).size.width * 0.05,
                      MediaQuery.of(context).size.height * 0.005),
                  child: showTextField("Grama Niladhari Division", "gnDivision",myController12),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.05,
                      MediaQuery.of(context).size.height * 0.025,
                      MediaQuery.of(context).size.width * 0.05,
                      MediaQuery.of(context).size.height * 0.005),
                  child: showTextField("Name of the Field Clinic", "fcName",myController13),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.05,-
                      MediaQuery.of(context).size.height * 0.025,
                      MediaQuery.of(context).size.width * 0.05,
                      MediaQuery.of(context).size.height * 0.005),
                  child: showTextField("Name of the Hospital in Clinic", "hcName",myController14),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.05,
                      MediaQuery.of(context).size.height * 0.025,
                      MediaQuery.of(context).size.width * 0.05,
                      MediaQuery.of(context).size.height * 0.005),
                  child: showTextField("Name of the Consultant Obstetrician", "coName",myController15),
                ),
              ),
              
            ],
          )),
      Step(
        title: const Text(
          "Step 2",
          style:
              TextStyle(fontSize: 10, color: Color.fromARGB(500, 21, 166, 211)),
        ),
        isActive: true,
        state: StepState.indexed,
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.05,
                  MediaQuery.of(context).size.height * 0.03,
                  MediaQuery.of(context).size.width * 0.03,
                  MediaQuery.of(context).size.height * 0.03),
              child: Container(
                child: Text(
                  "Pre Obstetric History",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    // color: Color.fromARGB(500, 21, 166, 211),
                    fontSize: 20,
                  ),
                ),
              ),
            ),

              Container(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                          flex: 60,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 25,
                              child: Text(
                                "What a Womb",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                   fontSize: 15, ),
                              ),
                            ),
                          )),
                      Expanded(
                        flex: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              height: 25,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0),
                                  boxShadow: [
                                    new BoxShadow(
                                        color: Colors.black, blurRadius: 80.0),
                                  ],
                                  color: Colors.grey[300],
                                  border: Border.all(
                                      color: Colors.black,
                                      style: BorderStyle.solid,
                                      width: 0.5)),
                              child: wombDropDownMenu()),
                        ),
                      ),
                      Expanded(flex: 10, child: Container()),
                    ],
                  ),
                ],
              ),
            ),
            Container(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.05,
                      MediaQuery.of(context).size.height * 0.025,
                      MediaQuery.of(context).size.width * 0.05,
                      MediaQuery.of(context).size.height * 0.005),
                  child: showTextField("Result", "pohResult",myController16),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.05,
                      MediaQuery.of(context).size.height * 0.025,
                      MediaQuery.of(context).size.width * 0.05,
                      MediaQuery.of(context).size.height * 0.005),
                  child: showTextField("Details", "pohDetails",myController17),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.05,
                      MediaQuery.of(context).size.height * 0.025,
                      MediaQuery.of(context).size.width * 0.05,
                      MediaQuery.of(context).size.height * 0.005),
                child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                            flex: 30,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 25,
                                child: Text(
                                  "Birth Weight",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                     fontSize: 16, ),
                                ),
                              ),
                            )),
                        Expanded(
                          flex: 15,
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Container(
                                height: 30,
                                alignment: Alignment.center,
                                child:  showTextField("", "kgWeight",myController18),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0),
                                  color: Colors.grey[300],
                                  border: Border.all(
                                      color: Colors.black,
                                      style: BorderStyle.solid,
                                      width: 0.5)),
                              ),
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Text("Kg")
                          ),
                        ),
                        Expanded(
                          flex: 15,
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Container(
                                height: 30,
                                alignment: Alignment.center,
                                child:  showTextField("", "gWeight",myController19),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0),
                                  color: Colors.grey[300],
                                  border: Border.all(
                                      color: Colors.black,
                                      style: BorderStyle.solid,
                                      width: 0.5)),
                              ),
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Text("g"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
            ),
              ),
            Container(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.05,
                      MediaQuery.of(context).size.height * 0.025,
                      MediaQuery.of(context).size.width * 0.05,
                      MediaQuery.of(context).size.height * 0.005),
                  child: showTextField("Sex", "pohDetails",myController20),
                ),
              ),
          ],
        ),
      ),
      Step(
          title: const Text(
            "Step 3",
            style: TextStyle(
                fontSize: 10, color: Color.fromARGB(500, 21, 166, 211)),
          ),
          isActive: true,
          state: StepState.indexed,
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.05,
                  MediaQuery.of(context).size.height * 0.01,
                  MediaQuery.of(context).size.width * 0.03,
                  MediaQuery.of(context).size.height * 0.01),
              child: Container(
                child: Text(
                  "Present Obstetric History",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    // color: Color.fromARGB(500, 21, 166, 211),
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Container(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.05,
                      MediaQuery.of(context).size.height * 0.025,
                      MediaQuery.of(context).size.width * 0.05,
                      MediaQuery.of(context).size.height * 0.005),
                  child: showTextField("Present vaginal bleeding", "pvb",myController21),
                ),
              ),
               Container(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.05,
                      MediaQuery.of(context).size.height * 0.025,
                      MediaQuery.of(context).size.width * 0.05,
                      MediaQuery.of(context).size.height * 0.005),
                  child: showTextField("Blood Pressure", "bloodPressure",myController22),
                ),
              ),
              Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.05,
                  MediaQuery.of(context).size.height * 0.03,
                  MediaQuery.of(context).size.width * 0.03,
                  MediaQuery.of(context).size.height * 0.03),
              child: Container(
                child: Text(
                  "Medical/Surgical History",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    // color: Color.fromARGB(500, 21, 166, 211),
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.05,
                  MediaQuery.of(context).size.height * 0.01,
                  MediaQuery.of(context).size.width * 0.01,
                  MediaQuery.of(context).size.height * 0.01),
              child: Column(
                children: <Widget>[
                 Row(
                    children: <Widget>[
                            Expanded(flex: 40, child: Text("Diabetic")),
                            Expanded(
                                flex: 20,
                                child: Checkbox(
                                    value: diabetic_Yes,
                                    onChanged: (bool value) {
                                      setState(() {
                                        diabetic_Yes = value;
                                        print(value);
                                      });
                                    })),
                            Expanded(
                                flex: 40,
                                child:Container()),
                          ],
                        ),
                         Row(
                children: <Widget>[
                        Expanded(flex: 40, child: Text("Maleria")),
                        Expanded(
                            flex: 20,
                            child: Checkbox(
                                value: maleria_Yes,
                                onChanged: (bool value) {
                                  setState(() {
                                    maleria_Yes = value;
                                    print(value);
                                  });
                                })),
                        Expanded(
                            flex: 40,
                            child:Container()),
                      ],
                    ),
            Row(
                children: <Widget>[
                        Expanded(flex: 40, child: Text("Heart Disrders")),
                        Expanded(
                            flex: 20,
                            child: Checkbox(
                                value: heartDisorders_Yes,
                                onChanged: (bool value) {
                                  setState(() {
                                    heartDisorders_Yes = value;
                                    print(value);
                                  });
                                })),
                        Expanded(
                            flex: 40,
                            child:Container()),
                      ],
                    ),
            Row(
                children: <Widget>[
                        Expanded(flex: 40, child: Text("Kidney Disorders")),
                        Expanded(
                            flex: 20,
                            child: Checkbox(
                                value: kidneyDisorders_Yes,
                                onChanged: (bool value) {
                                  setState(() {
                                    kidneyDisorders_Yes = value;
                                    print(value);
                                  });
                                })),
                        Expanded(
                            flex: 40,
                            child:Container()),
                      ],
                    ),
                ]
              ),
            ),
           


            ],
          ))
    ];

    goto(int step) {
      setState(() {
        currentStep = step;
        //isActive=true;
      });
    }

    next() {
      currentStep + 1 != steps.length
          ? goto(currentStep + 1)
          : setState(() {
              complete = true;
            });
    }

    cancel() {
      if (currentStep > 0) {
        goto(currentStep - 1);
      }
    }

    return new Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        complete
            ? Expanded(
                child: Center(
                child: AlertDialog(
                  title: Text("Pregnancy Registration Succesfully"),
                  content: Text("Congratulation"),
                  actions: <Widget>[
                    Row(
                      children: <Widget>[
                        FlatButton(
                            child: Text("OK"),
                            onPressed: () {
                              setState(() {
                                complete = false;
                              });
                            }),
                        FlatButton(
                            child: Text("Cancel"),
                            onPressed: () {
                              setState(() {
                                complete = false;
                              });
                            }),
                      ],
                    ),
                  ],
                ),
              ))
            : Expanded(
                flex: 80,
                child: Stepper(
                  steps: steps,
                  type: StepperType.horizontal,
                  currentStep: currentStep,
                  onStepContinue: next,
                  onStepCancel: cancel,
                  onStepTapped: (step) => goto(step),
                  controlsBuilder: (BuildContext context,
                      {VoidCallback onStepContinue,
                      VoidCallback onStepCancel}) {
                    return Padding(
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.1,
                          MediaQuery.of(context).size.height * 0.005,
                          MediaQuery.of(context).size.width * 0.05,
                          MediaQuery.of(context).size.height * 0.005),
                      child: Container(
                        height: 100,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                flex: 50,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: RaisedButton(
                                    color: Colors.white,
                                    textColor:
                                        Color.fromARGB(500, 21, 166, 211),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        side: BorderSide(
                                          color:
                                              Color.fromARGB(500, 21, 166, 211),
                                        )),
                                    child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            new BoxShadow(
                                                color: Colors.black,
                                                blurRadius: 30.0),
                                          ],
                                        ),
                                        child: Text(
                                          "Prev",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )),
                                    onPressed: onStepCancel,
                                  ),
                                )),
                            Expanded(
                                flex: 50,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: RaisedButton(
                                    color: Color.fromARGB(500, 21, 166, 211),
                                    textColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        side: BorderSide(color: Colors.white)),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          new BoxShadow(
                                              color: Colors.black,
                                              blurRadius: 30.0),
                                        ],
                                      ),
                                      child: Text(
                                        "Continue",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    onPressed: onStepContinue,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
      ],
    ));
  }
}
