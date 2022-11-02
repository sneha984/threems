// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:threems/screens/splash_screen.dart';
// import 'package:threems/utils/themes.dart';
//
// class CreateRoomScreen extends StatefulWidget {
//   CreateRoomScreen({Key? key}) : super(key: key);
//
//   @override
//   State<CreateRoomScreen> createState() => _CreateRoomScreenState();
// }
//
// class _CreateRoomScreenState extends State<CreateRoomScreen> {
//   String? dropdownValue;
//   List dropDownList = ["1", "2", "3", "4"];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 5,
//         shadowColor: Colors.black.withOpacity(.2),
//         backgroundColor: Colors.white,
//         leading: InkWell(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Icon(
//             Icons.arrow_back_rounded,
//             color: Colors.black,
//           ),
//         ),
//         title: Text(
//           "Create Room",
//           style: TextStyle(
//               fontSize: FontSize17,
//               fontFamily: 'Urbanist',
//               fontWeight: FontWeight.w600,
//               color: Colors.black),
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(
//           horizontal: padding15,
//           vertical: scrWidth * 0.05,
//         ),
//         child: SingleChildScrollView(
//           physics: BouncingScrollPhysics(),
//           child: Column(
//             children: [
//               Container(
//                 width: scrWidth,
//                 // color: Colors.red,
//                 height: scrWidth * 0.2,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       // color: Colors.pink,
//                       width: textFormFieldWidth280,
//                       height: textFormFieldHeight45,
//
//                       child: TextFormField(
//                         decoration: InputDecoration(
//                           contentPadding: EdgeInsets.only(
//                             left: textFormFieldPadding19,
//                           ),
//                           hintText: 'Name',
//                           hintStyle: TextStyle(
//                             fontSize: FontSize15,
//                             fontFamily: 'Urbanist',
//                             fontWeight: FontWeight.w500,
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: BorderSide(
//                               color: Colors.grey,
//                             ),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: BorderSide(
//                               color: Colors.grey,
//                             ),
//                           ),
//                           disabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: BorderSide(
//                               color: Colors.grey,
//                             ),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: BorderSide(
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SvgPicture.asset(
//                       "assets/icons/camera.svg",
//                       height: scrWidth * 0.06,
//                       width: scrWidth * 0.08,
//                       // height: 21,
//                       // width: 25,
//                     )
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: scrWidth * 0.01,
//                 // height: 14,
//               ),
//               Container(
//                 width: scrWidth,
//                 // color: Colors.red,
//                 height: textFormFieldHeight45,
//                 child: Container(
//                   // color: Colors.pink,
//                   width: scrWidth * 0.8,
//                   height: textFormFieldHeight45,
//                   child: TextFormField(
//                     decoration: InputDecoration(
//                       contentPadding: EdgeInsets.only(
//                         left: textFormFieldPadding19,
//                       ),
//                       hintText: 'Description',
//                       hintStyle: TextStyle(
//                         fontSize: FontSize15,
//                         fontFamily: 'Urbanist',
//                         fontWeight: FontWeight.w500,
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide(
//                           color: Colors.grey,
//                         ),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide(
//                           color: Colors.grey,
//                         ),
//                       ),
//                       disabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide(
//                           color: Colors.grey,
//                         ),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide(
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: scrWidth * 0.04,
//               ),
//               Container(
//                 width: scrWidth,
//                 // color: Colors.red,
//                 height: textFormFieldHeight45,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Container(
//                       // color: Colors.pink,
//                       width: scrWidth * 0.44,
//                       // width: 157,
//                       height: textFormFieldHeight45,
//                       child: TextFormField(
//                         decoration: InputDecoration(
//                           contentPadding: EdgeInsets.only(
//                             left: textFormFieldPadding19,
//                           ),
//                           hintText: 'Value',
//                           hintStyle: TextStyle(
//                             fontSize: FontSize15,
//                             fontFamily: 'Urbanist',
//                             fontWeight: FontWeight.w500,
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: BorderSide(
//                               color: Colors.grey,
//                             ),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: BorderSide(
//                               color: Colors.grey,
//                             ),
//                           ),
//                           disabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: BorderSide(
//                               color: Colors.grey,
//                             ),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: BorderSide(
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: scrWidth * 0.04,
//                       // width: 19,
//                     ),
//                     Container(
//                       // color: Colors.pink,
//                       width: scrWidth * 0.44,
//                       height: textFormFieldHeight45,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(
//                           width: 1.1,
//                           color: Colors.grey,
//                         ),
//                       ),
//                       padding: EdgeInsets.symmetric(horizontal: padding15),
//                       child: DropdownButton(
//                         icon: Icon(
//                           Icons.arrow_drop_down_rounded,
//                           size: 30,
//                         ),
//                         underline: Container(),
//                         isExpanded: true,
//                         borderRadius: BorderRadius.circular(12),
//                         style: TextStyle(
//                           fontSize: FontSize15,
//                           fontFamily: 'Urbanist',
//                           color: Colors.black,
//                           fontWeight: FontWeight.w500,
//                         ),
//                         hint: Text(
//                           "Duration",
//                           style: TextStyle(
//                             fontSize: FontSize15,
//                             fontFamily: 'Urbanist',
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         value: dropdownValue,
//                         onChanged: (value) {
//                           dropdownValue = value.toString();
//                           setState(() {});
//                         },
//                         items: dropDownList
//                             .map(
//                               (value) => DropdownMenuItem(
//                                 value: value,
//                                 child: Text(value.toString()),
//                               ),
//                             )
//                             .toList(),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: scrWidth * 0.04,
//               ),
//               Container(
//                 width: scrWidth,
//                 // color: Colors.red,
//                 height: textFormFieldHeight45,
//                 child: Container(
//                   // color: Colors.pink,
//                   width: scrWidth * 0.8,
//                   height: textFormFieldHeight45,
//                   child: TextFormField(
//                     decoration: InputDecoration(
//                       contentPadding: EdgeInsets.only(
//                         left: textFormFieldPadding19,
//                       ),
//                       hintText: 'Subscription Amount',
//                       hintStyle: TextStyle(
//                         fontSize: FontSize15,
//                         fontFamily: 'Urbanist',
//                         fontWeight: FontWeight.w500,
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide(
//                           color: Colors.grey,
//                         ),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide(
//                           color: Colors.grey,
//                         ),
//                       ),
//                       disabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide(
//                           color: Colors.grey,
//                         ),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide(
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: scrWidth * 0.04,
//               ),
//               Container(
//                 width: scrWidth,
//                 // color: Colors.red, ...
//                 height: textFormFieldHeight45,
//                 child: Container(
//                   // color: Colors.pink,
//                   width: scrWidth * 0.8,
//                   height: textFormFieldHeight45,
//                   child: TextFormField(
//                     decoration: InputDecoration(
//                       contentPadding: EdgeInsets.only(
//                         left: textFormFieldPadding19,
//                       ),
//                       suffixIcon: Padding(
//                         padding: const EdgeInsets.all(9.0),
//                         child: SvgPicture.asset(
//                           "assets/icons/contacts.svg",
//                           height: scrWidth * 0.07,
//                           width: scrWidth * 0.07,
//                           // height: 26,
//                           // width: 23,
//                         ),
//                       ),
//                       hintText: 'Invite Members',
//                       hintStyle: TextStyle(
//                         fontSize: FontSize15,
//                         fontFamily: 'Urbanist',
//                         fontWeight: FontWeight.w500,
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide(
//                           color: Colors.grey,
//                         ),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide(
//                           color: Colors.grey,
//                         ),
//                       ),
//                       disabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide(
//                           color: Colors.grey,
//                         ),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide(
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: scrWidth * 0.04,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
