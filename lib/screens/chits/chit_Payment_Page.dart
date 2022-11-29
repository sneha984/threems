import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconpicker/Serialization/iconDataSerialization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../Authentication/root.dart';
import '../../kuri/createkuri.dart';
import '../../layouts/screen_layout.dart';
import '../../model/ChitModel.dart';
import '../../utils/themes.dart';
import '../splash_screen.dart';
import 'chitsucesspaid.dart';

class ChitPaymentPage extends StatefulWidget {
  final ChitModel chit;
  const ChitPaymentPage({Key? key, required this.chit}) : super(key: key);

  @override
  State<ChitPaymentPage> createState() => _ChitPaymentPageState();
}

class _ChitPaymentPageState extends State<ChitPaymentPage> {
  var icons;
  var categoryName;
  getIconData(){
    FirebaseFirestore.instance.collection('expenses').
    where('expenseName',isEqualTo:'Chit' ).snapshots().listen((event) {
      for(DocumentSnapshot data in event.docs){
        icons=deserializeIcon(data['icon']);
        categoryName=data['expenseName'];
        // _icon = Icon(icons,color: Colors.white,size: 45,);

      }


    });

  }
  TextEditingController? amount;

  String? imgUrl;
  var imgFile;
  // var fileUrl;

  Future uploadImageToFirebase(BuildContext context) async {
    Reference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('chit Payment Proof/$currentuserid');
    UploadTask uploadTask = firebaseStorageRef.putFile(imgFile);
    TaskSnapshot taskSnapshot = (await uploadTask);
    uploadTask.then((res) async {
      imgUrl = (await firebaseStorageRef.getDownloadURL()).toString();
    }).then((value) {
      setState(() {
        // imgUrl = value;
        print("----=========-============-===============-=============");
        print(imgUrl);
        print("----=========-============-===============-=============");
      });
    });
    // String value = await taskSnapshot.ref.getDownloadURL();

    // if(value!=null){
    //   imageList.add(value);
    // }
  }

