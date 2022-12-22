import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:threems/Notes/notes.dart';
import 'package:threems/kuri/kuripage.dart';
import 'package:threems/model/usermodel.dart';
import 'package:threems/phonebook/phone_book.dart';
import 'package:threems/screens/charity/basic_details.dart';
import 'package:threems/screens/chits/hostedchits.dart';
import 'package:threems/screens/flgraph.dart';
import 'package:threems/screens/splash_screen.dart';
import 'package:threems/utils/themes.dart';
import 'package:threems/widgets/fundraise_and_charity_widget.dart';
import 'package:threems/widgets/verified_charity_widget.dart';
import 'package:threems/widgets/head_image_slider.dart';
import 'package:threems/widgets/funding_widget.dart';
import 'package:threems/widgets/upcomming_card_widget.dart';

import '../Authentication/auth.dart';
import '../Authentication/root.dart';
import '../UpComing__Collection_&__Payments/Collections.dart';
import '../UpComing__Collection_&__Payments/payments.dart';
import '../kuri/createkuri.dart';
import '../model/charitymodel.dart';
import '../topbar/prifilepage.dart';
import '../topbar/settings.dart';
import 'charity/donatepage.dart';
import 'charity/seemorecharities.dart';

var currenPlace;
double? lat;
double? long;
List<Contact> contacts = [];

