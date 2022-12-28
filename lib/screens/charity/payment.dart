
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconpicker/Serialization/iconDataSerialization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:threems/screens/charity/sucess.dart';

import '../../Authentication/root.dart';
import '../../model/charitymodel.dart';
import '../../model/usermodel.dart';
import '../../utils/themes.dart';
import '../splash_screen.dart';
import 'dart:io';


class PaymentPage extends StatefulWidget {
  final CharityModel charitymodel;
  const PaymentPage({Key? key, required this.charitymodel,}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

  bool loading=false;


  String? imgUrl;
  var imgFile;
  var uploadTask;
  var fileUrl;
  var docUrl;
  var uploadTasks;
  Future uploadImageToFirebase(BuildContext context) async {
    Reference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('deposits/${imgFile.path}');
    UploadTask uploadTask = firebaseStorageRef.putFile(imgFile);
    TaskSnapshot taskSnapshot = (await uploadTask);
    String value = await taskSnapshot.ref.getDownloadURL();

    // if(value!=null){
    //   imageList.add(value);
    // }
    setState(() {
      loading=false;
      imgUrl = value;

    });
  }
  _pickImage() async {
    loading=true;

    final imageFile = await ImagePicker.platform.pickImage(
        source: ImageSource.gallery);
    setState(() {
      imgFile = File(imageFile!.path);
      uploadImageToFirebase(context);
    });
  }
  var icons;
  var categoryName;
  getIconData(){
    FirebaseFirestore.instance.collection('expenses').
    where('expenseName',isEqualTo:'charity' ).snapshots().listen((event) {
      for(DocumentSnapshot data in event.docs){
        icons=deserializeIcon(data['icon']);
        categoryName=data['expenseName'];
        // _icon = Icon(icons,color: Colors.white,size: 45,);

      }


    });

  }
  final FocusNode valueAmountFocus = FocusNode();
  final  TextEditingController valueAmountController =TextEditingController();

  @override
  void initState() {

    // image = null;
    super.initState();
    getIconData();
  }

  @override
  void dispose() {
    super.dispose();
  }
  refreshPage() {
    setState(() {
      loading = false;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading?Center(child: CircularProgressIndicator(),):SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: scrHeight*0.136,
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
              child:  Padding(
                padding: EdgeInsets.only(
                    top: scrHeight*0.07,),
                child: Row(
                  children: [
                    SizedBox(width: scrWidth*0.05,),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child:  SvgPicture.asset("assets/icons/arrow.svg",),
                    ),
                    SizedBox(width: scrWidth*0.05,),

                    Text("Make a Donation",style: TextStyle(
                        fontSize: scrWidth*0.045,
                        color: Colors.black,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w700),),
                  ],
                ),
              ),
            ),
            SizedBox(height: scrHeight*0.025,),
            Row(
              children: [
                SizedBox(width: scrWidth*0.055,),
                Container(
                  width: scrWidth*0.32,
                  height: scrHeight*0.15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(scrWidth*0.09),
                      image: DecorationImage(
                          image: NetworkImage(widget.charitymodel.image!),fit: BoxFit.fill)
                  ),
                ),
                SizedBox(width: scrWidth*0.035,),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: scrWidth*0.56,
                      child: Text(widget.charitymodel.charityDetailes!,style: TextStyle(
                          fontSize:scrWidth*0.036,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(height: scrHeight*0.01,),

                    Row(
                      children: [
                        Text(widget.charitymodel.beneficiaryName!,style: TextStyle(
                            fontSize:scrWidth*0.04,
                            color: Color(0xff827E7E),
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w500)),
                        SizedBox(width: scrWidth*0.01,),
                        SvgPicture.asset("assets/icons/Frame (1).svg"),

                      ],
                    ),
                    SizedBox(height: scrHeight*0.07,),
                  ],
                )
              ],
            ),
            SizedBox(height: scrHeight*0.026,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width:scrWidth*0.057,),
                Container(
                    width: scrWidth*0.24,
                    height: scrHeight*0.048,
                    decoration: BoxDecoration(
                        color: Color(0xffF7F8F9),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Color(0xffDADADA))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            height: scrHeight*0.025,
                            width: scrWidth*0.09,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/flag.png"),fit: BoxFit.fill)
                          ),
                        ),
                        Text(
                          "INR",
                          style: TextStyle(
                            fontSize: scrWidth*0.044,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )),
                SizedBox(width: scrWidth*0.029,),

