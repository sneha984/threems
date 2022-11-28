import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/themes.dart';
import '../splash_screen.dart';
import 'details.dart';

class ServiceSubcategoryPage extends StatefulWidget {
  final String serviceCategoryName;
  final String image;
  final String serviceId;
  const ServiceSubcategoryPage({Key? key, required this.serviceCategoryName, required this.image, required this.serviceId,}) : super(key: key);

  @override
  State<ServiceSubcategoryPage> createState() => _ServiceSubcategoryPageState();
}

class _ServiceSubcategoryPageState extends State<ServiceSubcategoryPage> {
  List subcategories=[];
  getSubCategories(){
    FirebaseFirestore.instance.collection('serviceCategory').doc(widget.serviceId).
    snapshots().listen((event) {
      for(var a in event.get('subCategory')){
        subcategories.add(a);
      }
      print(subcategories);
      if(mounted){
        setState(() {

        });
      }
    }
    );

  }
  @override
  void initState() {
    getSubCategories();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(scrWidth * 0.15),
        child: Container(
          /*decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.08),
                offset: Offset(0, 4),
                blurRadius: 25),
          ]),*/
          child: AppBar(
            elevation: 0,
            toolbarHeight: 75,
            automaticallyImplyLeading: false,
            backgroundColor: tabBarColor,
            title: Padding(
              padding: EdgeInsets.only(top: 30,left: 15),
              child: Row(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.close_outlined,color: Colors.black,size: 20,)),
                  ),
                  SizedBox(width: 15,),
                  Text(
                   widget.serviceCategoryName,
                    style: TextStyle(
                        fontSize: 19,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ],
              ),
            ),

          ),
        ),
      ),
     body: Container(
        height: scrHeight,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: scrWidth*0.2,
                  color: tabBarColor,

                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(top:scrWidth*0.1),
                      child: Container(

                        child: GridView.builder(
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: subcategories!.length,
                          padding: EdgeInsets.only(
                              top: 25, bottom: 15, left: 20,right: 15),
                          itemBuilder: (BuildContext context, int index) {
                            return  subcategories.length==0?Container(
                              child:Center(
                                child: Text(
                                  "No subcategories under this Category",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ),
                            ):
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ServiceDetailesPage(
                                          subCategoryName: subcategories[index]['sub'],
                                          category: widget.serviceCategoryName,

                                          // image:categories![index]['image'],
                                          // serviceId:categories![index].id,

                                        )));
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Container(
                                  //   height:80,
                                  //   width:120,
                                  //   decoration: BoxDecoration(
                                  //       color: Color(0xffF3F3F3),
                                  //
                                  //       borderRadius: BorderRadius.circular(20)
                                  //   ),
                                  //   child: Column(
                                  //     mainAxisAlignment: MainAxisAlignment.center,
                                  //     children: [
                                  //       Image.network( subcategories[index]['image'].toString(),height: 55,width: 50, ),
                                  //     ],
                                  //   ),
                                  // ),
                                  CircleAvatar(
                                    radius:40,
                                    backgroundImage: NetworkImage(subcategories[index]['image']),

                                  ),
                                  Expanded(
                                    child:  Center(
                                      child: Text(
                                        subcategories![index]['sub'],
                                        style: TextStyle(
                                            fontSize: scrWidth * 0.029,
                                            color: Colors.black,
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            );
                          },

                        ),
                      ),
                    ),

                  ],
                ),
              ],
            ),
            Positioned(
                top: scrHeight*0.035,
                left: scrWidth*0.35,
                right: scrWidth*0.35,

                child: Container(
                  height: scrWidth*0.2,
                  width: scrWidth*0.001,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xffF3F3F3),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        spreadRadius: 4,
                        offset: Offset(0, 7),
                        color: Colors.grey.withOpacity(0.15),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.network(widget.image,height: 30,width: 30,),
                  ),


                )
            ),

          ],
        ),
      ),

    );
  }
}
