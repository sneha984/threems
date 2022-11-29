import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/Serialization/iconDataSerialization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../Authentication/root.dart';
import '../../Expenses/Report/ExpenseReportByYear.dart';
import '../../customPackage/date_picker.dart';
import '../../screens/splash_screen.dart';
import '../../utils/themes.dart';
import 'IncomeReportByDate.dart';
var date1;
class IncomeReportPage extends StatefulWidget {
  const IncomeReportPage({Key? key}) : super(key: key);

  @override
  State<IncomeReportPage> createState() => _IncomeReportPageState();
}

class _IncomeReportPageState extends State<IncomeReportPage> {

  Icon? _icon;
  var icons;
  String
  catName='';

  List incomeList=[];
  List categoryNameList=[];
  List singleCategoryList=[];
  String? selectedValue;
  String? selectedCategory;
  List incomeCategory=[];
  double totalExpense=0.00;
  double amount=0.00;
  getYearwiseCategoryIncome(){
    FirebaseFirestore.instance.collection('users').doc(currentuserid).collection('incomes').
    snapshots().listen((event) {
      if(event.docs.isNotEmpty) {
        totalExpense=0.00;
        incomeList=[];
        incomeCategory=[];
        for (DocumentSnapshot data in event.docs) {
          totalExpense+=double.tryParse(data['amount'].toString())??0;
          if(incomeCategory.contains(data['IncomeCategoryName'])){
            Map <String,dynamic>item=incomeList[incomeCategory.indexOf(data['IncomeCategoryName'])];
            double amount=item['amount'];
            amount+=data['amount'];
            item['amount']=amount;
            incomeList.removeAt(incomeCategory.indexOf(data['IncomeCategoryName']));
            incomeList.insert(incomeCategory.indexOf(data['IncomeCategoryName']), item);
          }else{
            incomeCategory.add(data['IncomeCategoryName']);
            incomeList.add(data);
          }


        }

      }
      if(mounted){
        setState(() {

        });
      }
    });
  }
  List monthlyReports=[];
  List months=[];
  getYearMonthIncomes(){
    FirebaseFirestore.instance.collection('users').doc(currentuserid).collection('incomes').
    snapshots().listen((event) {
      if(event.docs.isNotEmpty) {
        months=[];
        monthlyReports=[];
        for (DocumentSnapshot data in event.docs) {
          if(months.contains(data['date'].toDate().toString().substring(0,7))){
            Map<String,dynamic> item=monthlyReports[months.indexOf(data['date'].toDate().toString().substring(0,7))];
            double amount=item['amount'];
            amount+=data['amount'];
            item['amount']=amount;
            // expenseList.removeAt(expenseCategory.indexOf(data['date'].toDate().toString().substring(5,7)));
            // expenseList.insert(expenseCategory.indexOf(data['date'].toDate().toString().substring(5,7)), item);
            monthlyReports.removeAt(months.indexOf(data['date'].toDate().toString().substring(0,7)));
            monthlyReports.insert(months.indexOf(data['date'].toDate().toString().substring(0,7)), item);

          }else{
            // expenseCategory.add(data['date'].toDate().toString().substring(5,7));
            // expenseList.add(data);
            months.add(data['date'].toDate().toString().substring(0,7));
            monthlyReports.add({
              'date':data['date'],
              'amount':data['amount']
            });
          }


        }

      }
      print('1234567890-');
      print(monthlyReports);

      if(mounted){
        setState(() {

        });
      }
    });
  }
  // getCategoryName(){
  //   FirebaseFirestore.instance.collection('expenses').snapshots().listen((event) {
  //     if(event.docs.isNotEmpty) {
  //       for (DocumentSnapshot data in event.docs) {
  //         categoryNameList.add(data['expenseName']);
  //       }
  //
  //     }
  //     if(mounted){
  //       setState(() {
  //
  //       });
  //     }
  //   });
  //
  // }


