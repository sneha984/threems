import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../Authentication/root.dart';
import '../model/Kuri/kuriModel.dart';
import '../screens/splash_screen.dart';
import '../utils/themes.dart';
import 'addedkuriprivate.dart';
import 'addedkuripublic.dart';

class KuriViewPage extends StatefulWidget {
  final KuriModel kuri;
  const KuriViewPage({Key? key, required this.kuri}) : super(key: key);

  @override
  State<KuriViewPage> createState() => _KuriViewPageState();
}

class _KuriViewPageState extends State<KuriViewPage> {
  static const _locale = 'HI';
  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get _currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale, decimalDigits: 2)
          .currencySymbol;

  Duration? remainingTime;
  int count = 1;
  getTime() async {
    DateTime deadLine = widget.kuri.deadLine!;
    for (int i = count; i > 0; i--) {
      await Future.delayed(const Duration(seconds: 1));
      remainingTime = deadLine.difference(DateTime.now());
      // DateTime.now().difference(launch);

    }

    print(mounted);

    if (mounted) {
      setState(() {});
    }
    getTime();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTime();
  }

  @override
  Widget build(BuildContext context) {
    final DateTime deadLine = widget.kuri.deadLine!;
    final DateFormat formatter = DateFormat('dd MMMM yyyy');
    final String formatted = formatter.format(deadLine);
    final double percentage = widget.kuri.totalReceived! / widget.kuri.amount!;
    return Padding(
      padding: EdgeInsets.only(top: scrHeight * 0.01),
      child: GestureDetector(
        onTap: () {
          // ? Navigator.push(
          // context,
          // MaterialPageRoute(
          //     builder: (context) =>
          //         AddedKuriPublic()))
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddedKuriPublic(
                        kuri: widget.kuri,
                      )));
        },
        child: Container(
          height: scrHeight * 0.25,
          width: scrWidth * 0.95,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                offset: const Offset(
                  2.0,
                  2.0,
                ),
                blurRadius: 20.0,
                spreadRadius: 1.0,
              ), //BoxShadow
            ],
          ),
          child: Column(
            children: [
              SizedBox(
                height: scrHeight * 0.01,
              ),
              Row(
                children: [
                  SizedBox(
                    width: scrWidth * 0.04,
                  ),
                  Container(
                    height: scrHeight * 0.065,
                    width: scrWidth * 0.15,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0wRDAivyQVAx54eks-rILb0NY6HcuSKkPEw&usqp=CAU"),
                            fit: BoxFit.fill)),
                  ),
                  SizedBox(
                    width: scrWidth * 0.024,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: scrHeight * 0.015,
                      ),
                      Text(
                        "Name",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color(0xff989898),
                            fontSize: scrWidth * 0.03,
                            fontFamily: 'Urbanist'),
                      ),
                      SizedBox(
                        height: scrHeight * 0.004,
                      ),
                      Text(widget.kuri.kuriName!,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xff000000),
                              fontSize: scrWidth * 0.04,
                              fontFamily: 'Urbanist')),
                      SizedBox(
                        height: scrHeight * 0.006,
                      ),
                      Row(
                        children: [
                          Container(
                            child: Center(
                                child: Text(
                              remainingTime == null
                                  ? "..."
                                  : "${remainingTime?.inDays} Days Left"
                                      .toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: scrWidth * 0.025,
                                  fontFamily: 'Urbanist'),
                            )),
                            // Text("20 Days Left",
                            //     style: TextStyle(
                            //         fontWeight: FontWeight.w600,
                            //         color: Colors.white,
                            //         fontSize: scrWidth * 0.025,
                            //         fontFamily: 'Urbanist'))),
                            height: scrHeight * 0.023,
                            width: scrWidth * 0.22,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius:
                                    BorderRadius.circular(scrWidth * 0.04)),
                          ),
                          SizedBox(
                            width: scrWidth * 0.13,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset("assets/icons/timeiconsvg.svg"),
                              SizedBox(
                                width: scrWidth * 0.02,
                              ),
                              Text(
                                formatted,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xffA4A4A4),
                                    fontSize: scrWidth * 0.033,
                                    fontFamily: 'Urbanist'),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: scrHeight * 0.025,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: scrWidth * 0.02),
                child: LinearPercentIndicator(
                  //leaner progress bar
                  animation: true,
                  animationDuration: 1000,
                  lineHeight: scrHeight * 0.025,
                  width: scrWidth * 0.86,
                  percent: percentage,
                  alignment: MainAxisAlignment.start,
                  barRadius: Radius.circular(scrWidth * 0.2),
                  progressColor: primarycolor,
                  backgroundColor: Color(0xffD9D9D9),
                ),
              ),
              SizedBox(
                height: scrHeight * 0.015,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Collected",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xff989898),
                            fontSize: scrWidth * 0.026,
                            fontFamily: 'Urbanist'),
                      ),
                      SizedBox(
                        height: scrHeight * 0.002,
                      ),
                      Text(
                        '$_currency ${_formatNumber(
                          widget.kuri.totalReceived!
                              .truncate()
                              .toString()
                              .replaceAll(',', ''),
                        )}',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: primarycolor,
                            fontSize: scrWidth * 0.026,
                            fontFamily: 'Urbanist'),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: scrWidth * 0.35,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Value",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xff989898),
                            fontSize: scrWidth * 0.026,
                            fontFamily: 'Urbanist'),
                      ),
                      SizedBox(
                        height: scrHeight * 0.002,
                      ),
                      Text(
                        '$_currency ${_formatNumber(
                          widget.kuri.amount!
                              .truncate()
                              .toString()
                              .replaceAll(',', ''),
                        )}',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: primarycolor,
                            fontSize: scrWidth * 0.026,
                            fontFamily: 'Urbanist'),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: scrHeight * 0.012,
              ),
              widget.kuri.userID == currentuserid
                  ? SizedBox()
                  : Container(
                      height: scrHeight * 0.036,
                      width: scrWidth * 0.83,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: primarycolor,
                      ),
                      child: Center(
                          child: Text(
                        "Pay Now",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color(0xffFFFFFF),
                            fontSize: 14,
                            fontFamily: 'Urbanist'),
                      )),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
