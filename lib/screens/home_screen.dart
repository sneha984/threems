import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:threems/Notes/notes.dart';
import 'package:threems/kuri/kuripage.dart';
import 'package:threems/model/usermodel.dart';
import 'package:threems/phonebook/phone_book.dart';
import 'package:threems/screens/charity/basic_details.dart';
import 'package:threems/screens/flgraph.dart';
import 'package:threems/screens/splash_screen.dart';
import 'package:threems/utils/themes.dart';
import 'package:threems/widgets/fundraise_and_charity_widget.dart';
import 'package:threems/widgets/verified_charity_widget.dart';
import 'package:threems/widgets/head_image_slider.dart';
import 'package:threems/widgets/funding_widget.dart';
import 'package:threems/widgets/upcomming_card_widget.dart';
import 'dart:io';
import '../Authentication/auth.dart';
import '../Authentication/root.dart';
import '../UpComing__Collection_&__Payments/Collections.dart';
import '../UpComing__Collection_&__Payments/payments.dart';
import '../kuri/createkuri.dart';
import '../layouts/screen_layout.dart';
import '../model/charitymodel.dart';
import '../topbar/prifilepage.dart';
import '../topbar/settings.dart';
import 'charity/donatepage.dart';
import 'charity/seemorecharities.dart';
import 'chits/chitList.dart';

var currenPlace;
double? lat;
double? long;

