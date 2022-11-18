import 'dart:developer';
import 'dart:developer';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:threems/ByeandSell/checkout.dart';
import 'package:threems/utils/themes.dart';
import 'dart:developer';

import '../screens/splash_screen.dart';
import '../utils/dummy.dart';
List<Map<String,dynamic>> cartlist=[];

class StorePage extends StatefulWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  State<StorePage> createState() => _StorePageState();
}
class Items{
  final String categoryname;
  List<Map<String,dynamic>> categoryitems;
  Items(
      this.categoryname, this.categoryitems,
      );
}
class _StorePageState extends State<StorePage> {
  List <Items> itemsCategory=[

    Items(
        'Rice Products',
        [{
          'image':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3YhxUEFTHw7Q7YAzXp7AG7-oqE6AI5x8O8Q&usqp=CAU',
          'unit':'1 kg',
          'price':243,
          'name':'close up',
          'ShouldVisible':false,
          'counter':1

        },
          {
            'image':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3YhxUEFTHw7Q7YAzXp7AG7-oqE6AI5x8O8Q&usqp=CAU',
            'unit':'1 kg',
            'price':243,
            'name':'Mandhi Rice',
            'ShouldVisible':false,
            'counter':1



          },
          {
            'image':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3YhxUEFTHw7Q7YAzXp7AG7-oqE6AI5x8O8Q&usqp=CAU',
            'unit':'1 kg',
            'price':243,
            'name':'Surf Ecl',
            'ShouldVisible':false,
            'counter':1



          },
          {
            'image':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3YhxUEFTHw7Q7YAzXp7AG7-oqE6AI5x8O8Q&usqp=CAU',
            'unit':'1 kg',
            'price':243,
            'name':'Surf Ecl',
          'ShouldVisible':false,
            'counter':1



          }
        ]
    ),
    Items(
        'Snacks Items',
        [{
          'image':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3YhxUEFTHw7Q7YAzXp7AG7-oqE6AI5x8O8Q&usqp=CAU',
          'unit':'1 kg',
          'price':243,
          'name':'Surf Ecl',
          'ShouldVisible':false,
          'counter':1



        },
          {
            'image':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3YhxUEFTHw7Q7YAzXp7AG7-oqE6AI5x8O8Q&usqp=CAU',
            'unit':'1 kg',
            'price':243,
            'name':'Surf Ecl',
            'ShouldVisible':false,
            'counter':1



          }
        ]
    ),
    Items(
        'Oils',
        [{
          'image':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3YhxUEFTHw7Q7YAzXp7AG7-oqE6AI5x8O8Q&usqp=CAU',
          'unit':'1 kg',
          'price':243,
          'name':'Surf Ecl',
          'ShouldVisible':false,
          'counter':1

        },
          {
            'image':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3YhxUEFTHw7Q7YAzXp7AG7-oqE6AI5x8O8Q&usqp=CAU',
            'unit':'1 kg',
            'price':243,
            'name':'Surf Ecl',
            'ShouldVisible':false,
            'counter':1
          }
        ]
    ),

  ];
  var currencyConvert = NumberFormat.currency(
    locale: 'HI',
    symbol: '₹ ',
  );
  bool _customTileExpanded = false;
  List<EachStore> eachstore=[
    EachStore(productimage: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3YhxUEFTHw7Q7YAzXp7AG7-oqE6AI5x8O8Q&usqp=CAU",
        productprice:234, productunit: "1 kg", productname: 'Surf Excel',counter: 1,ShouldVisible: false),
    EachStore(productimage: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8rNEg0PFYehTq2_ZTRckqgvNZRKTm8WjPkCoQZalie5uoxQFYTiTuUxdAYjHPOJeOmHA&usqp=CAU",
        productprice:100, productunit: "3 kg",productname: 'Sugar',counter: 1,ShouldVisible: false),
    EachStore(productimage: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_-le3oZrKxbung5DnvptkskDJ6BTEdfH6KA&usqp=CAU",
        productprice:40, productunit: "1 kg",productname: 'Colgate',counter: 1,ShouldVisible: false),
    EachStore(productimage: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3YhxUEFTHw7Q7YAzXp7AG7-oqE6AI5x8O8Q&usqp=CAU",
        productprice:234, productunit: "1 kg",productname: 'Surf Excel',counter: 1,ShouldVisible: false),
    EachStore(productimage: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3YhxUEFTHw7Q7YAzXp7AG7-oqE6AI5x8O8Q&usqp=CAU",
        productprice:234, productunit: "1 kg",productname: 'Surf Excel',counter: 1,ShouldVisible: false),
  ];
  bool onclick =true;
  // int count=1;
  // int counter=1;
  //
  // List _selectedIndexs=[];
  // void _decrement(){
  //   setState(() {
  //     if(count!=0){
  //       count--;
  //     }
  //
  //   });
  // }
  // void _increment(){
  //   setState(() {
  //     count++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: scrWidth*0.06,),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: scrHeight * 0.072,