                Container(
                  width: scrWidth*0.615,
                  height: scrHeight*0.048,
                  padding: EdgeInsets.symmetric(
                    horizontal: scrWidth * 0.04,
                    vertical: scrHeight*0.001,
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
                        padding:  EdgeInsets.only(bottom: scrHeight*0.014,left: scrWidth*0.03),
                        child: Container(
                          height: scrHeight*0.05,
                          width: scrWidth*0.4,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: valueAmountController,
                            focusNode: valueAmountFocus,
                            cursorHeight: scrWidth * 0.06,
                            cursorWidth: 1,
                            cursorColor: Colors.black,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: scrWidth*0.05,
                              fontFamily: 'Urbanist',
                            ),
                            decoration: InputDecoration(
                              fillColor: textFormFieldFillColor,
                              filled: true,
                              contentPadding: EdgeInsets.only(left: scrWidth*0.01,
                                   top: scrHeight*0.01, bottom: scrHeight*0.01),
                              disabledBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              border: InputBorder.none,
                              // focusedBorder: UnderlineInputBorder(
                              //   borderSide: BorderSide(
                              //     color: primarycolor,
                              //     width: 2,
                              //   ),
                              // ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
            SizedBox(height: scrHeight*0.017,),
            Row(
              children: [
                SizedBox(width: scrWidth*0.06,),
                Text(
                  "Pay to",
                  style: TextStyle(
                    fontSize: scrWidth*0.04,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w500,
                    color: Color(0xff827E7E),
                  ),
                ),
                SizedBox(width: scrWidth*0.03,),
                GestureDetector(
                  onLongPress: () {
                    Clipboard.setData(ClipboardData(text: widget.charitymodel.phoneNumber!));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Text copied to clipboard"),
                      ),
                    );
                  },
                  child: Container(
                      width: scrWidth*0.74,
                      height: scrHeight*0.048,
                      decoration: BoxDecoration(
                          color: Color(0xffF7F8F9),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Color(0xffDADADA))),
                      child: Row(
                        children: [
                          SizedBox(width: scrWidth*0.04,),
                          Text(
                            "+91 ",
                            style: TextStyle(
                              fontSize: scrWidth*0.05,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            widget.charitymodel.phoneNumber!,
                            style: TextStyle(
                              fontSize: scrWidth*0.05,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: scrWidth*0.16,),

                          SvgPicture.asset("assets/icons/copy.svg"),
                          SizedBox(width:scrWidth*0.02,),

                          Text(
                            "copy",
                            style: TextStyle(
                              fontSize: scrWidth*0.03,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),


                        ],
                      )),
                ),

              ],
            ),
            SizedBox(height: scrHeight*0.017,),
            Row(
              children: [
                SizedBox(width: scrWidth*0.05,),
                Text(
                  "Accepted UPI Apps",
                  style: TextStyle(
                    fontSize: scrWidth*0.04,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w500,
                    color: Color(0xff827E7E),
                  ),
                ),
                SizedBox(width: scrWidth*0.16,),

                Container(
                  height: scrHeight*0.03,
                    width: scrWidth*0.05,
                    child: Image(image: AssetImage("assets/images/gpay.png"))),
                SizedBox(width:scrWidth*0.015,),

                Container(
                    height: scrHeight*0.03,
                    width: scrWidth*0.04,
                    child: Image(image: AssetImage("assets/images/phonepe.png"))),
                SizedBox(width: scrWidth*0.02,),

                Container(
                    height: scrHeight*0.02,
                    width: scrWidth*0.09,
                    child: Image(image: AssetImage("assets/images/paytm (1).png"))),
                SizedBox(width: scrWidth*0.01,),

                Container(
                    height: scrHeight*0.02,
                    width: scrWidth*0.05,
                    child: Image(image: AssetImage("assets/images/whatsp pay.png"))),
                SizedBox(width: scrWidth*0.01,),

                Container(
                    height: scrHeight*0.02,
                    width: scrWidth*0.09,
                    child: Image(image: AssetImage("assets/images/amaz pay (1).png"))),
              ],
            ),
            SizedBox(height: scrHeight*0.01,),
            Stack(
              children: [
                Container(
                  width: scrWidth*1,
                  height: scrHeight*0.3,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage("assets/images/card desigbn.png"),fit: BoxFit.fill)
                  ),
                ),
                Positioned(
                    top: scrHeight*0.04,
                    left: scrWidth*0.15,
                    child: Column(
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(left: scrWidth*0.3),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(widget.charitymodel.bankName!,style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white
                              ),),
                              SizedBox(height: scrHeight*0.005,),
                              Text("IFSC : ${widget.charitymodel.ifscCode}",style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white
                              ),),
                            ],
                          ),
                        ),

