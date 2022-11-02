import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/splash_screen.dart';
import '../utils/themes.dart';

class FlchartMonth extends StatefulWidget {
  const FlchartMonth({Key? key}) : super(key: key);

  @override
  State<FlchartMonth> createState() => _FlchartMonthState();
}

class _FlchartMonthState extends State<FlchartMonth> {
  int index=0;

  List <FlSpot>spotindex=[
    FlSpot(0, 8),
    FlSpot(2, 9),
    FlSpot(4, 6),
    FlSpot(6, 7),
    FlSpot(8, 4),
    FlSpot(10, 10),
    FlSpot(12, 9),
    FlSpot(14, 13),
    FlSpot(16, 7),
    FlSpot(18,2),
    FlSpot(20, 14),
    FlSpot(22, 10),
    FlSpot(24, 2),
    // FlSpot(26,4 ),
    // FlSpot(28, 1),
    // FlSpot(30, 7),


  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,

      child: Row(

        children: [
          Container(
            height: scrHeight*0.2,
            width: scrWidth*1.5,
            child: LineChart(
              LineChartData(
                lineTouchData: LineTouchData(
                  getTouchedSpotIndicator: (LineChartBarData bardata,List<int>spotindex){
                    return spotindex.map((index) {
                      return TouchedSpotIndicatorData(
                        FlLine(
                          color:primarycolor.withOpacity(0.1) ,
                          strokeWidth: 50,
                          // dashArray: [10,10],

                        ),
                        FlDotData(
                            show:true,
                            getDotPainter:(spot, percent, barData, index){
                              return FlDotCirclePainter(
                                radius: 10,
                                color:primarycolor,
                                strokeWidth: 4,
                                strokeColor: Colors.white,
                              );
                            }
                        ),
                      );
                    }).toList();
                  },
                  enabled: true,



                  touchTooltipData: LineTouchTooltipData(
                      tooltipBgColor: Colors.transparent,
                      tooltipRoundedRadius: 10,


                      tooltipBorder: BorderSide(
                          color: primarycolor,

                          width: 0.3,
                          strokeAlign: StrokeAlign.inside,
                          style: BorderStyle.solid

                      ),
                      tooltipMargin: 20,
                      tooltipPadding: EdgeInsets.all(8),
                      getTooltipItems: (touchedSpots){
                        return touchedSpots.map((e) {
                          return LineTooltipItem("₹12,000", TextStyle(
                              color: Colors.black,fontSize: 10,
                              fontFamily: 'Urbanist',fontWeight: FontWeight.w900
                          ),textAlign: TextAlign.left);

                        }).toList();
                      }


                  ),
                ),
                minX: 0,
                maxX: 26,
                maxY: 14,
                minY: 0,
                lineBarsData: [
                  LineChartBarData(
                    dotData: FlDotData(
                      show: false,
                    ),
                    isStrokeCapRound: true,
                    isStrokeJoinRound: true,

                    spots: spotindex,
                    isCurved: true,
                    barWidth: 2,
                    // dotData: FlDotData(
                    //   show: true,
                    // ),
                    color: primarycolor,
                    belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [.01, 1],
                            colors: gradientColors
                                .map((color) => color)
                                .toList()
                        )
                    ),

                  )
                ],

                borderData: FlBorderData(

                    border: const Border(bottom: BorderSide(width: 0.06,), left: BorderSide(width: 0.06))),
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        interval: 1,
                        showTitles: true,
                        getTitlesWidget: (value,meta){
                          String text='';
                          switch (value.toInt()) {
                            case 1:
                              return Padding(
                                  padding:  EdgeInsets.only(left: scrWidth*0.1),
                                  child: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        index=0;
                                      });
                                    },
                                    child: Container(

                                        height: 20,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: (index==0)?primarycolor:null,
                                        ),
                                        child: Center(child: Text("week1",style: TextStyle(
                                            fontWeight: FontWeight.w500,fontSize: 11,fontFamily: 'Poppins',color: (index==0)?Colors.white:Colors.grey),))),
                                  )
                              );
                            case 2:
                              return Padding(
                                  padding:  EdgeInsets.only(left: scrWidth*0.24,),
                                  child: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        index=1;
                                      });
                                    },
                                    child: Container(
                                        height: 20,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: (index==1)?primarycolor:null,

                                        ),
                                        child: Center(child: Text("week2",style: TextStyle(
                                            fontWeight: FontWeight.w500,fontSize: 11,fontFamily: 'Poppins',color: (index==1)?Colors.white:Colors.grey)))),
                                  )
                              );
                            case 3:
                              return Padding(
                                  padding:  EdgeInsets.only(left: scrWidth*0.35),
                                  child: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        index=2;
                                      });
                                    },
                                    child: Container(

                                        height: 20,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: (index==2)?primarycolor:null,

                                        ),
                                        child: Center(child: Text("Mar.",style: TextStyle(
                                            fontWeight: FontWeight.w500,fontSize: 11,fontFamily: 'Poppins',color:(index==2)?Colors.white:Colors.grey),))),
                                  )
                              );
                            case 4:
                              return Padding(
                                  padding:  EdgeInsets.only(left: scrWidth*0.47),
                                  child: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        index=3;
                                      });
                                    },
                                    child: Container(

                                        height: 20,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: (index==3)?primarycolor:null,

                                        ),
                                        child: Center(child: Text("Apr",style: TextStyle(
                                            fontWeight: FontWeight.w500,fontSize: 11,fontFamily: 'Poppins',color:(index==3)?Colors.white:Colors.grey),))),
                                  )
                              );
                            case 5:
                              return Padding(
                                  padding:  EdgeInsets.only(left: scrWidth*0.57),
                                  child: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        index=4;
                                      });
                                    },
                                    child: Container(

                                        height: 20,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: (index==4)?primarycolor:null,

                                        ),
                                        child: Center(
                                            child: Text(
                                              "May",style: TextStyle(
                                                fontWeight: FontWeight.w500,fontSize: 11,
                                                fontFamily: 'Poppins',color:(index==4)?Colors.white:Colors.grey),))),
                                  )
                              );
                            case 6:
                              return Padding(
                                  padding:  EdgeInsets.only(left: scrWidth*0.68),
                                  child: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        index=5;
                                      });
                                    },
                                    child: Container(

                                        height: 20,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: (index==5)?primarycolor:null,

                                        ),
                                        child: Center(child: Text("Jun",style: TextStyle(
                                            fontWeight: FontWeight.w500,fontSize: 11,fontFamily: 'Poppins',color: (index==5)?Colors.white:Colors.grey),))),
                                  )
                              );
                            case 7:
                              return Padding(
                                  padding:  EdgeInsets.only(left: scrWidth*0.79),
                                  child: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        index=6;
                                      });
                                    },
                                    child: Container(
                                        height: 20,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: (index==6)?primarycolor:null,

                                        ),
                                        child: Center(child: Text("Jul",style: TextStyle(
                                            fontWeight: FontWeight.w500,fontSize: 11,fontFamily: 'Poppins',color: (index==6)?Colors.white:Colors.grey),))),
                                  )
                              );
                            case 8:
                              return Padding(
                                  padding:  EdgeInsets.only(left: scrWidth*0.9),
                                  child: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        index=7;
                                      });
                                    },
                                    child: Container(

                                        height: 20,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: (index==7)?primarycolor:null,

                                        ),
                                        child: Center(
                                            child: Text(
                                              "Aug",style: TextStyle(
                                                fontWeight: FontWeight.w500,fontSize: 11,fontFamily: 'Poppins',color:(index==7)?Colors.white:Colors.grey),))),
                                  )
                              );
                            case 9:
                              return Padding(
                                  padding:  EdgeInsets.only(left: scrWidth*1.03),
                                  child: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        index=8;
                                      });
                                    },
                                    child: Container(

                                        height: 20,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: (index==8)?primarycolor:null,

                                        ),
                                        child: Center(
                                            child: Text(
                                              "Sep",style: TextStyle(
                                                fontWeight: FontWeight.w500,fontSize: 11,fontFamily: 'Poppins',color:(index==8)?Colors.white:Colors.grey),))),
                                  )
                              );
                            case 10:
                              return Padding(
                                  padding:  EdgeInsets.only(left: scrWidth*1.15),
                                  child: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        index=9;
                                      });
                                    },
                                    child: Container(

                                        height: 20,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: (index==9)?primarycolor:null,

                                        ),
                                        child: Center(
                                            child: Text(
                                              "Oct",style: TextStyle(
                                                fontWeight: FontWeight.w500,fontSize: 11,fontFamily: 'Poppins',color:(index==9)?Colors.white:Colors.grey),))),
                                  )
                              );
                            case 11:
                              return Padding(
                                  padding:  EdgeInsets.only(left: scrWidth*1.27),
                                  child: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        index=10;
                                      });
                                    },
                                    child: Container(

                                        height: 20,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: (index==10)?primarycolor:null,

                                        ),
                                        child: Center(
                                            child: Text(
                                              "Nov",style: TextStyle(
                                                fontWeight: FontWeight.w500,fontSize: 11,fontFamily: 'Poppins',color:(index==10)?Colors.white:Colors.grey),))),
                                  )
                              );
                            case 12:
                              return Padding(
                                  padding:  EdgeInsets.only(left: scrWidth*1.4),
                                  child: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        index=11;
                                      });
                                    },
                                    child: Container(

                                        height: 20,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: (index==11)?primarycolor:null,

                                        ),
                                        child: Center(
                                            child: Text(
                                              "Dec",style: TextStyle(
                                                fontWeight: FontWeight.w500,fontSize: 11,fontFamily: 'Poppins',color:(index==11)?Colors.white:Colors.grey),))),
                                  )
                              );
                          }
                          return Text('');
                        },
                      )),
                  leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),

              ),

            ),
          ),
        ],
      ),
    );
  }
  List<Color> gradientColors = [
    const Color(0xff008036).withOpacity(0.59),
    const Color(0xffDAFFE2).withOpacity(0),
  ];
  List<Color> toolColors = [
    const Color(0xffFFFFFF).withOpacity(0.59),
    const Color(0xff008036).withOpacity(0),
  ];
}
