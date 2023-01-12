import 'dart:math';

import 'package:another_stepper/dto/stepper_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/Serialization/iconDataSerialization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:threems/Authentication/root.dart';
import 'package:threems/screens/splash_screen.dart';
import 'package:another_stepper/another_stepper.dart';
import 'package:threems/simple.dart';

import '../../Income/addIncome/addnew_income.dart';
import '../../customPackage/date_picker.dart';
import '../../screens/charity/verification_details.dart';
import '../../utils/themes.dart';
import 'expenses_succss_widget.dart';
import 'newExpenseCategory.dart';

int _activeStepIndex = 0;

class NewExpensePage extends StatefulWidget {
  const NewExpensePage({Key? key}) : super(key: key);

  @override
  State<NewExpensePage> createState() => _NewExpensePageState();
}

class _NewExpensePageState extends State<NewExpensePage> {
  bool switchValue=false;
  bool click=false;
  String phNumber = '';
  String contactName = '';
  String category = '';
  String merchantName = '';
  Icon? _icon;
  var icons;
  var xyz;
  Icon? selectedIcons;
  var selectedDate;
  // getdd(){
  //   FirebaseFirestore.instance.collection('users').snapshots().listen((event) {
  //     for(DocumentSnapshot doc in event.docs){
  //       FirebaseFirestore.instance.collection('users').
  //       doc(doc.id).collection('expense').snapshots().listen((event) {
  //         for(DocumentSnapshot abc in event.docs){
  //           FirebaseFirestore.instance.collection('users').
  //           doc(doc.id).collection('expense').doc(abc.id).update({
  //             'description':''
  //           });
  //
  //         }
  //       });
  //
  //     }
  //
  //   });
  // }
  getIcon() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('expenses')
        .doc('cn3myFOpRZrE8NLKC8fg')
        .get();
    icons = deserializeIcon(doc['serviceCity']);
    _icon = Icon(icons);

