
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/Serialization/iconDataSerialization.dart';
import 'package:intl/intl.dart';
import '../Authentication/root.dart';
import '../screens/splash_screen.dart';
import '../utils/themes.dart';

class IncomeExpenseByDatePage extends StatefulWidget {
  final DateTime? fromDate;
  final DateTime? toDate;
  const IncomeExpenseByDatePage({Key? key, this.fromDate, this.toDate}) : super(key: key);

  @override
  State<IncomeExpenseByDatePage> createState() => _IncomeExpenseByDatePageState();
}

class _IncomeExpenseByDatePageState extends State<IncomeExpenseByDatePage> {
  List ExpenseIncomeList=[];
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
  List dateExpenseReports=[];
  List dateExpense=[];
  List monthList=[];
  List IncomeExpenseMonthList=[];
  getCategoryWiseExpenseByDate(){
    FirebaseFirestore.instance.collection('users').doc(currentuserid).collection('expense').
    orderBy('date',descending: true).  where('date',isGreaterThanOrEqualTo:fromDate).
    where('date',isLessThanOrEqualTo:DateTime(toDate!.year,toDate!.month,toDate!.day,23,59,59)).snapshots().listen((event) {
      ExpenseIncomeList=[];
      if(event.docs.isNotEmpty) {
        totalExpense=0.00;
        dateExpenseReports=[];
        dateExpense=[];
        for (DocumentSnapshot data in event.docs) {
          totalExpense+=double.tryParse(data['amount'].toString())??0;
          if(dateExpense.contains(data['categoryName'])){
            Map item=dateExpenseReports[dateExpense.indexOf(data['categoryName'])].data();
            double amount=item['amount'];
            amount+=data['amount'];
            item['amount']=amount;
            dateExpenseReports.removeAt(dateExpense.indexOf(data['categoryName']));
            dateExpenseReports.insert(dateExpense.indexOf(data['categoryName']), item);
          }else{
            dateExpense.add(data['categoryName']);
            dateExpenseReports.add(data);
          }


        }

      }
      ExpenseIncomeList.addAll(dateExpenseReports);
      if(mounted){
        setState(() {

        });
      }
    });
  }
  List monthlyExpenseReports=[];
  List monthExpenseList=[];
  getMonthWiseExpensesByDate(){
    FirebaseFirestore.instance.collection('users').doc(currentuserid).collection('expense').
    where('date',isGreaterThanOrEqualTo:fromDate).
    where('date',isLessThanOrEqualTo:DateTime(toDate!.year,toDate!.month,toDate!.day,23,59,59)).
    snapshots().listen((event) {

      if(event.docs.isNotEmpty) {
        monthExpenseList=[];
        monthlyExpenseReports=[];
        for (DocumentSnapshot data in event.docs) {
          if(monthExpenseList.contains(data['date'].toDate().toString().substring(0,7))){
            Map<String,dynamic> item=monthlyExpenseReports[monthExpenseList.indexOf(data['date'].toDate().toString().substring(0,7))];
            double amount=item['amount'];
            amount+=data['amount'];
            item['amount']=amount;
            // expenseList.removeAt(expenseCategory.indexOf(data['date'].toDate().toString().substring(5,7)));
            // expenseList.insert(expenseCategory.indexOf(data['date'].toDate().toString().substring(5,7)), item);
            monthlyExpenseReports.removeAt(monthExpenseList.indexOf(data['date'].toDate().toString().substring(0,7)));
            monthlyExpenseReports.insert(monthExpenseList.indexOf(data['date'].toDate().toString().substring(0,7)), item);

          }else{
            // expenseCategory.add(data['date'].toDate().toString().substring(5,7));
            // expenseList.add(data);
            monthExpenseList.add(data['date'].toDate().toString().substring(0,7));
            monthlyExpenseReports.add({
              'date':data['date'],
              'amount':data['amount']
            });
          }


        }

      }
      for(int i=0;i<monthlyExpenseReports.length;i++){
        if(monthList.contains(DateFormat('MMM,yyyy').format(monthlyExpenseReports[i]['date'].toDate())
            .toString())){

          Map data = IncomeExpenseMonthList[monthList.indexOf(DateFormat('MMM,yyyy')
              .format(monthlyExpenseReports[i]['date'].toDate())
              .toString())];
          double expAmount = double.tryParse(data['expAmount'].toString())??0;
          expAmount += monthlyExpenseReports[i]['amount'];
          data['expAmount'] = expAmount;
          IncomeExpenseMonthList.removeAt(monthList.indexOf(DateFormat('MMM,yyyy')
              .format(monthlyExpenseReports[i]['date'].toDate())
              .toString()));
          IncomeExpenseMonthList.insert(monthList.indexOf(DateFormat('MMM,yyyy')
              .format(monthlyExpenseReports[i]['date'].toDate())
              .toString()),data);
        }else{
          monthList.add(DateFormat('MMM,yyyy')
              .format(monthlyExpenseReports[i]['date'].toDate())
              .toString());
          IncomeExpenseMonthList.add({
            'date': monthlyExpenseReports[i]['date'],
            'expAmount': monthlyExpenseReports[i]['amount'],
            'incAmount': 0.00,
          });
        }

      }


      if(mounted){
        setState(() {

        });
      }
    });
  }
  double totalIncome=0.00;
  List dateIncomeReports=[];
  List dateIncome=[];
  getCategoryWiseIncomeByDate(){
    FirebaseFirestore.instance.collection('users').doc(currentuserid).collection('incomes').
    orderBy('date',descending: true).  where('date',isGreaterThanOrEqualTo:fromDate).
    where('date',isLessThanOrEqualTo:DateTime(toDate!.year,toDate!.month,toDate!.day,23,59,59)).snapshots().listen((event) {
      if(event.docs.isNotEmpty) {
        totalIncome=0.00;
        dateIncomeReports=[];
        dateIncome=[];
        for (DocumentSnapshot data in event.docs) {
          totalIncome+=double.tryParse(data['amount'].toString())??0;
          if(dateIncome.contains(data['categoryName'])){
            Map item=dateIncomeReports[dateIncome.indexOf(data['categoryName'])].data();
            double amount=item['amount'];
            amount+=data['amount'];
            item['amount']=amount;
            dateIncomeReports.removeAt(dateIncome.indexOf(data['categoryName']));
            dateIncomeReports.insert(dateIncome.indexOf(data['categoryName']), item);
          }else{
            dateIncome.add(data['categoryName']);
            dateIncomeReports.add(data);
          }


        }

      }
      ExpenseIncomeList.addAll(dateIncomeReports);
      SortList();
      if(mounted){
        setState(() {

        });
      }
    });
  }
  List monthlyIncomeReports=[];
  List months=[];
  getMonthWiseIncomesByDate(){
    FirebaseFirestore.instance.collection('users').doc(currentuserid).collection('incomes').
    where('date',isGreaterThanOrEqualTo:fromDate).
    where('date',isLessThanOrEqualTo:DateTime(toDate!.year,toDate!.month,toDate!.day,23,59,59)).
    snapshots().listen((event) {
      if(event.docs.isNotEmpty) {
        months=[];
        monthlyIncomeReports=[];
        for (DocumentSnapshot data in event.docs) {
          if(months.contains(data['date'].toDate().toString().substring(0,7))){
            Map<String,dynamic> item=monthlyIncomeReports[months.indexOf(data['date'].toDate().toString().substring(0,7))];
            double amount=item['amount'];
            amount+=data['amount'];
            item['amount']=amount;
            // expenseList.removeAt(expenseCategory.indexOf(data['date'].toDate().toString().substring(5,7)));
            // expenseList.insert(expenseCategory.indexOf(data['date'].toDate().toString().substring(5,7)), item);
            monthlyIncomeReports.removeAt(months.indexOf(data['date'].toDate().toString().substring(0,7)));
            monthlyIncomeReports.insert(months.indexOf(data['date'].toDate().toString().substring(0,7)), item);

          }else{
            // expenseCategory.add(data['date'].toDate().toString().substring(5,7));
            // expenseList.add(data);
            months.add(data['date'].toDate().toString().substring(0,7));
            monthlyIncomeReports.add({
              'date':data['date'],
              'amount':data['amount']
            });
          }


        }

      }
      for(int i=0;i<monthlyIncomeReports.length;i++){
        if(monthList.contains(DateFormat('MMM,yyyy')
            .format(monthlyIncomeReports[i]['date'].toDate())
            .toString())){

          Map data = IncomeExpenseMonthList[monthList.indexOf(DateFormat('MMM,yyyy')
              .format(monthlyIncomeReports[i]['date'].toDate())
              .toString())];
          double incAmount = data['incAmount'];
          incAmount += monthlyIncomeReports[i]['amount'];
          data['incAmount'] = incAmount;
          IncomeExpenseMonthList.removeAt(monthList.indexOf(DateFormat('MMM,yyyy')
              .format(monthlyIncomeReports[i]['date'].toDate())
              .toString()));
          IncomeExpenseMonthList.insert(monthList.indexOf(DateFormat('MMM,yyyy')
              .format(monthlyIncomeReports[i]['date'].toDate())
              .toString()),data);
        }else{
          monthList.add(DateFormat('MMM,yyyy')
              .format(monthlyIncomeReports[i]['date'].toDate())
              .toString());
          IncomeExpenseMonthList.add({
            'date': monthlyIncomeReports[i]['date'],
            'expAmount': 0.00,
            'incAmount': monthlyIncomeReports[i]['amount'],
          });
        }

      }

      if(mounted){
        setState(() {

        });
      }
    });
  }
  SortList(){
    ExpenseIncomeList.sort((a,b)=>b['date'].microsecondsSinceEpoch.compareTo(a['date'].microsecondsSinceEpoch));
    IncomeExpenseMonthList.sort((a,b)=>b['date'].microsecondsSinceEpoch.compareTo(a['date'].microsecondsSinceEpoch));
  }
  @override
  void initState() {

    fromDate=widget.fromDate;
    toDate=widget.toDate;

    getCategoryWiseExpenseByDate();
    getCategoryWiseIncomeByDate();
    // TODO: implement initState
    super.initState();
  }
  @override
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
                                    getMonthWiseIncomesByDate();
                                  }else{
                                    getCategoryWiseExpenseByDate();
                                    getCategoryWiseIncomeByDate();

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



                          ),

                        ],
                      ),
                    ),
                  ),

                ),

                Container(
                  height: scrWidth*1.5,
                  child:selectedCategory==categryItems[0]?
                  ExpenseIncomeList.length==0?Container(
                    child:Center(
                      child: Text(
                        "No List found",
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                  ):
                  Padding(
                    padding:  EdgeInsets.only(top: scrWidth*0.2,left:scrWidth*0.025,right: scrWidth*0.025 ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,

                      child: SingleChildScrollView(
                        child: DataTable(
                          dataRowHeight: 47,
                          headingRowHeight: 40,
                          horizontalMargin: 0,
                          dividerThickness: 2,
                          columnSpacing: 10,
                          showBottomBorder: true,
                          columns: [
                            DataColumn(
                              label: Text("DATE",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13),),
                            ),
                            // DataColumn(
                            //   label: Text("Image",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13)),
                            // ),
                            DataColumn(
                              label: Text("PARTICULARS",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13)),
                            ),
                            DataColumn(
                              label: Text("EXPENSE",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13)),
                            ),
                            DataColumn(
                              label: Text("INCOME",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13)),
                            ),
                          ],
                          rows: List.generate(
                            ExpenseIncomeList!.length,
                                (index) {
                              // icons=deserializeIcon(expenseList![index]['categoryIcon']);
                              // _icon = Icon(icons,size: 30,color: Colors.white,);
                              var item=ExpenseIncomeList[index];
                              return DataRow(
                                cells: [
                                  DataCell(Container(
                                    width: MediaQuery.of(context).size.width*0.25,
                                    child:Text(DateFormat('dd MMM,yyyy').format( ExpenseIncomeList[index]['date'].toDate()),style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: 'Urbanist',
                                        color: Colors.grey
                                    ),),
                                  )),
                                  // DataCell(Text(data.length.toString())),
                                  // DataCell(Padding(
                                  //   padding: const EdgeInsets.only(left: 16),
                                  //   child: Text((index+1).toString()??''),
                                  // )),
                                  // DataCell(Padding(
                                  //   padding: const EdgeInsets.only(left: 8.0),
                                  //   child: Container(
                                  //     height: MediaQuery.of(context).size.height*0.07,
                                  //     width: MediaQuery.of(context).size.width*0.05,
                                  //     decoration: BoxDecoration(
                                  //         image: DecorationImage(
                                  //           image: NetworkImage(item['image'],),
                                  //           fit: BoxFit.contain,
                                  //         )
                                  //     ),
                                  //   ),
                                  // ),),
                                  // DataCell(Container(
                                  //   width: MediaQuery.of(context).size.width*0.25,
                                  //   child:Text(DateFormat('dd MMM,yyyy').format( IncomeExpenseList[index]['date'].toDate()),style: TextStyle(
                                  //       fontSize: 13,
                                  //       fontFamily: 'Urbanist',
                                  //       color: Colors.grey
                                  //   ),),
                                  // )),
                                  DataCell(Container(
                                    width: MediaQuery.of(context).size.width*0.25,
                                    child: Text(ExpenseIncomeList[index]['categoryName'].toString(),style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Urbanist',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700
                                    ),),
                                  )),
                                  DataCell(
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child:ExpenseIncomeList[index]['income']==false?
                                        Text('-'+ExpenseIncomeList[index]['amount'].toString(),
                                          style: TextStyle(fontSize: 13,
                                              fontFamily: 'Urbanist',
                                              color: Colors.red

                                          ),

                                        ):
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Text(0.toString(),
                                            style: TextStyle(fontSize: 13,
                                                fontFamily: 'Urbanist',
                                                color: Colors.red

                                            ),

                                          ),
                                        ),
                                      )
                                  ),
                                  DataCell(
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child:ExpenseIncomeList[index]['income']==true?
                                        Text('+'+ExpenseIncomeList[index]['amount'].toString(),
                                          style: TextStyle(fontSize: 13,
                                              fontFamily: 'Urbanist',
                                              color: Colors.green

                                          ),

                                        ):
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Text(0.toString(),
                                            style: TextStyle(fontSize: 13,
                                                fontFamily: 'Urbanist',
                                                color: Colors.green

                                            ),

                                          ),
                                        ),
                                      )
                                  ),
                                  // DataCell(Text(brandName[data[index]['brandId']]??'')),

                                  // DataCell(Text(fileInfo.size)),
                                ],
                              );
                            },
                          ),





                        ),
                      ),

                    ),
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
                      :selectedCategory==categryItems[1]?ExpenseIncomeList.length==0?Container(
                    child:Center(
                      child: Text(
                        "No List found",
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                  ):Padding(
                    padding:  EdgeInsets.only(top: scrWidth*0.2),
                    child: Column(
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(left: scrWidth*0.08,right:  scrWidth*0.08,),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [

                              Text('Month'.toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Urbanist',
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                ),),
                              Text('Expense'.toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Urbanist',
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold

                                ),),

                              Text('Income'.toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Urbanist',
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold

                                ),),

                            ],
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left: scrWidth*0.06,right:  scrWidth*0.06,bottom: 10),
                          child: Container(child: Divider(thickness: 0.5,color: Colors.grey,)),
                        ),
                        Container(
                          child:  ListView.builder(
                            itemCount: IncomeExpenseMonthList.length,
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


                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [

                                              Text(DateFormat('MMM,yyyy').format(IncomeExpenseMonthList[index]['date'].toDate()).toString(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'Urbanist',
                                                    color: Colors.black
                                                ),),

                                              Text('-'+
                                                  IncomeExpenseMonthList[index]['expAmount'].toString(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'Urbanist',
                                                    color: Colors.red
                                                ),),
                                              Text('-'+IncomeExpenseMonthList[index]['incAmount'].toString(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'Urbanist',
                                                    color: Colors.green
                                                ),),

                                              // Text(DateFormat('dd MMM,yyyy').format( expenseList[index]['date'].toDate()),style: TextStyle(
                                              //     fontSize: 13,
                                              //     fontFamily: 'Urbanist',
                                              //     color: Colors.grey
                                              // ),),

                                            ],
                                          ),
                                          Padding(
                                            padding:  EdgeInsets.only(left: scrWidth*0.02,right:  scrWidth*0.02,bottom: 10),
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
                      ],
                    ),
                  ):
                  ExpenseIncomeList.isEmpty?Container(
                    child:Center(
                      child: Text(
                        "No list found",
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                  ):
                  Padding(
                    padding:  EdgeInsets.only(top: scrWidth*0.2,left:scrWidth*0.025,right: scrWidth*0.025 ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,

                      child: SingleChildScrollView(
                        child: DataTable(
                          dataRowHeight: 47,
                          headingRowHeight: 40,
                          horizontalMargin: 0,
                          dividerThickness: 2,
                          columnSpacing: 10,
                          showBottomBorder: true,
                          columns: [
                            DataColumn(
                              label: Text("DATE",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13),),
                            ),
                            // DataColumn(
                            //   label: Text("Image",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13)),
                            // ),
                            DataColumn(
                              label: Text("PARTICULARS",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13)),
                            ),
                            DataColumn(
                              label: Text("EXPENSE",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13)),
                            ),
                            DataColumn(
                              label: Text("INCOME",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13)),
                            ),
                          ],
                          rows: List.generate(
                            ExpenseIncomeList!.length,
                                (index) {
                              // icons=deserializeIcon(expenseList![index]['categoryIcon']);
                              // _icon = Icon(icons,size: 30,color: Colors.white,);
                              var item=ExpenseIncomeList[index];
                              return DataRow(
                                cells: [
                                  // DataCell(Text(data.length.toString())),
                                  // DataCell(Padding(
                                  //   padding: const EdgeInsets.only(left: 16),
                                  //   child: Text((index+1).toString()??''),
                                  // )),
                                  // DataCell(Padding(
                                  //   padding: const EdgeInsets.only(left: 8.0),
                                  //   child: Container(
                                  //     height: MediaQuery.of(context).size.height*0.07,
                                  //     width: MediaQuery.of(context).size.width*0.05,
                                  //     decoration: BoxDecoration(
                                  //         image: DecorationImage(
                                  //           image: NetworkImage(item['image'],),
                                  //           fit: BoxFit.contain,
                                  //         )
                                  //     ),
                                  //   ),
                                  // ),),
                                  DataCell(Container(
                                    width: MediaQuery.of(context).size.width*0.25,
                                    child:Text(DateFormat('dd MMM,yyyy').format( ExpenseIncomeList[index]['date'].toDate()),style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: 'Urbanist',
                                        color: Colors.grey
                                    ),),
                                  )),
                                  DataCell(Container(
                                    width: MediaQuery.of(context).size.width*0.25,
                                    child: Text(ExpenseIncomeList[index]['categoryName'].toString(),style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Urbanist',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700
                                    ),),
                                  )),
                                  DataCell(
                                      ExpenseIncomeList[index]['income']==false?
                                      Text('-'+ExpenseIncomeList[index]['amount'].toString(),
                                        style: TextStyle(fontSize: 13,
                                            fontFamily: 'Urbanist',
                                            color: Colors.red

                                        ),

                                      ):
                                      Text(0.toString(),
                                        style: TextStyle(fontSize: 13,
                                            fontFamily: 'Urbanist',
                                            color: Colors.red

                                        ),

                                      )
                                  ),
                                  DataCell(
                                      ExpenseIncomeList[index]['income']==true?
                                      Text('+'+ExpenseIncomeList[index]['amount'].toString(),
                                        style: TextStyle(fontSize: 13,
                                            fontFamily: 'Urbanist',
                                            color: Colors.green

                                        ),

                                      ):
                                      Text(0.toString(),
                                        style: TextStyle(fontSize: 13,
                                            fontFamily: 'Urbanist',
                                            color: Colors.green

                                        ),

                                      )
                                  ),
                                  // DataCell(Text(brandName[data[index]['brandId']]??'')),

                                  // DataCell(Text(fileInfo.size)),
                                ],
                              );
                            },
                          ),
                        ),
                      ),

                    ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Total Expense:",
                                style: TextStyle(
                                    fontSize: scrWidth*0.03,
                                    color: Colors.black,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w800),
                              ),
                              Text(
                                " ₹"+totalExpense.toString(),
                                style: TextStyle(
                                    fontSize: scrWidth*0.05,
                                    color: Colors.red,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w800),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "Total Income:",
                                style: TextStyle(
                                    fontSize: scrWidth*0.03,
                                    color: Colors.black,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w800),
                              ),
                              Text(
                                " ₹"+totalIncome.toString(),
                                style: TextStyle(
                                    fontSize: scrWidth*0.05,
                                    color: Colors.green,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w800),
                              ),
                            ],
                          ),
                        ],
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
