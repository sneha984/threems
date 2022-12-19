import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Authentication/root.dart';
import '../screens/splash_screen.dart';
import '../utils/themes.dart';

class RecentExpensePage extends StatefulWidget {
  const RecentExpensePage({Key? key}) : super(key: key);

  @override
  State<RecentExpensePage> createState() => _RecentExpensePageState();
}

class _RecentExpensePageState extends State<RecentExpensePage> {
  List expenseList=[];
  getRecentExpenses(){
    FirebaseFirestore.instance.collection('users').doc(currentuserid).collection('expense').
    orderBy('date',descending: true).limit(20).snapshots().listen((event) {

      if(event.docs.isNotEmpty) {
        expenseList=[];
        for (DocumentSnapshot data in event.docs) {
          expenseList.add(data);
        }
      }
      if(mounted){
        setState(() {

        });
      }
    });
  }

  @override
  void initState() {
    getRecentExpenses();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        foregroundColor: Colors.white,
        // toolbarHeight: 84,
        shadowColor: Colors.grey,
        leadingWidth: 40,
        centerTitle: false,
        elevation:0.1,
        backgroundColor: tabBarColor,

        title: Text(
          " Recent Expenses",
          style: TextStyle(
              fontSize: scrWidth*0.046,
              color: Colors.white,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w600),
        ),

      ),
      body:SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: scrHeight*0.015,), // SizedBox(height: scrHeight*0.015,)
            expenseList.isEmpty?Container(
                child:Center(
                  child: Text(
                    " No Recent expences",
                    style: TextStyle(
                      fontSize: scrWidth*0.035,
                      color: Colors.black,
                      fontFamily: 'Urbanist',
                    ),
                  ),
                )
            ): ListView.builder(
                itemCount: expenseList!.length,
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
                                  Text(expenseList[index]['merchant'].toString(),style: TextStyle(
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
                                      child: Text(expenseList[index]['categoryName'].toString(),style: TextStyle(
                                          fontSize: 10,
                                          fontFamily: 'Urbanist',
                                          color: Colors.white
                                      ),),
                                    ),
                                  ),
                                  Text(DateFormat('dd MMM,yyyy').format( expenseList[index]['date'].toDate()),style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'Urbanist',
                                      color: Colors.grey
                                  ),),

                                ],
                              ),
                              Padding(
                                padding:  EdgeInsets.only(top: scrWidth*0.05),
                                child: Container(
                                  height:scrWidth*0.5,
                                  width:scrWidth*0.25,
                                  color:Colors.grey,
                                  child: Text(expenseList[index]['description'].toString(),style: TextStyle(
                                      fontSize: 10,
                                      fontFamily: 'Urbanist',
                                      color:Colors.black,
                                      fontWeight: FontWeight.w700
                                  ),),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('₹ - '+expenseList[index]['amount'].toString(),style: TextStyle(
                                      fontSize: 19,
                                      fontFamily: 'Urbanist',
                                      color: Colors.red.shade600,
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

            )
          ],
        ),
      ),
    );
  }
}
