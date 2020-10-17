import 'package:flutter/material.dart';
import 'package:mun_care_app/screens/registration/ComFamReg02.dart';
import 'package:flutter/src/rendering/box.dart';
import 'ComFamReg01.dart';


class ComFamReg extends StatefulWidget {
  @override
  _ComFamRegState createState() => _ComFamRegState();
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
class _ComFamRegState extends State<ComFamReg> {


  List<Step> steps = [
    Step(
      title: const Text("Step 01"),
      isActive: true,
      state: StepState.complete,
      content: Container(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Container(
                height: 100,
                child: Text(
                  "Registration",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(500, 21, 166, 211),
                    fontSize: 30,
                  ),
                ),
              ),
          ],
        ),
      )
    ),
    Step(
        title: const Text("Step 02"),
        isActive: false,
        state: StepState.editing,
        //content: ComFamRegNext(),
        content: Text("HEllo")
        ),
    Step(
        title: const Text("Step 03"),
        isActive: false,
        state: StepState.editing,
        //content: ComFamRegNext02(),
        content: Text("HEllo")
        ),
  ];
  StepperType stepperType = StepperType.horizontal;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(
      children: <Widget>[
        Expanded(
            child: Stepper(
                steps: steps,
                type: stepperType,
              ),
          ),
      ],
        )
    );
  }
}
