import 'package:flutter/material.dart';

class MultiStepForm extends StatefulWidget {
  @override
  _MultiStepFormState createState() => _MultiStepFormState();
}

class _MultiStepFormState extends State<MultiStepForm> {
  int currentStep = 0;
  TextEditingController firstController = TextEditingController();
  TextEditingController secondController = TextEditingController();
  TextEditingController thirdController = TextEditingController();
  TextEditingController fourthController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multi Stepper Form'),
        centerTitle: true,
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: Colors.blue // to change color of buttons, Not much help ful
          )
        ),
        child: Stepper(
          type: StepperType.vertical, // for vertical do: StepperType.vertical
          steps: getSteps(),
          currentStep: currentStep,
          //onStepTapped: (step) => setState(() => currentStep = step), // to make steps clickable
          controlsBuilder: (context, {onStepContinue, onStepCancel}){
            final isLastStep = currentStep == getSteps().length - 1;
            return Container(
              margin: EdgeInsets.only(top: 50),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      child: Text(isLastStep ? 'CONFIRM' : 'NEXT'),
                      onPressed: onStepContinue,
                    ),
                  ),
                  const SizedBox(width: 15,),
                  if(currentStep != 0) // to not show cancel at first step.
                  Expanded(
                    child: ElevatedButton(
                      child: Text('BACK'),
                      onPressed: onStepCancel,
                    ),
                  ),
                ],
              ),
            );
          },
          onStepContinue: (){
            final isLastStep = currentStep == getSteps().length - 1;
            if(isLastStep){
              // at final step,  eg:- send data to server function
            }else{
              if(currentStep == 0){
                if(firstController.text.isNotEmpty && secondController.text.isNotEmpty){
                  setState(() => currentStep += 1);
                }
              }else if(currentStep == 1){
                if(thirdController.text.isNotEmpty){
                  setState(() => currentStep += 1);
                }
              }

            }
          },
          onStepCancel: currentStep == 0 ? null : () => setState(() => currentStep -= 1),
        ),
      ),
    );
  }

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete: StepState.indexed,
          isActive: currentStep >= 0,
            title: Text('Account'),
            content: Container(
              child: Column(
                children: [
                  TextField(
                    controller: firstController,
                    decoration: InputDecoration(
                      hintText: 'First name *',
                      border: OutlineInputBorder()
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    controller: secondController,
                    decoration: InputDecoration(
                        hintText: 'Last name *',
                        border: OutlineInputBorder()
                    ),
                  ),
                ],
              ),
            ),
        ),
        Step(
            state: currentStep > 1 ? StepState.complete: StepState.indexed,
            isActive: currentStep >= 1,
            title: Text('Address'),
            content: Container(
              child: Column(
                children: [
                  TextField(
                    controller: thirdController,
                    decoration: InputDecoration(
                        hintText: 'pincode *',
                        border: OutlineInputBorder()
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    controller: fourthController,
                    decoration: InputDecoration(
                        hintText: 'city name',
                        border: OutlineInputBorder()
                    ),
                  ),
                ],
              ),
            )
        ),
        Step(
            isActive: currentStep >= 2,
            title: Text('Complete'),
            content: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('FirstName: ${firstController.text}', style: TextStyle(fontSize: 20, color: Colors.black),),
                  SizedBox(height: 5,),
                  Text('LastName: ${secondController.text}', style: TextStyle(fontSize: 20, color: Colors.black),),
                  SizedBox(height: 5,),
                  Text('Pincode: ${thirdController.text}', style: TextStyle(fontSize: 20, color: Colors.black),),
                  SizedBox(height: 5,),
                  Text('City: ${fourthController.text.isNotEmpty ? fourthController.text : 'Not Mention'}', style: TextStyle(fontSize: 20, color: Colors.black),)
                ],
              ),
            )
        )
      ];
}
