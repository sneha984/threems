import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:threems/Income/recentIncomes.dart';
import 'package:threems/utils/themes.dart';

import '../Authentication/root.dart';
import '../screens/splash_screen.dart';
import 'addIncome/addnew_income.dart';
class IncomeFirstPage extends StatefulWidget {
  const IncomeFirstPage({Key? key}) : super(key: key);

  @override
  State<IncomeFirstPage> createState() => _IncomeFirstPageState();
}

class _IncomeFirstPageState extends State<IncomeFirstPage> {
  List incomeList=[];
  DateTime now=DateTime.now();
  var weekIncome=0.00;
  var totalIncome=0.00;
  var monthIncome=0.00;
  getOneWeekandOneMonthIncome(){
    FirebaseFirestore.instance.collection('users').doc(currentuserid).collection('incomes').
    orderBy('date',descending: true).
    where('date',isGreaterThanOrEqualTo:DateTime(now.year,now.month,now.day-7) ).
    snapshots().listen((event) {

      if(event.docs.isNotEmpty) {
        weekIncome=0.00;
        for (DocumentSnapshot data in event.docs) {
          weekIncome+=data['amount'];
          // expenseList.add(data);
        }
      }
      if(mounted){
        setState(() {

        });
      }
    });
    FirebaseFirestore.instance.collection('users').doc(currentuserid).collection('incomes').
    orderBy('date',descending: true).
    where('date',isGreaterThanOrEqualTo:DateTime(now.year,now.month-1,now.day) ).
    snapshots().listen((event) {

      if(event.docs.isNotEmpty) {
        monthIncome=0.00;
        for (DocumentSnapshot data in event.docs) {
          monthIncome+=data['amount'];
          // expenseList.add(data);
        }
      }
      if(mounted){
        setState(() {

        });
      }
    });
  }
  getTotalIncome(){
    FirebaseFirestore.instance.collection('users').doc(currentuserid).collection('incomes').
    snapshots().listen((event) {

      if(event.docs.isNotEmpty) {
        totalIncome=0.00;
        for (DocumentSnapshot data in event.docs) {
          totalIncome+=data['amount'];
          // expenseList.add(data);
        }
      }
      if(mounted){
        setState(() {

        });
      }
    });
  }
  getRecentIncomes(){
    FirebaseFirestore.instance.collection('users').doc(currentuserid).collection('incomes').
    orderBy('date',descending: true).limit(5).snapshots().listen((event) {

      if(event.docs.isNotEmpty) {
        incomeList=[];
        for (DocumentSnapshot data in event.docs) {
          incomeList.add(data);
        }
      }
      if(mounted){
        setState(() {

        });
      }
    });
  }

  Icon? _icon;
  var icons;

