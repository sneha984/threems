import 'dart:typed_data';
import 'package:flutter_iconpicker/Serialization/iconDataSerialization.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:threems/Authentication/root.dart';
import 'package:threems/kuri/createkuri.dart';
import 'package:threems/model/usermodel.dart';

import 'package:url_launcher/url_launcher.dart';

import '../model/ChitModel.dart';
import '../screens/splash_screen.dart';
import '../utils/themes.dart';

class ApprovePage extends StatefulWidget {
  final String id;
  final ChitModel chit;
  const ApprovePage({Key? key, required this.id, required this.chit})
      : super(key: key);

  @override
  State<ApprovePage> createState() => _ApprovePageState();
}

class _ApprovePageState extends State<ApprovePage> {
  static const _locale = 'HI';
  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get _currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale, decimalDigits: 2)
          .currencySymbol;

  UserModel? user;
  List<Payments> paymentList = [];
  Payments? activePayment;
  Winners? winningMonth;

  getWinningMonth() {
    List<Winners> listOfWinners = widget.chit.winners!;
    for (var item in listOfWinners) {
      if (item.userId == widget.id) {
        winningMonth = item;
      }
    }
    setState(() {});
  }

  getActivePayment() {
    ChitModel chit = widget.chit;
    for (var payment in paymentList) {
      if (chit.chitType == 'Monthly') {
        if (DateTime(
                DateTime.now().year,
                DateTime.now().month,
                chit.chitDate!,
                int.parse(chit.chitTime!.split(':')[0]),
                int.parse(chit.chitTime!.split(':')[1]))
            .isAfter(DateTime.now())) {
          if (payment.datePaid!.isAfter(DateTime(
                  DateTime.now().year,
                  DateTime.now().month - 1,
                  chit.chitDate!,
                  int.parse(chit.chitTime!.split(':')[0]),
                  int.parse(chit.chitTime!.split(':')[1]))) &&
              payment.datePaid!.isBefore(DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  chit.chitDate!,
                  int.parse(chit.chitTime!.split(':')[0]),
                  int.parse(chit.chitTime!.split(':')[1])))) {
            activePayment = payment;
          }
        } else {
          if (payment.datePaid!.isAfter(DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  chit.chitDate!,
                  int.parse(chit.chitTime!.split(':')[0]),
                  int.parse(chit.chitTime!.split(':')[1]))) &&
              payment.datePaid!.isBefore(DateTime(
                  DateTime.now().year,
                  DateTime.now().month + 1,
                  chit.chitDate!,
                  int.parse(chit.chitTime!.split(':')[0]),
                  int.parse(chit.chitTime!.split(':')[1])))) {
            activePayment = payment;
          }
        }
      } else {
        if (DateTime.now().weekday < chit.chitDate!) {
          if (payment.datePaid!.isBefore(DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  (DateTime.now().day +
                      (chit.chitDate! - DateTime.now().weekday)))) &&
              payment.datePaid!.isAfter(DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  (DateTime.now().day +
                          (7 - DateTime.now().weekday) +
                          chit.chitDate!) -
                      7))) {
            activePayment = payment;
          }
        } else {
          if (payment.datePaid!.isAfter(DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  (DateTime.now().day +
                          chit.chitDate! -
                          DateTime.now().weekday) -
                      7)) &&
              payment.datePaid!.isBefore(DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  (DateTime.now().day +
                      chit.chitDate! -
                      DateTime.now().weekday)))) {
            activePayment = payment;
          }
        }
      }
    }

    setState(() {
      getWinningMonth();
      print('hehe');
      if (activePayment != null) {
        print(activePayment!.datePaid!);
        print(activePayment!.amount!);
        print(activePayment!.verified!);
      }
    });
  }

  Icon? _icon;
  var icons;
  var categoryName;
  getIconData() {
    FirebaseFirestore.instance
        .collection('income')
        .where('categoryName', isEqualTo: 'Chit')
        .snapshots()
        .listen((event) {
      for (DocumentSnapshot data in event.docs) {
        icons = deserializeIcon(data['icon']);
        categoryName = data['categoryName'];
        // _icon = Icon(icons,color: Colors.white,size: 45,);

      }
    });
  }

  getPayments() {
    print('here');
    print(widget.id);
    FirebaseFirestore.instance
        .collection('chit')
        .doc(widget.chit.chitId)
        .collection('payments')
        .where('userId', isEqualTo: widget.id)
        .orderBy('datePaid', descending: false)
        .snapshots()
        .listen((event) {
      paymentList = [];
      for (DocumentSnapshot<Map<String, dynamic>> doc in event.docs) {
        paymentList.add(Payments.fromJson(doc.data()!));
      }

      if (mounted) {
        setState(() {
          print('[[[[[[[[[[[[[[[[[hello]]]]]]]]]]]]]]]]');
          print(paymentList.length);
          getActivePayment();
        });
      }
    });
  }

  getUser() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.id)
        .snapshots()
        .listen((event) {
      user = UserModel.fromJson(event.data()!);

      if (mounted) {
        setState(() {});
      }
    });
  }

  List<String> months = ["April", "March", "February", "January"];

  @override
  void initState() {
    super.initState();
    getPayments();
    getUser();
    getIconData();
  }

  @override
  Widget build(BuildContext context) {
    return user == null
        ? Container(
            width: scrWidth,
            height: scrHeight,
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
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
                                  image: NetworkImage(user!.userImage!),
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
                                user!.userName!,
                                style: TextStyle(
                                    fontSize: scrWidth * 0.045,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Urbanist'),
                              ),
                              SizedBox(
                                height: scrHeight * 0.005,
                              ),
                              Text(
                                widget.chit.chitName!,
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
                                  "Winning month",
                                  style: TextStyle(
                                      fontSize: scrWidth * 0.033,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Urbanist',
                                      color: Color(0xff827C7C)),
                                ),
                                SizedBox(
                                  height: scrHeight * 0.004,
                                ),
                                Text(
                                  winningMonth == null
                                      ? "Not yet updated"
                                      : DateFormat('MMMM')
                                          .format(winningMonth!.date!),
                                  style: TextStyle(
                                    fontSize: scrWidth * 0.045,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Urbanist',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: scrWidth * 0.3,
                          ),
                          SvgPicture.asset(
                            "assets/icons/winnerf.svg",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: scrHeight * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Last Month Statics",
                          style: TextStyle(
                              fontSize: scrWidth * 0.033,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Urbanist',
                              color: Color(0xff827C7C)),
                        ),
                        SizedBox(
                          width: scrWidth * 0.02,
                        ),
                        Text(
                          DateFormat('MMMM').format(DateTime.now()),
                          style: TextStyle(
                              fontSize: scrWidth * 0.033,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Urbanist',
                              color: Color(0xff827C7C)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: scrHeight * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: scrWidth * 0.023,
                        ),
                        Text(
                          activePayment == null
                              ? '$_currency ${_formatNumber(widget.chit.subscriptionAmount!.truncate().toString().replaceAll(',', ''))}'
                              : '$_currency ${_formatNumber(activePayment!.amount!.truncate().toString().replaceAll(',', ''))}',
                          style: TextStyle(
                              fontSize: scrWidth * 0.045,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Urbanist',
                              color: Color(0xff008036)),
                        ),
                        // SizedBox(width: scrWidth*0.02,),

                        Container(
                          height: scrHeight * 0.029,
                          width: scrWidth * 0.27,
                          decoration: BoxDecoration(
                              color: activePayment != null
                                  ? activePayment!.verified!
                                      ? Color(0xff02B558)
                                      : Color(0xff8391A1)
                                  : Color(0xffF61C0D),
                              borderRadius: BorderRadius.circular(3)),
                          child: Center(
                            child: Text(
                              activePayment == null
                                  ? 'Due'
                                  : activePayment!.verified!
                                      ? 'Paid'
                                      : "Pending",
                              style: TextStyle(
                                  fontSize: scrWidth * 0.036,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Urbanist',
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            if (activePayment == null) {
                              showSnackbar(
                                  context, 'There is nothing to view.');
                            } else {
                              GallerySaver.saveImage(activePayment!.url!,
                                      toDcim: true,
                                      albumName:
                                          '${widget.chit.chitName!}-${user!.userName!}-${DateFormat('dd-MM-yyyy').format(activePayment!.datePaid ?? DateTime.now())}')
                                  .then((success) {
                                Navigator.pop(context);
                                showSnackbar(context,
                                    'Download completed. Check your gallery');
                              });

                              // Uint8List response = await http
                              //     .get(Uri.parse(activePayment!.url!))
                              //     .then((value) => value.bodyBytes);

                              // await launchUrl(Uri.parse(activePayment!.url!))
                              //     .then((value) {
                              //   showSnackbar(
                              //       context, 'Successfully downloaded');
                              // });
                            }
                          },
                          child: Container(
                            height: scrHeight * 0.029,
                            width: scrWidth * 0.32,
                            decoration: BoxDecoration(
                                color: activePayment == null
                                    ? Color(0xff827C7C)
                                    : Color(0xff02B558),
                                borderRadius: BorderRadius.circular(3)),
                            child: Center(
                              child: Text(
                                "View Screenshot",
                                style: TextStyle(
                                    fontSize: scrWidth * 0.036,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Urbanist',
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: scrWidth * 0.02,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: scrHeight * 0.022,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: scrWidth * 0.72),
                      child: Text(
                        "Statics",
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
                        padding: EdgeInsets.only(
                            left: scrWidth * 0.068,
                            right: scrWidth * 0.068,
                            top: scrHeight * 0.013),
                        itemCount: paymentList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return paymentList.length == 0
                              ? Center(
                                  child: Text('There is no payments yet.'),
                                )
                              : Container(
                                  height: scrHeight * 0.052,
                                  width: scrWidth * 0.2,
                                  decoration: BoxDecoration(
                                      color: Color(0xffF3F3F3),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        DateFormat('MMMM').format(
                                            paymentList[index].datePaid!),
                                        style: TextStyle(
                                            fontSize: scrWidth * 0.045,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Urbanist',
                                            color: Color(0xff000000)),
                                      ),
                                      SizedBox(
                                        width: scrWidth * 0.3,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '$_currency ${_formatNumber(paymentList[index].amount!.truncate().toString().replaceAll(',', ''))}',
                                            style: TextStyle(
                                                fontSize: scrWidth * 0.036,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Urbanist',
                                                color: Color(0xff969696)),
                                          ),
                                          SizedBox(
                                            width: scrWidth * 0.01,
                                          ),
                                          Container(
                                            height: scrHeight * 0.02,
                                            width: activePayment!.verified!
                                                ? scrWidth * 0.1
                                                : scrWidth * 0.15,
                                            decoration: BoxDecoration(
                                                color: activePayment!.verified!
                                                    ? Color(0xff02B558)
                                                    : Color(0xff8391A1),
                                                borderRadius:
                                                    BorderRadius.circular(3)),
                                            child: Center(
                                              child: Text(
                                                paymentList[index].verified!
                                                    ? "Paid"
                                                    : "Pending",
                                                style: TextStyle(
                                                    fontSize: scrWidth * 0.026,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'Urbanist',
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
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
            bottomNavigationBar: Container(
              height: scrHeight * 0.08,
              color: primarycolor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: scrHeight * 0.02,
                      ),
                      Text(
                        "Last Month Chit Amount",
                        style: TextStyle(
                            fontSize: scrWidth * 0.026,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Urbanist',
                            color: Color(0xffFBED5D)),
                      ),
                      SizedBox(
                        height: scrHeight * 0.002,
                      ),
                      Text(
                        _formatNumber(widget.chit.subscriptionAmount!
                            .truncate()
                            .toString()
                            .replaceAll(',', '')),
                        style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: scrWidth * 0.044,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      )
                    ],
                  ),
                  SizedBox(
                    width: scrWidth * 0.04,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (activePayment != null &&
                          activePayment!.verified != true) {
                        FirebaseFirestore.instance
                            .collection('chit')
                            .doc(widget.chit.chitId)
                            .collection('payments')
                            .doc(activePayment!.paymentId!)
                            .update({'verified': true}).then((value) {
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(currentuserid)
                              .collection('incomes')
                              .add({
                            'amount': double.tryParse(
                                activePayment!.amount!.toString()),
                            "categoryIcon": serializeIcon(icons),
                            "IncomeCategoryName": categoryName.toString(),
                            'date': DateTime.now(),
                            'merchant': '',
                          });

                          showSnackbar(
                              context, 'Payment verified successfully');
                          Navigator.pop(context);
                        });
                      } else {
                        activePayment == null
                            ? showSnackbar(context,
                                '${user!.userName} is not paid this time')
                            : showSnackbar(
                                context, 'This Payment is already verified');
                      }

                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => Hostedchitperspage()));
                    },
                    child: Container(
                      height: scrHeight * 0.045,
                      width: scrWidth * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: Center(
                          child: Text(
                        "Approve",
                        style: TextStyle(
                            fontSize: scrWidth * 0.047,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Urbanist'),
                      )),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
