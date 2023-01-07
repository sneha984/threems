
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/Serialization/iconDataSerialization.dart';
import 'package:intl/intl.dart';
import '../Authentication/root.dart';
import '../Income/Report/IncomeReportByYear.dart';
import '../screens/splash_screen.dart';
import '../utils/themes.dart';
import 'IncomeExpenseReportDetailesPage.dart';
DateTime? fromDate;

DateTime? toDate;
class IncomeExpenseByDatePage extends StatefulWidget {

  const IncomeExpenseByDatePage({Key? key,}) : super(key: key);

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
  final List<String> sortItem = [
    "This year",
    "Select Date",
  ];

  String? selectedValue;
  String? selectedCategory;
  double totalExpense=0.00;
  List dateExpenseReports=[];
  List dateExpense=[];
  List monthList=[];
  List IncomeExpenseMonthList=[];
  QuerySnapshot? incomeEvent;
  QuerySnapshot? expenseEvent;

  getCategoryWiseExpenseByDate() async {
    print('hhhhhhhhhhhhhhhhhh');

while(expenseEvent==null){

  await Future.delayed(Duration(seconds: 1));
}

    if(expenseEvent?.docs.isNotEmpty==true) {
      monthExpenseList=[];
      monthlyExpenseReports=[];
      totalExpense=0;
      print(expenseEvent?.docs.length);

      for (DocumentSnapshot data in expenseEvent?.docs??[]) {
        totalExpense += double.tryParse(data['amount'].toString()) ?? 0;
        // if(monthExpenseList.contains(data['date'].toDate().toString().substring(0,7))){
        if(monthlyIncomeExpenseMap[data['categoryName']]==null){
          monthlyIncomeExpenseMap[data['categoryName']]={};
        }
        if( monthlyIncomeExpenseMap[data['categoryName']]['expense']!=null){
          // Map<String,dynamic> item=monthlyExpenseReports[monthExpenseList.indexOf(data['date'].toDate().toString().substring(0,7))];
          Map<String,dynamic> item=monthlyIncomeExpenseMap[data['categoryName']]['expense'];
          double amount=item['amount'];
          amount+=data['amount'];
          item['amount']=amount;
          item['data'].add(data);
          monthlyIncomeExpenseMap[data['categoryName']]['expense']=item;

        }else{
          print("'''''''''''''''''''''''''''''''''''''''''''''''''");
          print(data['categoryName']);
          print(data['amount']);
          monthlyIncomeExpenseMap[data['categoryName']]['expense']={
            'date':data['date'],
            'amount':data['amount'],
            'data':[data],
          };
        }


      }

    }
      if(mounted){
        setState(() {

        });
      }

  }
  List monthlyExpenseReports=[];
  List monthExpenseList=[];
  Map monthlyIncomeExpenseMap={};
  getMonthWiseExpensesByDate() async {

    while(expenseEvent==null){
      await Future.delayed(Duration(seconds: 1));
    }
      if(expenseEvent?.docs.isNotEmpty==true) {

        monthExpenseList=[];
        monthlyExpenseReports=[];
        totalExpense=0;
        for (DocumentSnapshot data in expenseEvent?.docs??[]) {
          totalExpense += double.tryParse(data['amount'].toString()) ?? 0;

          // if(monthExpenseList.contains(data['date'].toDate().toString().substring(0,7))){
          if(monthlyIncomeExpenseMap[data['date'].toDate().toString().substring(0,7)]==null){
            monthlyIncomeExpenseMap[data['date'].toDate().toString().substring(0,7)]={};
          }
          if( monthlyIncomeExpenseMap[data['date'].toDate().toString().substring(0,7)]['expense']!=null){
            // Map<String,dynamic> item=monthlyExpenseReports[monthExpenseList.indexOf(data['date'].toDate().toString().substring(0,7))];
            Map<String,dynamic> item=monthlyIncomeExpenseMap[data['date'].toDate().toString().substring(0,7)]['expense'];
            double amount=item['amount'];
            amount+=data['amount'];
            item['amount']=amount;
            item['data'].add(data);


            monthlyIncomeExpenseMap[data['date'].toDate().toString().substring(0,7)]['expense']=item;

          }else{

            monthlyIncomeExpenseMap[data['date'].toDate().toString().substring(0,7)]['expense']={
              'date':data['date'],
              'amount':data['amount'],
              'data':[data],
            };
          }


        }

      }



      if(mounted){
        setState(() {

        });
      }

  }
  double totalIncome=0.00;
  List dateIncomeReports=[];
  List dateIncome=[];

