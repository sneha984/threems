import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../model/ChitModel.dart';
import '../../model/usermodel.dart';
import '../../utils/themes.dart';
import '../splash_screen.dart';

class ShortListWinners extends StatefulWidget {
  final ChitModel chit;
  final Map<String, UserModel> totalMembers;
  const ShortListWinners(
      {Key? key, required this.chit, required this.totalMembers})
      : super(key: key);

  @override
  State<ShortListWinners> createState() => _ShortListWinnersState();
}

class _ShortListWinnersState extends State<ShortListWinners> {
  static const _locale = 'HI';
  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get _currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale, decimalDigits: 2)
          .currencySymbol;

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
                            image: NetworkImage(widget.chit.profile!),
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
                          'Winners List.',
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
                            "Last Time Winner",
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
                            widget
                                    .totalMembers[widget
                                        .chit
                                        .winners![
                                            widget.chit.winners!.length - 1]
                                        .userId!]!
                                    .userName! ??
                                '',
                            style: TextStyle(
                              fontSize: scrWidth * 0.049,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Urbanist',
                            ),
                          ),
                          Text(
                            DateFormat('MMMM yyyy').format(widget
                                .chit
                                .winners![widget.chit.winners!.length - 1]
                                .date!),
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
              SizedBox(
                height: scrHeight * 0.02,
              ),
              Padding(
                padding: EdgeInsets.only(right: scrWidth * 0.72),
                child: Text(
                  "All Winners,",
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
                  itemCount: widget.chit.winners!.length,
                  itemBuilder: (BuildContext context, int index) {
                    var member = widget.chit.winners![index];
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
                              Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: scrHeight * 0.012),
                                    child: Container(
                                      width: scrWidth * 0.12,
                                      height: scrHeight * 0.05,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Colors.black,
                                        image: DecorationImage(
                                            image: NetworkImage(widget
                                                .totalMembers[member.userId]!
                                                .userImage!),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: -1,
                                    left: 35,
                                    top: 22,
                                    child: SvgPicture.asset(
                                      "assets/icons/profilewinner.svg",
                                    ),
                                  ),
                                ],
                              ),
                              //     : Padding(
                              //   padding: EdgeInsets.only(
                              //       left: scrHeight *
                              //           0.012),
                              //   child:
                              //   Container(
                              //     width:
                              //     scrWidth *
                              //         0.12,
                              //     height:
                              //     scrHeight *
                              //         0.05,
                              //     decoration:
                              //     BoxDecoration(
                              //       borderRadius:
                              //       BorderRadius.circular(
                              //           16),
                              //       color: Colors
                              //           .black,
                              //       image: DecorationImage(
                              //           image: NetworkImage(members[index]
                              //               .userImage!),
                              //           fit: BoxFit
                              //               .cover),
                              //     ),
                              //   ),
                              // ),
                              SizedBox(width: scrHeight * 0.012),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: scrHeight * 0.013),
                                    child: Text(
                                      widget.totalMembers[member.userId]!
                                          .userName!,
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
                              Column(
                                children: [
                                  SizedBox(
                                    height: scrHeight * 0.02,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: scrWidth * 0.05),
                                    child: Text(
                                      '$_currency ${_formatNumber(member.amount!.truncate().toString().replaceAll(',', ''))}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'Urbanist',
                                          fontWeight: FontWeight.w600,
                                          fontSize: scrWidth * 0.034,
                                          color: primarycolor),
                                    ),
                                  ),
                                  Text(
                                    DateFormat('MMMM yyyy')
                                        .format(member.date!),
                                    style: TextStyle(
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.w600,
                                        fontSize: scrWidth * 0.022,
                                        color: Colors.black),
                                  ),
                                ],
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
    );
  }
}
