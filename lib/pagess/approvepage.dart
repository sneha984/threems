import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:threems/screens/chits/hostedchitpers.dart';

import '../screens/splash_screen.dart';
import '../utils/themes.dart';

class ApprovePage extends StatefulWidget {
  const ApprovePage({Key? key}) : super(key: key);

  @override
  State<ApprovePage> createState() => _ApprovePageState();
}

class _ApprovePageState extends State<ApprovePage> {
  List<String> months=[
    "April",
    "March",
    "February",
    "January"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Padding(padding: EdgeInsets.only(
                    top: scrHeight * 0.135,
                    left: scrWidth * 0.08,
                     ),
                    child: Container(
                      width: scrWidth*0.2,
                      height: scrHeight*0.09,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: scrWidth*0.03,),
                  Padding(
                    padding:  EdgeInsets.only(top: scrHeight * 0.14, ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("akhilgeorge",style: TextStyle(
                          fontSize: scrWidth*0.045,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Urbanist'
                        ),),
                        SizedBox(height: scrHeight*0.005,),
                        Text("First Logic Chit",style: TextStyle(
                            fontSize: scrWidth*0.045,
                            color: Color(0xffFFFFFF),
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Urbanist'
                        ),),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: scrHeight*0.017,),
              Container(
                height: scrHeight*0.165,
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
                      padding:  EdgeInsets.only( left: scrWidth * 0.05,),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: scrHeight*0.05,),
                          Text("Winning month",style: TextStyle(
                              fontSize: scrWidth*0.033,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Urbanist',
                            color: Color(0xff827C7C)
                          ),),
                          SizedBox(height: scrHeight*0.004,),
                          Text("Not yet updated",style: TextStyle(
                              fontSize: scrWidth*0.045,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Urbanist',

                          ),),
                        ],
                      ),
                    ),
                    SizedBox(width: scrWidth*0.3,),


                    SvgPicture.asset(
                      "assets/icons/winnerf.svg",
                    ),
                  ],
                ),
              ),
              SizedBox(height: scrHeight*0.02,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Last Month Statics",style: TextStyle(
                      fontSize: scrWidth*0.033,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Urbanist',
                      color: Color(0xff827C7C)
                  ),),
                  SizedBox(width: scrWidth*0.02,),
                  Text("September",style: TextStyle(
                      fontSize: scrWidth*0.033,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Urbanist',
                      color: Color(0xff827C7C)
                  ),),
                ],
              ),
              SizedBox(height: scrHeight*0.02,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                   SizedBox(width: scrWidth*0.023,),
                  Text("₹5.000",style: TextStyle(
                      fontSize: scrWidth*0.045,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Urbanist',
                      color: Color(0xff008036)
                  ),),
                  // SizedBox(width: scrWidth*0.02,),

                  Container(
                    height: scrHeight*0.029,
                    width: scrWidth*0.27,
                    decoration: BoxDecoration(
                      color: Color(0xff8391A1),
                      borderRadius: BorderRadius.circular(3)

                    ),
                    child: Center(
                      child: Text("Pending",style: TextStyle(
                          fontSize:scrWidth*0.036,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Urbanist',
                          color: Colors.white
                      ),),
                    ),
                  ),
                  Container(
                    height: scrHeight*0.029,
                    width: scrWidth*0.32,
                    decoration: BoxDecoration(
                        color: Color(0xff02B558),
                        borderRadius: BorderRadius.circular(3)
                    ),
                    child: Center(
                      child: Text("View Screenshot",style: TextStyle(
                          fontSize: scrWidth*0.036,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Urbanist',
                          color: Colors.white
                      ),),
                    ),

                  ),
                  SizedBox(width: scrWidth*0.02,),
                ],),
              SizedBox(height: scrHeight*0.022,),


              Padding(
                padding: EdgeInsets.only(right:scrWidth*0.72),
                child: Text("Statics",style: TextStyle(
                    fontSize: scrWidth*0.033,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Urbanist',
                    color: Color(0xff827C7C)
                ),),
              ),
              Expanded(
                  child: SizedBox(
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(
                          left: scrWidth * 0.068,
                          right: scrWidth * 0.068,
                          top: scrHeight * 0.013),
                      itemCount: months.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: scrHeight*0.052,
                          width: scrWidth*0.2,
                          decoration: BoxDecoration(
                            color: Color(0xffF3F3F3),
                            borderRadius: BorderRadius.circular(8)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(months[index],style: TextStyle(
                                  fontSize: scrWidth*0.045,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Urbanist',
                                  color: Color(0xff000000)
                              ),),
                               SizedBox(width: scrWidth*0.3,),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("₹5.000",style: TextStyle(
                                      fontSize:  scrWidth*0.036,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Urbanist',
                                      color: Color(0xff969696)
                                  ),),
                                  SizedBox(width: scrWidth*0.01,),
                                  Container(
                                    height: scrHeight*0.02,
                                    width: scrWidth*0.1,
                                    decoration: BoxDecoration(
                                        color: Color(0xff02B558),
                                        borderRadius: BorderRadius.circular(3)
                                    ),
                                    child: Center(
                                      child: Text("Paid",style: TextStyle(
                                          fontSize: scrWidth*0.026,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Urbanist',
                                          color: Colors.white
                                      ),),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                        },  separatorBuilder:
                        (BuildContext context, int index) {
                      return Divider(
                        height: scrHeight * 0.01,
                        color: Colors.white,
                      );
                    },
                    ),
                  )
              ),
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
                  "₹5,000.00",
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
              onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>Hostedchitperspage()));

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