  // getCategoryBasedExpense(){
  //
  //   FirebaseFirestore.instance.collection('users').doc(currentuserid).collection('expense').
  //   orderBy('date',descending: true).where('categoryName',isEqualTo: selectedCategory).snapshots().listen((event) {
  //     singleCategoryList=[];
  //     amount=0.00;
  //     try {
  //       catName = event.docs[0]['categoryName'];
  //       icons=deserializeIcon(event.docs[0]['categoryIcon']);
  //       _icon = Icon(icons,size: 30,color: Colors.white,);
  //       print(event.docs.toString());
  //       print(event.docs[0]['categoryName']);
  //       print('catName' + catName);
  //     }catch(e){
  //       catName='';
  //     }
  //     if(event.docs.isNotEmpty) {
  //       for (DocumentSnapshot data in event.docs) {
  //         singleCategoryList.add(data);
  //            amount+=data['amount'];
  //            print(amount);
  //
  //       }
  //
  //
  //
  //
  //     }
  //     if(mounted){
  //       setState(() {
  //
  //       });
  //     }
  //   });
  //
  // }
  final List<String> sortItem = [
    "This year",
    "Select Date",

  ];
  final List<String> categryItems = [
    "Category",
    "Monthly",

  ];

  @override
  void initState() {
    // getCategoryName();
    getYearwiseCategoryIncome();


    // getYearMonthExpenses();
    // fromDate=DateTime.now();
    // toDate=DateTime.now();

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
          " Reports",
          style: TextStyle(
              fontSize: scrWidth*0.046,
              color: Colors.white,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w600),
        ),

      ),
      body: Container(
        height: scrHeight,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: scrWidth*0.3,
                  color: tabBarColor,
                  child: Container(
                    child: Padding(
                      padding:  EdgeInsets.only(left:scrWidth*0.04,right:scrWidth*0.04, ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            height: scrWidth*0.09,
                            width: scrWidth*0.37,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                hint: Center(
                                  child: Text(
                                    sortItem[0],
                                    style: TextStyle(
                                        fontSize: FontSize15,
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                ),
                                items: sortItem
                                    .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Center(
                                    child: Text(
                                      item.toString(),
                                      // overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          fontFamily: 'Urbanist'),

                                    ),
                                  ),
                                ))
                                    .toList(),
                                value: selectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    selectedValue = value as String;
                                    if(selectedValue=='Select Date'){
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return SelectDatePage();
                                          });

                                    }
                                  });

                                },
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                ),

                                iconSize: 30,
                                iconEnabledColor: Colors.black,
                                iconDisabledColor: Colors.blue,
                                buttonHeight: 50,
                                buttonWidth: 247,
                                // buttonPadding: const EdgeInsets.only(),
                                buttonDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: Colors.white,
                                ),
                                // buttonElevation: 2,
                                itemHeight: 40,
                                itemPadding: const EdgeInsets.only(),
                                dropdownMaxHeight: 260,
                                dropdownWidth: 180,
                                dropdownPadding: EdgeInsets.only(
                                    left: 35, top: 15, bottom: 25, right: 35),
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                dropdownElevation: 1,
                                scrollbarRadius: Radius.circular(10),
                                scrollbarThickness: 3,
                                scrollbarAlwaysShow: true,
                                offset: const Offset(-20, 0),
                              ),
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //   children: [
                            //     Text(
                            //       " Last year",
                            //       style: TextStyle(
                            //           fontSize: scrWidth*0.04,
                            //           color: Colors.black,
                            //           fontFamily: 'Urbanist',
                            //           fontWeight: FontWeight.w600),
                            //     ),
                            //     Icon(Icons.arrow_drop_down_sharp,size: 30,)
                            //   ],
                            //
                            // ),


                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            height: scrWidth*0.09,
                            width: scrWidth*0.38,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,

                                hint: Center(
                                  child: Text(
                                    categryItems[0],
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.w600,
                                        color:primarycolor),
                                  ),
                                ),
                                items: categryItems
                                    .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Center(
                                    child: Text(
                                      item.toString(),overflow: TextOverflow.ellipsis,
                                      // overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          fontFamily: 'Urbanist'),maxLines: 2,

                                    ),
                                  ),
                                ))
                                    .toList(),
                                value: selectedCategory,
                                onChanged: (value) {
                                  setState(() {

                                    selectedCategory = value;
                                    // getCategoryBasedExpense();
                                  });
                                  if( selectedCategory==categryItems[1]){
                                    getYearMonthIncomes();
                                  }else{
                                    getYearwiseCategoryIncome();

                                  }

                                },
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black,
                                ),

                                iconSize: 30,
                                iconEnabledColor: Colors.black,
                                iconDisabledColor: Colors.blue,
                                buttonHeight: 50,
                                buttonWidth: 247,
                                // buttonPadding: const EdgeInsets.only(),
                                buttonDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: Colors.white,
                                ),
                                // buttonElevation: 2,
                                itemHeight: 40,

                                itemPadding: const EdgeInsets.only(),

                                dropdownMaxHeight: 260,
                                dropdownWidth: 180,
                                dropdownPadding: EdgeInsets.only(
                                    left: 35, top: 15, bottom: 25, right: 35),
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color:Colors.white,
                                ),
                                dropdownElevation: 1,
                                scrollbarRadius: Radius.circular(10),
                                scrollbarThickness: 3,
                                scrollbarAlwaysShow: true,
                                offset: const Offset(-20, 0),
                              ),
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //   children: [
                            //     Text(
                            //       " Last year",
                            //       style: TextStyle(
                            //           fontSize: scrWidth*0.04,
                            //           color: Colors.black,
                            //           fontFamily: 'Urbanist',
                            //           fontWeight: FontWeight.w600),
                            //     ),
                            //     Icon(Icons.arrow_drop_down_sharp,size: 30,)
                            //   ],
                            //
                            // ),


                          ),

                        ],
                      ),
                    ),
                  ),

                ),
                // Container(
                //   height: scrWidth*0.19,
                // ),
                Container(
                  height: scrWidth*1.5,
                  child:selectedCategory==categryItems[0]?
                  incomeList.length==0?Container(
                    child:Center(
                      child: Text(
                        "No expenses under this Category",
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                  ):
                  ListView.builder(
                      itemCount: incomeList!.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: scrWidth*0.2),
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context,index) {
                        icons=deserializeIcon(incomeList![index]['categoryIcon']);
                        _icon = Icon(icons,size: 30,color: Colors.white,);
                        return Column(
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(left: scrWidth*0.08,right:  scrWidth*0.08),
                              child: Container(
                                height: scrWidth*0.11,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 22,
                                          backgroundColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                                          child: _icon ,
                                        ),
                                        // Container(
                                        //   height: 100,
                                        //   decoration: BoxDecoration(
                                        //       color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                                        //       shape: BoxShape.circle
                                        //   ),
                                        //   child: _icon,
                                        // ),
                                        SizedBox(width: scrWidth*0.02,),
                                        Center(
                                          child: Text(incomeList[index]['IncomeCategoryName'].toString(),style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Urbanist',
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700
                                          ),),
                                        ),

                                        // Text(DateFormat('dd MMM,yyyy').format( expenseList[index]['date'].toDate()),style: TextStyle(
                                        //     fontSize: 13,
                                        //     fontFamily: 'Urbanist',
                                        //     color: Colors.grey
                                        // ),),

                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text('₹ '+incomeList[index]['amount'].toString(),style: TextStyle(
                                            fontSize: 17,
                                            fontFamily: 'Urbanist',
                                            color: Colors.black,
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
                  // ListView.builder(
                  //     itemCount: singleCategoryList!.length,
                  //     shrinkWrap: true,
                  //     padding: EdgeInsets.only(top: scrWidth*0.2),
                  //     scrollDirection: Axis.vertical,
                  //     physics: BouncingScrollPhysics(),
                  //     itemBuilder: (context,index) {
                  //       icons=deserializeIcon(singleCategoryList![index]['categoryIcon']);
                  //       _icon = Icon(icons,size: 30,color: Colors.white,);
                  //       return Column(
                  //         children: [
                  //           Padding(
                  //             padding:  EdgeInsets.only(left: scrWidth*0.08,right:  scrWidth*0.08),
                  //             child: Container(
                  //               height: scrWidth*0.11,
                  //               child: Row(
                  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                 children: [
                  //                   Row(
                  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                     crossAxisAlignment: CrossAxisAlignment.center,
                  //                     children: [
                  //                       CircleAvatar(
                  //                         radius: 22,
                  //                         backgroundColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                  //                         child: _icon ,
                  //                       ),
                  //                       // Container(
                  //                       //   height: 100,
                  //                       //   decoration: BoxDecoration(
                  //                       //       color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                  //                       //       shape: BoxShape.circle
                  //                       //   ),
                  //                       //   child: _icon,
                  //                       // ),
                  //                       SizedBox(width: scrWidth*0.02,),
                  //                       Center(
                  //                         child: Text(singleCategoryList[index]['categoryName'].toString(),style: TextStyle(
                  //                             fontSize: 16,
                  //                             fontFamily: 'Urbanist',
                  //                             color: Colors.black,
                  //                             fontWeight: FontWeight.w700
                  //                         ),),
                  //                       ),
                  //
                  //                       // Text(DateFormat('dd MMM,yyyy').format( expenseList[index]['date'].toDate()),style: TextStyle(
                  //                       //     fontSize: 13,
                  //                       //     fontFamily: 'Urbanist',
                  //                       //     color: Colors.grey
                  //                       // ),),
                  //
                  //                     ],
                  //                   ),
                  //                   Column(
                  //                     mainAxisAlignment: MainAxisAlignment.center,
                  //                     crossAxisAlignment: CrossAxisAlignment.center,
                  //                     children: [
                  //                       Text('₹ '+amount.toString(),style: TextStyle(
                  //                           fontSize: 17,
                  //                           fontFamily: 'Urbanist',
                  //                           color: Colors.black,
                  //                           fontWeight: FontWeight.w700
                  //                       ),),
                  //
                  //                     ],
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //           Padding(
                  //             padding:  EdgeInsets.only(left: scrWidth*0.08,right:  scrWidth*0.08,bottom: 10),
                  //             child: Container(child: Divider(thickness: 0.5,color: Colors.grey,)),
                  //           ),
                  //
                  //         ],
                  //       );
                  //     }
                  //
                  // )
                      :selectedCategory==categryItems[1]?Padding(
                    padding:  EdgeInsets.only(top: scrWidth*0.2),
                    child: Container(
                      child: ListView.builder(
                        itemCount: monthlyReports.length,
                        shrinkWrap: true,
                        itemBuilder: (context,index){
                          return Column(
                            children: [
                              // Padding(
                              //   padding: const EdgeInsets.only(top: 50),
                              //   child: Text('${monthlyReports[index]['date'].toDate().toString().substring(0,10)},  :  ${monthlyReports[index]['amount']}'),
                              // ),
                              Padding(
                                padding:  EdgeInsets.only(left: scrWidth*0.08,right:  scrWidth*0.08,),
                                child: Container(
                                  height: scrWidth*0.15,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [

                                          Text(DateFormat('MMM,yyyy').format(monthlyReports[index]['date'].toDate()),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'Urbanist',
                                                color: Colors.black
                                            ),),
                                          SizedBox(width: scrWidth*0.02,),
                                          Text(monthlyReports[index]['amount'].toString(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'Urbanist',
                                                color: Colors.black
                                            ),),

                                          // Text(DateFormat('dd MMM,yyyy').format( expenseList[index]['date'].toDate()),style: TextStyle(
                                          //     fontSize: 13,
                                          //     fontFamily: 'Urbanist',
                                          //     color: Colors.grey
                                          // ),),

                                        ],
                                      ),
                                      Padding(
                                        padding:  EdgeInsets.only(left: scrWidth*0.06,right:  scrWidth*0.06,bottom: 10),
                                        child: Container(child: Divider(thickness: 0.5,color: Colors.grey,)),
                                      ),


                                    ],
                                  ),
                                ),
                              ),

                            ],
                          );
                        },
                      ),
                    ),
                  ):
                  incomeList.isEmpty?Container(
                    child:Center(
                      child: Text(
                        "No expenses",
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                  ):
                  ListView.builder(
                      itemCount: incomeList!.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: scrWidth*0.2),
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context,index) {
                        icons=deserializeIcon(incomeList![index]['categoryIcon']);
                        _icon = Icon(icons,size: 30,color: Colors.white,);
                        return Column(
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(left: scrWidth*0.08,right:  scrWidth*0.08),
                              child: Container(
                                height: scrWidth*0.11,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 22,
                                          backgroundColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                                          child: _icon ,
                                        ),
                                        // Container(
                                        //   height: 100,
                                        //   decoration: BoxDecoration(
                                        //       color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                                        //       shape: BoxShape.circle
                                        //   ),
                                        //   child: _icon,
                                        // ),
                                        SizedBox(width: scrWidth*0.02,),
                                        Center(
                                          child: Text(incomeList[index]['IncomeCategoryName'].toString(),style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Urbanist',
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700
                                          ),),
                                        ),

                                        // Text(DateFormat('dd MMM,yyyy').format( expenseList[index]['date'].toDate()),style: TextStyle(
                                        //     fontSize: 13,
                                        //     fontFamily: 'Urbanist',
                                        //     color: Colors.grey
                                        // ),),

                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text('₹ '+incomeList[index]['amount'].toString(),style: TextStyle(
                                            fontSize: 17,
                                            fontFamily: 'Urbanist',
                                            color: Colors.black,
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
                  ,
                ),
                // SizedBox(height: scrWidth*0.05,)

              ],
            ),
            Positioned(
                top: scrHeight*0.085,
                left: scrWidth*0.08,
                right: scrWidth*0.08,
                child: Container(
                  height: scrWidth*0.26,
                  width: scrWidth*0.85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        spreadRadius: 4,
                        offset: Offset(0, 7),
                        color: Colors.grey.withOpacity(0.15),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(DateTime.now().toString().substring(0,10),
                        //     date==null?DateTime.now().toString().substring(0,10):
                        // "${fromDate.toString().substring(0,10)}- ${toDate.toString().substring(0,10)}",
                        style: TextStyle(
                            fontSize: scrWidth*0.035,
                            color: Colors.grey,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 12,),
                      Text(
                        " ₹"+totalExpense.toString(),
                        style: TextStyle(
                            fontSize: scrWidth*0.055,
                            color: Colors.black,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w800),
                      )
                      // selectedCategory==null?Text(
                      //   " ₹"+totalExpense.toString(),
                      //   style: TextStyle(
                      //       fontSize: scrWidth*0.055,
                      //       color: Colors.black,
                      //       fontFamily: 'Urbanist',
                      //       fontWeight: FontWeight.w800),
                      // ):
                      // Text(
                      //   " ₹"+amount.toString(),
                      //   style: TextStyle(
                      //       fontSize: scrWidth*0.055,
                      //       color: Colors.black,
                      //       fontFamily: 'Urbanist',
                      //       fontWeight: FontWeight.w800),
                      // ),

                    ],
                  ),

                )
            ),

          ],
        ),
      ),
    );
  }
  }
  class SelectDatePage extends StatefulWidget {
    const SelectDatePage({Key? key}) : super(key: key);

    @override
    State<SelectDatePage> createState() => _SelectDatePageState();
  }

  class _SelectDatePageState extends State<SelectDatePage> {
    DateTime? fromDate;

    DateTime? toDate;
    _FromDate(BuildContext context) async {
      final DateTime? datePicked = await showDatePickerCustom(
          cancelText: 'Cancel',
          confirmText: 'Select',
          context: context,
          firstDate: DateTime(2000,1),
          lastDate: DateTime(DateTime.now().year + 100),
          initialDate: DateTime.now(),
          builder: (context, child) => Theme(
              data: ThemeData(
                  colorScheme: ColorScheme.light(primary: Colors.green)),
              child: child!));
      if (datePicked != null && datePicked != fromDate) {
         date1=datePicked;
        setState(() {
          fromDate = datePicked;

        });
      }
    }
    _ToDate(BuildContext context) async {
      final DateTime? datePicked = await showDatePickerCustom(
          cancelText: 'Cancel',
          confirmText: 'Select',
          context: context,
          firstDate: DateTime(2000,1),
          lastDate: DateTime(DateTime.now().year + 100,),
          initialDate: DateTime.now(),
          builder: (context, child) => Theme(
              data: ThemeData(
                  colorScheme: ColorScheme.light(primary: Colors.green)),
              child: child!));
      if (datePicked != null && datePicked != toDate) {
        setState(() {
          date1=datePicked;
          toDate = datePicked;
        });
      }
    }
    @override
    Widget build(BuildContext context) {
      return AlertDialog(
          insetPadding: EdgeInsets.only(bottom: scrWidth*0.4,top:  scrWidth*0.4,right:  scrWidth*0.07,left:  scrWidth*0.07),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(45.0))),
          contentPadding: EdgeInsets.all(scrWidth*0.07),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Select Range',
                      // overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                          fontFamily: 'Urbanist'),

                    ),
                    Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: (){
                                _FromDate(context);
                                setState((){});

                              },

                              child: Container(
                                height:scrWidth*0.1,
                                width:scrWidth*0.32,
                                decoration: BoxDecoration(
                                    color: textFormFieldFillColor,
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                child:  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      fromDate==null?'From Date':fromDate.toString().substring(0,10),
                                      // overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          fontFamily: 'Urbanist'),

                                    ),
                                    SvgPicture.asset(
                                      'assets/icons/calendar.svg',
                                      width: scrWidth*0.042,
                                      height: scrHeight*0.025,
                                      fit: BoxFit.contain,
                                    ),

                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            InkWell(
                              onTap: (){
                                _ToDate(context);
                                setState((){});

                              },
                              child: Container(
                                height:scrWidth*0.1,
                                width:scrWidth*0.32,
                                decoration: BoxDecoration(
                                    color: textFormFieldFillColor,
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                child:  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      toDate==null? 'To Date':toDate.toString().substring(0,10),
                                      // overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          fontFamily: 'Urbanist'),

                                    ),
                                    SvgPicture.asset(
                                      'assets/icons/calendar.svg',
                                      width: scrWidth*0.042,
                                      height: scrHeight*0.025,
                                      fit: BoxFit.contain,
                                    ),

                                  ],
                                ),
                              ),
                            ),



                          ],
                        )
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                        // Navigator.of(context).pop({"fromDate":fromDate,"toDate":toDate});
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>IncomeReportByDate(
                            fromDate:fromDate,
                            toDate:toDate
                        )));
                      },
                      child: Center(
                        child: Container(
                          width: scrWidth*0.6,
                          height: scrHeight*0.05,
                          decoration: BoxDecoration(
                              color: Color(0xff008036),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Center(
                            child: Text(
                              " Select",
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
                  ],
                );
              }
          )
      );
    }
  }


