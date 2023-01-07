import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../screens/splash_screen.dart';
import '../utils/themes.dart';

class ReportDetailsPage extends StatefulWidget {
  final Map item;
  final String type;
  final String categoryName;
  const ReportDetailsPage({Key? key, required this.item, required this.type, required this.categoryName,  }) : super(key: key);

  @override
  State<ReportDetailsPage> createState() => _ReportDetailsPageState();
}

class _ReportDetailsPageState extends State<ReportDetailsPage> {
  Map item={};
  List keys=[];
  List keys2=[];

  @override
  void initState() {
    item=widget.item;
    print('itemkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
    print(item);
    print('tttttttttttttttttttttttttttttttttttttttttttt');
    keys=item[widget.type]['data'].toList();




    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print(widget.type);
    print('widget.type');
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
          widget.categoryName,
          style: TextStyle(
              fontSize: scrWidth*0.046,
              color: Colors.white,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w600),
        ),

      ),
      body: Column(
        children: [
          Padding(
            padding:  EdgeInsets.only(top: scrWidth*0.05),
            child: Column(
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: scrWidth*0.08,right:  scrWidth*0.08,),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      // Text(selectedCategory==categryItems[1]?'Month':"Particulars",
                      Text("Particulars",
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
                        itemCount: keys.length,
                        // monthlyIncomeExpenseMap.keys.toList().length,
                        shrinkWrap: true,
                        itemBuilder: (context,index){
                          // String dateKey =monthlyIncomeExpenseMap.keys.toList()[index];
                          // DateTime date=monthlyIncomeExpenseMap[dateKey]['income']!=null?monthlyIncomeExpenseMap[dateKey]['income']['date'].toDate():
                          // monthlyIncomeExpenseMap[dateKey]['expense']['date'].toDate();
                          // double income =monthlyIncomeExpenseMap[dateKey]['income']!=null?monthlyIncomeExpenseMap[dateKey]['income']['amount']:0;
                          // double expense =monthlyIncomeExpenseMap[dateKey]['expense']!=null?monthlyIncomeExpenseMap[dateKey]['expense']['amount']:0;
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
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(

                                          width:scrWidth*0.24,
                                          child: Text(DateFormat('dd MMM yyyy').format(keys[index]['date'].toDate()).toString(),
                                            // selectedCategory==categryItems[1]?DateFormat('MMM,yyyy').format(date).toString():dateKey,
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
                                              (widget.type=='expense'? keys[index]['amount'].toString():0.00.toString()),
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
                                            child: Text('+'+  (widget.type=='income'? keys[index]['amount'].toString():0.00.toString()),
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
    );
  }
}
