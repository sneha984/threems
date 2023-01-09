import 'package:flutter/material.dart';
import 'dart:io';
import 'package:badges/badges.dart';
import 'package:threems/layouts/phonNoChange.dart';
import '../Authentication/root.dart';
import '../model/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:image_picker/image_picker.dart';

import '../model/usermodel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../Authentication/auth.dart';
import '../screens/splash_screen.dart';
import '../utils/themes.dart';

class PersonalInfoPopUp extends StatefulWidget {
  const PersonalInfoPopUp({Key? key}) : super(key: key);

  @override
  State<PersonalInfoPopUp> createState() => _PersonalInfoPopUpState();
}

class _PersonalInfoPopUpState extends State<PersonalInfoPopUp> {
  //DRAWER FIELDS
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
      user.userImage = imgUrl;
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

  UserModel user = UserModel();
  getCurrentUserDet() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentuserid)
        .snapshots()
        .listen((event) {
      user = UserModel.fromJson(event.data()!);
      nameController.text = user.userName ?? '';
      phoneController.text = user.phone ?? '';
      emailController.text = user.userEmail ?? '';
      imgUrl = user.userImage ?? '';

      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUserDet();
  }

  @override
  Widget build(BuildContext context) {
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
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 16),
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(child: Text("X")),
                  ),
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
                SizedBox(
                  height: 15,
                ),
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
                        setState(() {});
                      }),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            // NetworkImage(currentuser?.userImage??'')
                            imgUrl == null
                                ? NetworkImage(
                                    user.userImage ?? '',
                                  )
                                : NetworkImage(imgUrl!),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 30,
                ),
                Container(
                  width: scrWidth,
                  height: textFormFieldHeight45,
                  padding: EdgeInsets.symmetric(
                    horizontal: scrWidth * 0.015,
                    vertical: scrHeight * 0.002,
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
                          left: scrWidth * 0.03,
                          top: scrHeight * 0.006,
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
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: scrWidth,
                  height: textFormFieldHeight45,
                  padding: EdgeInsets.symmetric(
                    horizontal: scrWidth * 0.015,
                    vertical: scrHeight * 0.002,
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
                          left: scrWidth * 0.03,
                          top: scrHeight * 0.006,
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
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>PhoneNoChangePage(phoneNo: phoneController.text)));
                  },
                  child: Container(
                    width: scrWidth,
                    height: textFormFieldHeight45,
                    padding: EdgeInsets.symmetric(
                      horizontal: scrWidth * 0.015,
                      vertical: scrHeight * 0.002,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xffDADADA),
                      ),
                      color: textFormFieldFillColor,
                      borderRadius: BorderRadius.circular(scrWidth * 0.026),
                    ),
                    child: TextFormField(
                      enabled: false,
                      // readOnly: true,
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
                        suffixIcon: InkWell(
                          onTap: (){
                            // Navigator.push(context, MaterialPageRoute(
                            //     builder: (context)=>PhoneNoChangePage(phoneNo: phoneController.text)));

                          },
                          child: Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                        ),
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
                            left: scrWidth * 0.03,
                            top: scrHeight * 0.006,
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
                SizedBox(
                  height: 30,
                ),
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
                  onTap: () {
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(currentuserid)
                        .update({
                      'userName': nameController.text,
                      'userEmail': emailController.text,
                      // 'phone': phoneController.text,
                      'userImage': imgUrl,
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
                        child: Text(
                          "Update",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontFamily: 'Urbanist'),
                        ),
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
  }
}
