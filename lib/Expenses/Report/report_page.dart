import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/IconPicker/Packs/Material.dart';
import 'package:flutter_iconpicker/Serialization/iconDataSerialization.dart';
import 'package:intl/intl.dart';
import 'package:threems/utils/themes.dart';

import '../../Authentication/root.dart';
import '../../screens/splash_screen.dart';
class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  Icon? _icon;
  var icons;
  List expenseList=[];
  List categoryNameList=[];
  List singleCategoryList=[];
  List singleCategoryList2=[];
  String? selectedValue;
  String? selectedCategory;
  getRecentExpenses(){
    FirebaseFirestore.instance.collection('users').doc(currentuserid).collection('expense').
    orderBy('date',descending: true).snapshots().listen((event) {

      if(event.docs.isNotEmpty) {
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
  getCategoryName(){
    FirebaseFirestore.instance.collection('expenses').snapshots().listen((event) {
      if(event.docs.isNotEmpty) {
        for (DocumentSnapshot data in event.docs) {
          categoryNameList.add(data['expenseName']);
        }

      }
      if(mounted){
        setState(() {

        });
      }
    });

  }
  var amount;
  var catName;
  getCategoryBasedExpense(){
    FirebaseFirestore.instance.collection('users').doc(currentuserid).collection('expense').
    orderBy('date',descending: true).where('categoryName',isEqualTo: selectedCategory).snapshots().listen((event) {
      singleCategoryList=[];

      if(event.docs.isNotEmpty) {
        for (DocumentSnapshot data in event.docs) {
          singleCategoryList.add(data);
      //     catName=selectedCategory.toString();
      //     for(int i=0;i<singleCategoryList.length;i++){
      //        amount += data[i]['amount'];
      //        singleCategoryList2.add(amount);
      //
      // }
        }



      }
      if(mounted){
        setState(() {

        });
      }
    });

  }
  final List<String> sortItem = [
    "This year",
    "Select Date",

  ];

  @override
  void initState() {
    getCategoryName();
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
                                    "This year",
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
                                dropdownWidth: 250,
                                dropdownPadding: EdgeInsets.only(
                                    left: 35, top: 15, bottom: 25, right: 35),
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: primarycolor,
                                ),
                                dropdownElevation: 0,
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
                                    "Category",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                ),
                                items: categoryNameList
                                    .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Center(
                                    child: Text(
                                      item.toString(),overflow: TextOverflow.ellipsis,
                                      // overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                          fontFamily: 'Urbanist'),maxLines: 2,

                                    ),
                                  ),
                                ))
                                    .toList(),
                                value: selectedCategory,
                                onChanged: (value) {
                                  setState(() {
                                    selectedCategory = value;
                                    getCategoryBasedExpense();

                                  });

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
                                dropdownWidth: 250,
                                dropdownPadding: EdgeInsets.only(
                                    left: 35, top: 15, bottom: 25, right: 35),
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: primarycolor,
                                ),
                                dropdownElevation: 0,
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
                  child:selectedCategory==null? ListView.builder(
                      itemCount: expenseList!.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: scrWidth*0.2),
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context,index) {
                        icons=deserializeIcon(expenseList![index]['categoryIcon']);
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
                                          child: Text(expenseList[index]['categoryName'].toString(),style: TextStyle(
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
                                        Text('₹ '+expenseList[index]['amount'].toString(),style: TextStyle(
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

                  ):ListView.builder(
                      itemCount: singleCategoryList!.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: scrWidth*0.2),
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context,index) {
                        icons=deserializeIcon(singleCategoryList![index]['categoryIcon']);
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
                                          child: Text(singleCategoryList[index]['categoryName'].toString(),style: TextStyle(
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
                                        Text('₹ '+singleCategoryList[index]['amount'].toString(),style: TextStyle(
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

                  ),
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
                      Text(
                        DateTime.now().toString().substring(0,10),
                        style: TextStyle(
                            fontSize: scrWidth*0.035,
                            color: Colors.grey,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 12,),
                      Text(
                        " ₹ 1500000",
                        style: TextStyle(
                            fontSize: scrWidth*0.055,
                            color: Colors.black,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w800),
                      ),

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
