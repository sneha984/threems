import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:threems/Authentication/root.dart';
import 'package:threems/layouts/screen_layout.dart';
import 'package:threems/model/usermodel.dart';
import 'package:threems/screens/home_screen.dart';
import 'package:threems/topbar/faqQuestions.dart';
import 'package:threems/topbar/howtouse.dart';
import 'package:threems/topbar/privacypolicy.dart';
import 'package:threems/topbar/settings.dart';
import 'package:threems/topbar/trems&conditions.dart';

import '../Authentication/auth.dart';
import '../screens/splash_screen.dart';
import '../utils/themes.dart';
import 'dart:io';


class ProfilePage extends StatefulWidget {
  final UserModel user;
  const ProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController nameController=TextEditingController();
  final TextEditingController emailController=TextEditingController();
  final TextEditingController phoneController=TextEditingController();
  final FocusNode nameFocus = FocusNode();
  final FocusNode emailFocus=FocusNode();
  final FocusNode phoneFocus=FocusNode();
  String? imgUrl;
  var imgFile;
  var uploadTask;
  var fileUrl;
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
      widget.user.userImage=imgUrl;

    });
  }
  _pickImage() async {
    final imageFile = await ImagePicker.platform.pickImage(
        source: ImageSource.gallery);
    setState(() {
      imgFile = File(imageFile!.path);
      uploadImageToFirebase(context);
    });
  }
  set(){
    setState(() {

    });
  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Row(
                children: [
                  IconButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ScreenLayout()));
                  }, icon: Icon(Icons.arrow_back_ios_rounded,size: 18,)),
                  Text(
                    "My Account",
                    style: TextStyle(
                        fontSize: FontSize17,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
             SizedBox(height: 20,),
            Container(
              height: 140,
              width: 400,
              // color: Color(0xfff0f4f7),
              color: primarycolor.withOpacity(0.1),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Container(
                      height:90,
                      width:90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(70),
                        color: Colors.grey,
                        image: DecorationImage(image: NetworkImage(widget.user.userImage??''),fit: BoxFit.fill)
                      ),
                    ),
                  ),
                  SizedBox(width: 20,),
                  Padding(
                    padding: const EdgeInsets.only(top: 45),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(widget.user.userName??"", style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w700,
                                color: Colors.black),),
                            SizedBox(width: scrWidth*0.3,),
                            InkWell(
                              onTap: (){
                                nameController.text=widget.user.userName??'';
                                phoneController.text=widget.user.phone??'';
                                emailController.text=widget.user.userEmail??'';
                                imgUrl=widget.user.userImage??'';

                                showDialog(context: context,
                                    builder: (context)=>StatefulBuilder(
                                      builder: (BuildContext context,
                                          void Function(void Function()) setState) {
                                        return Scaffold(
                                          backgroundColor: Colors.transparent,
                                          body: Dialog(
                                            child: Container(
                                              height: 450,
                                              decoration: BoxDecoration(
                                                // color: Colors.red,
                                                borderRadius: BorderRadius.circular(30),
                                              ),
                                              // color: Colors.grey,
                                              child: Padding(padding: EdgeInsets.only(left: 15,right: 15),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    InkWell(
                                                      onTap: (){
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.only(top: 16),
                                                        height: 25,
                                                        width: 25,
                                                        decoration: BoxDecoration(
                                                            color: Colors.grey.withOpacity(0.2),

                                                            borderRadius: BorderRadius.circular(20)
                                                        ),
                                                        child: Center(child: Text("X")),),
                                                    ),
                                                    // Container(
                                                    //   height:90,
                                                    //   width:90,
                                                    //   decoration: BoxDecoration(
                                                    //       borderRadius: BorderRadius.circular(70),
                                                    //       color: Colors.grey,
                                                    //       image: DecorationImage(image: NetworkImage(currentuser?.userImage??''),fit: BoxFit.fill)
                                                    //   ),
                                                    // ),
                                                    SizedBox(height: 15,),
                                                    Center(
                                                      child: Badge(
                                                        elevation: 0, //icon style
                                                        badgeContent: Container(
                                                            height: scrHeight * 0.03,
                                                            width: scrWidth * 0.07,
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(30),
                                                                color: primarycolor),
                                                            child: Icon(
                                                              Icons.add_photo_alternate_outlined,
                                                              color: Colors.white,
                                                              size: 15,
                                                            )),
                                                        badgeColor: Colors.white,
                                                        // position: BadgePosition(start:5 ),
                                                        child: InkWell(
                                                          onTap: (() async {
                                                            // pickLogo();
                                                            await _pickImage();
                                                            setState((){});
                                                          }),
                                                          child: CircleAvatar(
                                                            radius: 40,
                                                            backgroundImage:
                                                            // NetworkImage(currentuser?.userImage??'')
                                                            imgFile == null
                                                                ? NetworkImage(
                                                              widget.user.userImage??'',
                                                            )
                                                                :
                                                            FileImage(imgFile!) as ImageProvider,
                                                          ),
                                                        ),
                                                      ),
                                                    ),

                                                    SizedBox(height: 30,),
                                                    Container(
                                                      width: scrWidth,
                                                      height: textFormFieldHeight45,
                                                      padding: EdgeInsets.symmetric(
                                                        horizontal: scrWidth * 0.015,
                                                        vertical:scrHeight*0.002,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: Color(0xffDADADA),
                                                        ),
                                                        color: textFormFieldFillColor,
                                                        borderRadius: BorderRadius.circular(scrWidth * 0.026),
                                                      ),
                                                      child: TextFormField(
                                                        controller: nameController,
                                                        focusNode: nameFocus,
                                                        cursorHeight: scrWidth * 0.055,
                                                        cursorWidth: 1,
                                                        cursorColor: Colors.black,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: FontSize15,
                                                          fontFamily: 'Urbanist',
                                                        ),
                                                        decoration: InputDecoration(
                                                          labelText: 'Name',
                                                          labelStyle: TextStyle(
                                                            color: nameFocus.hasFocus
                                                                ? primarycolor
                                                                : textFormUnFocusColor,
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: FontSize15,
                                                            fontFamily: 'Urbanist',
                                                          ),
                                                          fillColor: textFormFieldFillColor,
                                                          filled: true,
                                                          contentPadding: EdgeInsets.only(
                                                              left: scrWidth*0.03, top: scrHeight*0.006,
                                                              bottom: scrWidth * 0.033),
                                                          disabledBorder: InputBorder.none,
                                                          enabledBorder: InputBorder.none,
                                                          errorBorder: InputBorder.none,
                                                          border: InputBorder.none,
                                                          focusedBorder: UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: primarycolor,
                                                              width: 2,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),

                                                    // TextFormField(
                                                    //   controller: nameController,
                                                    //   decoration: InputDecoration(
                                                    //     labelText: "name",
                                                    //     border: OutlineInputBorder(
                                                    //       borderRadius: BorderRadius.circular(20),
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                    SizedBox(height: 10,),
                                                    Container(
                                                      width: scrWidth,
                                                      height: textFormFieldHeight45,
                                                      padding: EdgeInsets.symmetric(
                                                        horizontal: scrWidth * 0.015,
                                                        vertical:scrHeight*0.002,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: Color(0xffDADADA),
                                                        ),
                                                        color: textFormFieldFillColor,
                                                        borderRadius: BorderRadius.circular(scrWidth * 0.026),
                                                      ),
                                                      child: TextFormField(
                                                        controller: emailController,
                                                        focusNode: emailFocus,
                                                        cursorHeight: scrWidth * 0.055,
                                                        cursorWidth: 1,
                                                        cursorColor: Colors.black,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: FontSize15,
                                                          fontFamily: 'Urbanist',
                                                        ),
                                                        decoration: InputDecoration(
                                                          labelText: 'Email',
                                                          labelStyle: TextStyle(
                                                            color: emailFocus.hasFocus
                                                                ? primarycolor
                                                                : textFormUnFocusColor,
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: FontSize15,
                                                            fontFamily: 'Urbanist',
                                                          ),
                                                          fillColor: textFormFieldFillColor,
                                                          filled: true,
                                                          contentPadding: EdgeInsets.only(
                                                              left: scrWidth*0.03, top: scrHeight*0.006,
                                                              bottom: scrWidth * 0.033),
                                                          disabledBorder: InputBorder.none,
                                                          enabledBorder: InputBorder.none,
                                                          errorBorder: InputBorder.none,
                                                          border: InputBorder.none,
                                                          focusedBorder: UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: primarycolor,
                                                              width: 2,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),

                                                    // TextFormField(
                                                    //   controller: emailController,
                                                    //   decoration: InputDecoration(
                                                    //     labelText: "email",
                                                    //     border: OutlineInputBorder(
                                                    //       borderRadius: BorderRadius.circular(20),
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                    SizedBox(height: 10,),
                                                    Container(
                                                      width: scrWidth,
                                                      height: textFormFieldHeight45,
                                                      padding: EdgeInsets.symmetric(
                                                        horizontal: scrWidth * 0.015,
                                                        vertical:scrHeight*0.002,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: Color(0xffDADADA),
                                                        ),
                                                        color: textFormFieldFillColor,
                                                        borderRadius: BorderRadius.circular(scrWidth * 0.026),
                                                      ),
                                                      child: TextFormField(
                                                        keyboardType: TextInputType.number,
                                                        controller: phoneController,
                                                        focusNode: phoneFocus,
                                                        cursorHeight: scrWidth * 0.055,
                                                        cursorWidth: 1,
                                                        cursorColor: Colors.black,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: FontSize15,
                                                          fontFamily: 'Urbanist',
                                                        ),
                                                        decoration: InputDecoration(
                                                          labelText: 'Phone No',
                                                          labelStyle: TextStyle(
                                                            color: phoneFocus.hasFocus
                                                                ? primarycolor
                                                                : textFormUnFocusColor,
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: FontSize15,
                                                            fontFamily: 'Urbanist',
                                                          ),
                                                          fillColor: textFormFieldFillColor,
                                                          filled: true,
                                                          contentPadding: EdgeInsets.only(
                                                              left: scrWidth*0.03, top: scrHeight*0.006,
                                                              bottom: scrWidth * 0.033),
                                                          disabledBorder: InputBorder.none,
                                                          enabledBorder: InputBorder.none,
                                                          errorBorder: InputBorder.none,
                                                          border: InputBorder.none,
                                                          focusedBorder: UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color: primarycolor,
                                                              width: 2,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    // TextFormField(
                                                    //   controller: phoneController,
                                                    //   decoration: InputDecoration(
                                                    //     labelText: "phoneNumber",
                                                    //     border: OutlineInputBorder(
                                                    //       borderRadius: BorderRadius.circular(20),
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                    SizedBox(height: 30,),
                                                    // ElevatedButton(onPressed: (){
                                                    //   FirebaseFirestore.instance.collection('users').doc(currentuserid).update({
                                                    //     'userName':nameController.text,
                                                    //     'userEmail':emailController.text,
                                                    //     'phone':phoneController.text,
                                                    //   });
                                                    //   Navigator.pop(context);
                                                    //
                                                    // }, child:Text("Update"))
                                                    InkWell(
                                                      onTap: (){
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection('users')
                                                            .doc(currentuserid)
                                                            .update({
                                                          'userName':nameController.text,
                                                          'userEmail':emailController.text,
                                                          'phone':phoneController.text,
                                                          'userImage':imgUrl,
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                      child: Center(
                                                        child: Container(
                                                          height: 45,
                                                          width: 230,
                                                          decoration: BoxDecoration(
                                                            color: primarycolor,
                                                            borderRadius: BorderRadius.circular(15),

                                                          ),
                                                          child: Center(
                                                            child: Text("Update", style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w700,
                                                                color: Colors.white,
                                                                fontFamily: 'Urbanist'),),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ));
                              },
                              child: Text("Edit", style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w700,
                                  // color: Color(0xff1c5f89)
                                color: primarycolor
                              ),),
                            ),
                          ],
                        ),
                        SizedBox(height: 6,),
                        Text(currentuser?.userEmail??'', style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w500,
                            color: Colors.black),),
                        SizedBox(height: 6,),
                        Text(currentuser?.phone??'',style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w500,
                            color: Colors.black),)
                      ],
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: 10,),

    SizedBox(height: 10,),


            // InkWell(
            //   onTap: (){
            //     nameController.text=currentuser?.userName??'';
            //     phoneController.text=currentuser?.phone??'';
            //     emailController.text=currentuser?.userEmail??'';
            //     showDialog(context: context,
            //         builder: (context)=>Dialog(
            //           child: Container(
            //             height: 400,
            //
            //             decoration: BoxDecoration(
            //               // color: Colors.red,
            //               borderRadius: BorderRadius.circular(18)
            //             ),
            //             // color: Colors.grey,
            //             child: Padding(padding: EdgeInsets.all(10),
            //               child: Column(
            //                 children: [
            //                   SizedBox(height: 10,),
            //                   TextFormField(
            //                     controller: nameController,
            //                     decoration: InputDecoration(
            //                       labelText: "name",
            //                       border: OutlineInputBorder(
            //                         borderRadius: BorderRadius.circular(20),
            //                       ),
            //                     ),
            //                   ),
            //                   SizedBox(height: 10,),
            //
            //                   TextFormField(
            //                     controller: emailController,
            //                     decoration: InputDecoration(
            //                       labelText: "email",
            //                       border: OutlineInputBorder(
            //                         borderRadius: BorderRadius.circular(20),
            //                       ),
            //                     ),
            //                   ),
            //                   SizedBox(height: 10,),
            //
            //                   TextFormField(
            //                     controller: phoneController,
            //                     decoration: InputDecoration(
            //                       labelText: "phoneNumber",
            //                       border: OutlineInputBorder(
            //                         borderRadius: BorderRadius.circular(20),
            //                       ),
            //                     ),
            //                   ),
            //                   SizedBox(height: 10,),
            //                   ElevatedButton(onPressed: (){
            //                     FirebaseFirestore.instance.collection('users').doc(currentuserid).update({
            //                       'userName':nameController.text,
            //                       'userEmail':emailController.text,
            //                       'phone':phoneController.text,
            //                     });
            //                     Navigator.pop(context);
            //
            //                   }, child:Text("Update"))
            //                 ],
            //               ),
            //             ),
            //           ),
            //         ));
            //     // Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfile()));
            //   },
            //   child: Container(
            //     height: 30,
            //     width: 300,
            //     // color: Colors.grey,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(10),
            //         border: Border.all(color: Colors.black)
            //     ),
            //     child: Center(
            //       child: Text("Edit Profile"),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
