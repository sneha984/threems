import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_svg/svg.dart';

import '../../kuri/createkuri.dart';
import '../../model/ChitModel.dart';
import '../../model/usermodel.dart';
import '../../utils/themes.dart';
import '../splash_screen.dart';

class SpinnerPage extends StatefulWidget {
  final ChitModel chit;
  final Map<String, UserModel> totalMembers;
  final List<String> membersListForDraw;
  const SpinnerPage(
      {Key? key,
      required this.totalMembers,
      required this.membersListForDraw,
      required this.chit})
      : super(key: key);

  @override
  State<SpinnerPage> createState() => _SpinnerPageState();
}

class _SpinnerPageState extends State<SpinnerPage> {
  StreamController<int> selected = StreamController<int>();

  FocusNode dialogueAuctionAmountNode = FocusNode();
  FocusNode dialoguePayableAmountNode = FocusNode();
  FocusNode dialogueWinnerNode = FocusNode();
  FocusNode dialogueDividentNode = FocusNode();

  TextEditingController winner = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController payableAmount = TextEditingController();
  TextEditingController dividend = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  int selectedIndex = 0;
  bool drawn = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 84,
        shadowColor: Colors.grey,
        centerTitle: false,
        elevation: 0.1,
        backgroundColor: primarycolor,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.only(
                top: scrHeight * 0.04,
                left: scrWidth * 0.07,
                bottom: scrHeight * 0.02,
                right: scrWidth * 0.05),
            child: SvgPicture.asset(
              "assets/icons/arrow.svg",
            ),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: scrHeight * 0.02),
          child: Text(
            "Draw Winner",
            style: TextStyle(
                fontSize: scrWidth * 0.045,
                color: Colors.black,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
      body: GestureDetector(
        child: Column(
          children: [
            Expanded(
              child: FortuneWheel(
                selected: selected.stream,
                animateFirst: false,
                onAnimationEnd: () {
                  // selected.stream.listen((index) {

                  print(widget.membersListForDraw[selectedIndex]);
                  print('test');
                  // print(selected.)
                  setState(() {
                    print('finished');

                    winner.text = widget
                        .totalMembers[widget.membersListForDraw[selectedIndex]]!
                        .userName!;
                    amount.text = widget.chit.amount!.toString();
                    payableAmount.text =
                        (widget.chit.amount! - widget.chit.dividendAmount!)
                            .toString();
                    dividend.text = widget.chit.dividendAmount!.toString();

                    payChitAmount();
                  });
                  // });
                },
                items: [
                  for (var it in widget.membersListForDraw)
                    FortuneItem(
                        child: Text(widget.totalMembers[it]!.userName!)),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                drawn = true;
                selectedIndex =
                    Fortune.randomInt(0, widget.membersListForDraw.length);
                selected.add(selectedIndex);
                setState(() {});
              },
              child: Container(
                height: scrHeight * 0.05,
                width: scrWidth * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: primarycolor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Spin Now",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: CreateChitFont,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: scrHeight * 0.2,
            )
          ],
        ),
      ),
    );
  }

  void payChitAmount() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, setState) {
          dialogueAuctionAmountNode.addListener(() {
            setState(() {});
          });
          dialogueWinnerNode.addListener(() {
            setState(() {});
          });
          dialoguePayableAmountNode.addListener(() {
            setState(() {});
          });
          dialogueDividentNode.addListener(() {
            setState(() {});
          });
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Add Winner'),
            titleTextStyle: TextStyle(
                fontSize: FontSize10,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w600,
                color: Color(0xff827C7C)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: scrWidth,
                  height: textFormFieldHeight45,
                  padding: EdgeInsets.symmetric(
                    horizontal: scrWidth * 0.015,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: textFormFieldFillColor,
                    borderRadius: BorderRadius.circular(scrWidth * 0.026),
                  ),
                  child: TextFormField(
                    readOnly: true,
                    keyboardType: TextInputType.number,
                    controller: winner,
                    focusNode: dialogueWinnerNode,
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
                      labelText: 'Winner Name',
                      labelStyle: TextStyle(
                        color: dialogueWinnerNode.hasFocus
                            ? primarycolor
                            : textFormUnFocusColor,
                        fontWeight: FontWeight.w600,
                        fontSize: FontSize15,
                        fontFamily: 'Urbanist',
                      ),
                      // prefixIcon: Container(
                      //   height: scrWidth * 0.045,
                      //   width: 10,
                      //   padding: EdgeInsets.all(
                      //       scrWidth * 0.033),
                      //   child: SvgPicture.asset(
                      //     'assets/icons/subscription.svg',
                      //     fit: BoxFit.contain,
                      //     color: textFormUnFocusColor,
                      //   ),
                      // ),
                      fillColor: textFormFieldFillColor,
                      filled: true,
                      contentPadding: EdgeInsets.only(
                          top: 5,
                          bottom: scrWidth * 0.033,
                          left: scrWidth * 0.033),
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
                SizedBox(
                  height: scrWidth * 0.05,
                ),
                Container(
                  width: scrWidth,
                  height: textFormFieldHeight45,
                  padding: EdgeInsets.symmetric(
                    horizontal: scrWidth * 0.015,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: textFormFieldFillColor,
                    borderRadius: BorderRadius.circular(scrWidth * 0.026),
                  ),
                  child: TextFormField(
                    controller: amount,
                    readOnly: true,
                    keyboardType: TextInputType.number,
                    focusNode: dialogueAuctionAmountNode,
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
                      labelText: 'Chit Amount',
                      labelStyle: TextStyle(
                        color: dialogueAuctionAmountNode.hasFocus
                            ? primarycolor
                            : textFormUnFocusColor,
                        fontWeight: FontWeight.w600,
                        fontSize: FontSize15,
                        fontFamily: 'Urbanist',
                      ),
                      // prefixIcon: Container(
                      //   height: scrWidth * 0.045,
                      //   width: 10,
                      //   padding: EdgeInsets.all(
                      //       scrWidth * 0.033),
                      //   child: SvgPicture.asset(
                      //     'assets/icons/subscription.svg',
                      //     fit: BoxFit.contain,
                      //     color: textFormUnFocusColor,
                      //   ),
                      // ),
                      fillColor: textFormFieldFillColor,
                      filled: true,
                      contentPadding: EdgeInsets.only(
                          top: 5,
                          bottom: scrWidth * 0.033,
                          left: scrWidth * 0.033),
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
                SizedBox(
                  height: scrWidth * 0.03,
                ),
                Container(
                  width: scrWidth,
                  height: textFormFieldHeight45,
                  padding: EdgeInsets.symmetric(
                    horizontal: scrWidth * 0.015,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: textFormFieldFillColor,
                    borderRadius: BorderRadius.circular(scrWidth * 0.026),
                  ),
                  child: TextFormField(
                    focusNode: dialoguePayableAmountNode,
                    readOnly: true,
                    controller: payableAmount,
                    keyboardType: TextInputType.number,
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
                      labelText: 'Payable Amount',
                      labelStyle: TextStyle(
                        color: dialoguePayableAmountNode.hasFocus
                            ? primarycolor
                            : textFormUnFocusColor,
                        fontWeight: FontWeight.w600,
                        fontSize: FontSize15,
                        fontFamily: 'Urbanist',
                      ),
                      // prefixIcon: Container(
                      //   height: scrWidth * 0.045,
                      //   width: 10,
                      //   padding: EdgeInsets.all(
                      //       scrWidth * 0.033),
                      //   child: SvgPicture.asset(
                      //     'assets/icons/subscription.svg',
                      //     fit: BoxFit.contain,
                      //     color: textFormUnFocusColor,
                      //   ),
                      // ),
                      fillColor: textFormFieldFillColor,
                      filled: true,
                      contentPadding: EdgeInsets.only(
                          top: 5,
                          bottom: scrWidth * 0.033,
                          left: scrWidth * 0.033),
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
                SizedBox(
                  height: scrWidth * 0.03,
                ),
                Container(
                  width: scrWidth,
                  height: textFormFieldHeight45,
                  padding: EdgeInsets.symmetric(
                    horizontal: scrWidth * 0.015,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: textFormFieldFillColor,
                    borderRadius: BorderRadius.circular(scrWidth * 0.026),
                  ),
                  child: TextFormField(
                    controller: dividend,
                    readOnly: true,
                    keyboardType: TextInputType.number,
                    focusNode: dialogueDividentNode,
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
                      labelText: 'Dividend Amount',
                      labelStyle: TextStyle(
                        color: dialogueDividentNode.hasFocus
                            ? primarycolor
                            : textFormUnFocusColor,
                        fontWeight: FontWeight.w600,
                        fontSize: FontSize15,
                        fontFamily: 'Urbanist',
                      ),
                      // prefixIcon: Container(
                      //   height: scrWidth * 0.045,
                      //   width: 10,
                      //   padding: EdgeInsets.all(
                      //       scrWidth * 0.033),
                      //   child: SvgPicture.asset(
                      //     'assets/icons/subscription.svg',
                      //     fit: BoxFit.contain,
                      //     color: textFormUnFocusColor,
                      //   ),
                      // ),
                      fillColor: textFormFieldFillColor,
                      filled: true,
                      contentPadding: EdgeInsets.only(
                          top: 5,
                          bottom: scrWidth * 0.033,
                          left: scrWidth * 0.033),
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
                SizedBox(
                  height: scrWidth * 0.06,
                ),
                InkWell(
                  onTap: () {
                    double pay = widget.chit.subscriptionAmount! -
                        (double.tryParse(dividend.text)! /
                            widget.chit.membersCount!);
                    print('hehe');
                    print(pay);
                    if (amount.text != '' &&
                        payableAmount.text != '' &&
                        dividend.text != '') {
                      final winnerMember = Winners(
                          amount: double.tryParse(payableAmount.text),
                          userId: widget.membersListForDraw[selectedIndex],
                          date: DateTime.now());
                      var map = winnerMember.toJson();
                      print(map);
                      FirebaseFirestore.instance
                          .collection('chit')
                          .doc(widget.chit.chitId)
                          .update({
                        'winners': FieldValue.arrayUnion([map]),
                        'payableAmount': widget.chit.subscriptionAmount! -
                            (double.tryParse(dividend.text)! /
                                widget.chit.membersCount!)
                      }).then((value) {
                        amount.text = '';
                        payableAmount.text = '';
                        dividend.text = '';
                        Navigator.pop(context);
                      });
                    } else {
                      amount.text == ''
                          ? showSnackbar(context, 'Please enter Amount')
                          : payableAmount.text == ''
                              ? showSnackbar(
                                  context, 'Please enter Payable Amount')
                              : showSnackbar(context, 'Please enter Dividend');
                    }
                  },
                  child: Container(
                    width: scrWidth,
                    height: textFormFieldHeight45,
                    decoration: BoxDecoration(
                        color: primarycolor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(
                        "Save",
                        style: TextStyle(
                            fontSize: FontSize16,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