                      // left: scrWidth * 0.07,
                    ),
                    child: Container(
                      height: scrHeight*0.03,
                      width: scrWidth*0.05,
                      child: SvgPicture.asset(
                        "assets/icons/arrow.svg",
                      ),
                    ),
                  ),
                ),
                SizedBox(width: scrWidth*0.04,),

                Padding(
                  padding:  EdgeInsets.only(top: scrHeight * 0.075,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        "Bavya Store",
                        style: TextStyle(
                            fontSize: scrWidth * 0.046,
                            color: Colors.black,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: scrHeight*0.01,),
                      Text(
                        "Grocery Store",
                        style: TextStyle(
                            fontSize:scrWidth*0.027,
                            color: Color(0xff818181),
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: scrHeight*0.002,),

                      Text(
                        "Manathumangalam,Perinthalmanna",
                        style: TextStyle(
                            fontSize:scrWidth*0.027,
                            color: Color(0xff818181),
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: scrHeight*0.01,),

                      Container(
                        width:scrWidth*0.5,
                        height: scrHeight*0.031,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(scrWidth*0.02),
                          color: primarycolor
                        ),
                        child: Center(
                          child: Text("Visit Store in Map",style: TextStyle(
                            fontFamily: 'Urbanist',fontWeight: FontWeight.w600,fontSize: scrWidth*0.027,color: Colors.white
                          ),),
                        ),

                      ),
                    ],
                  ),
                ),
                 SizedBox(width: scrWidth*0.031,),
                Padding(
                  padding:  EdgeInsets.only(
                      // left: 70,
                    top: scrHeight*0.076
                  ),
                  child: Container(
                    height:scrHeight*0.11,
                    width:scrWidth*0.26,
                    decoration: BoxDecoration(
                      image: DecorationImage(image:
                      NetworkImage("https://cdn.pixabay.com/photo/2016/03/02/20/13/grocery-1232944__340.jpg"),
                          fit: BoxFit.fill),
                      color: Colors.white,

                      borderRadius: BorderRadius.circular(
                          scrWidth*0.04),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding:  EdgeInsets.only(top: scrHeight*0.015,left: scrWidth*0.02),
              child: Container(
                height: scrHeight*0.042,
                width: scrWidth*0.92,
                decoration: BoxDecoration(
                    color: Color(0xffE9EEF3),

                    borderRadius: BorderRadius.circular(scrWidth*0.02)
                ),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: TextFormField(
                    decoration:  InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(
                              top: scrHeight*0.015,
                              left: scrWidth*0.04,
                              bottom: scrHeight*0.01,
                              right: scrWidth*0.05),
                          child:SvgPicture.asset("assets/icons/Vector (4).svg",),
                        ),
                        border: InputBorder.none,
                        hintText: "Search Products",
                        hintStyle: TextStyle(
                          fontFamily: 'Urbanist',fontWeight: FontWeight.w500,
                          fontSize: scrWidth*0.03,
                          color: Color(0xff8391A1),
                        )
                    ),
                    cursorColor: Colors.black,
                    cursorHeight: 20,
                    cursorWidth: 0.5,

                  ),
                ),
              ),
            ),
            SizedBox(height: scrHeight*0.02,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: scrWidth * 0.07,),
                SvgPicture.asset("assets/icons/staricon.svg"),
                SizedBox(width: scrWidth * 0.03,),
                Text("Featured Product", style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: scrWidth * 0.04,
                    fontWeight: FontWeight.w600
                ),)
              ],
            ),
            SizedBox(height: scrHeight*0.02,),
            Padding(
              padding:  EdgeInsets.only(left: scrWidth*0.02),
              child: Container(
                height: scrHeight*0.22,
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: eachstore.length,

                    itemBuilder: (context, index) {
                      // final _isSelected=_selectedIndexs.contains(index);
                      return Padding(
                        padding:  EdgeInsets.only(right: scrWidth*0.02),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: (){
                                Navigator.push(context,MaterialPageRoute(builder: (context)=>CheckOutPage()));
                              },
                              child: Padding(
                                padding:  EdgeInsets.only(
                                    left:scrWidth*0.039),
                                child: Container(
                                  padding: EdgeInsets.only(left: scrWidth*0.02,right: scrWidth*0.02,top: scrHeight*0.02),
                                  height:scrHeight*0.1,
                                  width: scrWidth*0.3,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(eachstore[index].productimage)),
                                      color: Colors.white,
                                      borderRadius: BorderRadius
                                          .circular(scrWidth*0.04),
                                      border: Border.all(
                                          color: Color(0xffECECEC),
                                          width: 1)
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(left: scrWidth*0.06),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment
                                    .start,
                                children: [
                                  SizedBox(height: scrHeight*0.009,),
                                  Text(
                                    eachstore[index].productname, textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'Urbanist',
                                        fontSize: scrWidth*0.03,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff0E0E0E)),),
                                  SizedBox(height: scrHeight*0.003,),

                                  Text(
                                    eachstore[index].productunit, textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'Urbanist',
                                        fontSize: scrWidth*0.025,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff818181)),),
                                  SizedBox(height: scrHeight*0.003,),

                                  Text(
                                    currencyConvert.format(eachstore[index].productprice).toString(), textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'Urbanist',
                                        fontSize: scrWidth*0.03,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xffF10000)),),
                                  SizedBox(height: scrHeight*0.004,),
                                ],
                              ),
                            ),
                           eachstore[index].ShouldVisible?
                           Padding(padding: EdgeInsets.only(left: scrWidth*0.07),
                             child: InkWell(
                               onTap: (){
                                 final findIndex=cartlist.indexWhere((element) => element['name'] ==eachstore[index].productname);
                                 print("index" +findIndex.toString());
                                 if(findIndex>=0) {
                                   setState(() {
                                     cartlist[findIndex]['quantity'] = eachstore[index].counter;
                                   });
                                 }else {
                                   cartlist.add({
                                     'img': eachstore[index].productimage,
                                     'name': eachstore[index].productname,
                                     'price': eachstore[index].productprice,
                                     'quantity':eachstore[index].counter,
                                   });
                                 }
                                 print(cartlist);
                                 final snackBar = SnackBar(
                                   backgroundColor: Colors.white,
                                   content: const Text(' item added to cart',
                                     style: TextStyle(color: Colors.black),),
                                   action: SnackBarAction(

                                     textColor: Colors.blue,
                                     label: 'Go To Cart',
                                     onPressed: () {
                                       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CheckOutPage()));



                                       // Some code to undo the change.
                                     },
                                   ),
                                 );
                                 ScaffoldMessenger.of(context).showSnackBar(snackBar);


                               },
                               child: Container(
                                 width: 126,
                                 height: 30,
                                 decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(8),
                                     color: Color(0xff02B558)
                                   // color: Colors.red
                                 ),
                                 child: Row(
                                   children: [
                                     InkWell(
                                       onTap: (){
                                         setState(() {
                                           if(eachstore[index].counter <2)
                                           {
                                             eachstore[index].ShouldVisible = !eachstore[index].ShouldVisible;
                                           }else{
                                             eachstore[index].counter--;
                                           }

                                         });
                                         final findIndex=cartlist.indexWhere((element) => element['name'] ==eachstore[index].productname);
                                         print("index" +findIndex.toString());
                                         if(findIndex>=0) {
                                           setState(() {
                                             cartlist[findIndex]['quantity'] = eachstore[index].counter;
                                           });
                                         }else {
                                           cartlist.add({
                                             'img': eachstore[index].productimage,
                                             'name': eachstore[index].productname,
                                             'price': eachstore[index].productprice,
                                             'quantity':eachstore[index].counter,
                                           });
                                         }
                                         print(cartlist);
                                         final snackBar = SnackBar(
                                           backgroundColor: Colors.white,
                                           content: const Text(' item added to cart',
                                             style: TextStyle(color: Colors.black),),
                                           action: SnackBarAction(

                                             textColor: Colors.blue,
                                             label: 'Go To Cart',
                                             onPressed: () {
                                               Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CheckOutPage()));



                                               // Some code to undo the change.
                                             },
                                           ),
                                         );
                                         ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                       },
                                       child: Container(
                                         height: 30,
                                         width: 45,
                                         decoration: BoxDecoration(
                                             color: Color(0xff02B558),
                                             borderRadius: BorderRadius.only(topLeft: Radius.circular(8),
                                                 bottomLeft:Radius.circular(8) )),
                                         child: Padding(
                                           padding: const EdgeInsets.only(bottom: 8),
                                           child: Icon(Icons.minimize_outlined,size: 15,color: Colors.white,),
                                         ),
                                       ),
                                     ),
                                     Container(
                                       height: 30,
                                       width: 36,
                                       decoration: BoxDecoration(
                                         color: Color(0xff9FFFCD),
                                       ),
                                       child: Center(child: Text('${eachstore[index].counter}')),
                                     ),
                                   InkWell(
                                     onTap: (){
                                       setState(() {
                                         eachstore[index].counter++;
                                       });
                                       final findIndex=cartlist.indexWhere((element) => element['name'] ==eachstore[index].productname);
                                       print("index" +findIndex.toString());
                                       if(findIndex>=0) {
                                         setState(() {
                                           cartlist[findIndex]['quantity'] = eachstore[index].counter;
                                         });
                                       }else {
                                         cartlist.add({
                                           'img': eachstore[index].productimage,
                                           'name': eachstore[index].productname,
                                           'price': eachstore[index].productprice,
                                           'quantity':eachstore[index].counter,
                                         });
                                       }
                                       print(cartlist);
                                       final snackBar = SnackBar(
                                         backgroundColor: Colors.white,
                                         content: const Text(' item added to cart',
                                           style: TextStyle(color: Colors.black),),
                                         action: SnackBarAction(

                                           textColor: Colors.blue,
                                           label: 'Go To Cart',
                                           onPressed: () {
                                             Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CheckOutPage()));
                                             // Some code to undo the change.
                                           },
                                         ),
                                       );
                                       ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                     },
                                     child: Container(
                                       height: 26,
                                       width: 30,
                                       decoration: BoxDecoration(
                                           color: Color(0xff02B558),
                                           borderRadius: BorderRadius.only(topLeft: Radius.circular(8),
                                               bottomLeft:Radius.circular(8) )

                                       ),
                                       child: Padding(
                                         padding: EdgeInsets.only(left: 5),
                                         child: Icon(Icons.add,size: 15,color: Colors.white,),
                                       ),
                                     ),
                                   ),

                                   ],
                                 ),

                               ),
                             ),
                           ):
                           Padding(
                              padding:  EdgeInsets.only(left: 7),
                              child:  InkWell(
                                onTap: (){
                                  setState(() {
                                    eachstore[index].ShouldVisible=!eachstore[index].ShouldVisible;
                                  });
                                  final findIndex=cartlist.indexWhere((element) => element['name'] ==eachstore[index].productname);
                                  print("index" +findIndex.toString());
                                  if(findIndex>=0) {
                                    setState(() {
                                      cartlist[findIndex]['quantity'] = eachstore[index].counter;
                                    });
                                  }else {
                                    cartlist.add({
                                      'img': eachstore[index].productimage,
                                      'name': eachstore[index].productname,
                                      'price': eachstore[index].productprice,
                                      'unit':eachstore[index].productunit,
                                      'quantity':eachstore[index].counter,
                                    });
                                  }
                                  print(cartlist);
                                  final snackBar = SnackBar(
                                    backgroundColor: Colors.white,
                                    content: const Text(' item added to cart',
                                      style: TextStyle(color: Colors.black),),
                                    action: SnackBarAction(

                                      textColor: Colors.blue,
                                      label: 'Go To Cart',
                                      onPressed: () {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CheckOutPage()));



                                        // Some code to undo the change.
                                      },
                                    ),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  },
                                child: Container(
                                  width: scrWidth*0.32,
                                  height: scrHeight*0.034,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color(0xff02B558)
                                  // color: Colors.red
                                ),
                                  child: Center(
                                  child: Text("Add",style: TextStyle(
                                      fontFamily: 'Urbanist',fontWeight: FontWeight.w600,fontSize: 12,color: Colors.white
                                      ),),
                                ),
                                ),
                              ),

                            ),

                            // Padding(
                            //   padding: EdgeInsets.only(left: 7),
                            //   child: InkWell(
                            //     onTap: (){
                            //       // setState((){
                            //       // if(_isSelected){
                            //       // _selectedIndexs.remove(index);
                            //       //
                            //       // }else{
                            //       // _selectedIndexs.add(index);
                            //       //
                            //       // }
                            //       // });
                            //
                            //       final findIndex=cartList.indexWhere((element) => element['name']==eachstore[index].productname);
                            //       print("index" +findIndex.toString());
                            //       if(findIndex>=0){
                            //         setState(() {
                            //           cartList[findIndex]['quantity'] =eachstore[index].counter;
                            //         });
                            //       }else{
                            //         cartList.add({
                            //           'name':eachstore[index].productname,
                            //           'image':eachstore[index].productimage,
                            //           'unit':eachstore[index].productunit,
                            //           'price':eachstore[index].productprice,
                            //           'quantity':eachstore[index].counter,
                            //         });
                            //       }
                            //       print(eachstore[index].counter);
                            //       print(cartList);
                            //       final snackBar = SnackBar(
                            //         backgroundColor: Colors.green,
                            //         content:  Text('${eachstore[index].counter} ${eachstore[index].productname} added to cart',
                            //           style: TextStyle(color: Colors.white),),
                            //         action: SnackBarAction(
                            //           textColor: Colors.white,
                            //           label: 'Go To Cart',
                            //           onPressed: () {
                            //             Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CheckOutPage()));
                            //             // Some code to undo the change.
                            //           },
                            //         ),
                            //       );
                            //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            //
                            //     },
                            //     child:Container(
                            //       width: 126,
                            //       height: 30,
                            //       decoration: BoxDecoration(
                            //           borderRadius: BorderRadius.circular(8),
                            //           color: Color(0xff02B558)
                            //         // color: Colors.red
                            //       ),
                            //       child:eachstore[index].ShouldVisible?
                            //       Row(
                            //         children: [
                            //           Container(
                            //             height: 30,
                            //             width: 45,
                            //             decoration: BoxDecoration(
                            //                 color: Color(0xff02B558),
                            //                 borderRadius: BorderRadius.only(topLeft: Radius.circular(8),
                            //                     bottomLeft:Radius.circular(8) )
                            //
                            //             ),
                            //             child: Padding(
                            //               padding: const EdgeInsets.only(bottom: 8),
                            //               child: InkWell(
                            //                   onTap:(){
                            //                     setState(() {
                            //                       if(eachstore[index].counter <2)
                            //                       {
                            //                         eachstore[index].ShouldVisible = !eachstore[index].ShouldVisible;
                            //                       }else{
                            //                         eachstore[index].counter--;
                            //                       }
                            //
                            //                     });
                            //                   },
                            //                   child: Icon(Icons.minimize_outlined,size: 15,color: Colors.white,)),
                            //             ),
                            //           ),
                            //           Container(
                            //             height: 30,
                            //             width: 36,
                            //             decoration: BoxDecoration(
                            //               color: Color(0xff9FFFCD),
                            //             ),
                            //             child: Center(child: InkWell(
                            //               onTap: (){
                            //
                            //               },
                            //                 child: Text(eachstore[index].counter.toString()))),
                            //           ),
                            //           Container(
                            //             height: 26,
                            //             width: 30,
                            //             decoration: BoxDecoration(
                            //                 color: Color(0xff02B558),
                            //                 borderRadius: BorderRadius.only(topLeft: Radius.circular(8),
                            //                     bottomLeft:Radius.circular(8) )
                            //
                            //             ),
                            //             child: InkWell(
                            //                 onTap:(){
                            //                   setState(() {
                            //                     eachstore[index].counter++;
                            //                   });
                            //                 },
                            //                 child: Padding(
                            //                   padding: EdgeInsets.only(left: 5),
                            //                   child: Icon(Icons.add,size: 15,color: Colors.white,),
                            //                 )),
                            //           ),
                            //         ],
                            //       )
                            //       : InkWell(
                            //         onTap: (){
                            //           setState(() {
                            //             eachstore[index].ShouldVisible = !eachstore[index].ShouldVisible;
                            //           });
                            //         },
                            //         child: Container(
                            //           width: 126,
                            //           height: 30,
                            //           decoration: BoxDecoration(
                            //               borderRadius: BorderRadius.circular(8),
                            //               color: Color(0xff02B558)
                            //             // color: Colors.red
                            //           ),
                            //           child: Center(
                            //             child: Text("Add",style: TextStyle(
                            //             fontFamily: 'Urbanist',fontWeight: FontWeight.w600,fontSize: 12,color: Colors.white
                            //             ),),
                            //           ),
                            //         ),
                            //       )
                            //     ),
                            //   ),
                            //   ),
                          ],
                        ),
                      );
                    }
                ),
              ),
            ),
            Container(
              height: 300,
              child: ListView.builder(
                itemCount: itemsCategory.length,
                itemBuilder: (context, i) {
                  return ExpansionTile(
                    onExpansionChanged: (bool expanded) {
                      setState(() => _customTileExpanded = expanded);
                    },
                    trailing: Icon(_customTileExpanded
                        ?Icons.arrow_drop_up
                        : Icons.arrow_drop_down,color: Colors.black,),
                    title: Text(itemsCategory[i].categoryname,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,fontFamily: 'Urbanist',color: Colors.black),),
                    children: <Widget>[
                      Container(
                          height: 400,
                          child:GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount:itemsCategory[i].categoryitems.length,
                            gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 3 / 5,
                                crossAxisSpacing: 2,
                                mainAxisSpacing: 20,
                                crossAxisCount: 3
                            ), itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding:  EdgeInsets.only(right: 10,top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      // Navigator.push(context,MaterialPageRoute(builder: (context)=>CheckOutPage()));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10),
                                      child: Container(
                                        padding: EdgeInsets.only(left: 10,right: 10),
                                        height: 90,
                                        width: 95,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(itemsCategory[i].categoryitems[index]['image'])),
                                            color: Colors.white,
                                            borderRadius: BorderRadius
                                                .circular(15),
                                            border: Border.all(
                                                color: Color(0xffECECEC),
                                                width: 1)
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        SizedBox(height: 5,),
                                        Text(
                                          itemsCategory[i].categoryitems[index]['name'], textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'Urbanist',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff0E0E0E)),),
                                        SizedBox(height: 3,),

                                        Text(
                                          itemsCategory[i].categoryitems[index]['unit'], textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'Urbanist',
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff818181)),),
                                        SizedBox(height: 3,),

                                        Text(
                                          itemsCategory[i].categoryitems[index]['price'].toString(), textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'Urbanist',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xffF10000)),),
                                        SizedBox(height: 3,),
                                      ],
                                    ),
                                  ),
