
import 'package:flutter/material.dart';



int _activeStepIndex=0;

class Expense extends StatefulWidget {
  const Expense({Key? key}) : super(key: key);

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  TextEditingController controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Expense"),),
      // body:Column(
      //   children: [
      //     Padding(
      //       padding:  EdgeInsets.only(left: 30,top: 40),
      //       child: AnotherStepper(
      //         titleTextStyle: TextStyle(
      //           fontSize: 16,
      //             fontWeight: FontWeight.w600,
      //             fontFamily: 'Urbanist',
      //             color: Color(0xff232323),
      //         ),
      //         subtitleTextStyle: TextStyle(
      //           fontSize: 12,
      //           fontWeight: FontWeight.w600,
      //           fontFamily: 'Urbanist',
      //           color: Color(0xff8B8B8B),
      //         ),
      //         dotWidget: Container(
      //           height: 35,
      //           width: 35,
      //           decoration: BoxDecoration(
      //               color: Color(0xff30CF7C),
      //               borderRadius: BorderRadius.circular(30),
      //             border: Border.all(color: primarycolor,width: 2)
      //           ),
      //         ),
      //         stepperList: [
      //           StepperData(
      //             title: "Create online store",
      //             subtitle: "Congratulations on opening your new \nonline store!",
      //           ),
      //           StepperData(
      //             title: "Add Product",
      //             subtitle: "Create your first product by adding the \nproduct name and images.",
      //           ),
      //         ],
      //         horizontalStepperHeight:300,
      //         stepperDirection: Axis.vertical,
      //         inActiveBarColor: Colors.grey,
      //         activeIndex: 1,
      //         barThickness: 2,
      //         activeBarColor: primarycolor,
      //       ),
      //     ),
      //     Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Center(
      //           child: Text(
      //             'Enter Youtube Link',
      //             style: TextStyle(
      //               fontSize: 26,
      //             ),
      //           ),
      //         ),
      //         SizedBox(
      //           height: 20,
      //         ),
      //         Container(
      //           margin: EdgeInsets.symmetric(horizontal: 20),
      //           child: TextFormField(
      //             controller: controller,
      //             decoration: InputDecoration(
      //               enabledBorder: OutlineInputBorder(
      //                 borderRadius: BorderRadius.circular(5),
      //               ),
      //               focusedBorder: OutlineInputBorder(
      //                 borderRadius: BorderRadius.circular(5),
      //               ),
      //             ),
      //           ),
      //         ),
      //         SizedBox(
      //           height: 20,
      //         ),
      //         ElevatedButton.icon(
      //             onPressed: () {
      //               Navigator.push(
      //                   context,
      //                   MaterialPageRoute(
      //                       builder: (context) => Simple(
      //                         youtubeLink: controller.text.trim(),
      //                       )));
      //             },
      //             icon: Icon(Icons.ondemand_video),
      //             label: Text(
      //               'Play',
      //               style: TextStyle(fontSize: 16),
      //             ))
      //       ],
      //     ),
      //   ],
      // ),
      // Stepper(
      //   currentStep: _activeStepIndex,
      //     steps: stepList(),
      //   onStepContinue: (){
      //     if(_activeStepIndex <(stepList().length-1)){
      //       _activeStepIndex=_activeStepIndex+1;
      //     }
      //     setState(() {
      //     });
      //   },
      //   onStepCancel: (){
      //     if(_activeStepIndex==0){
      //       return;
      //     }
      //     _activeStepIndex-=1;
      //     setState(() {
      //
      //     });
      //   },
      // ),

      // body: Center(
      //   child: Container(
      //     width: scrWidth * 0.9,
      //     height: textFormFieldHeight45,
      //     decoration: BoxDecoration(
      //       color: textFormFieldFillColor,
      //       borderRadius:
      //       BorderRadius.circular(scrWidth * 0.033),
      //     ),
      //     // padding: EdgeInsets.only(
      //     //     left: scrWidth * 0.051,
      //     //     right: scrWidth * 0.04),
      //     child: Row(
      //       children: [
      //         SizedBox(width: scrWidth*0.04,),
      //
      //         SvgPicture.asset(
      //           'assets/icons/storecategory.svg',
      //           fit: BoxFit.contain,
      //         ),
      //         SizedBox(width: scrWidth*0.04,),
      //         DropdownButtonHideUnderline(
      //           child: DropdownButton2(
      //
      //             isExpanded: true,
      //             hint: Expanded(
      //               child:  Text(
      //                 "Store Category",
      //                 style: TextStyle(
      //                     fontSize: FontSize15,
      //                     fontFamily: 'Urbanist',
      //                     fontWeight: FontWeight.w600,
      //                     color: Color(0xffB0B0B0)
      //                 ),
      //               ),
      //             ),
      //             items: items
      //                 .map((item) => DropdownMenuItem<String>(
      //               value: item,
      //               child:  Flexible(
      //                 child: Container(
      //                   child: Text(
      //                     item.toString(),overflow: TextOverflow.ellipsis,
      //                     style: TextStyle(
      //                         fontWeight: FontWeight.w600,
      //                         fontSize: 14,
      //                         fontFamily: 'Urbanist'
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             ))
      //                 .toList(),
      //             value: selectedValue,
      //             onChanged: (value) {
      //               setState(() {
      //                 selectedValue = value as String;
      //               });
      //             },
      //             icon: const Icon(
      //               Icons.arrow_drop_down,
      //             ),
      //             iconSize: 18,
      //             iconEnabledColor: Colors.black,
      //             iconDisabledColor: Colors.blue,
      //             buttonHeight: 50,
      //             buttonWidth:270,
      //             buttonPadding: const EdgeInsets.only(right: 10),
      //             buttonDecoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(14),
      //               color: textFormFieldFillColor,
      //             ),
      //             // buttonElevation: 2,
      //             itemHeight: 40,
      //             itemPadding: const EdgeInsets.only(),
      //             dropdownMaxHeight: 260,
      //             dropdownWidth: 300,
      //             dropdownPadding: EdgeInsets.only(left: 30,top: 15,bottom: 25,right: 30),
      //             dropdownDecoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(8),
      //               color: Colors.white,
      //             ),
      //             dropdownElevation: 0,
      //
      //             scrollbarRadius:  Radius.circular(10),
      //             scrollbarThickness: 3,
      //             scrollbarAlwaysShow: true,
      //             offset: const Offset(-20, 0),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
    //   Scaffold(
    //   body: Center(
    //     child: Text("Expense"),
    //   ),
    // );
  }
}