List<CharityModel> verifiedcharity = [];

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final FocusNode nameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  String? imgUrl;
  var imgFile;
  var uploadTask;
  var fileUrl;
  // getdd(){
  //   FirebaseFirestore.instance.collection('users').snapshots().listen((event) {
  //     for(DocumentSnapshot doc in event.docs){
  //       FirebaseFirestore.instance.collection('users').
  //       doc(doc.id).collection('incomes').snapshots().listen((event) {
  //         for(DocumentSnapshot abc in event.docs){
  //           FirebaseFirestore.instance.collection('users').
  //           doc(doc.id).collection('incomes').doc(abc.id).update({
  //             'description':'',
  //             'recieverId':'',
  //
  //           });
  //
  //         }
  //       });
  //
  //     }
  //
  //   });
  // }

  Future uploadImageToFirebase(BuildContext context) async {
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('deposits/${imgFile.path}');
    UploadTask uploadTask = firebaseStorageRef.putFile(imgFile);
    TaskSnapshot taskSnapshot = (await uploadTask);
    String value = await taskSnapshot.ref.getDownloadURL();
    print(value);

    // if(value!=null){
    //   imageList.add(value);
    // }
    setState(() {
      imgUrl = value;
      user[0].userImage = imgUrl;
      print(imgUrl);
    });
    setState(() {});
  }

  _pickImage() async {
    final imageFile =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    setState(() {
      imgFile = File(imageFile!.path);
      uploadImageToFirebase(context);
    });
  }

  double selectedIndex = 0;
  getVerifiedCharity() {
    FirebaseFirestore.instance
        .collection('charity')
        .where('userId', isNotEqualTo: currentuser?.userId)
        .where('status', isEqualTo: 1)
        .where('block',isEqualTo: false)
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

  List<UserModel> user = [];
  getCurrentUserDet() {
    FirebaseFirestore.instance
        .collection('users')
        .where('userId', isEqualTo: currentuserid)
        .snapshots()
        .listen((event) {
      user = [];
      for (DocumentSnapshot<Map<String, dynamic>> doc in event.docs) {
        user.add(UserModel.fromJson(doc.data()!));
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  final Authentication _authentication = Authentication();

  @override
  void initState() {
    getCurrentUserDet();
    // getdd();
    getVerifiedCharity();
    getLocation();

    // addFieldToAllDoc();

    super.initState();

    askPermissions();
  }

  // addFieldToAllDoc() {
  //   FirebaseFirestore.instance.collection('users').get().then(
  //         (value) => value.docs.forEach(
  //           (element) {
  //             FirebaseFirestore.instance
  //                 .collection('users')
  //                 .doc(element.id)
  //                 .collection('expense')
  //                 .get()
  //                 .then((value) => value.docs.forEach((subDoc) {
  //                       FirebaseFirestore.instance
  //                           .collection('users')
  //                           .doc(element.id)
  //                           .collection('expense')
  //                           .doc(subDoc.id)
  //                           .update({'income': false});
  //                     }));
  //           },
  //         ),
  //       );
  // }

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
        // endDrawer: Drawer(
        //   elevation: 10.0,
        //   child: ListView(
        //     children: <Widget>[
        //       InkWell(
        //         onTap: () {
        //           // Navigator.push(context,
        //           //                MaterialPageRoute(builder: (context) => ProfilePage(user: user![0],)));
        //
        //           nameController.text = user[0].userName ?? '';
        //           phoneController.text = user[0].phone ?? '';
        //           emailController.text = user[0].userEmail ?? '';
        //           imgUrl = user[0].userImage ?? '';
        //
        //           showDialog(
        //             context: context,
        //             builder: (context) => StatefulBuilder(
        //               builder: (BuildContext context,
        //                   void Function(void Function()) setState) {
        //                 return Scaffold(
        //                   backgroundColor: Colors.transparent,
        //                   body: Dialog(
        //                     child: Container(
        //                       height: 450,
        //                       decoration: BoxDecoration(
        //                         // color: Colors.red,
        //                         borderRadius: BorderRadius.circular(30),
        //                       ),
        //                       // color: Colors.grey,
        //                       child: Padding(
        //                         padding: EdgeInsets.only(left: 15, right: 15),
        //                         child: Column(
        //                           crossAxisAlignment: CrossAxisAlignment.start,
        //                           children: [
        //                             InkWell(
        //                               onTap: () {
        //                                 Navigator.pop(context);
        //                               },
        //                               child: Container(
        //                                 margin: EdgeInsets.only(top: 16),
        //                                 height: 25,
        //                                 width: 25,
        //                                 decoration: BoxDecoration(
        //                                     color: Colors.grey.withOpacity(0.2),
        //                                     borderRadius:
        //                                         BorderRadius.circular(20)),
        //                                 child: Center(child: Text("X")),
        //                               ),
        //                             ),
        //                             // Container(
        //                             //   height:90,
        //                             //   width:90,
        //                             //   decoration: BoxDecoration(
        //                             //       borderRadius: BorderRadius.circular(70),
        //                             //       color: Colors.grey,
        //                             //       image: DecorationImage(image: NetworkImage(currentuser?.userImage??''),fit: BoxFit.fill)
        //                             //   ),
        //                             // ),
        //                             SizedBox(
        //                               height: 15,
        //                             ),
        //                             Center(
        //                               child: Badge(
        //                                 elevation: 0, //icon style
        //                                 badgeContent: Container(
        //                                     height: scrHeight * 0.03,
        //                                     width: scrWidth * 0.07,
        //                                     decoration: BoxDecoration(
        //                                         borderRadius:
        //                                             BorderRadius.circular(30),
        //                                         color: primarycolor),
        //                                     child: Icon(
        //                                       Icons
        //                                           .add_photo_alternate_outlined,
        //                                       color: Colors.white,
        //                                       size: 15,
        //                                     )),
        //                                 badgeColor: Colors.white,
        //                                 // position: BadgePosition(start:5 ),
        //                                 child: InkWell(
        //                                   onTap: (() async {
        //                                     // pickLogo();
        //                                     await _pickImage();
        //                                     setState(() {});
        //                                   }),
        //                                   child: CircleAvatar(
        //                                     radius: 40,
        //                                     backgroundImage:
        //                                         // NetworkImage(currentuser?.userImage??'')
        //                                         imgUrl == null
        //                                             ? NetworkImage(
        //                                                 user[0].userImage ?? '',
        //                                               )
        //                                             : NetworkImage(imgUrl!),
        //                                   ),
        //                                 ),
        //                               ),
        //                             ),
        //
        //                             SizedBox(
        //                               height: 30,
        //                             ),
        //                             Container(
        //                               width: scrWidth,
        //                               height: textFormFieldHeight45,
        //                               padding: EdgeInsets.symmetric(
        //                                 horizontal: scrWidth * 0.015,
        //                                 vertical: scrHeight * 0.002,
        //                               ),
        //                               decoration: BoxDecoration(
        //                                 border: Border.all(
        //                                   color: Color(0xffDADADA),
        //                                 ),
        //                                 color: textFormFieldFillColor,
        //                                 borderRadius: BorderRadius.circular(
        //                                     scrWidth * 0.026),
        //                               ),
        //                               child: TextFormField(
        //                                 controller: nameController,
        //                                 focusNode: nameFocus,
        //                                 cursorHeight: scrWidth * 0.055,
        //                                 cursorWidth: 1,
        //                                 cursorColor: Colors.black,
        //                                 style: TextStyle(
        //                                   color: Colors.black,
        //                                   fontWeight: FontWeight.w600,
        //                                   fontSize: FontSize15,
        //                                   fontFamily: 'Urbanist',
        //                                 ),
        //                                 decoration: InputDecoration(
        //                                   labelText: 'Name',
        //                                   labelStyle: TextStyle(
        //                                     color: nameFocus.hasFocus
        //                                         ? primarycolor
        //                                         : textFormUnFocusColor,
        //                                     fontWeight: FontWeight.w500,
        //                                     fontSize: FontSize15,
        //                                     fontFamily: 'Urbanist',
        //                                   ),
        //                                   fillColor: textFormFieldFillColor,
        //                                   filled: true,
        //                                   contentPadding: EdgeInsets.only(
        //                                       left: scrWidth * 0.03,
        //                                       top: scrHeight * 0.006,
        //                                       bottom: scrWidth * 0.033),
        //                                   disabledBorder: InputBorder.none,
        //                                   enabledBorder: InputBorder.none,
        //                                   errorBorder: InputBorder.none,
        //                                   border: InputBorder.none,
        //                                   focusedBorder: UnderlineInputBorder(
        //                                     borderSide: BorderSide(
        //                                       color: primarycolor,
        //                                       width: 2,
        //                                     ),
        //                                   ),
        //                                 ),
        //                               ),
        //                             ),
        //
        //                             // TextFormField(
        //                             //   controller: nameController,
        //                             //   decoration: InputDecoration(
        //                             //     labelText: "name",
        //                             //     border: OutlineInputBorder(
        //                             //       borderRadius: BorderRadius.circular(20),
        //                             //     ),
        //                             //   ),
        //                             // ),
        //                             SizedBox(
        //                               height: 10,
        //                             ),
        //                             Container(
        //                               width: scrWidth,
        //                               height: textFormFieldHeight45,
        //                               padding: EdgeInsets.symmetric(
        //                                 horizontal: scrWidth * 0.015,
        //                                 vertical: scrHeight * 0.002,
        //                               ),
        //                               decoration: BoxDecoration(
        //                                 border: Border.all(
        //                                   color: Color(0xffDADADA),
        //                                 ),
        //                                 color: textFormFieldFillColor,
        //                                 borderRadius: BorderRadius.circular(
        //                                     scrWidth * 0.026),
        //                               ),
        //                               child: TextFormField(
        //                                 controller: emailController,
        //                                 focusNode: emailFocus,
        //                                 cursorHeight: scrWidth * 0.055,
        //                                 cursorWidth: 1,
        //                                 cursorColor: Colors.black,
        //                                 style: TextStyle(
        //                                   color: Colors.black,
        //                                   fontWeight: FontWeight.w600,
        //                                   fontSize: FontSize15,
        //                                   fontFamily: 'Urbanist',
        //                                 ),
        //                                 decoration: InputDecoration(
        //                                   labelText: 'Email',
        //                                   labelStyle: TextStyle(
        //                                     color: emailFocus.hasFocus
        //                                         ? primarycolor
        //                                         : textFormUnFocusColor,
        //                                     fontWeight: FontWeight.w500,
        //                                     fontSize: FontSize15,
        //                                     fontFamily: 'Urbanist',
        //                                   ),
        //                                   fillColor: textFormFieldFillColor,
        //                                   filled: true,
        //                                   contentPadding: EdgeInsets.only(
        //                                       left: scrWidth * 0.03,
        //                                       top: scrHeight * 0.006,
        //                                       bottom: scrWidth * 0.033),
        //                                   disabledBorder: InputBorder.none,
        //                                   enabledBorder: InputBorder.none,
        //                                   errorBorder: InputBorder.none,
        //                                   border: InputBorder.none,
        //                                   focusedBorder: UnderlineInputBorder(
        //                                     borderSide: BorderSide(
        //                                       color: primarycolor,
        //                                       width: 2,
        //                                     ),
        //                                   ),
        //                                 ),
        //                               ),
        //                             ),
        //
        //                             // TextFormField(
        //                             //   controller: emailController,
        //                             //   decoration: InputDecoration(
        //                             //     labelText: "email",
        //                             //     border: OutlineInputBorder(
        //                             //       borderRadius: BorderRadius.circular(20),
        //                             //     ),
        //                             //   ),
        //                             // ),
        //                             SizedBox(
        //                               height: 10,
        //                             ),
        //                             Container(
        //                               width: scrWidth,
        //                               height: textFormFieldHeight45,
        //                               padding: EdgeInsets.symmetric(
        //                                 horizontal: scrWidth * 0.015,
        //                                 vertical: scrHeight * 0.002,
        //                               ),
        //                               decoration: BoxDecoration(
        //                                 border: Border.all(
        //                                   color: Color(0xffDADADA),
        //                                 ),
        //                                 color: textFormFieldFillColor,
        //                                 borderRadius: BorderRadius.circular(
        //                                     scrWidth * 0.026),
        //                               ),
        //                               child: TextFormField(
        //                                 keyboardType: TextInputType.number,
        //                                 controller: phoneController,
        //                                 focusNode: phoneFocus,
        //                                 cursorHeight: scrWidth * 0.055,
        //                                 cursorWidth: 1,
        //                                 cursorColor: Colors.black,
        //                                 style: TextStyle(
        //                                   color: Colors.black,
        //                                   fontWeight: FontWeight.w600,
        //                                   fontSize: FontSize15,
        //                                   fontFamily: 'Urbanist',
        //                                 ),
        //                                 decoration: InputDecoration(
        //                                   labelText: 'Phone No',
        //                                   labelStyle: TextStyle(
        //                                     color: phoneFocus.hasFocus
        //                                         ? primarycolor
        //                                         : textFormUnFocusColor,
        //                                     fontWeight: FontWeight.w500,
        //                                     fontSize: FontSize15,
        //                                     fontFamily: 'Urbanist',
        //                                   ),
        //                                   fillColor: textFormFieldFillColor,
        //                                   filled: true,
        //                                   contentPadding: EdgeInsets.only(
        //                                       left: scrWidth * 0.03,
        //                                       top: scrHeight * 0.006,
        //                                       bottom: scrWidth * 0.033),
        //                                   disabledBorder: InputBorder.none,
        //                                   enabledBorder: InputBorder.none,
        //                                   errorBorder: InputBorder.none,
        //                                   border: InputBorder.none,
        //                                   focusedBorder: UnderlineInputBorder(
        //                                     borderSide: BorderSide(
        //                                       color: primarycolor,
        //                                       width: 2,
        //                                     ),
        //                                   ),
        //                                 ),
        //                               ),
        //                             ),
        //                             // TextFormField(
        //                             //   controller: phoneController,
        //                             //   decoration: InputDecoration(
        //                             //     labelText: "phoneNumber",
        //                             //     border: OutlineInputBorder(
        //                             //       borderRadius: BorderRadius.circular(20),
        //                             //     ),
        //                             //   ),
        //                             // ),
        //                             SizedBox(
        //                               height: 30,
        //                             ),
        //                             // ElevatedButton(onPressed: (){
        //                             //   FirebaseFirestore.instance.collection('users').doc(currentuserid).update({
        //                             //     'userName':nameController.text,
        //                             //     'userEmail':emailController.text,
        //                             //     'phone':phoneController.text,
        //                             //   });
        //                             //   Navigator.pop(context);
        //                             //
        //                             // }, child:Text("Update"))
        //                             InkWell(
        //                               onTap: () {
        //                                 FirebaseFirestore.instance
        //                                     .collection('users')
        //                                     .doc(currentuserid)
        //                                     .update({
        //                                   'userName': nameController.text,
        //                                   'userEmail': emailController.text,
        //                                   'phone': phoneController.text,
        //                                   'userImage': imgUrl,
        //                                 });
        //                                 Navigator.pop(context);
        //                               },
        //                               child: Center(
        //                                 child: Container(
        //                                   height: 45,
        //                                   width: 230,
        //                                   decoration: BoxDecoration(
        //                                     color: primarycolor,
        //                                     borderRadius:
        //                                         BorderRadius.circular(15),
        //                                   ),
        //                                   child: Center(
        //                                     child: Text(
        //                                       "Update",
        //                                       style: TextStyle(
        //                                           fontSize: 16,
        //                                           fontWeight: FontWeight.w700,
        //                                           color: Colors.white,
        //                                           fontFamily: 'Urbanist'),
        //                                     ),
        //                                   ),
        //                                 ),
        //                               ),
        //                             )
        //                           ],
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                 );
        //               },
        //             ),
        //           );
        //         },
        //         child: DrawerHeader(
        //           decoration: BoxDecoration(color: primarycolor),
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //             children: <Widget>[
        //               CircleAvatar(
        //                 backgroundImage:
        //                     NetworkImage(currentuser?.userImage ?? ''),
        //                 radius: 30.0,
        //               ),
        //               Column(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: <Widget>[
        //                   Text(
        //                     currentuser?.userName ?? '',
        //                     style: TextStyle(
        //                         fontWeight: FontWeight.bold,
        //                         color: Colors.white,
        //                         fontSize: 22.0),
        //                   ),
        //                   SizedBox(height: 10.0),
        //                   Flexible(
        //                     child: Container(
        //                       width: 160,
        //                       child: Text(
        //                         currentuser?.userEmail ?? '',
        //                         style: TextStyle(
        //                             overflow: TextOverflow.ellipsis,
        //                             fontWeight: FontWeight.bold,
        //                             color: Colors.white,
        //                             fontSize: 14.0),
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               )
        //             ],
        //           ),
        //         ),
        //       ),
        //
        //       //Here you place your menu items
        //       ListTile(
        //         leading: Container(
        //           height: 30,
        //           width: 34,
        //           decoration: BoxDecoration(
        //               image: DecorationImage(
        //                   image: NetworkImage(
        //                       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdlgdYbuGqOnWzk_isI5q_in4KYYbFwO1lCw&usqp=CAU"),
        //                   fit: BoxFit.fill)),
        //         ),
        //         title: Text('Settings', style: TextStyle(fontSize: 18)),
        //         onTap: () {
        //           Navigator.push(context,
        //               MaterialPageRoute(builder: (context) => SettingsPage()));
        //
        //           // Here you can give your route to navigate
        //         },
        //       ),
        //       Divider(height: 3.0),
        //       ListTile(
        //         leading: Padding(
        //           padding: const EdgeInsets.only(left: 6),
        //           child: Container(
        //             height: 20,
        //             width: 26,
        //             decoration: BoxDecoration(
        //                 image: DecorationImage(
        //                     image: NetworkImage(
        //                         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxfOzBxK8ISdCdErcVR0EFWHPL1I_SNQvEOw&usqp=CAU"),
        //                     fit: BoxFit.fill)),
        //           ),
        //         ),
        //         title: Text('Diary', style: TextStyle(fontSize: 18)),
        //         onTap: () {
        //           Navigator.push(context,
        //               MaterialPageRoute(builder: (context) => NotesPage()));
        //
        //           // Here you can give your route to navigate
        //         },
        //       ),
        //       Divider(height: 3.0),
        //       ListTile(
        //         leading: Padding(
        //           padding: const EdgeInsets.only(left: 6),
        //           child: Container(
        //             height: 23,
        //             width: 24,
        //             decoration: BoxDecoration(
        //                 image: DecorationImage(
        //                     image: NetworkImage(
        //                         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQgDNYGs8jqizlcPof-wNOx2dLJmmoioCfEZw&usqp=CAU"),
        //                     fit: BoxFit.fill)),
        //           ),
        //         ),
        //         title: Text('Phone Book', style: TextStyle(fontSize: 18)),
        //         onTap: () {
        //           Navigator.push(context,
        //               MaterialPageRoute(builder: (context) => PhoneBookPage()));
        //
        //           // Here you can give your route to navigate
        //         },
        //       ),
        //       SizedBox(
        //         height: scrHeight * 0.3,
        //       ),
        //
        //       InkWell(
        //         onTap: () {
        //           Navigator.of(context).pop();
        //           showDialog(
        //             context: context,
        //             builder: (ctx) => AlertDialog(
        //               content: const Text("do you want to exit this app"),
        //               actions: <Widget>[
        //                 TextButton(
        //                   onPressed: () {
        //                     Navigator.of(ctx).pop();
        //                   },
        //                   child: const Text("No"),
        //                 ),
        //                 TextButton(
        //                   onPressed: () {
        //                     _authentication.signOut(context);
        //                   },
        //                   child: const Text(
        //                     "Yes",
        //                     style: TextStyle(color: primarycolor),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           );
        //         },
        //         child: Padding(
        //           padding: const EdgeInsets.only(left: 17, right: 17),
        //           child: Container(
        //             height: 45,
        //             width: scrWidth * 0.3,
        //             // color: Colors.grey,
        //             decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.circular(10),
        //                 border: Border.all(color: Colors.black)),
        //             child: Center(
        //               child: Text("Logout"),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
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
              leading: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              elevation: 0,
              backgroundColor: appBarColor,
              centerTitle: false,
              leadingWidth: 0,
              title: Padding(
                padding: EdgeInsets.only(top: scrHeight * 0.009),
                child: InkWell(
                  child: Image.asset(
                    "assets/icons/homeIcon.png",
                    width: scrWidth * 0.35,
                    height: scrWidth * 0.3,
                  ),
                ),
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

  // ACCESS CONTACTS BY REQUESTING PERMISSION
  askPermissions() async {
    PermissionStatus permission = await getContactPermission();
    if (permission == PermissionStatus.granted) {
      showSnackbar(context, 'Permission granted by user');
      getContacts();
    } else {
      handleInvalidPermission(permission);
    }
  }

  handleInvalidPermission(PermissionStatus permission) {
    if (permission == PermissionStatus.denied) {
      // showSnackbar(context, 'Permission denied by user');
    } else if (permission == PermissionStatus.permanentlyDenied) {
      // showSnackbar(context, 'Permission denied by user');
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
    contacts = _contacts;
   if(mounted){
     setState(() {
     });
   }
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