  _pickImage() async {
    final imageFile =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    setState(() {
      imgFile = File(imageFile!.path);
      print('here');
      uploadImageToFirebase(context);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    amount = TextEditingController();
    getIconData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: scrHeight * 0.136,
              width: scrWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade100,
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: scrHeight * 0.07,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: scrWidth * 0.07,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        "assets/icons/arrow.svg",
                      ),
                    ),
                    SizedBox(
                      width: scrWidth * 0.04,
                    ),
                    Text(
                      "Kuri Payment",
                      style: TextStyle(
                          fontSize: scrWidth * 0.045,
                          color: Colors.black,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: scrHeight * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: scrWidth * 0.07,
                ),
                Container(
                    width: scrWidth * 0.21,
                    height: scrHeight * 0.048,
                    decoration: BoxDecoration(
                        color: Color(0xffF7F8F9),
                        borderRadius: BorderRadius.circular(scrWidth * 0.02),
                        border: Border.all(color: Color(0xffDADADA))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: scrHeight * 0.025,
                          width: scrWidth * 0.09,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/flag.png"),
                                  fit: BoxFit.fill)),
                        ),
                        Text(
                          "INR",
                          style: TextStyle(
                            fontSize: scrWidth * 0.045,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  width: scrWidth * 0.03,
                ),
                Container(
                  width: scrWidth * 0.62,
                  height: scrHeight * 0.048,
                  padding: EdgeInsets.symmetric(
                    horizontal: scrWidth * 0.04,
                    vertical: scrHeight * 0.006,
                  ),
                  decoration: BoxDecoration(
                      color: textFormFieldFillColor,
                      border: Border.all(
                        color: Color(0xffDADADA),
                      ),
                      borderRadius: BorderRadius.circular(scrWidth * 0.026)),
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/icons/rupees.svg"),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: scrHeight * 0.012, left: scrWidth * 0.02),
                        child: Container(
                          height: scrHeight * 0.03,
                          width: scrWidth * 0.4,
                          child: TextFormField(
                            controller: amount,
                            cursorHeight: scrWidth * 0.055,
                            cursorWidth: 1,
                            cursorColor: Colors.black,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize15,
                              fontFamily: 'Urbanist',
                            ),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              fillColor: textFormFieldFillColor,
                              filled: true,
                              contentPadding: EdgeInsets.only(
                                  left: scrWidth * 0.01,
                                  top: scrHeight * 0.01,
                                  bottom: scrHeight * 0.009),
                              disabledBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: scrHeight * 0.02,
            ),
            Row(
              children: [
                SizedBox(
                  width: scrWidth * 0.065,
                ),
                Text(
                  "Pay to",
                  style: TextStyle(
                    fontSize: scrWidth * 0.04,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w500,
                    color: Color(0xff827E7E),
                  ),
                ),
                SizedBox(
                  width: scrWidth * 0.02,
                ),
                Container(
                    width: scrWidth * 0.74,
                    height: scrHeight * 0.048,
                    decoration: BoxDecoration(
                        color: Color(0xffF7F8F9),
                        borderRadius: BorderRadius.circular(scrWidth * 0.026),
                        border: Border.all(color: Color(0xffDADADA))),
                    child: Row(
                      children: [
                        SizedBox(
                          width: scrWidth * 0.04,
                        ),
                        Text(
                          widget.chit.phone!,
                          style: TextStyle(
                            fontSize: scrWidth * 0.058,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: scrWidth * 0.1,
                        ),
                        SvgPicture.asset("assets/icons/copy.svg"),
                        SizedBox(
                          width: scrWidth * 0.015,
                        ),
                        InkWell(
                          onTap: () {
                            Clipboard.setData(
                                ClipboardData(text: widget.chit.phone!));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text("Phone Number copied to clipboard"),
                              ),
                            );
                          },
                          child: Text(
                            "copy",
                            style: TextStyle(
                              fontSize: scrWidth * 0.035,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
            SizedBox(
              height: scrHeight * 0.017,
            ),
            Row(
              children: [
                SizedBox(
                  width: scrWidth * 0.068,
                ),
                Text(
                  "Accepted UPI Apps",
                  style: TextStyle(
                    fontSize: scrWidth * 0.04,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w500,
                    color: Color(0xff827E7E),
                  ),
                ),
                SizedBox(
                  width: scrWidth * 0.09,
                ),
                widget.chit.upiApps!.contains('Google Pay')
                    ? Container(
                        height: 20,
                        width: 20,
                        child:
                            Image(image: AssetImage("assets/images/gpay.png")))
                    : SizedBox(),
                SizedBox(
                  width: 5,
                ),
                widget.chit.upiApps!.contains('Phonepe')
                    ? Container(
                        height: 20,
                        width: 15,
                        child: Image(
                            image: AssetImage("assets/images/phonepe.png")))
                    : SizedBox(),
                SizedBox(
                  width: 5,
                ),
                widget.chit.upiApps!.contains('Paytm')
                    ? Container(
                        height: 20,
                        width: 40,
                        child: Image(
                            image: AssetImage("assets/images/paytm (1).png")))
                    : SizedBox(),
                SizedBox(
                  width: 5,
                ),
                widget.chit.upiApps!.contains('Whatsapp Pay')
                    ? Container(
                        height: 20,
                        width: 15,
                        child: Image(
                            image: AssetImage("assets/images/whatsp pay.png")))
                    : SizedBox(),
                SizedBox(
                  width: 5,
                ),
                widget.chit.upiApps!.contains('Amazon Pay')
                    ? Container(
                        height: 20,
                        width: 45,
                        child: Image(
                            image:
                                AssetImage("assets/images/amaz pay (1).png")))
                    : SizedBox(),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Stack(
              children: [
                Container(
                  width: scrWidth * 1,
                  height: scrHeight * 0.3,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/card desigbn.png"),
                          fit: BoxFit.fill)),
                ),
                Positioned(
                    top: scrHeight * 0.04,
                    left: scrWidth * 0.15,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: scrWidth * 0.3),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                widget.chit.bankName!,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: scrHeight * 0.005,
                              ),
                              Text(
                                "IFSC : ${widget.chit.ifsc}",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: scrHeight * 0.05,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: scrWidth * 0.6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Banking Name",
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: scrHeight * 0.002,
                              ),
                              Text(
                                widget.chit.accountHolderName!,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: scrHeight * 0.005,
                              ),
                              Text(
                                "Account Number",
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: scrHeight * 0.002,
                              ),
                              Text(
                                widget.chit.accountNumber!,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ],
            ),
            InkWell(
              onTap: () {
                _pickImage();
                print(imgUrl);
              },
              child: imgFile == null
                  ? DottedBorder(
                      padding: EdgeInsets.all(0),
                      borderType: BorderType.RRect,
                      radius: Radius.circular(8),
                      color: Color(0xffDADADA),
                      dashPattern: [4, 4],
                      strokeWidth: 2,
                      child: Container(
                        height: scrHeight * 0.08,
                        width: scrWidth * 0.85,
                        decoration: BoxDecoration(
                          color: Color(0xffF7F8F9),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/images/Group 135.svg",
                            ),
                            SizedBox(
                              width: scrWidth * 0.02,
                            ),
                            Text(
                              "Upload Screenshot",
                              style: TextStyle(
                                color: Color(0xff8391A1),
                                fontSize: scrWidth * 0.04,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(
                      height: scrHeight * 0.5,
                      width: scrWidth * 0.85,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(imgFile) as ImageProvider,
                            fit: BoxFit.fill),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Color(0xffDADADA),
                        ),
                      ),
                    ),
            ),
            SizedBox(
              height: 118,
            ),
            Text(
              "after the verification of screenshot your payment will count on this kuri",
              style: TextStyle(
                color: Color(0xff827E7E),
                fontSize: 10,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                print(amount!.text);
                if (amount!.text != '' && (imgUrl != '' || imgUrl != null)) {
                  final payment = Payments(
                      userId: currentuserid,
                      amount: double.tryParse(amount!.text),
                      datePaid: DateTime.now(),
                      url: imgUrl,
                      verified: false);

                  FirebaseFirestore.instance
                      .collection('chit')
                      .doc(widget.chit.chitId)
                      .collection('payments')
                      .add(payment.toJson())
                      //     .update({
                      //   'payments': FieldValue.arrayUnion([
                      //     {
                      //       'amount': double.tryParse(amount!.text),
                      //       'url': imgUrl,
                      //       'userId': currentuserid,
                      //       'verified': false,
                      //       'datePaid': DateFormat.yMMMd().format(DateTime.now()),
                      //     }
                      //   ]),
                      //   'totalReceived':
                      //   FieldValue.increment(double.tryParse(amount!.text)!)
                      // })
                      .then((value) {
                    value.update({"paymentId": value.id}).then((value) {
                      FirebaseFirestore.instance.collection('users').doc(currentuserid).collection('expense').add({
                        'amount':double.tryParse(amount!.text.toString()),
                        "categoryIcon":serializeIcon(icons),
                        "categoryName":categoryName.toString(),
                        'date':DateTime.now(),
                        'merchant':'',

                      });
                      showSnackbar(context, 'Payment Completed Successfully');
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ChitSucessPaidPage()));
                      // Navigator.pushAndRemoveUntil(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => ScreenLayout(),
                      //     ),
                      //     (route) => false);
                    });
                  });
                } else {
                  amount!.text == ''
                      ? showSnackbar(context, 'Enter amount')
                      : showSnackbar(context, 'Upload Proof');
                }
                print(imgUrl);
                print(imgFile);
              },
              child: Container(
                height: 45,
                width: 320,
                decoration: BoxDecoration(
                  color: primarycolor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    "PAYMENT NOW",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
