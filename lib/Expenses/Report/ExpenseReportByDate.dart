import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/IconPicker/Packs/Material.dart';
import 'package:flutter_iconpicker/Serialization/iconDataSerialization.dart';
import 'package:intl/intl.dart';

import '../../Authentication/root.dart';
import '../../screens/splash_screen.dart';
import '../../utils/themes.dart';
class ReportByDatePage extends StatefulWidget {
  final DateTime? fromDate;
  final DateTime? toDate;
  const ReportByDatePage({Key? key,
    this.fromDate, this.toDate,}) : super(key: key);

  @override
  State<ReportByDatePage> createState() => _ReportByDatePageState();
}

class _ReportByDatePageState extends State<ReportByDatePage> {
  Icon? _icon;
  var icons;
  final List<String> categryItems = [
    "Category",
    "Monthly",
  ];

  DateTime? fromDate;
  String? selectedValue;
  String? selectedCategory;
  DateTime? toDate;
  double totalExpense=0.00;
  double amount=0.00;
  List dateReports=[];
  List dateExpense=[];
  getCategoryWiseExpenseByDate(){
    FirebaseFirestore.instance.collection('users').doc(currentuserid).collection('expense').
    orderBy('date',descending: true).  where('date',isGreaterThanOrEqualTo:fromDate).
    where('date',isLessThanOrEqualTo:toDate).snapshots().listen((event) {
      if(event.docs.isNotEmpty) {
        totalExpense=0.00;
        dateReports=[];
        dateExpense=[];
        for (DocumentSnapshot data in event.docs) {
          totalExpense+=double.tryParse(data['amount'].toString())??0;
          if(dateExpense.contains(data['categoryName'])){
            Map item=dateReports[dateExpense.indexOf(data['categoryName'])].data();
            double amount=item['amount'];
            amount+=data['amount'];
            item['amount']=amount;
            dateReports.removeAt(dateExpense.indexOf(data['categoryName']));
            dateReports.insert(dateExpense.indexOf(data['categoryName']), item);
          }else{
            dateExpense.add(data['categoryName']);
            dateReports.add(data);
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
  getMonthWiseExpensesByDate(){
    FirebaseFirestore.instance.collection('users').doc(currentuserid).collection('expense').
    where('date',isGreaterThanOrEqualTo:fromDate).
    where('date',isLessThanOrEqualTo:toDate).
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
  @override
  void initState() {

    fromDate=widget.fromDate;
    toDate=widget.toDate;

    getCategoryWiseExpenseByDate();
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
          " Reports By Date",
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                              " Select Date",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w600,
                                  color:primarycolor),
                            ),
                                // Icon(
                                //   Icons.arrow_drop_down,
                                //   color: Colors.black,size:  30,
                                // ),
                              ],

                            ),
                            // DropdownButtonHideUnderline(
                            //   child: DropdownButton2(
                            //     isExpanded: true,
                            //     hint: Center(
                            //       child: Text(
                            //         sortItem[1],
                            //         style: TextStyle(
                            //             fontSize: FontSize15,
                            //             fontFamily: 'Urbanist',
                            //             fontWeight: FontWeight.w600,
                            //             color: Colors.black),
                            //       ),
                            //     ),
                            //     items: sortItem
                            //         .map((item) => DropdownMenuItem<String>(
                            //       value: item,
                            //       child: Center(
                            //         child: Text(
                            //           item.toString(),
                            //           // overflow: TextOverflow.ellipsis,
                            //           style: TextStyle(
                            //               color: Colors.black,
                            //               fontWeight: FontWeight.w600,
                            //               fontSize: 18,
                            //               fontFamily: 'Urbanist'),
                            //
                            //         ),
                            //       ),
                            //     ))
                            //         .toList(),
                            //     value: selectedValue,
                            //     onChanged: (value) {
                            //       setState(() {
                            //         selectedValue = value as String;
                            //         // if(selectedValue=='Select Date'){
                            //         //   showDialog(
                            //         //       context: context,
                            //         //       builder: (BuildContext context) {
                            //         //         return SelectDateRange();
                            //         //       });
                            //         //
                            //         // }
                            //       });
                            //
                            //     },
                            //     icon: const Icon(
                            //       Icons.arrow_drop_down,
                            //     ),
                            //
                            //     iconSize: 30,
                            //     iconEnabledColor: Colors.black,
                            //     iconDisabledColor: Colors.blue,
                            //     buttonHeight: 50,
                            //     buttonWidth: 247,
                            //     // buttonPadding: const EdgeInsets.only(),
                            //     buttonDecoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(14),
                            //       color: Colors.white,
                            //     ),
                            //     // buttonElevation: 2,
                            //     itemHeight: 40,
                            //     itemPadding: const EdgeInsets.only(),
                            //     dropdownMaxHeight: 260,
                            //     dropdownWidth: 250,
                            //     dropdownPadding: EdgeInsets.only(
                            //         left: 35, top: 15, bottom: 25, right: 35),
                            //     dropdownDecoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(8),
                            //       color: primarycolor,
                            //     ),
                            //     dropdownElevation: 0,
                            //     scrollbarRadius: Radius.circular(10),
                            //     scrollbarThickness: 3,
                            //     scrollbarAlwaysShow: true,
                            //     offset: const Offset(-20, 0),
                            //   ),
                            // ),
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
                                        fontSize: 18,
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
                                    getMonthWiseExpensesByDate();
                                  }else{
                                    getCategoryWiseExpenseByDate();

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
                  dateReports.length==0?Container(
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
                      itemCount: dateReports!.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: scrWidth*0.2),
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context,index) {
                        icons=deserializeIcon(dateReports![index]['categoryIcon']);
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
                                          child: Text(dateReports[index]['categoryName'].toString(),style: TextStyle(
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
                                        Text('₹ '+dateReports[index]['amount'].toString(),style: TextStyle(
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
                  dateReports.isEmpty?Container(
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
                      itemCount: dateReports!.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: scrWidth*0.2),
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context,index) {
                        icons=deserializeIcon(dateReports![index]['categoryIcon']);
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
                                          child: Text(dateReports[index]['categoryName'].toString(),style: TextStyle(
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
                                        Text('₹ '+dateReports[index]['amount'].toString(),style: TextStyle(
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
                      Text(fromDate.toString().substring(0,10)+' - '+toDate.toString().substring(0,10),
                        //     date==null?DateTime.now().toString().substring(0,10):
                        // "${fromDate.toString().substring(0,10)}- ${toDate.toString().substring(0,10)}",
                        style: TextStyle(
                            fontSize: scrWidth*0.033,
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