//=========================//
                         itemsCategory[i].categoryitems[index]['ShouldVisible']?
                        Padding(padding: EdgeInsets.only(left: 7),
                          child: InkWell(
                            onTap: (){
                              final findIndex=cartlist.indexWhere((element) => element['name'] ==itemsCategory[i].categoryitems[index]['name']);
                              print("index" +findIndex.toString());
                              if(findIndex>=0) {
                                setState(() {
                                  cartlist[findIndex]['quantity'] =itemsCategory[i].categoryitems[index]['counter'] ;
                                });
                              }else {
                                cartlist.add({
                                  'img': itemsCategory[i].categoryitems[index]['image'],
                                  'name': itemsCategory[i].categoryitems[index]['name'],
                                  'price': itemsCategory[i].categoryitems[index]['price'],
                                  'quantity':itemsCategory[i].categoryitems[index]['counter'],
                                });
                              }
                              print(cartlist);
                              final snackBar = SnackBar(
                                backgroundColor: Colors.white,
                                content: const Text(' item added to cart',
                                  style: TextStyle(color: Colors.black),),
                                action: SnackBarAction(

                                  textColor: Colors.blue,
                                  label: 'Go To Cart',
                                  onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CheckOutPage()));



                                    // Some code to undo the change.
                                  },
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);


                            },
                            child: Container(
                              width: 99,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color(0xff02B558)
                                // color: Colors.red
                              ),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        if(itemsCategory[i].categoryitems[index]['counter'] <2)
                                        {
                                          itemsCategory[i].categoryitems[index]['ShouldVisible']= ! itemsCategory[i].categoryitems[index]['ShouldVisible'];
                                        }else{
                                          itemsCategory[i].categoryitems[index]['counter']--;
                                        }

                                      });
                                      final findIndex=cartlist.indexWhere((element) => element['name'] ==itemsCategory[i].categoryitems[index]['name']);
                                      print("index" +findIndex.toString());
                                      if(findIndex>=0) {
                                        setState(() {
                                          cartlist[findIndex]['quantity'] =itemsCategory[i].categoryitems[index]['counter'] ;
                                        });
                                      }else {
                                        cartlist.add({
                                          'img': itemsCategory[i].categoryitems[index]['image'],
                                          'name': itemsCategory[i].categoryitems[index]['name'],
                                          'price': itemsCategory[i].categoryitems[index]['price'],
                                          'quantity':itemsCategory[i].categoryitems[index]['counter'],
                                        });
                                      }
                                      print(cartlist);
                                      final snackBar = SnackBar(
                                        backgroundColor: Colors.white,
                                        content: const Text(' item added to cart',
                                          style: TextStyle(color: Colors.black),),
                                        action: SnackBarAction(

                                          textColor: Colors.blue,
                                          label: 'Go To Cart',
                                          onPressed: () {
                                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CheckOutPage()));



                                            // Some code to undo the change.
                                          },
                                        ),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 32,
                                      decoration: BoxDecoration(
                                          color: Color(0xff02B558),
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(8),
                                              bottomLeft:Radius.circular(8) )),
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 8),
                                        child: Icon(Icons.minimize_outlined,size: 15,color: Colors.white,),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color: Color(0xff9FFFCD),
                                    ),
                                    child: Center(child: Text('${ itemsCategory[i].categoryitems[index]['counter']}')),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        itemsCategory[i].categoryitems[index]['counter']++;
                                      });
                                      final findIndex=cartlist.indexWhere((element) => element['name'] ==itemsCategory[i].categoryitems[index]['name']);
                                      print("index" +findIndex.toString());
                                      if(findIndex>=0) {
                                        setState(() {
                                          cartlist[findIndex]['quantity'] =itemsCategory[i].categoryitems[index]['counter'] ;
                                        });
                                      }else {
                                        cartlist.add({
                                          'img': itemsCategory[i].categoryitems[index]['image'],
                                          'name': itemsCategory[i].categoryitems[index]['name'],
                                          'price': itemsCategory[i].categoryitems[index]['price'],
                                          'quantity':itemsCategory[i].categoryitems[index]['counter'],
                                        });
                                      }
                                      print(cartlist);
                                      final snackBar = SnackBar(
                                        backgroundColor: Colors.white,
                                        content: const Text(' item added to cart',
                                          style: TextStyle(color: Colors.black),),
                                        action: SnackBarAction(

                                          textColor: Colors.blue,
                                          label: 'Go To Cart',
                                          onPressed: () {
                                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CheckOutPage()));



                                            // Some code to undo the change.
                                          },
                                        ),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    },
                                    child: Container(
                                      height: 26,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: Color(0xff02B558),
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(8),
                                              bottomLeft:Radius.circular(8) )

                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Icon(Icons.add,size: 15,color: Colors.white,),
                                      ),
                                    ),
                                  ),

                                ],
                              ),

                            ),
                          ),
                        ):
                        Padding(
                          padding:  EdgeInsets.only(left: 7),
                          child:  InkWell(
                            onTap: (){
                              setState(() {
                                itemsCategory[i].categoryitems[index]['ShouldVisible']=! itemsCategory[i].categoryitems[index]['ShouldVisible'];
                              });
                              final findIndex=cartlist.indexWhere((element) => element['name'] ==itemsCategory[i].categoryitems[index]['name']);
                              print("index" +findIndex.toString());
                              if(findIndex>=0) {
                                setState(() {
                                  cartlist[findIndex]['quantity'] = itemsCategory[i].categoryitems[index]['counter'];
                                });
                              }else {
                                cartlist.add({
                                  'img': itemsCategory[i].categoryitems[index]['image'],
                                  'name': itemsCategory[i].categoryitems[index]['name'],
                                  'price': itemsCategory[i].categoryitems[index]['price'],
                                  'unit':itemsCategory[i].categoryitems[index]['unit'],
                                  'quantity':itemsCategory[i].categoryitems[index]['counter'],
                                });
                              }
                              print(cartlist);
                              final snackBar = SnackBar(
                                backgroundColor: Colors.white,
                                content: const Text(' item added to cart',
                                  style: TextStyle(color: Colors.black),),
                                action: SnackBarAction(

                                  textColor: Colors.blue,
                                  label: 'Go To Cart',
                                  onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CheckOutPage()));
                                    // Some code to undo the change.
                                  },
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            },
                            child: Container(
                              width: 99,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color(0xff02B558)
                                // color: Colors.red
                              ),
                              child: Center(
                                child: Text("Add",style: TextStyle(
                                    fontFamily: 'Urbanist',fontWeight: FontWeight.w600,fontSize: 12,color: Colors.white
                                ),),
                              ),
                            ),
                          ),

                        ),