                        SizedBox(height: scrHeight*0.05,),
                        Padding(
                          padding:  EdgeInsets.only(right: scrWidth*0.6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Banking Name",style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white
                              ),),
                              SizedBox(height: scrHeight*0.002,),
                              Text(widget.charitymodel.accountHolderName!,style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white
                              ),),
                              SizedBox(height: scrHeight*0.005,),
                              Text("Account Number",style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white
                              ),),
                              SizedBox(height: scrHeight*0.002,),
                              Text(widget.charitymodel.accountNumber!,style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white
                              ),),
                            ],
                          ),
                        ),
                      ],
                    )
                ),
              ],
            ),
            Container(
              height: 200,
              width:300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: NetworkImage(
                          widget.charitymodel.qrImage!),fit: BoxFit.fill)
              ),
            ),
         SizedBox(height: 20,),
            Padding(
              padding:  EdgeInsets.only(right: 98),
              child: Text("Upload Payment Screenshot",style: TextStyle(
                fontSize: scrWidth*0.043,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w500,
              ),),
            ),
            SizedBox(height: 10,),
            InkWell(
              onTap: (){
                _pickImage();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 16,right: 16),
                child: Container(
                  height:scrHeight*0.16,
                  width: scrWidth*1,
                  decoration: BoxDecoration(
                    color: Color(0xffF7F8F9),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Color(0xffDADADA),
                    ),
                  ),
                  child: Center(
                      child: imgFile==null?Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/camera2.svg',
                            color: Color(0xff8391A1),
                          ),
                          SizedBox(
                            width: scrWidth * 0.04,
                          ),
                          Text(
                            'Upload  ScreenShort',
                            style: TextStyle(
                              fontSize: FontSize15,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w500,
                              color: Color(0xff8391A1),
                            ),
                          )
                        ],
                      ):Container(
                        height:scrHeight*0.16,
                        width: scrWidth*1,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(imgFile!) as ImageProvider,fit: BoxFit.fill),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Color(0xffDADADA),
                          ),
                        ),

                      )
                  ),
                ),
              ),
            ),

          //   InkWell(
          // onTap: (){
          //   _pickImage();
          //   print(imgUrl);
          //   },
          //     child: imgFile==null?
          //     DottedBorder(
          //       padding: EdgeInsets.all(0),
          //       borderType: BorderType.RRect,
          //       radius: Radius.circular(8),
          //       color: Color(0xffDADADA),
          //       dashPattern: [4,4],
          //       strokeWidth: 2,
          //       child: Container(
          //         height: scrHeight*0.08,
          //         width: scrWidth*0.85,
          //         decoration: BoxDecoration(
          //           color: Color(0xffF7F8F9),
          //           borderRadius: BorderRadius.circular(8),
          //         ),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             SvgPicture.asset(
          //               "assets/images/Group 135.svg",
          //             ),
          //             SizedBox(
          //               width: scrWidth * 0.02,
          //             ),
          //             Text(
          //               "Upload Screenshot",
          //               style: TextStyle(
          //                 color: Color(0xff8391A1),
          //                 fontSize: scrWidth*0.04,
          //                 fontFamily: 'Urbanist',
          //                 fontWeight: FontWeight.w500,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ):Container(
          //       height: scrHeight*0.3,
          //       width: scrWidth*0.85,
          //       decoration: BoxDecoration(
          //         image: DecorationImage(
          //             image: FileImage(imgFile!) as ImageProvider,fit: BoxFit.fill),
          //         borderRadius: BorderRadius.circular(8),
          //         border: Border.all(
          //           color: Color(0xffDADADA),
          //         ),
          //       ),
          //     ),
          //   ),
            SizedBox(height: scrHeight*0.01,),
            Text(
              "after the verification of screenshot your donation will appear on this charity",
              style: TextStyle(
                color: Color(0xff827E7E),
                fontSize: scrWidth*0.025,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: scrHeight*0.2,),


          ],
        ),
      ),
      floatingActionButton: GestureDetector(
          onTap: (){
            FirebaseFirestore.instance.collection('charity').doc(widget.charitymodel.charityId).update({
              'payments':FieldValue.arrayUnion(
              [
                {
                  'amount':double.tryParse(valueAmountController.text),
                  'screenShotUrl':imgUrl,
                  'userId':currentuser!.userId,
                  'userName':currentuser!.userName,
                  'verified':false,
                  'date':DateFormat.yMMMd().format(DateTime.now()),
                }
              ]
              ),
              'totalReceived':
              FieldValue.increment(double.tryParse(valueAmountController.text)!)
            }

            );
            FirebaseFirestore.instance.collection('users').doc(currentuserid).collection('expense').add({
              'amount':double.tryParse(valueAmountController.text),
              "categoryIcon":serializeIcon(icons),
              "categoryName":categoryName.toString(),
              'date':DateTime.now(),
              'merchant':'',
            });
            print(imgUrl);
            print(imgFile);
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Sucesspage()));
          },
          child: Container(
      height: scrHeight*0.055,
      width: scrWidth*0.85,
      decoration: BoxDecoration(
          color: primarycolor,
          borderRadius: BorderRadius.circular(8),
      ),
            child: Center(
              child: Text(
                "DONATE NOW",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: scrWidth*0.04,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ),
    );
  }
}