List<CharityModel> verifiedcharity = [];

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  askPermissions() async {
    PermissionStatus permission = await getContactPermission();
    if (permission == PermissionStatus.granted) {
      getContacts();
    } else {
      handleInvalidPermission(permission);
    }
  }

  handleInvalidPermission(PermissionStatus permission) {
    if (permission == PermissionStatus.denied) {
      showSnackbar(context, 'Permission denied by user');
    } else if (permission == PermissionStatus.permanentlyDenied) {
      showSnackbar(context, 'Permission denied by user');
    }
  }

  getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  getContacts() async {
    List<Contact> _contacts = await ContactsService.getContacts();

    setState(() {
      contacts = _contacts;

      print('================ContactLength=================');
      print(contacts.length);
    });
  }

  double selectedIndex = 0;
  getVerifiedCharity() {
    FirebaseFirestore.instance
        .collection('charity')
        .where('userId', isNotEqualTo: currentuser?.userId)
        .snapshots()
        .listen((event) {
      verifiedcharity = [];
      for (DocumentSnapshot<Map<String, dynamic>> doc in event.docs) {
        verifiedcharity.add(CharityModel.fromJson(doc.data()!));
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  Position? currentLoc;
  getLocation() async {
    try {
      currentLoc = await Geolocator.getCurrentPosition();
      print('00000000000000000000000000000000000000000000000000000');
      lat = currentLoc!.latitude;
      long = currentLoc!.longitude;
      List<Placemark> placemarks = await placemarkFromCoordinates(
          currentLoc!.latitude, currentLoc!.longitude);
      Placemark place = placemarks[0];
      currenPlace = place.locality;
      print(currenPlace.toString());
      print('kkkkkkkkkkkkkkkkkkkkkkkkplace');
    } catch (err) {
      print(err.toString());
      print('00000000000000000000000000000000000000000000000000000');
    }
  }
  List<UserModel> user=[];
  getCurrentUserDet(){
    FirebaseFirestore.instance.collection('users')
        .where('userId',isEqualTo: currentuserid).snapshots().listen((event) {
      user=[];
      for(DocumentSnapshot<Map<String,dynamic>> doc in event.docs){
        user.add(UserModel.fromJson(doc.data()!));
      }
      if(mounted){
        setState(() {

        });
      }
    });
  }
  final Authentication _authentication = Authentication();


  @override
  void initState() {
    getCurrentUserDet();

    askPermissions();
    getVerifiedCharity();
    getLocation();

    super.initState();
  }

  // void pay() {
  //   showDialog(
  //     context: context,
  //     builder: (context) => StatefulBuilder(
  //       builder: (BuildContext context, setState) {
  //         payableAmountNode.addListener(() {
  //           setState(() {});
  //         });
  //         return AlertDialog(
  //           shape:
  //               RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  //           title: Text('Pay the chit amount of September'),
  //           titleTextStyle: TextStyle(
  //               fontSize: FontSize10,
  //               fontFamily: 'Urbanist',
  //               fontWeight: FontWeight.w600,
  //               color: Color(0xff827C7C)),
  //           content: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Container(
  //                 width: scrWidth,
  //                 height: textFormFieldHeight45,
  //                 padding: EdgeInsets.symmetric(
  //                   horizontal: scrWidth * 0.015,
  //                   vertical: 2,
  //                 ),
  //                 decoration: BoxDecoration(
  //                   color: textFormFieldFillColor,
  //                   borderRadius: BorderRadius.circular(scrWidth * 0.026),
  //                 ),
  //                 child: TextFormField(
  //                   keyboardType: TextInputType.number,
  //                   inputFormatters: <TextInputFormatter>[
  //                     CurrencyTextInputFormatter(
  //                         locale: 'HI', decimalDigits: 0, symbol: '₹ '),
  //                   ],
  //                   focusNode: payableAmountNode,
  //                   cursorHeight: scrWidth * 0.055,
  //                   cursorWidth: 1,
  //                   cursorColor: Colors.black,
  //                   style: TextStyle(
  //                     color: Colors.black,
  //                     fontWeight: FontWeight.w600,
  //                     fontSize: FontSize15,
  //                     fontFamily: 'Urbanist',
  //                   ),
  //                   decoration: InputDecoration(
  //                     labelText: 'Payable Amount',
  //                     labelStyle: TextStyle(
  //                       color: payableAmountNode.hasFocus
  //                           ? primarycolor
  //                           : textFormUnFocusColor,
  //                       fontWeight: FontWeight.w600,
  //                       fontSize: FontSize15,
  //                       fontFamily: 'Urbanist',
  //                     ),
  //                     fillColor: textFormFieldFillColor,
  //                     filled: true,
  //                     contentPadding: EdgeInsets.only(
  //                         top: 5,
  //                         bottom: scrWidth * 0.033,
  //                         left: scrWidth * 0.033),
  //                     disabledBorder: InputBorder.none,
  //                     enabledBorder: InputBorder.none,
  //                     errorBorder: InputBorder.none,
  //                     border: InputBorder.none,
  //                     focusedBorder: UnderlineInputBorder(
  //                       borderSide: BorderSide(
  //                         color: primarycolor,
  //                         width: 2,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: scrWidth * 0.03,
  //               ),
  //               DottedBorder(
  //                 padding: EdgeInsets.all(0),
  //                 borderType: BorderType.RRect,
  //                 radius: Radius.circular(8),
  //                 color: Color(0xffDADADA),
  //                 strokeWidth: 2,
  //                 child: Container(
  //                   height: 56,
  //                   width: 256,
  //                   decoration: BoxDecoration(
  //                     color: Color(0xffF7F8F9),
  //                     borderRadius: BorderRadius.circular(8),
  //                   ),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       SvgPicture.asset(
  //                         "assets/icons/docCam.svg",
  //                         height: scrWidth * 0.04,
  //                         width: scrWidth * 0.05,
  //                         color: Color(0xff8391A1),
  //                         // height: 21,
  //                         // width: 25,
  //                       ),
  //                       SizedBox(
  //                         width: scrWidth * 0.02,
  //                       ),
  //                       Text(
  //                         "Upload Screenshot",
  //                         style: TextStyle(
  //                           color: Color(0xffB0B0B0),
  //                           fontSize: FontSize13,
  //                           fontFamily: 'Urbanist',
  //                           fontWeight: FontWeight.w500,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: scrWidth * 0.03,
  //               ),
  //               Container(
  //                 width: scrWidth,
  //                 height: textFormFieldHeight45,
  //                 decoration: BoxDecoration(
  //                     color: primarycolor,
  //                     borderRadius: BorderRadius.circular(8)),
  //                 child: Center(
  //                   child: GestureDetector(
  //                     onTap: () {},
  //                     child: Text(
  //                       "Confirm Pay",
  //                       style: TextStyle(
  //                           fontSize: FontSize16,
  //                           fontFamily: 'Urbanist',
  //                           fontWeight: FontWeight.w600,
  //                           color: Colors.white),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  // void joinChit() {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         titlePadding:
  //             EdgeInsets.only(top: 29, bottom: 0, left: 20, right: 20),
  //         contentPadding:
  //             EdgeInsets.only(top: 5, bottom: 23, left: 20, right: 20),
  //         title: Text(
  //           "Are you sure want to join this Chit?",
  //           style: TextStyle(
  //             color: Color(0xff2C2C2C),
  //             fontSize: FontSize15,
  //             fontFamily: "Urbanist",
  //             fontWeight: FontWeight.w700,
  //           ),
  //         ),
  //         content: Container(
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: [
  //               Text(
  //                 'You can join after the approvel of Admin',
  //                 style: TextStyle(
  //                   color: Color(0xff827C7C),
  //                   fontSize: FontSize10,
  //                   fontFamily: "Urbanist",
  //                   fontWeight: FontWeight.w600,
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: 17,
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Container(
  //                     width: 109,
  //                     height: 44,
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(34),
  //                       color: Color(0xffDEDEDE),
  //                       boxShadow: [
  //                         //
  //                         BoxShadow(
  //                           blurRadius: 5,
  //                           spreadRadius: -4,
  //                           // offset: Offset(0, -4),
  //                           color: Colors.black.withOpacity(0.15),
  //                         ),
  //                       ],
  //                     ),
  //                     child: Center(
  //                       child: Text(
  //                         "Cancel",
  //                         style: TextStyle(
  //                           color: Color(0xff2C2C2C),
  //                           fontSize: FontSize16,
  //                           fontFamily: "Urbanist",
  //                           fontWeight: FontWeight.w700,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   Container(
  //                     width: 109,
  //                     height: 44,
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(34),
  //                       color: primarycolor,
  //                       boxShadow: [
  //                         BoxShadow(
  //                           blurRadius: 5,
  //                           spreadRadius: -4,
  //                           // offset: Offset(0, -4),
  //                           color: Colors.black.withOpacity(0.15),
  //                         ),
  //                       ],
  //                     ),
  //                     child: Center(
  //                       child: Text(
  //                         "Confirm",
  //                         style: TextStyle(
  //                           color: Color(0xff2C2C2C),
  //                           fontSize: FontSize16,
  //                           fontFamily: "Urbanist",
  //                           fontWeight: FontWeight.w700,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               )
  //             ],
  //           ),
  //         ),
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(34),
  //         ),
  //       );
  //     },
  //   );
  // }

  // void moveToVaccant() {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         contentPadding:
  //             EdgeInsets.only(top: 29, bottom: 23, left: 21, right: 21),
  //         content: Container(
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: [
  //               Text(
  //                 'Is this Chit is moving to Vacant Chit?',
  //                 style: TextStyle(
  //                   color: Color(0xff2C2C2C),
  //                   fontSize: FontSize16,
  //                   fontFamily: "Urbanist",
  //                   fontWeight: FontWeight.w700,
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: 17,
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Container(
  //                     width: 109,
  //                     height: 44,
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(34),
  //                       color: Color(0xffDEDEDE),
  //                       boxShadow: [
  //                         //
  //                         BoxShadow(
  //                           blurRadius: 5,
  //                           spreadRadius: -4,
  //                           // offset: Offset(0, -4),
  //                           color: Colors.black.withOpacity(0.15),
  //                         ),
  //                       ],
  //                     ),
  //                     child: Center(
  //                       child: Text(
  //                         "Cancel",
  //                         style: TextStyle(
  //                           color: Color(0xff2C2C2C),
  //                           fontSize: FontSize16,
  //                           fontFamily: "Urbanist",
  //                           fontWeight: FontWeight.w700,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   Container(
  //                     width: 109,
  //                     height: 44,
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(34),
  //                       color: primarycolor,
  //                       boxShadow: [
  //                         BoxShadow(
  //                           blurRadius: 5,
  //                           spreadRadius: -4,
  //                           // offset: Offset(0, -4),
  //                           color: Colors.black.withOpacity(0.15),
  //                         ),
  //                       ],
  //                     ),
  //                     child: Center(
  //                       child: Text(
  //                         "Confirm",
  //                         style: TextStyle(
  //                           color: Color(0xff2C2C2C),
  //                           fontSize: FontSize16,
  //                           fontFamily: "Urbanist",
  //                           fontWeight: FontWeight.w700,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               )
  //             ],
  //           ),
  //         ),
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(34),
  //         ),
  //       );
  //     },
  //   );
  // }
  // FocusNode dialogueAuctionAmountNode = FocusNode();
  // FocusNode dialoguePayableAmountNode = FocusNode();
  // FocusNode dialogueDividentNode = FocusNode();

  // @override
  // void dispose() {
  //   dialogueAuctionAmountNode.dispose();
  //   dialoguePayableAmountNode.dispose();
  //   dialogueDividentNode.dispose();
  //   super.dispose();
  // }

  // void payChitAmount() {
  //   showDialog(
  //     context: context,
  //     builder: (context) => StatefulBuilder(
  //       builder: (BuildContext context, setState) {
  //         dialogueAuctionAmountNode.addListener(() {
  //           setState(() {});
  //         });
  //         dialoguePayableAmountNode.addListener(() {
  //           setState(() {});
  //         });
  //         dialogueDividentNode.addListener(() {
  //           setState(() {});
  //         });
  //         return AlertDialog(
  //           shape:
  //               RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  //           title: Text('Pay the chit amount of September'),
  //           titleTextStyle: TextStyle(
  //               fontSize: FontSize10,
  //               fontFamily: 'Urbanist',
  //               fontWeight: FontWeight.w600,
  //               color: Color(0xff827C7C)),
  //           content: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 children: [
  //                   CircleAvatar(
  //                     backgroundColor: Colors.black,
  //                     radius: 16,
  //                   ),
  //                   Container(
  //                       margin: EdgeInsets.all(14),
  //                       child: Text(
  //                         "akhilgeorge",
  //                         style: TextStyle(
  //                             fontSize: FontSize16,
  //                             fontFamily: 'Urbanist',
  //                             fontWeight: FontWeight.w600,
  //                             color: Colors.black),
  //                       ))
  //                 ],
  //               ),
  //               SizedBox(
  //                 height: scrWidth * 0.05,
  //               ),
  //               Container(
  //                 width: scrWidth,
  //                 height: textFormFieldHeight45,
  //                 padding: EdgeInsets.symmetric(
  //                   horizontal: scrWidth * 0.015,
  //                   vertical: 2,
  //                 ),
  //                 decoration: BoxDecoration(
  //                   color: textFormFieldFillColor,
  //                   borderRadius: BorderRadius.circular(scrWidth * 0.026),
  //                 ),
  //                 child: TextFormField(
  //                   focusNode: dialogueAuctionAmountNode,
  //                   cursorHeight: scrWidth * 0.055,
  //                   cursorWidth: 1,
  //                   cursorColor: Colors.black,
  //                   style: TextStyle(
  //                     color: Colors.black,
  //                     fontWeight: FontWeight.w600,
  //                     fontSize: FontSize15,
  //                     fontFamily: 'Urbanist',
  //                   ),
  //                   decoration: InputDecoration(
  //                     labelText: 'Auction Amount',
  //                     labelStyle: TextStyle(
  //                       color: dialogueAuctionAmountNode.hasFocus
  //                           ? primarycolor
  //                           : textFormUnFocusColor,
  //                       fontWeight: FontWeight.w600,
  //                       fontSize: FontSize15,
  //                       fontFamily: 'Urbanist',
  //                     ),
  //                     // prefixIcon: Container(
  //                     //   height: scrWidth * 0.045,
  //                     //   width: 10,
  //                     //   padding: EdgeInsets.all(
  //                     //       scrWidth * 0.033),
  //                     //   child: SvgPicture.asset(
  //                     //     'assets/icons/subscription.svg',
  //                     //     fit: BoxFit.contain,
  //                     //     color: textFormUnFocusColor,
  //                     //   ),
  //                     // ),
//                     fillColor: textFormFieldFillColor,
  //                     filled: true,
  //                     contentPadding: EdgeInsets.only(
  //                         top: 5,
  //                         bottom: scrWidth * 0.033,
  //                         left: scrWidth * 0.033),
  //                     disabledBorder: InputBorder.none,
  //                     enabledBorder: InputBorder.none,
  //                     errorBorder: InputBorder.none,
  //                     border: InputBorder.none,
  //                     focusedBorder: UnderlineInputBorder(
  //                       borderSide: BorderSide(
  //                         color: primarycolor,
  //                         width: 2,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: scrWidth * 0.03,
  //               ),
  //               Container(
  //                 width: scrWidth,
  //                 height: textFormFieldHeight45,
  //                 padding: EdgeInsets.symmetric(
  //                   horizontal: scrWidth * 0.015,
  //                   vertical: 2,
  //                 ),
  //                 decoration: BoxDecoration(
  //                   color: textFormFieldFillColor,
  //                   borderRadius: BorderRadius.circular(scrWidth * 0.026),
  //                 ),
  //                 child: TextFormField(
  //                   focusNode: dialoguePayableAmountNode,
  //                   cursorHeight: scrWidth * 0.055,
  //                   cursorWidth: 1,
  //                   cursorColor: Colors.black,
  //                   style: TextStyle(
  //                     color: Colors.black,
  //                     fontWeight: FontWeight.w600,
  //                     fontSize: FontSize15,
  //                     fontFamily: 'Urbanist',
  //                   ),
  //                   decoration: InputDecoration(
  //                     labelText: 'Payable Amount',
  //                     labelStyle: TextStyle(
  //                       color: dialoguePayableAmountNode.hasFocus
  //                           ? primarycolor
  //                           : textFormUnFocusColor,
  //                       fontWeight: FontWeight.w600,
  //                       fontSize: FontSize15,
  //                       fontFamily: 'Urbanist',
  //                     ),
  //                     // prefixIcon: Container(
  //                     //   height: scrWidth * 0.045,
  //                     //   width: 10,
  //                     //   padding: EdgeInsets.all(
  //                     //       scrWidth * 0.033),
  //                     //   child: SvgPicture.asset(
  //                     //     'assets/icons/subscription.svg',
  //                     //     fit: BoxFit.contain,
  //                     //     color: textFormUnFocusColor,
  //                     //   ),
  //                     // ),
//                     fillColor: textFormFieldFillColor,
  //                     filled: true,
  //                     contentPadding: EdgeInsets.only(
  //                         top: 5,
  //                         bottom: scrWidth * 0.033,
  //                         left: scrWidth * 0.033),
  //                     disabledBorder: InputBorder.none,
  //                     enabledBorder: InputBorder.none,
  //                     errorBorder: InputBorder.none,
  //                     border: InputBorder.none,
  //                     focusedBorder: UnderlineInputBorder(
  //                       borderSide: BorderSide(
  //                         color: primarycolor,
  //                         width: 2,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: scrWidth * 0.03,
  //               ),
  //               Container(
  //                 width: scrWidth,
  //                 height: textFormFieldHeight45,
  //                 padding: EdgeInsets.symmetric(
  //                   horizontal: scrWidth * 0.015,
  //                   vertical: 2,
  //                 ),
  //                 decoration: BoxDecoration(
  //                   color: textFormFieldFillColor,
  //                   borderRadius: BorderRadius.circular(scrWidth * 0.026),
  //                 ),
  //                 child: TextFormField(
  //                   focusNode: dialogueDividentNode,
  //                   cursorHeight: scrWidth * 0.055,
  //                   cursorWidth: 1,
  //                   cursorColor: Colors.black,
  //                   style: TextStyle(
  //                     color: Colors.black,
  //                     fontWeight: FontWeight.w600,
  //                     fontSize: FontSize15,
  //                     fontFamily: 'Urbanist',
  //                   ),
  //                   decoration: InputDecoration(
  //                     labelText: 'Divident Amount',
  //                     labelStyle: TextStyle(
  //                       color: dialogueDividentNode.hasFocus
  //                           ? primarycolor
  //                           : textFormUnFocusColor,
  //                       fontWeight: FontWeight.w600,
  //                       fontSize: FontSize15,
  //                       fontFamily: 'Urbanist',
  //                     ),
  //                     // prefixIcon: Container(
  //                     //   height: scrWidth * 0.045,
  //                     //   width: 10,
  //                     //   padding: EdgeInsets.all(
  //                     //       scrWidth * 0.033),
  //                     //   child: SvgPicture.asset(
  //                     //     'assets/icons/subscription.svg',
  //                     //     fit: BoxFit.contain,
  //                     //     color: textFormUnFocusColor,
  //                     //   ),
  //                     // ),
//                     fillColor: textFormFieldFillColor,
  //                     filled: true,
  //                     contentPadding: EdgeInsets.only(
  //                         top: 5,
  //                         bottom: scrWidth * 0.033,
  //                         left: scrWidth * 0.033),
  //                     disabledBorder: InputBorder.none,
  //                     enabledBorder: InputBorder.none,
  //                     errorBorder: InputBorder.none,
  //                     border: InputBorder.none,
  //                     focusedBorder: UnderlineInputBorder(
  //                       borderSide: BorderSide(
  //                         color: primarycolor,
  //                         width: 2,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: scrWidth * 0.06,
  //               ),
  //               Container(
  //                 width: scrWidth,
  //                 height: textFormFieldHeight45,
  //                 decoration: BoxDecoration(
  //                     color: primarycolor,
  //                     borderRadius: BorderRadius.circular(8)),
  //                 child: Center(
  //                   child: GestureDetector(
  //                     onTap: () {},
  //                     child: Text(
  //                       "Save",
  //                       style: TextStyle(
  //                           fontSize: FontSize16,
  //                           fontFamily: 'Urbanist',
  //                           fontWeight: FontWeight.w600,
  //                           color: Colors.white),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
  // final Authentication _authentication = Authentication();

  @override
  Widget build(BuildContext context) {
    // print(" scrWidth : $scrWidth");
    // print(" scrHeight : $scrHeight");
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await confirmQuitDialog(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        endDrawer: Drawer(
           elevation: 10.0,
          child: ListView(
            children: <Widget>[
              InkWell(
                onTap: (){
                  Navigator.push(context,
                                 MaterialPageRoute(builder: (context) => ProfilePage(user: user![0],)));

                },
                child: DrawerHeader(
                  decoration: BoxDecoration(color: primarycolor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(currentuser?.userImage??''),
                        radius: 30.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                        currentuser?.userName??'',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 22.0),
                          ),
                          SizedBox(height: 10.0),
                          Flexible(
                            child: Container(
                              width: 160,
                              child: Text(
                                currentuser?.userEmail??'',
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 14.0),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),

              //Here you place your menu items
              ListTile(
                 leading:Container(
                           height: 30,
                           width: 34,
                           decoration: BoxDecoration(
                               image: DecorationImage(image:
                               NetworkImage(
                                   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdlgdYbuGqOnWzk_isI5q_in4KYYbFwO1lCw&usqp=CAU"),fit: BoxFit.fill)
                           ),
                         ),
                title: Text('Settings', style: TextStyle(fontSize: 18)),
                onTap: () {
                           Navigator.push(context,MaterialPageRoute(builder: (context)=>SettingsPage()));

                  // Here you can give your route to navigate
                },
              ),
              Divider(height: 3.0),
              ListTile(
                 leading:Padding(
                   padding: const EdgeInsets.only(left: 6),
                   child: Container(
                             height: 20,
                               width: 26,
                             decoration: BoxDecoration(
                               image: DecorationImage(image:
                               NetworkImage(
                                   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxfOzBxK8ISdCdErcVR0EFWHPL1I_SNQvEOw&usqp=CAU"),fit: BoxFit.fill)
                             ),
                           ),
                 ),
                title: Text('Diary', style: TextStyle(fontSize: 18)),
                onTap: () {
                         Navigator.push(context,MaterialPageRoute(builder: (context)=>NotesPage()));


                  // Here you can give your route to navigate
                },
              ),
              Divider(height: 3.0),
              ListTile(
                leading:Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Container(
                    height: 23,
                    width: 24,
                    decoration: BoxDecoration(
                        image: DecorationImage(image:
                        NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQgDNYGs8jqizlcPof-wNOx2dLJmmoioCfEZw&usqp=CAU"),fit: BoxFit.fill)
                    ),
                  ),
                ),
                title: Text('Phone Book', style: TextStyle(fontSize: 18)),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PhoneBookPage()));


                  // Here you can give your route to navigate
                },
              ),
              SizedBox(height: scrHeight*0.3,),


              InkWell(
                onTap: (){
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      content: const Text("do you want to exit this app"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: const Text("No"),
                        ),
                        TextButton(
                          onPressed: () {
                            _authentication.signOut(context);
                          },
                          child: const Text(
                            "Yes",
                            style: TextStyle(color: primarycolor),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 17,right: 17),
                  child: Container(
                    height: 45,
                    width: scrWidth*0.3,
                    // color: Colors.grey,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black)
                    ),
                    child: Center(
                      child: Text("Logout"),

                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: Offset(0, 4),
                  blurRadius: 25),
            ]),
            child: AppBar(
              iconTheme: IconThemeData(color: Colors.grey),
              leading: Icon(Icons.arrow_back,color: Colors.white,),
              elevation: 0,
              backgroundColor: appBarColor,
              centerTitle: false,
              leadingWidth: 0,
              title: Padding(
                padding: EdgeInsets.only(top: scrHeight * 0.009),
                child: SvgPicture.asset("assets/icons/3ms.svg"),
              ),
              // actions: [
              //   // GestureDetector(
              //   //   onTap: () {},
              //   //   child: Container(
              //   //     child: SvgPicture.asset(
              //   //       "assets/icons/notifications.svg",
              //   //       //  width: 19,
              //   //       // height: 20,
              //   //       width: scrWidth * 0.059,
              //   //       height: scrWidth * 0.055,
              //   //       color: Colors.black,
              //   //     ),
              //   //   ),
              //   // ),
              //   Padding(
              //     padding: const EdgeInsets.only(top: 16,bottom: 14),
              //     child: InkWell(
              //       onTap: (){
              //         Navigator.push(context,MaterialPageRoute(builder: (context)=>NotesPage()));
              //       },
              //       child: Container(
              //         height: 5,
              //           width: 26,
              //         decoration: BoxDecoration(
              //           image: DecorationImage(image:
              //           NetworkImage(
              //               "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxfOzBxK8ISdCdErcVR0EFWHPL1I_SNQvEOw&usqp=CAU"),fit: BoxFit.fill)
              //         ),
              //       ),
              //     ),
              //   ),
              //   SizedBox(width: 10,),
              //   Padding(
              //     padding: const EdgeInsets.only(top: 10,bottom: 10),
              //     child: InkWell(
              //       onTap: (){
              //         Navigator.push(context,MaterialPageRoute(builder: (context)=>SettingsPage()));
              //       },
              //       child: Container(
              //         height: 10,
              //         width: 34,
              //         decoration: BoxDecoration(
              //             image: DecorationImage(image:
              //             NetworkImage(
              //                 "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdlgdYbuGqOnWzk_isI5q_in4KYYbFwO1lCw&usqp=CAU"),fit: BoxFit.fill)
              //         ),
              //       ),
              //     ),
              //   ),
              //   // SizedBox(
              //   //   width: scrWidth * 0.045,
              //   //   // width: 16,
              //   // ),
              //   // SvgPicture.asset(
              //   //   "assets/icons/connected.svg",
              //   //   width: scrWidth * 0.059,
              //   //   height: scrWidth * 0.055,
              //   //   color: Colors.black,
              //   //   // width: 19,
              //   //   // height: 20,
              //   // ),
              //   // SizedBox(
              //   //   width: scrWidth * 0.045,
              //   // ),
              //   // GestureDetector(
              //   //     onTap: () async {
              //   //       // showDialog(
              //   //       //   context: context,
              //   //       //   builder: (ctx) => AlertDialog(
              //   //       //     content: const Text("do you want to exit this app"),
              //   //       //     actions: <Widget>[
              //   //       //       TextButton(
              //   //       //         onPressed: () {
              //   //       //           Navigator.of(ctx).pop();
              //   //       //         },
              //   //       //         child: const Text("No"),
              //   //       //       ),
              //   //       //       TextButton(
              //   //       //         onPressed: () {
              //   //       //           _authentication.signOut(context);
              //   //       //         },
              //   //       //         child: const Text(
              //   //       //           "Yes",
              //   //       //           style: TextStyle(color: primarycolor),
              //   //       //         ),
              //   //       //       ),
              //   //       //     ],
              //   //       //   ),
              //   //       // );
              //   //     },
              //   //     child: Icon(
              //   //       Icons.logout,
              //   //       color: Colors.black,
              //   //     )),
              //   SizedBox(
              //     width: scrWidth * 0.02,
              //     // width: 21,
              //   ),
              //   InkWell(
              //     onTap: () {
              //       Navigator.push(context,
              //           MaterialPageRoute(builder: (context) => ProfilePage()));
              //     },
              //     child: Container(
              //       margin: EdgeInsets.symmetric(vertical: scrWidth * 0.02),
              //       width: scrWidth * 0.12,
              //       height: scrWidth * 0.16,
              //       decoration: BoxDecoration(
              //         image: DecorationImage(
              //           fit: BoxFit.cover,
              //           image: NetworkImage(currentuser?.userImage ?? ''),
              //           // AssetImage("assets/avatar.jpg"),
              //         ),
              //         color: Colors.blueGrey,
              //         borderRadius: BorderRadius.circular(15),
              //       ),
              //     ),
              //   ),
              //   SizedBox(
              //     width: scrWidth * 0.03,
              //     // width: 21,
              //   ),
              // ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: scrWidth * 0.045,
                        right: scrWidth * 0.045,
                        top: scrWidth * 0.025),
                    height: scrHeight * .18,
                    width: scrWidth * 1,
                    child: CarouselWidget(),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpcomingPayments(),
                          ));
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(
                        scrWidth * 0.059,
                        scrWidth * 0.015,
                        scrWidth * 0.059,
                        0,
                      ),
                      height: scrHeight * .09,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            UpcommingCardWidget(
                              image: 'assets/icons/upcoming_payments.svg',
                              title: "Upcoming\nPayments",
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          UpcomingCollections(),
                                    ));
                              },
                              child: UpcommingCardWidget(
                                image: 'assets/icons/upcoming_collections.svg',
                                title: "Upcoming\nCollections",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: scrWidth * 0.06,
                        vertical: scrWidth * 0.045),
                    // color: Colors.deepOrange,
                    height: scrWidth * 0.47,
                    width: scrWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            // height: 137,
                            height: scrWidth * 0.38,
                            // width: 336,
                            width: scrWidth * .9,

                            decoration: BoxDecoration(
                                // color: Colors.pink,
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(68.5),
                                border: Border.all(
                                  width: 1,
                                  color: Color(0xffF6F6F6),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, 2),
                                    blurRadius: 15,
                                    spreadRadius: 5,
                                    color: Color(0xff000000).withOpacity(.05),
                                  ),
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HostedChitPage(),
                                        // CreateNewChitScreen(),
                                      )),
                                  child: FundingWidget(
                                      title: "Chit Funds",
                                      image: "assets/icons/money-bag.json"),
                                ),
                                VerticalDivider(
                                  thickness: scrHeight * 0.001,
                                  endIndent: scrWidth * 0.06,
                                  indent: scrWidth * 0.06,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Kuripage()));
                                  },
                                  child: FundingWidget(
                                      title: "Kuri Funds",
                                      image: "assets/icons/cash.json"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // height: 280,
                    height: scrWidth * 0.8,
                    width: scrWidth,
                    // color: Colors.deepPurple,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: scrWidth * 0.06),
                          child: Text(
                            "Verified Charities",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize13,
                              fontFamily: 'Urbanist',
                            ),
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              // Navigator.push(context,MaterialPageRoute(builder: (context)=>GeolocatorPage()));
                            },
                            child: VerifiedCharityWidget()),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: scrWidth * 0.01,
                  ),
                  Container(
                    width: scrWidth,
                    // height: 70,
                    height: scrWidth * 0.2,
                    // color: Colors.red,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: scrWidth * 0.059,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DonatePage()
                                      // FlGraph()
                                      ));
                            },
                            child: FundraiseAndCharityWidget(
                              icon: 'assets/icons/don.svg',
                              title: 'DONATE',
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SeeMoreCharities(),
                                  ));
                            },
                            child: FundraiseAndCharityWidget(
                              icon: 'assets/icons/fundraise.svg',
                              title: 'FUNDRAISE',
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: scrWidth * 0.3,
                  ),
                ],
              )
            ],
          ),
        ),
        //     floatingActionButton: Bounceable(
        //       onTap: () {},
        //       child: Container(
        //         width: scrWidth * .412,
        //         height: scrWidth * 0.12,
        //         // width: 146,
        //         // height: 43,
        //         child: ElevatedButton(
        //           // icon: Icon(Icons.add),
        //           style: ButtonStyle(
        //               backgroundColor: MaterialStateProperty.all(primarycolor),
        //               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        //                   RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(16),
        //               ))),
        //           onPressed: () {
        //             bottomsheets(context);
        //           },
        //           child: Text(
        //             "+  Create Room",
        //             style: TextStyle(
        //               fontSize: FontSize15,
        //               fontFamily: 'Urbanist',
        //               fontWeight: FontWeight.w600,
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //     floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        //   );
        // }

        // void bottomsheets(context) {
        //   showModalBottomSheet(
        //     context: context,
        //     backgroundColor: Colors.transparent,
        //     builder: (context) => StatefulBuilder(
        //       builder:
        //           (BuildContext context, void Function(void Function()) setState) {
        //         return Container(
        //           height: scrHeight * 0.36,
        //           decoration: const BoxDecoration(
        //               color: Colors.white,
        //               borderRadius: BorderRadius.only(
        //                 topLeft: Radius.circular(40),
        //                 topRight: Radius.circular(40),
        //               )),
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.start,
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               SizedBox(
        //                 height: scrHeight * 0.05,
        //               ),
        //               Padding(
        //                 padding: EdgeInsets.only(left: 30),
        //                 child: Text(
        //                   "Create New Room",
        //                   style: TextStyle(
        //                       fontFamily: 'Urbanist',
        //                       fontWeight: FontWeight.w700,
        //                       fontSize: scrWidth * 0.053),
        //                 ),
        //               ),
        //               SizedBox(
        //                 height: scrHeight * 0.03,
        //               ),
        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //                 children: [
        //                   InkWell(
        //                     onTap: () {
        //                       setState(() {
        //                         selectedIndex = 1;
        //                       });
        //                     },
        //                     child: Column(
        //                       children: [
        //                         Badge(
        //                           animationType: BadgeAnimationType.slide,
        //                           showBadge: selectedIndex == 1 ? true : false,
        //                           padding: EdgeInsets.all(scrWidth * 0.005),
        //                           badgeContent: Icon(
        //                             Icons.check,
        //                             color: primarycolor,
        //                             size: createRoomIconSize,
        //                           ),
        //                           child: Container(
        //                             width: scrWidth * 0.23,
        //                             height: scrHeight * 0.11,
        //                             decoration: BoxDecoration(
        //                               shape: BoxShape.circle,
        //                               color: Colors.grey.shade100,
        //                               border: selectedIndex == 1
        //                                   ? Border.all(
        //                                       color: primarycolor,
        //                                       width: 3,
        //                                     )
        //                                   : Border.all(color: Colors.transparent),
        //                             ),
        //                             child: Padding(
        //                               padding: EdgeInsets.all(scrWidth * 0.05),
        //                               child: SvgPicture.asset(
        //                                 "assets/icons/chiti_funds.svg",
        //                                 fit: BoxFit.contain,
        //                               ),
        //                             ),
        //                           ),
        //                           badgeColor: Colors.white,
        //                           position: BadgePosition(
        //                             bottom: -7,
        //                           ),
        //                         ),
        //                         SizedBox(
        //                           height: scrHeight * 0.01,
        //                         ),
        //                         Text(
        //                           "Chit",
        //                           style: TextStyle(
        //                               fontFamily: 'Urbanist',
        //                               fontWeight: FontWeight.w500,
        //                               fontSize: CardFont2),
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                   InkWell(
        //                     onTap: () {
        //                       setState(() {
        //                         selectedIndex = 0;
        //                       });
        //                     },
        //                     child: Column(
        //                       children: [
        //                         Badge(
        //                           animationType: BadgeAnimationType.slide,
        //                           showBadge: selectedIndex == 0 ? true : false,
        //                           padding: EdgeInsets.all(scrWidth * 0.005),
        //                           badgeContent: Icon(
        //                             Icons.check,
        //                             color: primarycolor,
        //                             size: createRoomIconSize,
        //                           ),
        //                           child: Container(
        //                             width: scrWidth * 0.23,
        //                             height: scrHeight * 0.11,
        //                             decoration: BoxDecoration(
        //                               shape: BoxShape.circle,
        //                               color: Colors.grey.shade100,
        //                               border: selectedIndex == 0
        //                                   ? Border.all(
        //                                       color: primarycolor,
        //                                       width: 3,
        //                                     )
        //                                   : Border.all(color: Colors.transparent),
        //                             ),
        //                             child: Padding(
        //                               padding: EdgeInsets.all(scrWidth * 0.05),
        //                               child: SvgPicture.asset(
        //                                 "assets/icons/kuri_funds.svg",
        //                                 fit: BoxFit.contain,
        //                               ),
        //                             ),
        //                           ),
        //                           badgeColor: Colors.white,
        //                           position: BadgePosition(
        //                             bottom: -7,
        //                           ),
        //                         ),
        //                         SizedBox(
        //                           height: scrHeight * 0.01,
        //                         ),
        //                         Text("Kuri",
        //                             style: TextStyle(
        //                                 fontFamily: 'Urbanist',
        //                                 fontWeight: FontWeight.w500,
        //                                 fontSize: CardFont2))
        //                       ],
        //                     ),
        //                   ),
        //                   InkWell(
        //                     onTap: () {
        //                       setState(() {
        //                         selectedIndex = 2;
        //                       });
        //                     },
        //                     child: Column(
        //                       children: [
        //                         Badge(
        //                           animationType: BadgeAnimationType.slide,
        //                           showBadge: selectedIndex == 2 ? true : false,
        //                           padding: EdgeInsets.all(scrWidth * 0.005),
        //                           badgeContent: Icon(
        //                             Icons.check,
        //                             color: primarycolor,
        //                             size: createRoomIconSize,
        //                           ),
        //                           child: Container(
        //                             width: scrWidth * 0.23,
        //                             height: scrHeight * 0.11,
        //                             decoration: BoxDecoration(
        //                               shape: BoxShape.circle,
        //                               color: Colors.grey.shade100,
        //                               border: selectedIndex == 2
        //                                   ? Border.all(
        //                                       color: primarycolor,
        //                                       width: 3,
        //                                     )
        //                                   : Border.all(color: Colors.transparent),
        //                             ),
        //                             child: Padding(
        //                               padding: EdgeInsets.all(scrWidth * 0.05),
        //                               child: SvgPicture.asset(
        //                                 "assets/icons/charity.svg",
        //                                 fit: BoxFit.contain,
        //                               ),
        //                             ),
        //                           ),
        //                           badgeColor: Colors.white,
        //                           position: BadgePosition(
        //                             bottom: -7,
        //                           ),
        //                         ),
        //                         SizedBox(
        //                           height: scrHeight * 0.01,
        //                         ),
        //                         Text(
        //                           "Charity",
        //                           style: TextStyle(
        //                               fontFamily: 'Urbanist',
        //                               fontWeight: FontWeight.w500,
        //                               fontSize: CardFont2),
        //                         ),
        //                       ],
        //                     ),
        //                   )
        //                 ],
        //               ),
        //               SizedBox(
        //                 height: scrHeight * 0.025,
        //               ),
        //               Center(
        //                 child: Bounceable(
        //                   onTap: () {
        //                     Navigator.push(
        //                         context,
        //                         MaterialPageRoute(
        //                           builder: (context) => CreateRoomScreen(),
        //                         ));
        //                   },
        //                   child: Container(
        //                     height: scrHeight * 0.07,
        //                     width: scrWidth * 0.9,
        //                     decoration: BoxDecoration(
        //                       borderRadius: BorderRadius.circular(10),
        //                       color: primarycolor,
        //                     ),
        //                     child: Center(
        //                       child: Row(
        //                         mainAxisAlignment: MainAxisAlignment.center,
        //                         children: [
        //                           Icon(
        //                             Icons.add,
        //                             size: createRoomIconSize,
        //                             color: Colors.white,
        //                           ),
        //                           SizedBox(
        //                             width: scrWidth * 0.01,
        //                           ),
        //                           Text(
        //                             "Create Room",
        //                             style: TextStyle(
        //                                 color: Colors.white,
        //                                 fontSize: FontSize17,
        //                                 fontFamily: 'Urbanist',
        //                                 fontWeight: FontWeight.w500),
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //               SizedBox(
        //                 height: scrWidth * 0.005,
        //               )
        //             ],
        //           ),
        //         );
        //       },
        //     ),
      ),
    );
  }
}

Future<bool?> confirmQuitDialog(BuildContext context) => showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
          title: Text('Do You want to Quit?'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('No')),
            TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(
                  'Yes',
                  style: TextStyle(color: primarycolor),
                )),
          ],
        ));
