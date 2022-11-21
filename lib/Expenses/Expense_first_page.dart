import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/Serialization/iconDataSerialization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:threems/Authentication/root.dart';

import '../screens/charity/verification_details.dart';
import '../screens/splash_screen.dart';
import '../utils/themes.dart';
import 'Report/report_page.dart';
import 'new_expense.dart';
// import 'add_expense.dart';
class AddExpensesPage extends StatefulWidget {
  const AddExpensesPage({Key? key}) : super(key: key);

  @override
  State<AddExpensesPage> createState() => _AddExpensesPageState();
}

class _AddExpensesPageState extends State<AddExpensesPage> with TickerProviderStateMixin {
  List expenseList=[];
  getRecentExpenses(){
    FirebaseFirestore.instance.collection('users').doc(currentuserid).collection('expense').
    orderBy('date',descending: true).limit(5).snapshots().listen((event) {

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

  Icon? _icon;
  var icons;
  TabController? _tabController;
  TextEditingController ?expenseAmount;
  TextEditingController ?narration;
  void initState() {
    getRecentExpenses();
    expenseAmount = TextEditingController(text:'');
    narration = TextEditingController(text:'');
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _tabController?.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        foregroundColor: Colors.black,
        toolbarHeight: 84,
        shadowColor: Colors.grey,
        leadingWidth: 40,
        centerTitle: false,
        elevation:0.1,
        backgroundColor: Colors.white,

        title: Text(
          " Your Expense Tracker",
          style: TextStyle(
              fontSize: scrWidth*0.046,
              color: Colors.black,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w600),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: InkWell(
                onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>ReportPage()));

                },
                child: SvgPicture.asset('assets/images/expense tracker.svg',height: 35,width: 35,)),
          )
        ],
      ),
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
                            Text('Total Expences'.toString(),style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Urbanist',
                                color: Colors.white
                            ),),
                            SizedBox(height: scrHeight*0.002,),
                            Text('₹ '+1500000.toString(),style: TextStyle(
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
                                Text('₹ '+1500000.toString(),style: TextStyle(
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
                                Text('₹ '+125263.toString(),style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white
                                ),),
                                SizedBox(height: scrHeight*0.002,),
                                Text("Total Expences",style: TextStyle(
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=>NewExpensePage()));
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
                      " Add new expense",
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
                    " Recent expences",
                    style: TextStyle(
                        fontSize: scrWidth*0.045,
                        color: Colors.black,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: scrWidth*0.2,),
                  Icon(Icons.arrow_forward,color: Colors.red.shade500,size: 20,)
                ],
              ),
            ),
            SizedBox(height: scrWidth*0.02,),
            SingleChildScrollView(
              child: Container(
                height: scrWidth*0.8,
                child:expenseList.isEmpty?Container(
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

                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}
