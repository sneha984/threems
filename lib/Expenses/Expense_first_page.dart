import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/Serialization/iconDataSerialization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:threems/Authentication/root.dart';

import '../screens/charity/verification_details.dart';
import '../screens/splash_screen.dart';
import '../utils/themes.dart';
class AddExpensesPage extends StatefulWidget {
  const AddExpensesPage({Key? key}) : super(key: key);

  @override
  State<AddExpensesPage> createState() => _AddExpensesPageState();
}

class _AddExpensesPageState extends State<AddExpensesPage> with TickerProviderStateMixin {
  Icon? _icon;
  var icons;
   TabController? _tabController;
   TextEditingController ?expenseAmount;
   TextEditingController ?narration;
   void initState() {
     expenseAmount = TextEditingController(text:'');
     narration = TextEditingController(text:'');
     _tabController = TabController(length: 2, vsync: this);
     super.initState();
   }

   @override
   void dispose() {
     super.dispose();
     _tabController?.dispose();
   }
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
          "Track Your Expenses",
          style: TextStyle(
              fontSize: scrWidth*0.046,
              color: Colors.black,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: scrHeight*0.015,),
          Padding(
            padding:  EdgeInsets.only(left: scrWidth*0.05,right: scrWidth*0.05),
            child: Container(
              height: scrHeight*0.05,
              decoration: BoxDecoration(
                color: primarycolor,
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
              ),
              child: TabBar(
                controller: _tabController,
                // give the indicator a decoration (color and border radius)
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                  color: Color(0xff02B558),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white,
                tabs: [
                  Text("Add Expenses",style: TextStyle(
                      fontFamily: 'Urbanist',fontSize: 15,fontWeight: FontWeight.w700
                  ),),
                  Text("Your Expenses",style: TextStyle(
                      fontFamily: 'Urbanist',fontSize: 15,fontWeight: FontWeight.w700
                  ),),
                ],
              ),
            ),
          ),
          Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [

                  Container(
                    height: MediaQuery.of(context).size.height,

                    child:StreamBuilder<QuerySnapshot> (
                        stream: FirebaseFirestore.instance.collection('expenses').snapshots(),
                        builder: (context, snapshot) {
                          if(!snapshot.hasData){
                            return  Container(child: Center(child: CircularProgressIndicator()));
                          }
                          var  data=snapshot.data?.docs;
                          return data?.length==0?
                          Center(
                            child: Text('No Expense category ',style: TextStyle(
                                fontFamily: 'outfit',
                                fontSize: 15,
                                fontWeight: FontWeight.w500
                            ),),
                          ):
                          Padding(
                            padding: const EdgeInsets.only(top: 28.0),
                            child: GridView.builder(

                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount
                                (
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 15,
                                  crossAxisSpacing: 15,
                                  childAspectRatio: 1.2
                              ),
                              padding: EdgeInsets.all( MediaQuery.of(context).size.width*0.05,),
                              itemCount: data?.length,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                icons=deserializeIcon(data![index]['icon']);
                                _icon = Icon(icons,color: Colors.primaries[Random().nextInt(Colors.primaries.length)],);
                                return Padding(
                                  padding: const EdgeInsets.only(left: 15.0,right: 15,bottom: 10,),
                                  child: InkWell(
                                    onTap: (){
                                      showModalBottomSheet(context: context,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(25.0),
                                            ),
                                          ),
                                          isScrollControlled: true,
                                          builder: (context){
                                            return Padding(
                                              padding:  EdgeInsets.only(
                                                  bottom: MediaQuery.of(context).viewInsets.bottom),
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.3,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 8.0),
                                                      child: Text('Enter '+data![index]['expenseName']+ " Expense",style: TextStyle(
                                                        fontFamily: 'outfit',
                                                        fontSize: 18,
                                                          color: Color(0xff034a82)
                                                      ),),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                                                      child: Container(
                                                        width: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                            0.9,
                                                        height: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                            0.065,
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                        ),
                                                        child: TextFormField(
                                                          controller: expenseAmount,
                                                          obscureText: false,
                                                          keyboardType: TextInputType.number,
                                                          decoration: InputDecoration(
                                                            labelText:
                                                            'Expense Amount',
                                                            labelStyle: TextStyle(
                                                              fontFamily: 'outfit',
                                                                color: Colors.grey),
                                                            hintText: 'Expense Amount',
                                                            enabledBorder:
                                                            OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                color: Colors.black,
                                                                width: 1,
                                                              ),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                            ),
                                                            focusedBorder:
                                                            OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                color: primarycolor,
                                                                width: 1,
                                                              ),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                            ),
                                                            filled: true,
                                                            fillColor: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                                                      child: Container(
                                                        width: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                            0.9,
                                                        height: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                            0.065,
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                        ),
                                                        child: TextFormField(
                                                          controller: narration,
                                                          obscureText: false,
                                                          keyboardType: TextInputType.number,
                                                          decoration: InputDecoration(
                                                            labelText:
                                                            'Narration',
                                                            labelStyle: TextStyle(
                                                                fontFamily: 'outfit',
                                                                color: Colors.grey),
                                                            hintText: 'Narration',
                                                            enabledBorder:
                                                            OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                color: Colors.black,
                                                                width: 1,
                                                              ),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                            ),
                                                            focusedBorder:
                                                            OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                color: primarycolor,
                                                                width: 1,
                                                              ),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                            ),
                                                            filled: true,
                                                            fillColor: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap:() {
                                                        if(expenseAmount!.text!=''&& narration!.text!=''){
                                                          FirebaseFirestore.instance.collection('users').doc(currentuserid).collection('expenses').add(
                                                              {
                                                                'expenseCategory':data![index]['expenseName'].toString(),
                                                                'expenseAmount':expenseAmount!.text.toString(),
                                                                'narration':narration!.text.toString(),
                                                                'date':FieldValue.serverTimestamp(),

                                                              });
                                                        }else{
                                                          expenseAmount!.text==''?showUploadMessage(context,'Please enter amount'):
                                                         showUploadMessage(context,'Please enter detailes of expense');

                                                        }

                                                      },
                                                      child: Container(
                                                        width: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                            0.3,
                                                        height: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                            0.045,
                                                        decoration: BoxDecoration(
                                                          color: primarycolor,
                                                          borderRadius: BorderRadius.circular(10),
                                                          border: Border.all(
                                                            color: primarycolor,
                                                          ),
                                                        ),child: InkWell(
                                                          onTap:(){
                                                            Navigator.pop(context);
                                                          },
                                                          child: Center(child: Text('Save',
                                                            style:TextStyle(
                                                              color: Colors.white,
                                                              fontFamily: 'outfit',
                                                            ) ,))),),
                                                    ),
                                                    SizedBox(height: 5,)
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>DropdownEditPage(
                                      //   id:data![index].id,
                                      // )));
                                    },
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            radius: 26,
                                            foregroundColor: Colors.black,
                                            backgroundColor: Colors.white,
                                            child: _icon,
                                          ),
                                          Text(data![index]['expenseName'],style: TextStyle(
                                              fontFamily: 'outfit',
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                               color: Color(0xff034a82)),
                                              // color:primarycolor),
                                          ),
                                        ],
                                      ),


                                    ),
                                  ),
                                );

                              },
                            ),
                          );
                        }),
                  ),
                  Container(),
               ],

              )
    )

        ],
      ),
    );
  }

}