  void initState() {
    getOneWeekandOneMonthIncome();
    getTotalIncome();
    getRecentIncomes();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: true,
      //   foregroundColor: Colors.black,
      //   toolbarHeight: 84,
      //   shadowColor: Colors.grey,
      //   leadingWidth: 40,
      //   centerTitle: false,
      //   elevation:0.1,
      //   backgroundColor: Colors.white,
      //
      //   title: Text(
      //     " Your Expense Tracker",
      //     style: TextStyle(
      //         fontSize: scrWidth*0.046,
      //         color: Colors.black,
      //         fontFamily: 'Urbanist',
      //         fontWeight: FontWeight.w600),
      //   ),
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.only(right: 18.0),
      //       child: InkWell(
      //           onTap: (){
      //              Navigator.push(context, MaterialPageRoute(builder: (context)=>ReportPage()));
      //
      //           },
      //           child: SvgPicture.asset('assets/images/expense tracker.svg',height: 35,width: 35,)),
      //     )
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: scrHeight*0.015,),
            Stack(
              children: [
                Container(
                  width: scrWidth*1,
                  height: scrHeight*0.29,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage("assets/images/card desigbn.png"),fit: BoxFit.fill)
                  ),
                ),
                Positioned(
                    top: scrHeight*0.04,
                    left: scrWidth*0.13,
                    right: scrWidth*0.2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Total Income'.toString(),style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Urbanist',
                                color: Colors.white
                            ),),
                            SizedBox(height: scrHeight*0.002,),
                            Text('₹ '+monthIncome.toString(),style: TextStyle(
                                fontSize: 24,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w700,
                                color: Colors.white
                            ),),
                            SizedBox(height: scrHeight*0.002,),
                            Text("Last 30 days",style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Urbanist',
                                color: Colors.white
                            ),),

                          ],
                        ),
                        SizedBox(height: scrHeight*0.05,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('₹ '+weekIncome.toString(),style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white
                                ),),
                                SizedBox(height: scrHeight*0.002,),
                                Text("Last 7 days",style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'Urbanist',
                                    color: Colors.white
                                ),),

                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('₹ '+totalIncome.toString(),style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white
                                ),),
                                SizedBox(height: scrHeight*0.002,),
                                Text("Total income",style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'Urbanist',
                                    color: Colors.white
                                ),),

                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: scrHeight*0.07,),
                      ],
                    )
                ),
              ],
            ),
            // SizedBox(height: scrHeight*0.015,),

            InkWell(
              onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>AddIncomePage()));
              },
              child: Center(
                child: Container(
                  width: scrWidth*0.88,
                  height: scrHeight*0.07,
                  decoration: BoxDecoration(
                      color: Color(0xff02B558),
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Center(
                    child: Text(
                      " Add new Income",
                      style: TextStyle(
                          fontSize: scrWidth*0.046,
                          color: Colors.white,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8,top: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    " Recent incomes",
                    style: TextStyle(
                        fontSize: scrWidth*0.045,
                        color: Colors.black,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: scrWidth*0.2,),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>RecentIncomePage()));


                    },
                      child: Icon(Icons.arrow_forward,color: Colors.red.shade500,size: 20,))
                ],
              ),
            ),
            SizedBox(height: scrWidth*0.02,),
            SingleChildScrollView(
              child: Container(
                height: scrWidth*0.8,
                child:incomeList.isEmpty?Container(
                    child:Center(
                      child: Text(
                        " No Recent incomes",
                        style: TextStyle(
                          fontSize: scrWidth*0.035,
                          color: Colors.black,
                          fontFamily: 'Urbanist',
                        ),
                      ),
                    )
                ): ListView.builder(
                    itemCount: incomeList!.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context,index) {
                      return Column(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(left: scrWidth*0.08,right:  scrWidth*0.08),
                            child: Container(
                              height: scrWidth*0.21,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(incomeList[index]['merchant'].toString(),style: TextStyle(
                                          fontSize: 17,
                                          fontFamily: 'Urbanist',
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700
                                      ),),
                                      Container(
                                        height:scrWidth*0.075,
                                        width:scrWidth*0.22,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(25),
                                          color: Colors.primaries[Random().nextInt(Colors.primaries.length)],

                                        ),
                                        child: Center(
                                          child: Text(incomeList[index]['categoryName'].toString(),style: TextStyle(
                                              fontSize: 10,
                                              fontFamily: 'Urbanist',
                                              color: Colors.white
                                          ),),
                                        ),
                                      ),
                                      Text(DateFormat('dd MMM,yyyy').format( incomeList[index]['date'].toDate()),style: TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Urbanist',
                                          color: Colors.grey
                                      ),),

                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text('₹ + '+incomeList[index]['amount'].toString(),style: TextStyle(
                                          fontSize: 19,
                                          fontFamily: 'Urbanist',
                                          color: primarycolor,
                                          fontWeight: FontWeight.w700
                                      ),),

                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(left: scrWidth*0.08,right:  scrWidth*0.08,bottom: 10),
                            child: Container(child: Divider(thickness: 0.5,color: Colors.grey,)),
                          ),

                        ],
                      );
                    }

                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
