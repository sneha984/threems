import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/Serialization/iconDataSerialization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../Authentication/root.dart';
import '../Expenses/Expense_first_page.dart';
import '../Expenses/Report/ExpenseReportByYear.dart';
import '../customPackage/date_picker.dart';
import '../screens/charity/verification_details.dart';
import '../screens/splash_screen.dart';
import '../utils/themes.dart';
import 'IncomeExpenseReportBydate.dart';

class IncomeExpenseYearReport extends StatefulWidget {
  const IncomeExpenseYearReport({Key? key}) : super(key: key);

  @override
  State<IncomeExpenseYearReport> createState() =>
      _IncomeExpenseYearReportState();
}

class _IncomeExpenseYearReportState extends State<IncomeExpenseYearReport> {
  Icon? _icon;
  var icons;
  String catName = '';
  List IncomeExpenseList = [];
  List IncomeExpenseMonthList = [];
  List expenseList = [];
  List categoryNameList = [];
  List singleCategoryList = [];
  String? selectedValue;
  String? selectedCategory;
  List expenseCategory = [];
  double totalExpense = 0.00;
  double amount = 0.00;
  getYearwiseCategoryExpenses() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentuserid)
        .collection('expense')
        .orderBy('date', descending: true)
        .snapshots()
        .listen((event) {
      IncomeExpenseList = [];
      if (event.docs.isNotEmpty) {
        totalExpense = 0.00;
        expenseList = [];
        expenseCategory = [];
        for (DocumentSnapshot data in event.docs) {
          totalExpense += double.tryParse(data['amount'].toString()) ?? 0;
          if (expenseCategory.contains(data['categoryName'])) {
            Map item =
                expenseList[expenseCategory.indexOf(data['categoryName'])]
                    .data();
            double amount = item['amount'];
            amount += data['amount'];
            item['amount'] = amount;
            expenseList.removeAt(expenseCategory.indexOf(data['categoryName']));
            expenseList.insert(
                expenseCategory.indexOf(data['categoryName']), item);
          } else {
            expenseCategory.add(data['categoryName']);
            expenseList.add(data);
          }
        }
      }
      IncomeExpenseList.addAll(expenseList);

      if (mounted) {
        setState(() {});
      }
    });
  }

  List monthlyExpenseReports = [];
  List monthsExpenseList = [];
  List monthList = [];
  getYearMonthExpenses() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentuserid)
        .collection('expense')
        .snapshots()
        .listen((event) {
      IncomeExpenseMonthList = [];
      if (event.docs.isNotEmpty) {
        monthsExpenseList = [];
        monthlyExpenseReports = [];
        for (DocumentSnapshot data in event.docs) {
          if (monthsExpenseList
              .contains(data['date'].toDate().toString().substring(0, 7))) {
            Map<String, dynamic> item = monthlyExpenseReports[monthsExpenseList
                .indexOf(data['date'].toDate().toString().substring(0, 7))];
            double amount = item['amount'];
            amount += data['amount'];
            item['amount'] = amount;
            // expenseList.removeAt(expenseCategory.indexOf(data['date'].toDate().toString().substring(5,7)));
            // expenseList.insert(expenseCategory.indexOf(data['date'].toDate().toString().substring(5,7)), item);
            monthlyExpenseReports.removeAt(monthsExpenseList
                .indexOf(data['date'].toDate().toString().substring(0, 7)));
            monthlyExpenseReports.insert(
                monthsExpenseList
                    .indexOf(data['date'].toDate().toString().substring(0, 7)),
                item);
          } else {
            // expenseCategory.add(data['date'].toDate().toString().substring(5,7));
            // expenseList.add(data);
            monthsExpenseList
                .add(data['date'].toDate().toString().substring(0, 7));
            monthlyExpenseReports.add({
              'date': data['date'],
              'amount': data['amount'],
              'income': data['income']
            });
          }
        }
      }

      for (int i = 0; i < monthlyExpenseReports.length; i++) {
        if (monthList.contains(DateFormat('MMM,yyyy')
            .format(monthlyExpenseReports[i]['date'].toDate())
            .toString())) {
          Map data = IncomeExpenseMonthList[monthList.indexOf(
              DateFormat('MMM,yyyy')
                  .format(monthlyExpenseReports[i]['date'].toDate())
                  .toString())];
          double expAmount = data['expAmount'];
          expAmount += monthlyExpenseReports[i]['amount'];
          data[expAmount] = expAmount;
          IncomeExpenseMonthList.removeAt(monthList.indexOf(
              DateFormat('MMM,yyyy')
                  .format(monthlyExpenseReports[i]['date'].toDate())
                  .toString()));
          IncomeExpenseMonthList.insert(
              monthList.indexOf(DateFormat('MMM,yyyy')
                  .format(monthlyExpenseReports[i]['date'].toDate())
                  .toString()),
              data);
        } else {
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

      if (mounted) {
        setState(() {});
      }
    });
  }

  List incomeList = [];
  List kk = [];
  List incomeCategory = [];
  double totalIncome = 0.00;
  getYearwiseCategoryIncome() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentuserid)
        .collection('incomes')
        .snapshots()
        .listen((event) {
      if (event.docs.isNotEmpty) {
        totalIncome = 0.00;
        incomeList = [];
        incomeCategory = [];
        for (DocumentSnapshot data in event.docs) {
          totalIncome += double.tryParse(data['amount'].toString()) ?? 0;
          if (incomeCategory.contains(data['categoryName'])) {
            print('yes');
            print(data['categoryName']);
            // Map <String,dynamic>item=incomeList[incomeCategory.indexOf(data['IncomeCategoryName'])];
            Map item =
                incomeList[incomeCategory.indexOf(data['categoryName'])].data();
            print(item);
            double amount = item['amount'];
            amount += data['amount'];
            item['amount'] = amount;
            incomeList.removeAt(incomeCategory.indexOf(data['categoryName']));
            incomeList.insert(
                incomeCategory.indexOf(data['categoryName']), item);
          } else {
            incomeCategory.add(data['categoryName']);
            incomeList.add(data);
          }
        }
      }
      IncomeExpenseList.addAll(incomeList);

      sortList();

      if (mounted) {
        setState(() {});
      }
    });
  }

  List monthlyIncomeReports = [];
  List monthIncomeList = [];
  getYearMonthIncomes() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentuserid)
        .collection('incomes')
        .snapshots()
        .listen((event) {
      if (event.docs.isNotEmpty) {
        monthIncomeList = [];
        monthlyIncomeReports = [];
        for (DocumentSnapshot data in event.docs) {
          if (monthIncomeList
              .contains(data['date'].toDate().toString().substring(0, 7))) {
            Map<String, dynamic> item = monthlyIncomeReports[monthIncomeList
                .indexOf(data['date'].toDate().toString().substring(0, 7))];
            double amount = item['amount'];
            amount += data['amount'];
            item['amount'] = amount;
            // expenseList.removeAt(expenseCategory.indexOf(data['date'].toDate().toString().substring(5,7)));
            // expenseList.insert(expenseCategory.indexOf(data['date'].toDate().toString().substring(5,7)), item);
            monthlyIncomeReports.removeAt(monthIncomeList
                .indexOf(data['date'].toDate().toString().substring(0, 7)));
            monthlyIncomeReports.insert(
                monthIncomeList
                    .indexOf(data['date'].toDate().toString().substring(0, 7)),
                item);
          } else {
            // expenseCategory.add(data['date'].toDate().toString().substring(5,7));
            // expenseList.add(data);
            monthIncomeList
                .add(data['date'].toDate().toString().substring(0, 7));
            monthlyIncomeReports.add({
              'date': data['date'],
              'amount': data['amount'],
              'income': data['income']
            });
          }
        }
      }
      for (int i = 0; i < monthlyIncomeReports.length; i++) {
        if (monthList.contains(DateFormat('MMM,yyyy')
            .format(monthlyIncomeReports[i]['date'].toDate())
            .toString())) {
          Map data = IncomeExpenseMonthList[monthList.indexOf(
              DateFormat('MMM,yyyy')
                  .format(monthlyIncomeReports[i]['date'].toDate())
                  .toString())];
          double incAmount = data['incAmount'];
          incAmount += monthlyIncomeReports[i]['amount'];
          data['incAmount'] = incAmount;
          IncomeExpenseMonthList.removeAt(monthList.indexOf(
              DateFormat('MMM,yyyy')
                  .format(monthlyIncomeReports[i]['date'].toDate())
                  .toString()));
          IncomeExpenseMonthList.insert(
              monthList.indexOf(DateFormat('MMM,yyyy')
                  .format(monthlyIncomeReports[i]['date'].toDate())
                  .toString()),
              data);
        } else {
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
      // for(int i=0;i<monthlyIncomeReports.length;i++){
      //   bool contains=false;
      //   if(IncomeExpenseMonthList.isNotEmpty){
      //     for (var map in IncomeExpenseMonthList) {
      //       if (map?.containsKey("date")) {
      //         if (DateFormat('MMM,yyyy')
      //                 .format(map['date'].toDate())
      //                 .toString() !=
      //             DateFormat('MMM,yyyy')
      //                 .format(monthlyIncomeReports[i]['date'].toDate())
      //                 .toString()) {
      //           IncomeExpenseMonthList.add({
      //             'date': monthlyIncomeReports[i]['date'],
      //             'expAmount': 0.00,
      //             'incAmount': monthlyIncomeReports[i]['amount'],
      //             'income': false,
      //           });
      //         }
      //       } else {
      //         int index = IncomeExpenseMonthList.indexOf(map);
      //         Map data = map;
      //         double incAmount = data['incAmount'];
      //         incAmount += monthlyIncomeReports[i]['amount'];
      //         data[incAmount] = incAmount;
      //         IncomeExpenseMonthList.removeAt(index);
      //         IncomeExpenseMonthList.add(data);
      //       }
      //     }
      //   }else{
      //     IncomeExpenseMonthList.add({
      //       'date': monthlyIncomeReports[i]['date'],
      //       'expAmount': 0.00,
      //       'incAmount': monthlyIncomeReports[i]['amount'],
      //       'income': false,
      //     });
      //   }
      // }
      //IncomeExpenseMonthList.addAll(monthlyIncomeReports);

      sortList();

      if (mounted) {
        setState(() {});
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

  sortList() {
    IncomeExpenseList.sort((a, b) => b['date']
        .microsecondsSinceEpoch
        .compareTo(a['date'].microsecondsSinceEpoch));
    IncomeExpenseMonthList.sort((a, b) => b['date']
        .microsecondsSinceEpoch
        .compareTo(a['date'].microsecondsSinceEpoch));
  }

  @override
  void initState() {
    // getCategoryName();
    getYearwiseCategoryExpenses();
    getYearwiseCategoryIncome();
    // getYearMonthExpenses();
    // fromDate=DateTime.now();
    // toDate=DateTime.now();
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
        elevation: 0.1,
        backgroundColor: tabBarColor,

        title: Text(
          " Reports",
          style: TextStyle(
              fontSize: scrWidth * 0.046,
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
                  height: scrWidth * 0.3,
                  color: tabBarColor,
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: scrWidth * 0.04,
                        right: scrWidth * 0.04,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            height: scrWidth * 0.09,
                            width: scrWidth * 0.37,
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
                                    if (selectedValue == 'Select Date') {
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
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            height: scrWidth * 0.09,
                            width: scrWidth * 0.38,
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
                                        color: primarycolor),
                                  ),
                                ),
                                items: categryItems
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Center(
                                            child: Text(
                                              item.toString(),
                                              overflow: TextOverflow.ellipsis,
                                              // overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18,
                                                  fontFamily: 'Urbanist'),
                                              maxLines: 2,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                value: selectedCategory,
                                onChanged: (value) async {
                                  setState(() {
                                    selectedCategory = value;
                                    // getCategoryBasedExpense();
                                  });
                                  if (selectedCategory == categryItems[1]) {
                                    IncomeExpenseMonthList = [];
                                    monthList = [];
                                    getYearMonthExpenses();
                                    getYearMonthIncomes();
                                  } else {
                                    getYearwiseCategoryExpenses();
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
                        ],
                      ),
                    ),
                  ),
                ),

                // Container(
                //   height: scrWidth*1.5,
                //   child:selectedCategory==categryItems[0]?
                //   IncomeExpenseList.length==0?Container(
                //     child:Center(
                //       child: Text(
                //         "No expenses under this Category",
                //         style: TextStyle(
                //             fontSize: 15,
                //             fontFamily: 'Urbanist',
                //             fontWeight: FontWeight.w600,
                //             color: Colors.black),
                //       ),
                //     ),
                //   ):
                //
                //   Padding(
                //     padding:  EdgeInsets.only(top: scrWidth*0.2,left:scrWidth*0.03,right: scrWidth*0.03 ),
                //     child: Container(
                //       width: MediaQuery.of(context).size.width,
                //       // decoration: BoxDecoration(
                //       //     border: Border.all()
                //       // ),
                //       child: SingleChildScrollView(
                //         child: DataTable(
                //
                //           dataRowHeight: 47,
                //           headingRowHeight: 40,
                //           horizontalMargin: 0,
                //           dividerThickness: 2,
                //           columnSpacing: 10,
                //           showBottomBorder: true,
                //           columns: [
                //             DataColumn(
                //               label: Padding(
                //                 padding: const EdgeInsets.only(left: 8.0),
                //                 child: Text("DATE",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13),),
                //               ),
                //             ),
                //             // DataColumn(
                //             //   label: Text("Image",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13)),
                //             // ),
                //             DataColumn(
                //               label: Text("PARTICULARS",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13)),
                //             ),
                //             DataColumn(
                //               label: Text("AMOUNT",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13)),
                //             ),
                //           ],
                //           rows: List.generate(
                //
                //             IncomeExpenseList!.length,
                //                 (index) {
                //                   // icons=deserializeIcon(IncomeExpenseList![index]['categoryIcon']);
                //                   // _icon = Icon(icons,size: 30,color: Colors.white,);
                //               var item=IncomeExpenseList[index];
                //               return DataRow(
                //                 cells: [
                //                   // DataCell(Text(data.length.toString())),
                //                   // DataCell(Padding(
                //                   //   padding: const EdgeInsets.only(left: 16),
                //                   //   child: Text((index+1).toString()??''),
                //                   // )),
                //                   // DataCell(Padding(
                //                   //   padding: const EdgeInsets.only(left: 8.0),
                //                   //   child: Container(
                //                   //     height: MediaQuery.of(context).size.height*0.07,
                //                   //     width: MediaQuery.of(context).size.width*0.05,
                //                   //     decoration: BoxDecoration(
                //                   //         image: DecorationImage(
                //                   //           image: NetworkImage(item['image'],),
                //                   //           fit: BoxFit.contain,
                //                   //         )
                //                   //     ),
                //                   //   ),
                //                   // ),),
                //                   DataCell(Container(
                //                       width: MediaQuery.of(context).size.width*0.25,
                //                       child:Text(DateFormat('dd MMM,yyyy').format( IncomeExpenseList[index]['date'].toDate()),style: TextStyle(
                //                         fontSize: 13,
                //                         fontFamily: 'Urbanist',
                //                         color: Colors.grey
                //                     ),),
                //                   )),
                //                   DataCell(Container(
                //                       width: MediaQuery.of(context).size.width*0.25,
                //                       child: Text(IncomeExpenseList[index]['categoryName'].toString(),style: TextStyle(
                //                           fontSize: 16,
                //                           fontFamily: 'Urbanist',
                //                           color: Colors.black,
                //                           fontWeight: FontWeight.w700
                //                       ),),
                //                   )),
                //                   DataCell(
                //                       Padding(
                //                         padding: const EdgeInsets.only(left: 8.0),
                //                         child:IncomeExpenseList[index]['income']==true?
                //                         Text('+'+IncomeExpenseList[index]['amount'].toString(),
                //                             style: TextStyle(fontSize: 13,
                //                               fontFamily: 'Urbanist',
                //                               color: Colors.green
                //
                //                             ),
                //
                //                         ):
                //                         Text('-'+IncomeExpenseList[index]['amount'].toString(),
                //                             style: TextStyle(fontSize: 13,
                //                               fontFamily: 'Urbanist',
                //                               color: Colors.red
                //
                //                             ),
                //
                //                         ),
                //                       )
                //                   ),
                //                   // DataCell(Text(brandName[data[index]['brandId']]??'')),
                //
                //                   // DataCell(Text(fileInfo.size)),
                //                 ],
                //               );
                //             },
                //           ),
                //         ),
                //       ),
                //
                //     ),
                //   )
                //   // ListView.builder(
                //   //     itemCount: expenseList!.length,
                //   //     shrinkWrap: true,
                //   //     padding: EdgeInsets.only(top: scrWidth*0.2),
                //   //     scrollDirection: Axis.vertical,
                //   //     physics: BouncingScrollPhysics(),
                //   //     itemBuilder: (context,index) {
                //   //       icons=deserializeIcon(expenseList![index]['categoryIcon']);
                //   //       _icon = Icon(icons,size: 30,color: Colors.white,);
                //   //       return Column(
                //   //         children: [
                //   //           Padding(
                //   //             padding:  EdgeInsets.only(left: scrWidth*0.08,right:  scrWidth*0.08),
                //   //             child: Container(
                //   //               height: scrWidth*0.11,
                //   //               child: Row(
                //   //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   //                 children: [
                //   //                   Row(
                //   //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   //                     crossAxisAlignment: CrossAxisAlignment.center,
                //   //                     children: [
                //   //                       CircleAvatar(
                //   //                         radius: 22,
                //   //                         backgroundColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                //   //                         child: _icon ,
                //   //                       ),
                //   //                       // Container(
                //   //                       //   height: 100,
                //   //                       //   decoration: BoxDecoration(
                //   //                       //       color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                //   //                       //       shape: BoxShape.circle
                //   //                       //   ),
                //   //                       //   child: _icon,
                //   //                       // ),
                //   //                       SizedBox(width: scrWidth*0.02,),
                //   //                       Center(
                //   //                         child: Text(expenseList[index]['categoryName'].toString(),style: TextStyle(
                //   //                             fontSize: 16,
                //   //                             fontFamily: 'Urbanist',
                //   //                             color: Colors.black,
                //   //                             fontWeight: FontWeight.w700
                //   //                         ),),
                //   //                       ),
                //   //
                //   //                       // Text(DateFormat('dd MMM,yyyy').format( expenseList[index]['date'].toDate()),style: TextStyle(
                //   //                       //     fontSize: 13,
                //   //                       //     fontFamily: 'Urbanist',
                //   //                       //     color: Colors.grey
                //   //                       // ),),
                //   //
                //   //                     ],
                //   //                   ),
                //   //                   Column(
                //   //                     mainAxisAlignment: MainAxisAlignment.center,
                //   //                     crossAxisAlignment: CrossAxisAlignment.center,
                //   //                     children: [
                //   //                       Text('₹ '+expenseList[index]['amount'].toString(),style: TextStyle(
                //   //                           fontSize: 17,
                //   //                           fontFamily: 'Urbanist',
                //   //                           color: Colors.black,
                //   //                           fontWeight: FontWeight.w700
                //   //                       ),),
                //   //
                //   //                     ],
                //   //                   ),
                //   //                 ],
                //   //               ),
                //   //             ),
                //   //           ),
                //   //           Padding(
                //   //             padding:  EdgeInsets.only(left: scrWidth*0.08,right:  scrWidth*0.08,bottom: 10),
                //   //             child: Container(child: Divider(thickness: 0.5,color: Colors.grey,)),
                //   //           ),
                //   //
                //   //         ],
                //   //       );
                //   //     }
                //   //
                //   // )
                //   // ListView.builder(
                //   //     itemCount: singleCategoryList!.length,
                //   //     shrinkWrap: true,
                //   //     padding: EdgeInsets.only(top: scrWidth*0.2),
                //   //     scrollDirection: Axis.vertical,
                //   //     physics: BouncingScrollPhysics(),
                //   //     itemBuilder: (context,index) {
                //   //       icons=deserializeIcon(singleCategoryList![index]['categoryIcon']);
                //   //       _icon = Icon(icons,size: 30,color: Colors.white,);
                //   //       return Column(
                //   //         children: [
                //   //           Padding(
                //   //             padding:  EdgeInsets.only(left: scrWidth*0.08,right:  scrWidth*0.08),
                //   //             child: Container(
                //   //               height: scrWidth*0.11,
                //   //               child: Row(
                //   //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   //                 children: [
                //   //                   Row(
                //   //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   //                     crossAxisAlignment: CrossAxisAlignment.center,
                //   //                     children: [
                //   //                       CircleAvatar(
                //   //                         radius: 22,
                //   //                         backgroundColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                //   //                         child: _icon ,
                //   //                       ),
                //   //                       // Container(
                //   //                       //   height: 100,
                //   //                       //   decoration: BoxDecoration(
                //   //                       //       color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                //   //                       //       shape: BoxShape.circle
                //   //                       //   ),
                //   //                       //   child: _icon,
                //   //                       // ),
                //   //                       SizedBox(width: scrWidth*0.02,),
                //   //                       Center(
                //   //                         child: Text(singleCategoryList[index]['categoryName'].toString(),style: TextStyle(
                //   //                             fontSize: 16,
                //   //                             fontFamily: 'Urbanist',
                //   //                             color: Colors.black,
                //   //                             fontWeight: FontWeight.w700
                //   //                         ),),
                //   //                       ),
                //   //
                //   //                       // Text(DateFormat('dd MMM,yyyy').format( expenseList[index]['date'].toDate()),style: TextStyle(
                //   //                       //     fontSize: 13,
                //   //                       //     fontFamily: 'Urbanist',
                //   //                       //     color: Colors.grey
                //   //                       // ),),
                //   //
                //   //                     ],
                //   //                   ),
                //   //                   Column(
                //   //                     mainAxisAlignment: MainAxisAlignment.center,
                //   //                     crossAxisAlignment: CrossAxisAlignment.center,
                //   //                     children: [
                //   //                       Text('₹ '+amount.toString(),style: TextStyle(
                //   //                           fontSize: 17,
                //   //                           fontFamily: 'Urbanist',
                //   //                           color: Colors.black,
                //   //                           fontWeight: FontWeight.w700
                //   //                       ),),
                //   //
                //   //                     ],
                //   //                   ),
                //   //                 ],
                //   //               ),
                //   //             ),
                //   //           ),
                //   //           Padding(
                //   //             padding:  EdgeInsets.only(left: scrWidth*0.08,right:  scrWidth*0.08,bottom: 10),
                //   //             child: Container(child: Divider(thickness: 0.5,color: Colors.grey,)),
                //   //           ),
                //   //
                //   //         ],
                //   //       );
                //   //     }
                //   //
                //   // )
                //       :selectedCategory==categryItems[1]?Padding(
                //     padding:  EdgeInsets.only(top: scrWidth*0.2),
                //     child: Container(
                //       child: ListView.builder(
                //         itemCount: monthlyExpenseReports.length,
                //         shrinkWrap: true,
                //         itemBuilder: (context,index){
                //           return Column(
                //             children: [
                //               // Padding(
                //               //   padding: const EdgeInsets.only(top: 50),
                //               //   child: Text('${monthlyReports[index]['date'].toDate().toString().substring(0,10)},  :  ${monthlyReports[index]['amount']}'),
                //               // ),
                //               Padding(
                //                 padding:  EdgeInsets.only(left: scrWidth*0.08,right:  scrWidth*0.08,),
                //                 child: Container(
                //                   height: scrWidth*0.15,
                //                   child: Column(
                //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                     children: [
                //                       Row(
                //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                         crossAxisAlignment: CrossAxisAlignment.center,
                //                         children: [
                //
                //                           Text(DateFormat('MMM,yyyy').format(monthlyExpenseReports[index]['date'].toDate()),
                //                             style: TextStyle(
                //                                 fontSize: 18,
                //                                 fontFamily: 'Urbanist',
                //                                 color: Colors.black
                //                             ),),
                //                           SizedBox(width: scrWidth*0.02,),
                //                           Text(monthlyExpenseReports[index]['amount'].toString(),
                //                             style: TextStyle(
                //                                 fontSize: 18,
                //                                 fontFamily: 'Urbanist',
                //                                 color: Colors.black
                //                             ),),
                //
                //                           // Text(DateFormat('dd MMM,yyyy').format( expenseList[index]['date'].toDate()),style: TextStyle(
                //                           //     fontSize: 13,
                //                           //     fontFamily: 'Urbanist',
                //                           //     color: Colors.grey
                //                           // ),),
                //
                //                         ],
                //                       ),
                //                       Padding(
                //                         padding:  EdgeInsets.only(left: scrWidth*0.06,right:  scrWidth*0.06,bottom: 10),
                //                         child: Container(child: Divider(thickness: 0.5,color: Colors.grey,)),
                //                       ),
                //
                //
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //
                //             ],
                //           );
                //         },
                //       ),
                //     ),
                //   ):
                //   IncomeExpenseList.isEmpty?Container(
                //     child:Center(
                //       child: Text(
                //         "No expenses",
                //         style: TextStyle(
                //             fontSize: 15,
                //             fontFamily: 'Urbanist',
                //             fontWeight: FontWeight.w600,
                //             color: Colors.black),
                //       ),
                //     ),
                //   ):
                //   Padding(
                //     padding:  EdgeInsets.only(top: scrWidth*0.2,left:scrWidth*0.02,right: scrWidth*0.02 ),
                //     child: Container(
                //       width: MediaQuery.of(context).size.width,
                //
                //       child: SingleChildScrollView(
                //         child: DataTable(
                //           dataRowHeight: 47,
                //           headingRowHeight: 40,
                //           horizontalMargin: 0,
                //           dividerThickness: 2,
                //           columnSpacing: 10,
                //           showBottomBorder: true,
                //           columns: [
                //             DataColumn(
                //               label: Padding(
                //                 padding: const EdgeInsets.only(left: 8.0),
                //                 child: Text("DATE",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13),),
                //               ),
                //             ),
                //             // DataColumn(
                //             //   label: Text("Image",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13)),
                //             // ),
                //             DataColumn(
                //               label: Text("PARTICULARS",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13)),
                //             ),
                //             DataColumn(
                //               label: Text("AMOUNT",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13)),
                //             ),
                //           ],
                //           rows: List.generate(
                //             IncomeExpenseList!.length,
                //                 (index) {
                //               // icons=deserializeIcon(expenseList![index]['categoryIcon']);
                //               // _icon = Icon(icons,size: 30,color: Colors.white,);
                //               var item=IncomeExpenseList[index];
                //               return DataRow(
                //                 cells: [
                //                   // DataCell(Text(data.length.toString())),
                //                   // DataCell(Padding(
                //                   //   padding: const EdgeInsets.only(left: 16),
                //                   //   child: Text((index+1).toString()??''),
                //                   // )),
                //                   // DataCell(Padding(
                //                   //   padding: const EdgeInsets.only(left: 8.0),
                //                   //   child: Container(
                //                   //     height: MediaQuery.of(context).size.height*0.07,
                //                   //     width: MediaQuery.of(context).size.width*0.05,
                //                   //     decoration: BoxDecoration(
                //                   //         image: DecorationImage(
                //                   //           image: NetworkImage(item['image'],),
                //                   //           fit: BoxFit.contain,
                //                   //         )
                //                   //     ),
                //                   //   ),
                //                   // ),),
                //                   DataCell(Container(
                //                     width: MediaQuery.of(context).size.width*0.25,
                //                     child:Text(DateFormat('dd MMM,yyyy').format( IncomeExpenseList[index]['date'].toDate()),style: TextStyle(
                //                         fontSize: 13,
                //                         fontFamily: 'Urbanist',
                //                         color: Colors.grey
                //                     ),),
                //                   )),
                //                   DataCell(Container(
                //                     width: MediaQuery.of(context).size.width*0.25,
                //                     child: Text(IncomeExpenseList[index]['categoryName'].toString(),style: TextStyle(
                //                         fontSize: 16,
                //                         fontFamily: 'Urbanist',
                //                         color: Colors.black,
                //                         fontWeight: FontWeight.w700
                //                     ),),
                //                   )),
                //                   DataCell(
                //                       Padding(
                //                         padding: const EdgeInsets.only(left: 8.0),
                //                         child:IncomeExpenseList[index]['income']==true?
                //                         Text('+'+IncomeExpenseList[index]['amount'].toString(),
                //                           style: TextStyle(fontSize: 13,
                //                               fontFamily: 'Urbanist',
                //                               color: Colors.green
                //
                //                           ),
                //
                //                         ):
                //                         Text('-'+IncomeExpenseList[index]['amount'].toString(),
                //                           style: TextStyle(fontSize: 13,
                //                               fontFamily: 'Urbanist',
                //                               color: Colors.red
                //
                //                           ),
                //
                //                         ),
                //                       )
                //                   ),
                //                   // DataCell(Text(brandName[data[index]['brandId']]??'')),
                //
                //                   // DataCell(Text(fileInfo.size)),
                //                 ],
                //               );
                //             },
                //           ),
                //         ),
                //       ),
                //
                //     ),
                //   )
                //   ,
                // ),
                // SizedBox(height: scrWidth*0.05,)
                Container(
                  height: scrWidth * 1.5,
                  child: selectedCategory == categryItems[0]
                      ? IncomeExpenseList.length == 0
                          ? Container(
                              child: Center(
                                child: Text(
                                  "No detailes found",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.only(
                                  top: scrWidth * 0.2,
                                  left: scrWidth * 0.04,
                                  right: scrWidth * 0.01),
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
                                      // DataColumn(
                                      //   label: Padding(
                                      //     padding: const EdgeInsets.only(left: 8.0),
                                      //     child: Text("DATE",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13),),
                                      //   ),
                                      // ),
                                      // DataColumn(
                                      //   label: Text("Image",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13)),
                                      // ),
                                      DataColumn(
                                        label: Text("PARTICULARS",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13)),
                                      ),
                                      DataColumn(
                                        label: Text("EXPENSE",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13)),
                                      ),
                                      DataColumn(
                                        label: Text("INCOME",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13)),
                                      ),
                                    ],
                                    rows: List.generate(
                                      IncomeExpenseList!.length,
                                      (index) {
                                        // icons=deserializeIcon(expenseList![index]['categoryIcon']);
                                        // _icon = Icon(icons,size: 30,color: Colors.white,);
                                        var item = IncomeExpenseList[index];
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
                                            // DataCell(Container(
                                            //   width: MediaQuery.of(context).size.width*0.25,
                                            //   child:Text(DateFormat('dd MMM,yyyy').format( IncomeExpenseList[index]['date'].toDate()),style: TextStyle(
                                            //       fontSize: 13,
                                            //       fontFamily: 'Urbanist',
                                            //       color: Colors.grey
                                            //   ),),
                                            // )),
                                            DataCell(Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.25,
                                              child: Text(
                                                IncomeExpenseList[index]
                                                        ['categoryName']
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'Urbanist',
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            )),
                                            DataCell(Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: IncomeExpenseList[index]
                                                          ['income'] ==
                                                      false
                                                  ? Text(
                                                      '-' +
                                                          IncomeExpenseList[
                                                                      index]
                                                                  ['amount']
                                                              .toString(),
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontFamily:
                                                              'Urbanist',
                                                          color: Colors.red),
                                                    )
                                                  : Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: Text(
                                                        0.toString(),
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            fontFamily:
                                                                'Urbanist',
                                                            color: Colors.red),
                                                      ),
                                                    ),
                                            )),
                                            DataCell(Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: IncomeExpenseList[index]
                                                          ['income'] ==
                                                      true
                                                  ? Text(
                                                      '+' +
                                                          IncomeExpenseList[
                                                                      index]
                                                                  ['amount']
                                                              .toString(),
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontFamily:
                                                              'Urbanist',
                                                          color: Colors.green),
                                                    )
                                                  : Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: Text(
                                                        0.toString(),
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            fontFamily:
                                                                'Urbanist',
                                                            color:
                                                                Colors.green),
                                                      ),
                                                    ),
                                            )),
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
                      //     itemCount: expenseList!.length,
                      //     shrinkWrap: true,
                      //     padding: EdgeInsets.only(top: scrWidth*0.2),
                      //     scrollDirection: Axis.vertical,
                      //     physics: BouncingScrollPhysics(),
                      //     itemBuilder: (context,index) {
                      //       icons=deserializeIcon(expenseList![index]['categoryIcon']);
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
                      //                         child: Text(expenseList[index]['categoryName'].toString(),style: TextStyle(
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
                      //                       Text('₹ '+expenseList[index]['amount'].toString(),style: TextStyle(
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
                      : selectedCategory == categryItems[1]
                          ? IncomeExpenseMonthList.length == 0
                              ? Container(
                                  child: Center(
                                    child: Text(
                                      "No Report found",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'Urbanist',
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.only(
                                    top: scrWidth * 0.2,
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: scrWidth * 0.08,
                                          right: scrWidth * 0.08,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Month'.toString(),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontFamily: 'Urbanist',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'Expense'.toString(),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontFamily: 'Urbanist',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'Income'.toString(),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontFamily: 'Urbanist',
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: scrWidth * 0.06,
                                            right: scrWidth * 0.06,
                                            bottom: 10),
                                        child: Container(
                                            child: Divider(
                                          thickness: 0.5,
                                          color: Colors.grey,
                                        )),
                                      ),
                                      Container(
                                        child: ListView.builder(
                                          itemCount:
                                              IncomeExpenseMonthList.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            print(IncomeExpenseMonthList);
                                            return Column(
                                              children: [
                                                // Padding(
                                                //   padding: const EdgeInsets.only(top: 50),
                                                //   child: Text('${monthlyReports[index]['date'].toDate().toString().substring(0,10)},  :  ${monthlyReports[index]['amount']}'),
                                                // ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: scrWidth * 0.08,
                                                    right: scrWidth * 0.08,
                                                  ),
                                                  child: Container(
                                                    height: scrWidth * 0.15,
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              DateFormat(
                                                                      'MMM,yyyy')
                                                                  .format(IncomeExpenseMonthList[
                                                                              index]
                                                                          [
                                                                          'date']
                                                                      .toDate())
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontFamily:
                                                                      'Urbanist',
                                                                  color: Colors
                                                                      .black),
                                                            ),

                                                            Text(
                                                              '-' +
                                                                  IncomeExpenseMonthList[
                                                                              index]
                                                                          [
                                                                          'expAmount']
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontFamily:
                                                                      'Urbanist',
                                                                  color: Colors
                                                                      .red),
                                                            ),
                                                            Text(
                                                              '+' +
                                                                  IncomeExpenseMonthList[
                                                                              index]
                                                                          [
                                                                          'incAmount']
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontFamily:
                                                                      'Urbanist',
                                                                  color: Colors
                                                                      .green),
                                                            ),

                                                            // Text(DateFormat('dd MMM,yyyy').format( expenseList[index]['date'].toDate()),style: TextStyle(
                                                            //     fontSize: 13,
                                                            //     fontFamily: 'Urbanist',
                                                            //     color: Colors.grey
                                                            // ),),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left:
                                                                      scrWidth *
                                                                          0.02,
                                                                  right:
                                                                      scrWidth *
                                                                          0.02,
                                                                  bottom: 10),
                                                          child: Container(
                                                              child: Divider(
                                                            thickness: 0.5,
                                                            color: Colors.grey,
                                                          )),
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
                                )
                          : IncomeExpenseList.isEmpty
                              ? Container(
                                  child: Center(
                                    child: Text(
                                      "No expenses",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: 'Urbanist',
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.only(
                                    top: scrWidth * 0.2,
                                    left: scrWidth * 0.04,
                                  ),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: SingleChildScrollView(
                                      child: DataTable(
                                        dataRowHeight: 47,
                                        headingRowHeight: 40,
                                        horizontalMargin: 0,
                                        dividerThickness: 2,
                                        columnSpacing: 15,
                                        showBottomBorder: true,
                                        columns: [
                                          // DataColumn(
                                          //   label: Padding(
                                          //     padding: const EdgeInsets.only(left: 8.0),
                                          //     child: Text("DATE",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13),),
                                          //   ),
                                          // ),
                                          // DataColumn(
                                          //   label: Text("Image",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13)),
                                          // ),
                                          DataColumn(
                                            label: Text("PARTICULARS",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13)),
                                          ),
                                          DataColumn(
                                            label: Text("EXPENSE",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13)),
                                          ),
                                          DataColumn(
                                            label: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 12.0),
                                              child: Text("INCOME",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13)),
                                            ),
                                          ),
                                        ],
                                        rows: List.generate(
                                          IncomeExpenseList.length,
                                          (index) {
                                            print(IncomeExpenseList);
                                            // print();
                                            // print();
                                            // print();
                                            // print();
                                            // print();

                                            // icons=deserializeIcon(expenseList![index]['categoryIcon']);
                                            // _icon = Icon(icons,size: 30,color: Colors.white,);
                                            var item = IncomeExpenseList[index];
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
                                                // DataCell(Container(
                                                //   width: MediaQuery.of(context).size.width*0.25,
                                                //   child:Text(DateFormat('dd MMM,yyyy').format( IncomeExpenseList[index]['date'].toDate()),style: TextStyle(
                                                //       fontSize: 13,
                                                //       fontFamily: 'Urbanist',
                                                //       color: Colors.grey
                                                //   ),),
                                                // )),
                                                DataCell(Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.25,
                                                  child: Text(
                                                    IncomeExpenseList[index]
                                                            ['categoryName']
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: 'Urbanist',
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                )),
                                                DataCell(Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: IncomeExpenseList[
                                                                  index]
                                                              ['income'] ==
                                                          false
                                                      ? Text(
                                                          '-' +
                                                              IncomeExpenseList[
                                                                          index]
                                                                      ['amount']
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontFamily:
                                                                  'Urbanist',
                                                              color:
                                                                  Colors.red),
                                                        )
                                                      : Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            0.toString(),
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                fontFamily:
                                                                    'Urbanist',
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                        ),
                                                )),
                                                DataCell(Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: IncomeExpenseList[
                                                                  index]
                                                              ['income'] ==
                                                          true
                                                      ? Text(
                                                          '+' +
                                                              IncomeExpenseList[
                                                                          index]
                                                                      ['amount']
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontFamily:
                                                                  'Urbanist',
                                                              color:
                                                                  Colors.green),
                                                        )
                                                      : Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8.0),
                                                          child: Text(
                                                            0.toString(),
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                fontFamily:
                                                                    'Urbanist',
                                                                color: Colors
                                                                    .green),
                                                          ),
                                                        ),
                                                )),
                                                // DataCell(Text(brandName[data[index]['brandId']]??'')),

                                                // DataCell(Text(fileInfo.size)),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                ),
              ],
            ),
            Positioned(
                top: scrHeight * 0.085,
                left: scrWidth * 0.08,
                right: scrWidth * 0.08,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: scrWidth * 0.28,
                      width: scrWidth * 0.4,
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
                          Text(
                            " Total Expense".toString(),
                            style: TextStyle(
                                fontSize: scrWidth * 0.04,
                                color: Colors.black,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w800),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            DateTime.now().toString().substring(0, 10),
                            //     date==null?DateTime.now().toString().substring(0,10):
                            // "${fromDate.toString().substring(0,10)}- ${toDate.toString().substring(0,10)}",
                            style: TextStyle(
                                fontSize: scrWidth * 0.032,
                                color: Colors.grey,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            " ₹ -" + totalExpense.toString(),
                            style: TextStyle(
                                fontSize: scrWidth * 0.05,
                                color: Colors.red,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w800),
                          ),
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
                    ),
                    Container(
                      height: scrWidth * 0.28,
                      width: scrWidth * 0.4,
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
                          Text(
                            " Total Income",
                            style: TextStyle(
                                fontSize: scrWidth * 0.04,
                                color: Colors.black,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w800),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            DateTime.now().toString().substring(0, 10),
                            //     date==null?DateTime.now().toString().substring(0,10):
                            // "${fromDate.toString().substring(0,10)}- ${toDate.toString().substring(0,10)}",
                            style: TextStyle(
                                fontSize: scrWidth * 0.032,
                                color: Colors.grey,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            " ₹ +" + totalIncome.toString(),
                            style: TextStyle(
                                fontSize: scrWidth * 0.05,
                                color: Colors.green,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w800),
                          ),
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
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

// update(){
//   FirebaseFirestore.instance.collection('users').
//   doc(currentuserid).collection('expense').snapshots().listen((event) {
//     for(DocumentSnapshot data in event.docs){
//
//       FirebaseFirestore.instance.collection('users').
//       doc(currentuserid).collection('expense').doc(data.id).update({
//         'income':false,
//
//       });
//     }
//
//   });
//   FirebaseFirestore.instance.collection('users').
//   doc(currentuserid).collection('incomes').snapshots().listen((event) {
//     for(DocumentSnapshot data in event.docs){
//
//       FirebaseFirestore.instance.collection('users').
//       doc(currentuserid).collection('incomes').doc(data.id).update({
//         'income':true,
//
//       });
//     }
//
//   });
//
//
//
// }
class SelectDatePage extends StatefulWidget {
  const SelectDatePage({Key? key}) : super(key: key);

  @override
  State<SelectDatePage> createState() => _SelectDatePageState();
}

class _SelectDatePageState extends State<SelectDatePage> {
  DateTime? fromDate;

  DateTime? toDate;
  // var fromDate;
  // var toDate;
  _FromDate(BuildContext context) async {
    final DateTime? datePicked = await showDatePickerCustom(
        cancelText: 'Cancel',
        confirmText: 'Select',
        context: context,
        firstDate: DateTime(2000, 1),
        lastDate: DateTime(DateTime.now().year + 100),
        initialDate: DateTime.now(),
        builder: (context, child) => Theme(
            data: ThemeData(
                colorScheme: ColorScheme.light(primary: Colors.green)),
            child: child!));
    if (datePicked != null && datePicked != fromDate) {
      date = datePicked;
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
        firstDate: DateTime(2000, 1),
        lastDate: DateTime(DateTime.now().year + 100),
        initialDate: DateTime.now(),
        builder: (context, child) => Theme(
            data: ThemeData(
                colorScheme: ColorScheme.light(primary: Colors.green)),
            child: child!));
    if (datePicked != null && datePicked != toDate) {
      setState(() {
        date = datePicked.add(Duration(hours: 23, minutes: 59, seconds: 59));
        toDate = datePicked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        insetPadding: EdgeInsets.only(
            bottom: scrWidth * 0.4,
            top: scrWidth * 0.4,
            right: scrWidth * 0.07,
            left: scrWidth * 0.07),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(45.0))),
        contentPadding: EdgeInsets.all(scrWidth * 0.07),
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
                    onTap: () {
                      _FromDate(context);
                      setState(() {});
                    },
                    child: Container(
                      height: scrWidth * 0.1,
                      width: scrWidth * 0.32,
                      decoration: BoxDecoration(
                          color: textFormFieldFillColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            fromDate == null
                                ? 'From Date'
                                : fromDate.toString().substring(0, 10),
                            // overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                fontFamily: 'Urbanist'),
                          ),
                          SvgPicture.asset(
                            'assets/icons/calendar.svg',
                            width: scrWidth * 0.042,
                            height: scrHeight * 0.025,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      _ToDate(context);
                      setState(() {});
                    },
                    child: Container(
                      height: scrWidth * 0.1,
                      width: scrWidth * 0.32,
                      decoration: BoxDecoration(
                          color: textFormFieldFillColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            toDate == null
                                ? 'To Date'
                                : toDate.toString().substring(0, 10),
                            // overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                fontFamily: 'Urbanist'),
                          ),
                          SvgPicture.asset(
                            'assets/icons/calendar.svg',
                            width: scrWidth * 0.042,
                            height: scrHeight * 0.025,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
              InkWell(
                onTap: () {
                  if (fromDate != null && toDate != null) {
                    Navigator.pop(context);
                    // Navigator.of(context).pop({"fromDate":fromDate,"toDate":toDate});
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => IncomeExpenseByDatePage(
                                fromDate: fromDate, toDate: toDate)));
                  } else {
                    fromDate == null
                        ? showUploadMessage(context, 'Choose from date ...')
                        : showUploadMessage(context, 'Choose to date ...');
                  }
                },
                child: Center(
                  child: Container(
                    width: scrWidth * 0.6,
                    height: scrHeight * 0.05,
                    decoration: BoxDecoration(
                        color: Color(0xff008036),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        " Select",
                        style: TextStyle(
                            fontSize: scrWidth * 0.046,
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
        }));
  }
}