  getCategoryWiseIncomeByDate() async {
    while(incomeEvent==null){
      await Future.delayed(Duration(seconds: 1));
    }

    if(incomeEvent?.docs.isNotEmpty==true) {
      months=[];
      monthlyIncomeReports=[];
      totalIncome=0;
      for (DocumentSnapshot data in incomeEvent?.docs??[]) {
        totalIncome += double.tryParse(data['amount'].toString()) ?? 0;

        // if(months.contains(data['date'].toDate().toString().substring(0,7))){
        if(monthlyIncomeExpenseMap[data['categoryName']]==null){
          monthlyIncomeExpenseMap[data['categoryName']]={};
        }
        if( monthlyIncomeExpenseMap[data['categoryName']]['income']!=null){
          // Map<String,dynamic> item=monthlyIncomeReports[months.indexOf(data['date'].toDate().toString().substring(0,7))];
          Map<String,dynamic> item=monthlyIncomeExpenseMap[data['categoryName']]['income'];
          double amount=item['amount'];
          amount+=data['amount'];
          item['amount']=amount;
          item['data'].add(data);

          monthlyIncomeExpenseMap[data['categoryName']]['income']=item;

        }else{

          monthlyIncomeExpenseMap[data['categoryName']]['income']={
            'date':data['date'],
            'amount':data['amount'],
            'data':[data],
          };
        }


      }

    }
      if(mounted){
        setState(() {

        });
      }

  }
  List monthlyIncomeReports=[];
  List months=[];
  Map monthlyIncomeMap={};

  getMonthWiseIncomesByDate() async {
    while(incomeEvent==null){
      await Future.delayed(Duration(seconds: 1));
    }
      if(incomeEvent?.docs.isNotEmpty==true) {
        months=[];
        monthlyIncomeReports=[];
        totalIncome=0;
        for (DocumentSnapshot data in incomeEvent?.docs??[]) {
          totalIncome += double.tryParse(data['amount'].toString()) ?? 0;
          // if(months.contains(data['date'].toDate().toString().substring(0,7))){
          if(monthlyIncomeExpenseMap[data['date'].toDate().toString().substring(0,7)]==null){
            monthlyIncomeExpenseMap[data['date'].toDate().toString().substring(0,7)]={};
          }
            if( monthlyIncomeExpenseMap[data['date'].toDate().toString().substring(0,7)]['income']!=null){
            // Map<String,dynamic> item=monthlyIncomeReports[months.indexOf(data['date'].toDate().toString().substring(0,7))];
            Map<String,dynamic> item=monthlyIncomeExpenseMap[data['date'].toDate().toString().substring(0,7)]['income'];
            double amount=item['amount'];
            amount+=data['amount'];
            item['amount']=amount;
            item['data'].add(data);

            monthlyIncomeExpenseMap[data['date'].toDate().toString().substring(0,7)]['income']=item;

          }else{

              monthlyIncomeExpenseMap[data['date'].toDate().toString().substring(0,7)]['income']={
              'date':data['date'],
              'amount':data['amount'],
              'data':[data],
            };
          }


        }

      }


      if(mounted){
        setState(() {

        });
      }

  }
  SortList(){
    ExpenseIncomeList.sort((a,b)=>b['date'].microsecondsSinceEpoch.compareTo(a['date'].microsecondsSinceEpoch));
    IncomeExpenseMonthList.sort((a,b)=>b['date'].microsecondsSinceEpoch.compareTo(a['date'].microsecondsSinceEpoch));
  }
  @override
  void initState() {
    selectedCategory=categryItems[0];
    fromDate=DateTime(DateTime.now().year);
    toDate=DateTime.now();
    getData();
    // getCategoryWiseExpenseByDate();
    // getCategoryWiseIncomeByDate();
    // TODO: implement initState
    super.initState();
  }

