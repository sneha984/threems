import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:threems/kuri/createkuri.dart';

import '../Authentication/root.dart';
import '../screens/splash_screen.dart';
import '../utils/themes.dart';
import 'loginpage.dart';

class DetailsPage extends StatefulWidget {
  final String id;
  final String phone;
  const DetailsPage({Key? key, required this.id, required this.phone})
      : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final _loginkey = GlobalKey<FormState>();
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  bool loading = true;
  String userId="";
  bool blankUser=false;
  getUserData() async {
    QuerySnapshot usrs = await FirebaseFirestore.instance
        .collection('users')
        .where('phone', whereIn:[widget.phone,"+91${widget.phone}","+91 ${widget.phone}"])
        .get();

    if (usrs.docs.length>0) {
      print("hereeeeee");
      print(widget.phone);
      if(usrs.docs[0].get('userEmail')!="") {
        print("rooting");
        print(usrs.docs[0].get('userEmail'));
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Rootingpage(),
            ),
                (route) => false);
      }
      else{
        print("blankUser");
        print(usrs.docs[0].id);
        userId =usrs.docs[0].id;
        blankUser=true;
        loading = false;
        setState(() {});
      }
    } else {
      print("elseeeeeeeee");
      loading = false;
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Container(
            width: scrWidth,
            height: scrHeight,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      top: scrHeight * 0.02,
                      left: scrWidth * 0.07,
                      bottom: scrHeight * 0.02,
                      right: scrWidth * 0.05),
                  child: SvgPicture.asset(
                    "assets/icons/arrow.svg",
                  ),
                ),
              ),
            ),
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Padding(
                padding: EdgeInsets.only(left: scrWidth * 0.07),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: scrHeight * 0.008,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Enter your details here",
                          style: TextStyle(
                              fontFamily: 'Outfit',
                              fontWeight: FontWeight.w600,
                              fontSize: scrWidth * 0.05),
                        ),
                        SizedBox(
                          height: scrHeight * 0.008,
                        ),
                      ],
                    ),
                    Form(
                      key: _loginkey,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Username",
                                  style: TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 0.5),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Outfit',
                                      fontSize: scrWidth * 0.039)),
                              Padding(
                                padding: EdgeInsets.only(left: scrWidth * 0.02),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: scrWidth * 0.07,
                                      vertical: scrHeight * 0.01),
                                  height: scrHeight * 0.05,
                                  width: scrWidth * 0.66,
                                  decoration: BoxDecoration(
                                      color: Color(0xffEEEEEE),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: TextFormField(
                                    controller: _namecontroller,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "username",
                                        hintStyle: TextStyle(
                                          fontSize: scrWidth * 0.039,
                                          color: Colors.grey,
                                        )),
                                    cursorColor: Colors.black,
                                    cursorHeight: 20,
                                    cursorWidth: 0.5,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: scrHeight * 0.014,
                          ),
                          Row(
                            children: [
                              Text(
                                "Email",
                                style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 0.5),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Outfit',
                                    fontSize: scrWidth * 0.039),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: scrWidth * 0.1),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: scrWidth * 0.07,
                                  ),
                                  height: scrHeight * 0.05,
                                  width: scrWidth * 0.66,
                                  decoration: BoxDecoration(
                                      color: Color(0xffEEEEEE),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: TextFormField(
                                    controller: _emailcontroller,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "email",
                                      hintStyle: TextStyle(
                                        fontSize: scrWidth * 0.039,
                                        color: Colors.grey,
                                      ),
                                      contentPadding: EdgeInsets.only(
                                          left: 2, right: 3, bottom: 9),
                                      errorStyle:
                                          TextStyle(fontSize: 9, height: 0.3),
                                    ),
                                    cursorColor: Colors.black,
                                    cursorHeight: 20,
                                    cursorWidth: 0.5,
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty ||
                                          !value.contains('@') ||
                                          !value.contains('.')) {
                                        return 'Invalid Email';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: scrHeight * 0.04,
                    ),
                    GestureDetector(
                      onTap: () {
                        print("click");
                        print(userId);
                        print(blankUser);
                        if (_loginkey.currentState!.validate()) {
                          if (_namecontroller.text != '' &&
                              _emailcontroller.text != '') {
                            if(userId!="" && blankUser){
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(userId)
                                  .update({

                                "userName": _namecontroller.text,
                                "userEmail": _emailcontroller.text,
                                "userImage": '',

                              }).then((value) =>
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Rootingpage(),
                                      ),
                                          (route) => false));
                            }
                            else {
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(widget.id)
                                  .set({
                                "userId": widget.id,
                                "userName": _namecontroller.text,
                                "userEmail": _emailcontroller.text,
                                "userImage": '',
                                "phone": widget.phone,
                                "totalExpense": 0,
                                "totalIncome": 0,
                              }).then((value) =>
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Rootingpage(),
                                      ),
                                          (route) => false));
                            }
                            // Navigator.push(context,
                            // MaterialPageRoute(builder: (context) => LoginPage()));
                          } else {
                            _namecontroller.text == ''
                                ? showSnackbar(context, 'Enter your User Name')
                                : showSnackbar(context, 'Enter your E Mail');
                          }
                        }
                      },
                      child: Container(
                        height: scrHeight * 0.055,
                        width: scrWidth * 0.87,
                        decoration: BoxDecoration(
                          color: primarycolor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text("CONTINUE", style: style),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: scrHeight * 0.02,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
