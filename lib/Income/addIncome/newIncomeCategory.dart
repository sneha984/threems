import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:threems/Authentication/root.dart';

import '../../screens/charity/verification_details.dart';
import '../../screens/splash_screen.dart';
import '../../utils/themes.dart';


class IncomeCategoryPage extends StatefulWidget {
  const IncomeCategoryPage({Key? key}) : super(key: key);

  @override
  State<IncomeCategoryPage> createState() => _IncomeCategoryPageState();
}

class _IncomeCategoryPageState extends State<IncomeCategoryPage> {
  Icon? _icon;
  var icons;
  _pickIcon() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(context,
        // iconPackModes: [IconPack.cupertino]);
        iconPackModes: [IconPack.custom,IconPack.cupertino,IconPack.fontAwesomeIcons,IconPack.material],);
    icons=icon;

    _icon = Icon(icon);
    setState(() {});
    debugPrint('Picked Icon:  $_icon');

  }
  TextEditingController? incomeCategory;

  // getIcon() async {
  //   DocumentSnapshot doc =await FirebaseFirestore.instance
  //       .collection('income')
  //       .doc('cn3myFOpRZrE8NLKC8fg')
  //       .get();
  //   icons=deserializeIcon(doc['serviceCity']);
  //   _icon = Icon(icons);
  //
  //   setState(() {
  //
  //   });
  // }
  @override
  void initState() {
    // getIcon();
    incomeCategory = TextEditingController(text:'');


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: primarycolor,
          backgroundColor: Colors.white,
          title: Text('Add income Category',style: TextStyle(fontFamily: 'Outfit',
              color: primarycolor),),
          bottom: TabBar(
              unselectedLabelColor: primarycolor,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: primarycolor),
              tabs: [
                Tab(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: primarycolor, width: 1)),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Add"),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color:primarycolor, width: 1)),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(" view Icons"),
                    ),
                  ),
                ),

              ]),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: padding15, right: padding15, top: scrWidth * 0.025,
                // vertical: scrWidth * 0.05,
              ),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(
                      height: scrWidth * 0.08,
                    ),
                    Center(
                      child: InkWell(
                        onTap: (){
                          _pickIcon();
                        },
                        child: Container(
                          width: scrWidth*0.3,
                          height: scrHeight*0.09,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: primarycolor)
                          ),
                          child: Center(
                              child: _icon ??Column(
                                children: [
                                  Icon(Icons.add_circle_outline_outlined,color: primarycolor,size: 30,),
                                  SizedBox(height: 6,),

                                  Text(
                                    "Pick Icon",
                                    style: TextStyle(color: primarycolor,fontWeight: FontWeight.w500,fontSize: 18),
                                  ),

                                ],
                              )
                          ),

                        ),
                      ),
                    ),
                    SizedBox(
                      height: scrWidth * 0.08,
                    ),
                    Container(
                      width: scrWidth,
                      height: textFormFieldHeight45,
                      padding: EdgeInsets.symmetric(
                        horizontal: scrWidth * 0.015,
                        vertical:scrHeight*0.002,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xffDADADA),
                        ),
                        color: textFormFieldFillColor,
                        borderRadius: BorderRadius.circular(scrWidth * 0.026),
                      ),
                      child:  TextFormField(
                        controller:  incomeCategory,
                        cursorHeight: scrWidth * 0.055,
                        cursorWidth: 1,
                        cursorColor: Colors.black,
                        style: GoogleFonts.urbanist(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: FontSize15,
                        ),
                        keyboardType: TextInputType.text,
                        decoration:  InputDecoration(
                          labelText: 'Enter your income category',
                          labelStyle: TextStyle(
                            color: textFormUnFocusColor,
                            fontWeight: FontWeight.w500,
                            fontSize: FontSize15,
                            fontFamily: 'Urbanist',
                          ),
                          fillColor: textFormFieldFillColor,
                          filled: true,
                          contentPadding: EdgeInsets.only(
                              left: scrWidth*0.03, top: scrHeight*0.006, bottom: scrWidth * 0.02),
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          border: InputBorder.none,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: primarycolor,
                              width: 2,
                            ),
                          ),

                          floatingLabelStyle: TextStyle(
                              color:primarycolor),
                          focusColor: Color(0xff034a82),
                          // border: OutlineInputBorder(),
                          // focusedBorder: OutlineInputBorder(
                          //     borderSide: BorderSide(color: Color(0xff034a82),width: 2)
                          // ),
                        ),
                      ),

                    ),


                    SizedBox(
                      height: scrWidth * 0.04,
                    ),

                    GestureDetector(
                        onTap: () {
                          if(incomeCategory?.text!='' ){
                            showDialog(context: context,
                                builder: (buildcontext)
                                {
                                  return AlertDialog(
                                    title: const Text('Add income Category'),
                                    content: const Text('Do you want to Add?'),
                                    actions: [
                                      TextButton(onPressed: (){
                                        Navigator.pop(context);
                                      },
                                          child: const Text('Cancel')),
                                      TextButton(onPressed: (){
                                        FirebaseFirestore.instance.collection('income').add({
                                          "icon":serializeIcon(icons),
                                          'categoryName':incomeCategory!.text,
                                          'user':currentuserid
                                        });

                                        showUploadMessage(context, 'Income Category added succesfully');
                                        Navigator.pop(context);
                                        incomeCategory?.clear();

                                        // Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => CharityCatogoryPage(),), (route) => false);
                                      },
                                          child: const Text('Yes')),
                                    ],
                                  );

                                });

                          }
                          else{
                            showUploadMessage(context,'Please enter category name');
                          }

                        },
                        child: Container(
                          height: scrHeight*0.065,
                          decoration: BoxDecoration(
                              color: primarycolor,
                              borderRadius: BorderRadius.circular(17)),
                          margin: EdgeInsets.symmetric(vertical: scrWidth*0.03, horizontal: scrHeight*0.06),
                          child: Center(
                              child: Text(
                                "ADD",
                                style: TextStyle(color: Colors.white),
                              )
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,

              child:StreamBuilder<QuerySnapshot> (
                  stream: FirebaseFirestore.instance.collection('income').where('user',isEqualTo: currentuserid).snapshots(),
                  builder: (context, snapshot) {
                    if(!snapshot.hasData){
                      return  Container(child: Center(child: CircularProgressIndicator()));
                    }
                    var  data=snapshot.data?.docs;
                    return data?.length==0?
                    Center(
                      child: Text('No income category ',style: GoogleFonts.urbanist(
                          fontSize: 15,
                          fontWeight: FontWeight.w500
                      ),),
                    ):
                    GridView.builder(

                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount
                        (
                          crossAxisCount: 3,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.9
                      ),
                      padding: EdgeInsets.all( MediaQuery.of(context).size.width*0.05,),
                      itemCount: data?.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        icons=deserializeIcon(data![index]['icon']);
                        _icon = Icon(icons,color: Colors.white,size: 45,);
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: (){
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>DropdownEditPage(
                              //   id:data![index].id,
                              // )));
                            },
                            onLongPress: (){
                              showDialog(context: context, builder:(buildcontext)
                              {
                                return AlertDialog(
                                  title: Text('Delete'),
                                  content: Text('Are you sure?'),
                                  actions: [
                                    TextButton(onPressed: () {

                                      Navigator.pop(context);
                                    },
                                        child: Text('Cancel')),
                                    TextButton(onPressed: ()  {

                                      FirebaseFirestore.instance.collection('income').doc(data![index].id).delete();


                                      Navigator.pop(context);
                                      showUploadMessage(context, "Deleted");


                                    },

                                        child: Text('Delete')),

                                  ],
                                );
                              });
                            },
                            child:Container(

                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                                          shape: BoxShape.circle
                                      ),
                                      child: _icon,
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      child: Text(data![index]['categoryName'],style: TextStyle(
                                          fontFamily: 'urbanist',
                                          fontSize: scrWidth*0.027,
                                          fontWeight: FontWeight.bold,
                                          // color: Color(0xff034a82)
                                          color: Colors.black
                                      ),textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),


                            ),
                          ),
                        );

                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