  getData() async {
    incomeEvent = await FirebaseFirestore.instance.collection('users').doc(currentuserid).collection('incomes').
    orderBy('date',descending: true).  where('date',isGreaterThanOrEqualTo:fromDate).
    where('date',isLessThanOrEqualTo:DateTime(toDate!.year,toDate!.month,toDate!.day,23,59,59)).get();
    expenseEvent = await FirebaseFirestore.instance.collection('users').doc(currentuserid).collection('expense').
    orderBy('date',descending: true).  where('date',isGreaterThanOrEqualTo:fromDate).
    where('date',isLessThanOrEqualTo:DateTime(toDate!.year,toDate!.month,toDate!.day,23,59,59)).get();

    if( selectedCategory==categryItems[1]){
      print(selectedCategory);
      print('selectedCategorymmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm');
      IncomeExpenseMonthList=[];
      monthlyIncomeExpenseMap={};
      getMonthWiseExpensesByDate();
      getMonthWiseIncomesByDate();
    }else{
      print(selectedCategory);
      print('selectedCategoryyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
      IncomeExpenseMonthList=[];
      monthlyIncomeExpenseMap={};
      getCategoryWiseExpenseByDate();
      getCategoryWiseIncomeByDate();

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        foregroundColor: Colors.white,
        // toolbarHeight: 84,
        shadowColor: Colors.grey,
        leadingWidth: 65,
        centerTitle: true,
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: scrWidth*0.3,
                  color: tabBarColor,
                  child: Container(
                    child: Padding(
                      padding:  EdgeInsets.only(left:scrWidth*0.04,right:scrWidth*0.04, top: scrWidth*0.02),
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
                                onChanged: (value) async {
                                  selectedValue = value as String;
                                  if (selectedValue == 'Select Date') {
                                    await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                      return const SelectDatePage();
                                    });
                                  }else{
                                    fromDate=DateTime(DateTime.now().year);
                                    toDate=DateTime.now();
                                  }
                                  incomeEvent = await FirebaseFirestore.instance.collection('users').doc(currentuserid).collection('incomes').
                                  orderBy('date',descending: true).  where('date',isGreaterThanOrEqualTo:fromDate).
                                 where('date',isLessThanOrEqualTo:DateTime(toDate!.year,toDate!.month,toDate!.day,23,59,59)).get();

                                  expenseEvent = await FirebaseFirestore.instance.collection('users').doc(currentuserid).collection('expense').
                                  orderBy('date',descending: true).  where('date',isGreaterThanOrEqualTo:fromDate).
                                  where('date',isLessThanOrEqualTo:DateTime(toDate!.year,toDate!.month,toDate!.day,23,59,59)).get();
                                  if( selectedCategory==categryItems[1]){
                                    IncomeExpenseMonthList=[];
                                    monthlyIncomeExpenseMap={};
                                    getMonthWiseExpensesByDate();
                                    getMonthWiseIncomesByDate();
                                  }else{
                                    IncomeExpenseMonthList=[];
                                    monthlyIncomeExpenseMap={};
                                    getCategoryWiseExpenseByDate();
                                    getCategoryWiseIncomeByDate();

                                  }
                                  setState(() async {
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
                                    IncomeExpenseMonthList=[];
                                    monthlyIncomeExpenseMap={};
                                    getMonthWiseExpensesByDate();
                                    getMonthWiseIncomesByDate();
                                  }else{
                                    IncomeExpenseMonthList=[];
                                    monthlyIncomeExpenseMap={};
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
                monthlyIncomeExpenseMap.keys.toList().length==0?
                Container(
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
                  padding:  EdgeInsets.only(top: scrWidth*0.2),
                  child: Column(
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(left: scrWidth*0.08,right:  scrWidth*0.08,),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [

                            Text(selectedCategory==categryItems[1]?'Month':"Particulars",
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
                      Column(
                        children: [
                          SingleChildScrollView(
                            child: ListView.builder(
                              itemCount: monthlyIncomeExpenseMap.keys.toList().length,
                              shrinkWrap: true,
                              itemBuilder: (context,index){
                                String dateKey =monthlyIncomeExpenseMap.keys.toList()[index];
                                DateTime date=monthlyIncomeExpenseMap[dateKey]['income']!=null?monthlyIncomeExpenseMap[dateKey]['income']['date'].toDate():
                                monthlyIncomeExpenseMap[dateKey]['expense']['date'].toDate();
                                double income =monthlyIncomeExpenseMap[dateKey]['income']!=null?monthlyIncomeExpenseMap[dateKey]['income']['amount']:0;
                                double expense =monthlyIncomeExpenseMap[dateKey]['expense']!=null?monthlyIncomeExpenseMap[dateKey]['expense']['amount']:0;
                                return Column(
                                  children: [
                                    // Padding(
                                    //   padding: const EdgeInsets.only(top: 50),
                                    //   child: Text('${monthlyReports[index]['date'].toDate().toString().substring(0,10)},  :  ${monthlyReports[index]['amount']}'),
                                    // ),
                                    Padding(
                                      padding:  EdgeInsets.only(left: scrWidth*0.08,right:  scrWidth*0.08,),
                                      child: Column(


                                        children: [
                                          InkWell(
                                            onTap: (){
                                              print('monthlyIncomeExpenseMap[dateKey]');
                                              print(monthlyIncomeExpenseMap[dateKey].keys.toList()[0].toString());
                                              Navigator.push(context,
                                                  MaterialPageRoute(builder: (context)=>ReportDetailsPage(
                                                    item:monthlyIncomeExpenseMap[dateKey],
                                                    type:monthlyIncomeExpenseMap[dateKey].keys.toList()[0].toString(),
                                                    categoryName:dateKey,
                                                  )));
                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(

                                                  width:scrWidth*0.24,
                                                  child: Text(
                                                    selectedCategory==categryItems[1]?DateFormat('MMM,yyyy').format(date).toString():dateKey,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: 'Urbanist',
                                                        color: Colors.black
                                                    ),),
                                                ),
                                                Container(

                                                  width:scrWidth*0.24,
                                                  child: Center(
                                                    child: Text('-'+
                                                        expense.toString(),
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontFamily: 'Urbanist',
                                                          color: Colors.red
                                                      ),),
                                                  ),
                                                ),
                                                Container(

                                                  width:scrWidth*0.24,
                                                  child: Center(
                                                    child: Text('+'+income.toString(),
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontFamily: 'Urbanist',
                                                          color: Colors.green
                                                      ),),
                                                  ),
                                                ),

                                                // Text(DateFormat('dd MMM,yyyy').format( expenseList[index]['date'].toDate()),style: TextStyle(
                                                //     fontSize: 13,
                                                //     fontFamily: 'Urbanist',
                                                //     color: Colors.grey
                                                // ),),

                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:  EdgeInsets.only(left: scrWidth*0.02,right:  scrWidth*0.02,bottom: 10),
                                            child: Container(child: Divider(thickness: 0.5,color: Colors.grey,)),
                                          ),


                                        ],
                                      ),
                                    ),

                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

              ],
            ),
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
                    Text( DateFormat('dd-MM-yyyy').format(fromDate!).toString()+' - '+DateFormat('dd-MM-yyyy').format(toDate!).toString(),
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
    );
  }
}
