import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../kuri/createkuri.dart';
import '../../model/ChitModel.dart';
import '../../model/usermodel.dart';
import '../../utils/themes.dart';
import '../splash_screen.dart';
import 'drawSpinnerPage.dart';

class OptOutPage extends StatefulWidget {
  final ChitModel chit;
  final Map<String, UserModel> totalMembers;
  final List<String> membersListForDraw;
  const OptOutPage(
      {Key? key,
      required this.chit,
      required this.totalMembers,
      required this.membersListForDraw})
      : super(key: key);

  @override
  State<OptOutPage> createState() => _OptOutPageState();
}

class _OptOutPageState extends State<OptOutPage> {
  FocusNode dialogueAuctionAmountNode = FocusNode();
  FocusNode dialoguePayableAmountNode = FocusNode();
  FocusNode dialogueWinnerNode = FocusNode();
  FocusNode dialogueDividentNode = FocusNode();

  TextEditingController winner = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController payableAmount = TextEditingController();
  TextEditingController dividend = TextEditingController();

  List<String> members = [];
  static const _locale = 'HI';
  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get _currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale, decimalDigits: 2)
          .currencySymbol;
  @override
  void initState() {
    super.initState();
    print('hereeeeeee');
    members.addAll(widget.membersListForDraw);
    print(members);
  }

  @override
  Widget build(BuildContext context) {
    return
        //   user == null
        //     ? Container(
        //   width: scrWidth,
        //   height: scrHeight,
        //   color: Colors.white,
        //   child: Center(
        //     child: CircularProgressIndicator(),
        //   ),
        // )
        //     :
        Scaffold(
      body: Stack(
        children: [
          Container(
            width: scrWidth * 1,
            height: scrHeight * 0.36,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/icons/background.png"),
                    fit: BoxFit.fill)),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.only(
                  top: scrHeight * 0.09,
                  left: scrWidth * 0.06,
                  bottom: scrHeight * 0.008),
              child: SvgPicture.asset(
                "assets/icons/whitearrow.svg",
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: scrHeight * 0.135,
                      left: scrWidth * 0.08,
                    ),
                    child: Container(
                      width: scrWidth * 0.2,
                      height: scrHeight * 0.09,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                widget.chit.profile!),
                            fit: BoxFit.fill),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: scrWidth * 0.03,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: scrHeight * 0.14,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.chit.chitName!,
                          style: TextStyle(
                              fontSize: scrWidth * 0.045,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Urbanist'),
                        ),
                        SizedBox(
                          height: scrHeight * 0.005,
                        ),
                        Text(
                          'Opt-Out Page',
                          style: TextStyle(
                              fontSize: scrWidth * 0.045,
                              color: Color(0xffFFFFFF),
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Urbanist'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: scrHeight * 0.017,
              ),
              Container(
                height: scrHeight * 0.165,
                width: scrWidth * 0.88,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 25.0,
                          offset: Offset(0, 4)),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(17.5)),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: scrWidth * 0.05,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: scrHeight * 0.05,
                          ),
                          Text(
                            'Available Members For Next Draw,',
                            style: TextStyle(
                              fontSize: scrWidth * 0.049,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Urbanist',
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                '${members.length.toString()}/',
                                style: TextStyle(
                                  fontSize: scrWidth * 0.045,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Urbanist',
                                ),
                              ),
                              Text(
                                widget.membersListForDraw.length.toString(),
                                style: TextStyle(
                                    fontSize: scrWidth * 0.045,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Urbanist',
                                    color: primarycolor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: scrHeight * 0.02,
              ),
              SizedBox(
                height: scrHeight * 0.02,
              ),
              Padding(
                padding: EdgeInsets.only(right: scrWidth * 0.72),
                child: Text(
                  "All Members,",
                  style: TextStyle(
                      fontSize: scrWidth * 0.033,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Urbanist',
                      color: Color(0xff827C7C)),
                ),
              ),
              Expanded(
                  child: SizedBox(
                child: ListView.separated(
                  shrinkWrap: true,
                  // reverse: true,
                  padding: EdgeInsets.only(
                      left: scrWidth * 0.04,
                      right: scrWidth * 0.04,
                      top: scrHeight * 0.003),
                  physics: NeverScrollableScrollPhysics(),
                  // scrollDirection: Axis.vertical,
                  itemCount: widget.membersListForDraw.length,
                  itemBuilder: (BuildContext context, int index) {
                    var member = widget.membersListForDraw[index];
                    return Container(
                      width: scrWidth * 0.02,
                      height: scrHeight * 0.075,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xffF3F3F3)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: scrHeight * 0.012),
                                child: Container(
                                  width: scrWidth * 0.12,
                                  height: scrHeight * 0.05,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.black,
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(widget
                                            .totalMembers[member]!.userImage!),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                              SizedBox(width: scrHeight * 0.012),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: scrHeight * 0.013),
                                    child: Text(
                                      widget.totalMembers[member]!.userName!,
                                      style: TextStyle(
                                          fontFamily: 'Urbanist',
                                          fontWeight: FontWeight.w600,
                                          fontSize: scrWidth * 0.045),
                                    ),
                                  ),
                                  SizedBox(
                                    height: scrHeight * 0.004,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Switch(
                                value: members.contains(member),
                                onChanged: (bool value) {
                                  if (members.contains(member)) {
                                    members.remove(member);
                                  } else {
                                    members.add(member);
                                  }
                                  setState(() {});
                                },
                                activeColor: primarycolor,
                                activeTrackColor: Color(0xff02B558),
                              ),
                              SizedBox(width: scrHeight * 0.012),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      height: scrHeight * 0.01,
                      color: Colors.white,
                    );
                  },
                ),
              )),
            ],
          ),
        ],
      ),
      bottomNavigationBar: InkWell(
        onTap: () async {
          if (members.length > 1) {
            await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SpinnerPage(
                    chit: widget.chit,
                    totalMembers: widget.totalMembers,
                    membersListForDraw: members,
                  ),
                ));

            Navigator.pop(context);
          } else if (members.length == 1) {
            winner.text = widget.totalMembers[members[0]]!.userName!;
            amount.text = widget.chit.amount!.toString();
            payableAmount.text =
                (widget.chit.amount! - widget.chit.dividendAmount!).toString();
            dividend.text = widget.chit.dividendAmount!.toString();

            payChitAmount();
            setState(() {});
          } else {
            showSnackbar(context, 'Please choose at least one member');
          }
        },
        child: Container(
          height: scrHeight * 0.08,
          color: primarycolor,
          child: Center(
            child: Text('Draw',
                style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: scrWidth * 0.09,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
          ),
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
                          userId: widget.membersListForDraw[0],
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