//=========================//

// Padding(
//   padding: EdgeInsets.only(left: 7),
//   child: InkWell(
//     onTap: (){
//       // setState((){
//       // if(_isSelected){
//       // _selectedIndexs.remove(index);
//       //
//       // }else{
//       // _selectedIndexs.add(index);
//       //
//       // }
//       // });
//
//       final findIndex=cartList.indexWhere((element) => element['name']==eachstore[index].productname);
//       print("index" +findIndex.toString());
//       if(findIndex>=0){
//         setState(() {
//           cartList[findIndex]['quantity'] =eachstore[index].counter;
//         });
//       }else{
//         cartList.add({
//           'name':eachstore[index].productname,
//           'image':eachstore[index].productimage,
//           'unit':eachstore[index].productunit,
//           'price':eachstore[index].productprice,
//           'quantity':eachstore[index].counter,
//         });
//       }
//       print(eachstore[index].counter);
//       print(cartList);
//       final snackBar = SnackBar(
//         backgroundColor: Colors.green,
//         content:  Text('${eachstore[index].counter} ${eachstore[index].productname} added to cart',
//           style: TextStyle(color: Colors.white),),
//         action: SnackBarAction(
//           textColor: Colors.white,
//           label: 'Go To Cart',
//           onPressed: () {
//             Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CheckOutPage()));
//             // Some code to undo the change.
//           },
//         ),
//       );
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//
//     },
//     child:Container(
//       width: 126,
//       height: 30,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//           color: Color(0xff02B558)
//         // color: Colors.red
//       ),
//       child:eachstore[index].ShouldVisible?
//       Row(
//         children: [
//           Container(
//             height: 30,
//             width: 45,
//             decoration: BoxDecoration(
//                 color: Color(0xff02B558),
//                 borderRadius: BorderRadius.only(topLeft: Radius.circular(8),
//                     bottomLeft:Radius.circular(8) )
//
//             ),
//             child: Padding(
//               padding: const EdgeInsets.only(bottom: 8),
//               child: InkWell(
//                   onTap:(){
//                     setState(() {
//                       if(eachstore[index].counter <2)
//                       {
//                         eachstore[index].ShouldVisible = !eachstore[index].ShouldVisible;
//                       }else{
//                         eachstore[index].counter--;
//                       }
//
//                     });
//                   },
//                   child: Icon(Icons.minimize_outlined,size: 15,color: Colors.white,)),
//             ),
//           ),
//           Container(
//             height: 30,
//             width: 36,
//             decoration: BoxDecoration(
//               color: Color(0xff9FFFCD),
//             ),
//             child: Center(child: InkWell(
//               onTap: (){
//
//               },
//                 child: Text(eachstore[index].counter.toString()))),
//           ),
//           Container(
//             height: 26,
//             width: 30,
//             decoration: BoxDecoration(
//                 color: Color(0xff02B558),
//                 borderRadius: BorderRadius.only(topLeft: Radius.circular(8),
//                     bottomLeft:Radius.circular(8) )
//
//             ),
//             child: InkWell(
//                 onTap:(){
//                   setState(() {
//                     eachstore[index].counter++;
//                   });
//                 },
//                 child: Padding(
//                   padding: EdgeInsets.only(left: 5),
//                   child: Icon(Icons.add,size: 15,color: Colors.white,),
//                 )),
//           ),
//         ],
//       )
//       : InkWell(
//         onTap: (){
//           setState(() {
//             eachstore[index].ShouldVisible = !eachstore[index].ShouldVisible;
//           });
//         },
//         child: Container(
//           width: 126,
//           height: 30,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8),
//               color: Color(0xff02B558)
//             // color: Colors.red
//           ),
//           child: Center(
//             child: Text("Add",style: TextStyle(
//             fontFamily: 'Urbanist',fontWeight: FontWeight.w600,fontSize: 12,color: Colors.white
//             ),),
//           ),
//         ),
//       )
//     ),
//   ),
//   ),
                                ],
                              ),
                            );

                          },)

                        // Row(
                        //   children: [
                        //     Text(vehicles[i].contents[0]['image']),
                        //     Text(vehicles[i].contents[0]['price'].toString()),
                        //
                        //
                        //   ],
                        // ),
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
