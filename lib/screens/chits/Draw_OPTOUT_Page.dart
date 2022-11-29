import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../model/ChitModel.dart';
import '../../model/usermodel.dart';
import '../../utils/themes.dart';
import '../splash_screen.dart';

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
    members.addAll(widget.membersListForDraw);
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
                          'Draw',
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
                                '${widget.membersListForDraw.length.toString()}',
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
                                        image: NetworkImage(widget
                                            .totalMembers[member.userId]!
                                            .userImage!),
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
                              Switch(
                                value: members.contains(member.userId),
                                onChanged: (bool value) {
                                  if (members.contains(member.userId)) {
                                    members.remove(member.userId);
                                  } else {
                                    members.add(member.userId!);
                                  }
                                  setState(() {});
                                },
                                activeColor: primarycolor,
                                activeTrackColor: primarycolor,
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
      bottomNavigationBar: Container(
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
    );
  }
}