    setState(() {});
  }

  TextEditingController amount = TextEditingController();
  TextEditingController merchant = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController userName = TextEditingController();
  String selectedUserId='';
  getUserData() async {
    QuerySnapshot event= await FirebaseFirestore.instance.collection('users').where('phone',whereIn: [phNumber,"+91$phNumber","+91 $phNumber"]).
    get();

    if(event.docs.isNotEmpty) {
      for (DocumentSnapshot data in event.docs) {
        selectedUserId=data['userId'];
        return;

      }
    }else{

      await  FirebaseFirestore.instance.collection('users').add({
        // "userId": selectedUserId,
        "userName": contactName,
        "userEmail": '',
        "userImage": '',
        "phone": phNumber,
        "dateTime": FieldValue.serverTimestamp(),

      }).then((value) async {
        selectedUserId=value.id;
        value.update({
          'userId':value.id

        });
        return;

      });
      await Future.delayed(Duration(seconds: 1));
      return;


    }
    // if(mounted){
    //   setState(() {
    //
    //   });
    // }


  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? datePicked = await showDatePickerCustom(
        cancelText: 'Cancel',
        confirmText: 'Select',
        context: context,
        firstDate: DateTime(2000, 1),
        lastDate: DateTime(DateTime.now().year + 100),
        initialDate: DateTime.now(),
        builder: (context, child) => Theme(
            data: ThemeData(
                colorScheme: ColorScheme.light(primary: Colors.green)),
            child: child!));
    if (datePicked != null && datePicked != selectedDate) {
      setState(() {
        selectedDate = datePicked;
      });
    }
  }

  @override
  void initState() {
    // getdd();
    print(currentuserid);
    selectedDate = DateTime.now();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (amount?.text != '') {
          return !await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                      backgroundColor: Colors.white,
                      title: Text(
                        'Are you sure you want to exit ?',
                        style: GoogleFonts.urbanist(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                      actions: <Widget>[
                        ElevatedButton(
                            // color: Colors.transparent,
                            // shape: ShapeBorder.lerp(Border.all(color: Colors.red), Border.all(color: Colors.green), 50),
                            child: Text(
                              'Yes',
                              style: GoogleFonts.urbanist(color: Colors.white),
                            ),
                            onPressed: () => Navigator.of(context).pop(false)),
                        ElevatedButton(
                            // color: Colors.transparent,
                            // shape: ShapeBorder.lerp(Border.all(color: Colors.red), Border.all(color: Colors.green), 5),

                            child: Text(
                              'No',
                              style: GoogleFonts.urbanist(color: Colors.white),
                            ),
                            onPressed: () => Navigator.of(context).pop(true)),
                      ]));
        } else {
          Navigator.pop(context);
        }
        return null!;
      },
      child: Scaffold(
        backgroundColor: Color(0xff02B558),
        extendBody: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(scrWidth * 0.24),
          child: Container(
            /*decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  offset: Offset(0, 4),
                  blurRadius: 25),
            ]),*/
            child: AppBar(
              toolbarHeight: 75,
              automaticallyImplyLeading: false,
              backgroundColor: tabBarColor,
              title: Padding(
                padding: EdgeInsets.only(top: 30, left: 15),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.close_outlined,
                            color: Colors.black,
                            size: 20,
                          )),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Add new expense",
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),

                  ],
                ),
              ),

            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: scrWidth,
            height: scrHeight * .846,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: scrWidth * 0.09,
                    ),
                    Container(
                      width: scrWidth * 0.8,
                      height: scrWidth * 0.13,
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
                        controller: amount,
                        cursorHeight: scrWidth * 0.06,
                        cursorWidth: 1,
                        cursorColor: Colors.black,
                        style: TextStyle(
                          color: primarycolor,
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                          fontFamily: 'urbanist',
                        ),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: '₹ 0.00',
                          hintStyle: TextStyle(
                            color: textFormUnFocusColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 35,
                            fontFamily: 'Urbanist',
                          ),
                          fillColor: textFormFieldFillColor,
                          filled: true,
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

                          contentPadding: EdgeInsets.only(
                            left: scrWidth * 0.03,
                            top: scrHeight * 0.006,
                          ),
                          // border: OutlineInputBorder(),
                          // focusedBorder: OutlineInputBorder(
                          //     borderSide: BorderSide(color: Color(0xff034a82),width: 2)
                          // ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: scrWidth * 0.035,
                    ),
                    Container(
                      height: scrWidth * 0.6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 22.0, right: 18),
                            child: InkWell(
                              onTap: () {
                                _selectDate(context);
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 15,
                                    ),
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundColor: textFormFieldFillColor,
                                      child: SvgPicture.asset(
                                        'assets/icons/calendar.svg',
                                        width: scrWidth * 0.05,
                                        height: scrHeight * 0.03,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    selectedDate == null
                                        ? Text(
                                            'Nov1 16,2022',
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontFamily: 'Urbanist',
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                          )
                                        : Text(
                                            DateFormat('MMM dd,yyyy')
                                                .format(selectedDate),
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontFamily: 'Urbanist',
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 22.0, right: 18),
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                          insetPadding: EdgeInsets.only(
                                              bottom: scrWidth * 0.275,
                                              top: scrWidth * 0.275,
                                              right: scrWidth * 0.07,
                                              left: scrWidth * 0.07),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(45.0))),
                                          contentPadding:
                                              EdgeInsets.all(scrWidth * 0.07),
                                          content: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  width: scrWidth * 1,
                                                  child: StreamBuilder<
                                                          QuerySnapshot>(
                                                      stream: FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              'expenses')
                                                          .where('user',
                                                              whereIn: [
                                                            'admin',
                                                            currentuserid
                                                          ]).snapshots(),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (!snapshot.hasData) {
                                                          return Container(
                                                              child: Center(
                                                                  child:
                                                                      CircularProgressIndicator()));
                                                        }
                                                        var data =
                                                            snapshot.data?.docs;
                                                        return data?.length == 0
                                                            ? Center(
                                                                child: Text(
                                                                  'No Expense category ',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      fontFamily:
                                                                          'urbanist',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              )
                                                            : GridView.builder(
                                                                shrinkWrap:
                                                                    true,
                                                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                                    crossAxisCount:
                                                                        3,
                                                                    mainAxisSpacing:
                                                                        10,
                                                                    crossAxisSpacing:
                                                                        10,
                                                                    childAspectRatio:
                                                                        0.9),
                                                                itemCount: data
                                                                    ?.length,
                                                                itemBuilder:
                                                                    (context,
                                                                        index) {
                                                                  icons = deserializeIcon(
                                                                      data![index]
                                                                          [
                                                                          'icon']);
                                                                  _icon = Icon(
                                                                    icons,
                                                                    size: 40,
                                                                    color: Colors
                                                                        .white,
                                                                  );
                                                                  return InkWell(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        category =
                                                                            data![index]['expenseName'];
                                                                        xyz = deserializeIcon(data![index]
                                                                            [
                                                                            'icon']);
                                                                        selectedIcons =
                                                                            Icon(
                                                                          xyz,
                                                                          size:
                                                                              35,
                                                                          color:
                                                                              Colors.white,
                                                                        );
                                                                      });
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.stretch,
                                                                        children: [
                                                                          Expanded(
                                                                            flex:
                                                                                5,
                                                                            child:
                                                                                Container(
                                                                              decoration: BoxDecoration(color: Colors.primaries[Random().nextInt(Colors.primaries.length)], shape: BoxShape.circle),
                                                                              child: _icon,
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            flex:
                                                                                2,
                                                                            child:
                                                                                Container(
                                                                              child: Text(
                                                                                data![index]['expenseName'],
                                                                                style: TextStyle(
                                                                                    fontFamily: 'urbanist',
                                                                                    fontSize: scrWidth * 0.027,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    // color: Color(0xff034a82)
                                                                                    color: Colors.black),
                                                                                textAlign: TextAlign.center,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                      }),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ExpenseCategoryPage()));
                                                },
                                                child: Center(
                                                  child: Container(
                                                    width: scrWidth * 0.8,
                                                    height: scrHeight * 0.07,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xff008036),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    child: Center(
                                                      child: Text(
                                                        " Add new category",
                                                        style: TextStyle(
                                                            fontSize: scrWidth *
                                                                0.046,
                                                            color: Colors.white,
                                                            fontFamily:
                                                                'Urbanist',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ));
                                    });
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 15,
                                    ),
                                    category == ''
                                        ? CircleAvatar(
                                            radius: 25,
                                            backgroundColor:
                                                textFormFieldFillColor,
                                            child: SvgPicture.asset(
                                              'assets/icons/storecategory.svg',
                                              width: scrWidth * 0.05,
                                              height: scrHeight * 0.03,
                                              fit: BoxFit.contain,
                                              color: primarycolor,
                                            ))
                                        : CircleAvatar(
                                            backgroundColor: Colors.primaries[
                                                Random().nextInt(
                                                    Colors.primaries.length)],
                                            radius: 25,
                                            child: selectedIcons,
                                          ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    category == ''
                                        ? Text(
                                            'Add Category',
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey,
                                            ),
                                          )
                                        : Text(
                                            category.toString(),
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              switchValue==false? Padding(
                                padding:
                                    const EdgeInsets.only(left: 22.0, right: 18),
                                child: InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                            height: 200,
                                            child: AlertDialog(
                                              title: Text(
                                                'Add Merchant',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'urbanist'),
                                              ),
                                              // insetPadding: EdgeInsets.only(bottom: scrWidth*0.6,top:  scrWidth*0.6,right:  scrWidth*0.09,left:  scrWidth*0.09),
                                              // shape: RoundedRectangleBorder(
                                              //     borderRadius: BorderRadius.all(Radius.circular(45.0))),
                                              content: Container(
                                                width: scrWidth * 1,
                                                height: scrWidth * 0.5,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(15)),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Container(
                                                      width: scrWidth * 1,
                                                      height: scrWidth * 0.12,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  15),
                                                          border: Border.all(
                                                              color: primarycolor)),
                                                      child: TextFormField(
                                                        controller: merchant,
                                                        cursorColor: Colors.black,
                                                        style: TextStyle(
                                                          color: primarycolor,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 15,
                                                          fontFamily: 'urbanist',
                                                        ),
                                                        keyboardType:
                                                            TextInputType.text,
                                                        decoration: InputDecoration(
                                                          hintText:
                                                              'Enter merchant name',
                                                          hintStyle: TextStyle(
                                                            color:
                                                                textFormUnFocusColor,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 15,
                                                            fontFamily: 'Urbanist',
                                                          ),
                                                          fillColor:
                                                              textFormFieldFillColor,
                                                          filled: true,
                                                          disabledBorder:
                                                              InputBorder.none,
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                          color:
                                                                              primarycolor,
                                                                          width:
                                                                              1.0),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15)),
                                                          errorBorder:
                                                              InputBorder.none,
                                                          border: InputBorder.none,

                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(15),
                                                            borderSide: BorderSide(
                                                              color: primarycolor,
                                                              width: 2,
                                                            ),
                                                          ),

                                                          //
                                                          // border: OutlineInputBorder(),
                                                          // focusedBorder: OutlineInputBorder(
                                                          //     borderSide: BorderSide(color: Color(0xff034a82),width: 2)
                                                          // ),
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        merchantName =
                                                            merchant!.text;
                                                        setState(() {});
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        width: scrWidth * 0.3,
                                                        height: scrWidth * 0.12,
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  15),
                                                          color: primarycolor,
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            " Ok",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    scrWidth * 0.05,
                                                                color: Colors.white,
                                                                fontFamily:
                                                                    'Urbanist',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // actions: [
                                              //   TextButton(onPressed: (){
                                              //     Navigator.pop(context);
                                              //     merchantName=merchant!.text;
                                              //     setState(() {
                                              //
                                              //     });
                                              //   },
                                              //       child: const Text('Ok')),
                                              // ],
                                            ),
                                          );
                                        });
                                  },
                                  child: Container(
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 15,
                                        ),
                                        CircleAvatar(
                                          radius: 25,
                                          backgroundColor: textFormFieldFillColor,
                                          child: SvgPicture.asset(
                                            'assets/icons/merchant.svg',
                                            width: scrWidth * 0.05,
                                            height: scrHeight * 0.03,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        merchantName == ''
                                            ? Text(
                                                'Merchant',
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  fontFamily: 'Urbanist',
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey,
                                                ),
                                              )
                                            : Text(
                                                merchantName.toString(),
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  fontFamily: 'Urbanist',
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                              ): Padding(
                                padding:
                                const EdgeInsets.only(left: 22.0, right: 18),
                                child: InkWell(
                                  onTap: () async {
                                    await Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectUserWidget(
                                      contactName:contactName??'',
                                      phNumber:phNumber??'',
                                    )));
                                    if(dataIncome!=null){
                                      contactName=dataIncome['contactName'];
                                      phNumber=dataIncome['phNumber'];
                                      setState(() {

                                      });
                                    }
                                    // showDialog(
                                    //     context: context,
                                    //     builder: (BuildContext context) {
                                    //       return  SelectUserWidget(
                                    //
                                    //       );
                                    //       //   Container(
                                    //       //   height: 200,
                                    //       //   child: AlertDialog(
                                    //       //     title: Text(
                                    //       //       'Add User',
                                    //       //       style: TextStyle(
                                    //       //           fontSize: 15,
                                    //       //           fontFamily: 'urbanist'),
                                    //       //     ),
                                    //       //     // insetPadding: EdgeInsets.only(bottom: scrWidth*0.6,top:  scrWidth*0.6,right:  scrWidth*0.09,left:  scrWidth*0.09),
                                    //       //     // shape: RoundedRectangleBorder(
                                    //       //     //     borderRadius: BorderRadius.all(Radius.circular(45.0))),
                                    //       //     content: Container(
                                    //       //       width: scrWidth * 1,
                                    //       //       height: scrWidth * 0.5,
                                    //       //       decoration: BoxDecoration(
                                    //       //           borderRadius:
                                    //       //           BorderRadius.circular(15)),
                                    //       //       child: Column(
                                    //       //         mainAxisAlignment:
                                    //       //         MainAxisAlignment.spaceEvenly,
                                    //       //         children: [
                                    //       //           Container(
                                    //       //             width: scrWidth * 1,
                                    //       //             height: scrWidth * 0.12,
                                    //       //             decoration: BoxDecoration(
                                    //       //                 borderRadius:
                                    //       //                 BorderRadius.circular(
                                    //       //                     15),
                                    //       //                 border: Border.all(
                                    //       //                     color: primarycolor)),
                                    //       //             child: TextFormField(
                                    //       //               onChanged: (txt){
                                    //       //                 totalContactsSearch = [];
                                    //       //                 if (merchant.text == '') {
                                    //       //                   totalContactsSearch.addAll(totalContacts);
                                    //       //                 } else {
                                    //       //                   searchContacts(merchant.text);
                                    //       //                 }
                                    //       //               },
                                    //       //
                                    //       //               controller: merchant,
                                    //       //               cursorColor: Colors.black,
                                    //       //               style: TextStyle(
                                    //       //                 color: primarycolor,
                                    //       //                 fontWeight:
                                    //       //                 FontWeight.w600,
                                    //       //                 fontSize: 15,
                                    //       //                 fontFamily: 'urbanist',
                                    //       //               ),
                                    //       //               keyboardType:
                                    //       //               TextInputType.text,
                                    //       //               decoration: InputDecoration(
                                    //       //                 hintText:
                                    //       //                 'Enter User name',
                                    //       //                 hintStyle: TextStyle(
                                    //       //                   color:
                                    //       //                   textFormUnFocusColor,
                                    //       //                   fontWeight:
                                    //       //                   FontWeight.w500,
                                    //       //                   fontSize: 15,
                                    //       //                   fontFamily: 'Urbanist',
                                    //       //                 ),
                                    //       //                 fillColor:
                                    //       //                 textFormFieldFillColor,
                                    //       //                 filled: true,
                                    //       //                 disabledBorder:
                                    //       //                 InputBorder.none,
                                    //       //                 enabledBorder:
                                    //       //                 OutlineInputBorder(
                                    //       //                     borderSide:
                                    //       //                     BorderSide(
                                    //       //                         color:
                                    //       //                         primarycolor,
                                    //       //                         width:
                                    //       //                         1.0),
                                    //       //                     borderRadius:
                                    //       //                     BorderRadius
                                    //       //                         .circular(
                                    //       //                         15)),
                                    //       //                 errorBorder:
                                    //       //                 InputBorder.none,
                                    //       //                 border: InputBorder.none,
                                    //       //
                                    //       //                 focusedBorder:
                                    //       //                 UnderlineInputBorder(
                                    //       //                   borderRadius:
                                    //       //                   BorderRadius
                                    //       //                       .circular(15),
                                    //       //                   borderSide: BorderSide(
                                    //       //                     color: primarycolor,
                                    //       //                     width: 2,
                                    //       //                   ),
                                    //       //                 ),
                                    //       //
                                    //       //                 //
                                    //       //                 // border: OutlineInputBorder(),
                                    //       //                 // focusedBorder: OutlineInputBorder(
                                    //       //                 //     borderSide: BorderSide(color: Color(0xff034a82),width: 2)
                                    //       //                 // ),
                                    //       //               ),
                                    //       //             ),
                                    //       //           ),
                                    //       //           InkWell(
                                    //       //             onTap: () {
                                    //       //               merchantName =
                                    //       //                   merchant!.text;
                                    //       //               setState(() {});
                                    //       //               Navigator.pop(context);
                                    //       //             },
                                    //       //             child: Container(
                                    //       //               width: scrWidth * 0.3,
                                    //       //               height: scrWidth * 0.12,
                                    //       //               decoration: BoxDecoration(
                                    //       //                 borderRadius:
                                    //       //                 BorderRadius.circular(
                                    //       //                     15),
                                    //       //                 color: primarycolor,
                                    //       //               ),
                                    //       //               child: Center(
                                    //       //                 child: Text(
                                    //       //                   " Ok",
                                    //       //                   style: TextStyle(
                                    //       //                       fontSize:
                                    //       //                       scrWidth * 0.05,
                                    //       //                       color: Colors.white,
                                    //       //                       fontFamily:
                                    //       //                       'Urbanist',
                                    //       //                       fontWeight:
                                    //       //                       FontWeight
                                    //       //                           .w600),
                                    //       //                 ),
                                    //       //               ),
                                    //       //             ),
                                    //       //           ),
                                    //       //         ],
                                    //       //       ),
                                    //       //     ),
                                    //       //     // actions: [
                                    //       //     //   TextButton(onPressed: (){
                                    //       //     //     Navigator.pop(context);
                                    //       //     //     merchantName=merchant!.text;
                                    //       //     //     setState(() {
                                    //       //     //
                                    //       //     //     });
                                    //       //     //   },
                                    //       //     //       child: const Text('Ok')),
                                    //       //     // ],
                                    //       //   ),
                                    //       // );
                                    //     });
                                  },
                                  child: Container(
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 15,
                                        ),
                                        CircleAvatar(
                                          radius: 25,
                                          backgroundColor: textFormFieldFillColor,
                                          child: SvgPicture.asset(
                                            'assets/images/profilepic.svg',
                                            color: primarycolor,
                                            width: scrWidth * 0.05,
                                            height: scrHeight * 0.03,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),

                                        Text(
                                          contactName==''?
                                          'User' :contactName.toString(),
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey,
                                          ),
                                        )

                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              Padding(
                                padding:  EdgeInsets.only(right: 11,),
                                child: Row(
                                  children: [
                                    // ToggleSwitch(
                                    //   changeOnTap:true,
                                    //   // minWidth: scrWidth*0.15,
                                    //   // minHeight:  scrWidth*0.07,
                                    //   cornerRadius: 20.0,
                                    //   activeBgColors: [[Colors.green[800]!], [Colors.green[800]!]],
                                    //   activeFgColor: Colors.white,
                                    //   inactiveBgColor: Colors.grey,
                                    //   inactiveFgColor: Colors.white,
                                    //   initialLabelIndex: 0,
                                    //   totalSwitches: 2,
                                    //   labels: [ 'Merchant','User'],
                                    //   radiusStyle: true,
                                    //   onToggle: (index) {
                                    //
                                    //      switchValue=!switchValue;
                                    //      print(switchValue);
                                    //
                                    //
                                    //                                 },
                                    // ),
                                    switchValue==false?Text('Merchant',style: GoogleFonts.urbanist(),):
                                    Text('User',style: GoogleFonts.urbanist(),),
                                    CupertinoSwitch(
                                      trackColor: Colors.green,
                                      thumbColor: Colors.white,
                                      activeColor: Colors.green,
                                      value: switchValue,
                                      onChanged: (value) {
                                        setState(() {
                                          switchValue = value;

                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 22.0, right: 18, top: 10),
                            child: Container(
                              width: scrWidth * 0.8,
                              height: scrWidth * 0.12,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: primarycolor)),
                              child: TextFormField(
                                controller: description,
                                cursorColor: Colors.black,
                                style: TextStyle(
                                  color: primarycolor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  fontFamily: 'urbanist',
                                ),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: 'Description',
                                  hintStyle: TextStyle(
                                    color: textFormUnFocusColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    fontFamily: 'Urbanist',
                                  ),
                                  fillColor: textFormFieldFillColor,
                                  filled: true,
                                  disabledBorder: InputBorder.none,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: primarycolor, width: 1.0),
                                      borderRadius: BorderRadius.circular(15)),
                                  errorBorder: InputBorder.none,
                                  border: InputBorder.none,

                                  focusedBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      color: primarycolor,
                                      width: 2,
                                    ),
                                  ),

                                  //
                                  // border: OutlineInputBorder(),
                                  // focusedBorder: OutlineInputBorder(
                                  //     borderSide: BorderSide(color: Color(0xff034a82),width: 2)
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
                Padding(
                    padding: EdgeInsets.only(bottom: scrWidth * 0.07, right: scrWidth * 0.07),
                    child:switchValue==false? InkWell(
                      onTap: () {
                        if (amount.text != '' &&
                            (selectedIcons != null || selectedIcons != '') &&
                            selectedDate != null &&
                            category != '') {
                          showDialog(
                              context: context,
                              builder: (buildcontext) {
                                return AlertDialog(
                                  title: const Text('Add Expense '),
                                  content: const Text('Do you want to Add?'),
                                  actions: [
                                    TextButton(
                                        onPressed: () async {
                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(currentuserid)
                                              .collection('expense')
                                              .add({
                                            'amount':
                                            double.tryParse(amount!.text.toString()),
                                            "categoryIcon": serializeIcon(xyz),
                                            "categoryName": category.toString(),
                                            'date': selectedDate,
                                            'income': false,
                                            'merchant': merchantName.toString(),
                                            'description':
                                            description.text.toString() ?? '',
                                          });
                                          await FirebaseFirestore.instance.collection('users').doc(currentuserid).update({
                                            'totalExpense':FieldValue.increment(double.tryParse(amount!.text.toString())??0),

                                          });

                                          Navigator.pop(context);

                                          showUploadMessage(
                                              context, 'Expense  added succesfully');

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ExpenseSuccesPage()));
                                          amount?.clear();
                                          category == '';

                                          selectedDate = null;
                                          xyz = '';
                                          _icon = null;
                                          merchantName = '';
                                          description.text = '';
                                          setState(() {});

                                          // Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => CharityCatogoryPage(),), (route) => false);
                                        },
                                        child: const Text('Yes')),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Cancel')),
                                  ],
                                );
                              });
                        } else {
                          amount.text == ''
                              ? showUploadMessage(context, 'Please enter amount')
                              : category == ''
                              ? showUploadMessage(context, 'Please choose Category')
                              : showUploadMessage(
                              context, 'Please enter merchant name');
                        }
                      },
                      child: Container(
                        width: scrWidth * 0.76,
                        height: scrHeight * 0.065,
                        decoration: BoxDecoration(
                            color: Color(0xff008036),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text(
                            " Add expense",
                            style: TextStyle(
                                fontSize: scrWidth * 0.046,
                                color: Colors.white,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ):InkWell(
                      onTap: () {
                        if (amount.text != '' &&
                            (selectedIcons != null || selectedIcons != '') &&
                            selectedDate != null &&
                            category != '' && contactName!=''&& phNumber!='') {
                          showDialog(
                              context: context,
                              builder: (buildcontext) {
                                return AlertDialog(
                                  title: const Text('Add Expense '),
                                  content: const Text('Do you want to Add?'),
                                  actions: [
                                    TextButton(
                                        onPressed: () async {
                                          if(click==false){
                                            click=true;

                                            await getUserData();
                                          FirebaseFirestore.instance.runTransaction((transaction) async {

                                            await  FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(currentuserid)
                                                .collection('expense')
                                                .add({
                                              'amount': double.tryParse(amount!.text.toString()),
                                              "categoryIcon": serializeIcon(xyz),
                                              "categoryName": category.toString(),
                                              'date': selectedDate,
                                              'merchant': merchantName.toString() ?? "",
                                              'description': description.text,
                                              'income': true,
                                              'paymentId':selectedUserId,


                                            });

                                            await FirebaseFirestore.instance.collection('users').doc(currentuserid).update({
                                              'totalExpense':FieldValue.increment(double.tryParse(amount!.text.toString())??0),

                                            });

                                            await FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(selectedUserId)
                                                .collection('incomes')
                                                .add({

                                              'amount': double.tryParse(amount!.text.toString()),
                                              "categoryIcon": serializeIcon(xyz),
                                              "categoryName": category.toString(),
                                              'date': selectedDate,
                                              'income': true,
                                              'merchant': merchantName.toString(),
                                              'description': description.text.toString() ?? '',
                                              'recieverId':currentuserid,
                                            });
                                            await FirebaseFirestore.instance.collection('users').doc(selectedUserId).update({
                                              'totalIncome':FieldValue.increment(double.tryParse(amount!.text.toString())??0),
                                            });

                                          }).then((value){
                                            Navigator.pop(context);

                                            showUploadMessage(
                                                context, 'expense  added successfully');

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ExpenseSuccesPage()));
                                            amount?.clear();
                                            description.text = '';
                                            category == '';
                                            selectedDate = null;
                                            xyz = '';
                                            _icon = null;
                                            merchantName = '';
                                            setState(() {});

                                          });
                                          }


                                          // Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => CharityCatogoryPage(),), (route) => false);
                                        },
                                        child: const Text('Yes')),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Cancel')),
                                  ],
                                );
                              });
                        } else {
                          amount.text == ''
                              ? showUploadMessage(context, 'Please enter amount')
                              : category == ''
                              ? showUploadMessage(context, 'Please choose Category')
                              : showUploadMessage(
                              context, 'Please enter merchant name');
                        }
                      },
                      child: Container(
                        width: scrWidth * 0.76,
                        height: scrHeight * 0.065,
                        decoration: BoxDecoration(
                            color: Color(0xff008036),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text(
                            " Add income",
                            style: TextStyle(
                                fontSize: scrWidth * 0.046,
                                color: Colors.white,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    )
                ),
              ],
            ),
          ),
        ),
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

        // floatingActionButton:
      ),
    );
    //   Scaffold(
    //   body: Center(
    //     child: Text("Expense"),
    //   ),
    // );
  }
}
