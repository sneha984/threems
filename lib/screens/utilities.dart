import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:threems/screens/splash_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../utils/themes.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

import '../widgets/list.dart';




class Utilities extends StatefulWidget {

  // Future<firebase_storage.UploadTask> uploadFile(File file) async {
  //   // if(file ==null){
  //   //   print("no file picked up");
  //   //   return null;
  //   // }
  //
  //   firebase_storage.UploadTask uploadTask;
  //
  //   // Create a Reference to the file
  //   firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
  //       .ref()
  //       .child('files')
  //       .child('/some-file.pdf');
  //
  //   final metadata = firebase_storage.SettableMetadata(
  //       contentType: 'file/pdf',
  //       customMetadata: {'picked-file-path': file.path});
  //   print("Uploading..!");
  //   //putdata is just upload files
  //
  //   uploadTask = ref.putData(await file.readAsBytes(), metadata);
  //
  //   print("done..!");
  //   return Future.value(uploadTask);
  // }

   Utilities({Key? key}) : super(key: key);

  @override
  State<Utilities> createState() => _UtilitiesState();
}
// class Vehicle {
//   final String title;
//   List<Map<String,dynamic>> contents;
//   final IconData icon;
//
//   Vehicle(this.title, this.contents, this.icon);
// }
class Items{
  final String categoryname;
  List<Map<String,dynamic>> categoryitems;
  Items(
      this.categoryname, this.categoryitems
);
}



class _UtilitiesState extends State<Utilities> {
  // List<Vehicle> vehicles = [
  //   Vehicle(
  //     'Bike',
  //     [{
  //       "image":"akhil",
  //       "price":1,
  //     },{
  //       "image":"akhil",
  //       "price":1,
  //     }],
  //     Icons.motorcycle,
  //   ),
  //   Vehicle(
  //     'Cars',
  //     [{
  //       "image":"sneha",
  //       "price":2,
  //     },
  //       {
  //         "image":"sneha",
  //         "price":2,
  //       }
  //     ],
  //     Icons.directions_car,
  //   ),
  // ];
  List <Items> itemsCategory=[

    Items(
      'Rice Products',
      [{
        'image':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3YhxUEFTHw7Q7YAzXp7AG7-oqE6AI5x8O8Q&usqp=CAU',
        'unit':'1 kg',
        'price':'243',
        'name':'Surf Ecl'

      },
        {
          'image':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3YhxUEFTHw7Q7YAzXp7AG7-oqE6AI5x8O8Q&usqp=CAU',
          'unit':'1 kg',
          'price':'243',
          'name':'Surf Ecl'

        },
        {
          'image':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3YhxUEFTHw7Q7YAzXp7AG7-oqE6AI5x8O8Q&usqp=CAU',
          'unit':'1 kg',
          'price':'243',
          'name':'Surf Ecl'

        },
        {
          'image':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3YhxUEFTHw7Q7YAzXp7AG7-oqE6AI5x8O8Q&usqp=CAU',
          'unit':'1 kg',
          'price':'243',
          'name':'Surf Ecl'

        }
      ]
    ),
    Items(
        'Rice Products',
        [{
          'image':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3YhxUEFTHw7Q7YAzXp7AG7-oqE6AI5x8O8Q&usqp=CAU',
          'unit':'1 kg',
          'price':'243',
          'name':'Surf Ecl'

        },
          {
            'image':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3YhxUEFTHw7Q7YAzXp7AG7-oqE6AI5x8O8Q&usqp=CAU',
            'unit':'1 kg',
            'price':'243',
            'name':'Surf Ecl'

          }
        ]
    ),
    Items(
        'Rice Products',
        [{
          'image':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3YhxUEFTHw7Q7YAzXp7AG7-oqE6AI5x8O8Q&usqp=CAU',
          'unit':'1 kg',
          'price':'243',
          'name':'Surf Ecl'

        },
          {
            'image':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3YhxUEFTHw7Q7YAzXp7AG7-oqE6AI5x8O8Q&usqp=CAU',
            'unit':'1 kg',
            'price':'243',
            'name':'Surf Ecl'

          }
        ]
    ),

  ];
  var currencyConvert = NumberFormat.currency(
    locale: 'HI',
    symbol: '₹ ',
  );
  bool _customTileExpanded = false;


  // String? imgUrl;
  // var imgFile;
  // var uploadTask;
  // var fileUrl;
  // var fileName;
  //
  //
  // Future uploadImageToFirebase(BuildContext context) async {
  //   Reference firebaseStorageRef =
  //   FirebaseStorage.instance.ref().child('deposits/${imgFile.path}');
  //   UploadTask uploadTask = firebaseStorageRef.putFile(imgFile);
  //   TaskSnapshot taskSnapshot = (await uploadTask);
  //   String value = await taskSnapshot.ref.getDownloadURL();
  //
  //   // if(value!=null){
  //   //   imageList.add(value);
  //   // }
  //   setState(() {
  //     imgUrl = value;
  //
  //   });
  // }
  // _pickImage() async {
  //   final imageFile = await ImagePicker.platform.pickImage(
  //       source: ImageSource.gallery);
  //   setState(() {
  //     imgFile = File(imageFile!.path);
  //     uploadImageToFirebase(context);
  //   });
  // }
  // var pickFile;
  // Future uploadFileToFireBase(fileBytes) async {
  //   print(fileBytes);
  //   uploadTask = FirebaseStorage.instance.ref('uploads/${DateTime.now()}').putData(fileBytes);
  //   final snapshot= await  uploadTask?.whenComplete((){});
  //   final urlDownlod = await  snapshot?.ref.getDofwnloadURL();
  //   print("--------------------------------------------------------------------------------");
  //
  //   print(urlDownlod);
  //
  //   // FirebaseFirestore.instance.collection('candidates').doc(widget.id).update({
  //   //   'documents.$name':urlDownlod,
  //   // });
  //
  //   setState(() {
  //     fileUrl=urlDownlod!;
  //
  //   });
  //
  // }
  // _pickFile() async {
  //   final result = await FilePicker.platform.pickFiles(
  //     withData: true,
  //   );
  //
  //   if(result==null) return;
  //
  //   pickFile=result.files.first;
  //   final fileBytes = pickFile!.bytes;
  //   fileName = result.files.first.name;
  //   // print("File1234");
  //   // print(pickFile);
  //   // print(fileBytes);
  //   uploadFileToFireBase(fileBytes);
  //   setState(() {
  //
  //   });
  //
  //
  // }


  // var linkText =TextStyle(color: Colors.red,);
  //
  // var defaultText =TextStyle(color: Colors.blue,);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ListView.builder(
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
            color: Colors.red,
                child:GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount:itemsCategory[i].categoryitems.length,
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 3 / 4.15,
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
                            height: 100,
                            width: 120,
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
                              itemsCategory[i].categoryitems[index]['price'], textAlign: TextAlign.center,
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
// eachstore[index].ShouldVisible?
// Padding(padding: EdgeInsets.only(left: 7),
//   child: InkWell(
//     onTap: (){
//       final findIndex=cartlist.indexWhere((element) => element['name'] ==eachstore[index].productname);
//       print("index" +findIndex.toString());
//       if(findIndex>=0) {
//         setState(() {
//           cartlist[findIndex]['quantity'] = eachstore[index].counter;
//         });
//       }else {
//         cartlist.add({
//           'img': eachstore[index].productimage,
//           'name': eachstore[index].productname,
//           'price': eachstore[index].productprice,
//           'quantity':eachstore[index].counter,
//         });
//       }
//       print(cartlist);
//       final snackBar = SnackBar(
//         backgroundColor: Colors.white,
//         content: const Text(' item added to cart',
//           style: TextStyle(color: Colors.black),),
//         action: SnackBarAction(
//
//           textColor: Colors.blue,
//           label: 'Go To Cart',
//           onPressed: () {
//             Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CheckOutPage()));
//
//
//
//             // Some code to undo the change.
//           },
//         ),
//       );
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//
//
//     },
//     child: Container(
//       width: 126,
//       height: 30,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//           color: Color(0xff02B558)
//         // color: Colors.red
//       ),
//       child: Row(
//         children: [
//           InkWell(
//             onTap: (){
//               setState(() {
//                 if(eachstore[index].counter <2)
//                 {
//                   eachstore[index].ShouldVisible = !eachstore[index].ShouldVisible;
//                 }else{
//                   eachstore[index].counter--;
//                 }
//
//               });
//             },
//             child: Container(
//               height: 30,
//               width: 45,
//               decoration: BoxDecoration(
//                   color: Color(0xff02B558),
//                   borderRadius: BorderRadius.only(topLeft: Radius.circular(8),
//                       bottomLeft:Radius.circular(8) )),
//               child: Padding(
//                 padding: const EdgeInsets.only(bottom: 8),
//                 child: Icon(Icons.minimize_outlined,size: 15,color: Colors.white,),
//               ),
//             ),
//           ),
//           Container(
//             height: 30,
//             width: 36,
//             decoration: BoxDecoration(
//               color: Color(0xff9FFFCD),
//             ),
//             child: Center(child: Text('${eachstore[index].counter}')),
//           ),
//           InkWell(
//             onTap: (){
//               setState(() {
//                 eachstore[index].counter++;
//               });
//             },
//             child: Container(
//               height: 26,
//               width: 30,
//               decoration: BoxDecoration(
//                   color: Color(0xff02B558),
//                   borderRadius: BorderRadius.only(topLeft: Radius.circular(8),
//                       bottomLeft:Radius.circular(8) )
//
//               ),
//               child: Padding(
//                 padding: EdgeInsets.only(left: 5),
//                 child: Icon(Icons.add,size: 15,color: Colors.white,),
//               ),
//             ),
//           ),
//
//         ],
//       ),
//
//     ),
//   ),
// ):
// Padding(
//   padding:  EdgeInsets.only(left: 7),
//   child:  InkWell(
//     onTap: (){
//       setState(() {
//         eachstore[index].ShouldVisible=!eachstore[index].ShouldVisible;
//       });
//       final findIndex=cartlist.indexWhere((element) => element['name'] ==eachstore[index].productname);
//       print("index" +findIndex.toString());
//       if(findIndex>=0) {
//         setState(() {
//           cartlist[findIndex]['quantity'] = eachstore[index].counter;
//         });
//       }else {
//         cartlist.add({
//           'img': eachstore[index].productimage,
//           'name': eachstore[index].productname,
//           'price': eachstore[index].productprice,
//           'unit':eachstore[index].productunit,
//           'quantity':eachstore[index].counter,
//         });
//       }
//       print(cartlist);
//       final snackBar = SnackBar(
//         backgroundColor: Colors.white,
//         content: const Text(' item added to cart',
//           style: TextStyle(color: Colors.black),),
//         action: SnackBarAction(
//
//           textColor: Colors.blue,
//           label: 'Go To Cart',
//           onPressed: () {
//             Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CheckOutPage()));
//
//
//
//             // Some code to undo the change.
//           },
//         ),
//       );
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     },
//     child: Container(
//       width: 126,
//       height: 30,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//           color: Color(0xff02B558)
//         // color: Colors.red
//       ),
//       child: Center(
//         child: Text("Add",style: TextStyle(
//             fontFamily: 'Urbanist',fontWeight: FontWeight.w600,fontSize: 12,color: Colors.white
//         ),),
//       ),
//     ),
//   ),
//
// ),
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
      // Center(child: Text("Utilities"),),
      // body:
      // Column(
      //   children: [
      //     SizedBox(height: 100,),
      //     FloatingActionButton(onPressed: (){
      //       _pickImage();
      //     },child: imgFile==null?Container(
      //       height: 300,
      //       width: 300,
      //       color: Colors.red,
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           SvgPicture.asset(
      //             'assets/icons/camera2.svg',
      //             color: Color(0xff8391A1),
      //           ),
      //           SizedBox(
      //             width: scrWidth * 0.04,
      //           ),
      //           Text(
      //             'Upload Cover Photo',
      //             style: TextStyle(
      //               fontSize: FontSize15,
      //               fontFamily: 'Urbanist',
      //               fontWeight: FontWeight.w500,
      //               color: Color(0xff8391A1),
      //             ),
      //           )
      //         ],
      //       ),
      //     ):Container(
      //       height:scrHeight*0.16,
      //       width: scrWidth*1,
      //       decoration: BoxDecoration(
      //         image: DecorationImage(
      //             image: FileImage(imgFile!) as ImageProvider,fit: BoxFit.fill),
      //         borderRadius: BorderRadius.circular(8),
      //         border: Border.all(
      //           color: Color(0xffDADADA),
      //         ),
      //       ),
      //
      //     ),
      //     ),
      //    InkWell(
      //      onTap: (){
      //        _pickFile();
      //      },
      //      child: Container(
      //        height: 200,
      //        width: 200,
      //        child: pickFile==null? Container(
      //          width: scrWidth,
      //          height: textFormFieldHeight45,
      //          padding: EdgeInsets.symmetric(
      //            horizontal: scrWidth * 0.015,
      //            vertical: scrHeight*0.002,
      //          ),
      //          decoration: BoxDecoration(
      //            color: textFormFieldFillColor,
      //            border: Border.all(
      //              color: Color(0xffDADADA),
      //            ),
      //            borderRadius: BorderRadius.circular(scrWidth * 0.026),
      //          ),
      //          child: Padding(
      //            padding:  EdgeInsets.symmetric(horizontal: scrHeight*0.03),
      //            child: Row(
      //              mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //              children: [
      //                Text(
      //                  "Upload Documents",
      //                  style: TextStyle(
      //                    color: Color(0xff8391A1),
      //                    fontWeight: FontWeight.w500,
      //                    fontSize: FontSize15,
      //                    fontFamily: 'Urbanist',
      //                  ),
      //                ),
      //                SvgPicture.asset(
      //                  'assets/icons/camera2.svg',
      //                  color: Color(0xff8391A1),
      //                ),
      //              ],
      //            ),
      //          ),
      //        ):  Container(
      //              height: scrHeight*0.19,
      //              width: scrWidth*0.3,
      //              decoration: BoxDecoration(
      //                // color: Colors.pink,
      //                borderRadius: BorderRadius.circular(8),
      //              ),
      //              child:Text(fileName),
      //
      //        ),
      //      ),
      //    ),
      //
      //     // FloatingActionButton(
      //     //   onPressed: () async {
      //     //     final path = await FlutterDocumentPicker.openDocument();
      //     //     print(path);
      //     //     File file=File(path!);
      //     //     firebase_storage.UploadTask task=await uploadFile(file) ;
      //     //     Navigator.pop(context);
      //     //     //firebase_storage.UploadTask task = await uploadFile(file);
      //     //   },
      //     //   child: Text("select file"),),
      //     SizedBox(height: 30,),
      //     //--------------------------------------------------youtube-----------------------------------
      //     // RichText(
      //     //     text: TextSpan(
      //     //         children: [
      //     //           TextSpan(
      //     //               style: defaultText,
      //     //               text: "To learn more "
      //     //           ),
      //     //           TextSpan(
      //     //               style: linkText,
      //     //               text: "Click here",
      //     //               recognizer: TapGestureRecognizer()..onTap =  () async{
      //     //                 var url = "https://youtu.be/RmVKTH71soI";
      //     //                 if (await canLaunch(url)) {
      //     //                   await launch(url);
      //     //                 } else {
      //     //                   throw 'Could not launch $url';
      //     //                 }
      //     //               }
      //     //           ),
      //     //         ]
      //     //     )),
      //     // Linkify(
      //     //   onOpen: (link)  {
      //     //     print("Linkify link = ${link.url}");
      //     //   },
      //     //   options: LinkifyOptions(humanize: false,removeWww: true),
      //     //
      //     //   text: "Linkify click -  https://www.youtube.com/channel/UCwxiHP2Ryd-aR0SWKjYguxw",
      //     //   style: TextStyle(color: Colors.blue),
      //     //   linkStyle: TextStyle(color: Colors.green),
      //     // ),
      //     //--------------------------------------------------youtube-----------------------------------
      //
      //   ],
      // ),

      );
  }
  // _buildExpandableContent(Vehicle vehicle) {
  //   List<Widget> columnContent = [];
  //
  //   for (String content in vehicle.contents)
  //     columnContent.add(
  //       ListTile(
  //         title: Text(content, style: TextStyle(fontSize: 18.0),),
  //         leading: Icon(vehicle.icon),
  //       ),
  //     );
  //
  //   return columnContent;
  // }

}

// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:threems/utils/themes.dart';
//
// class LineChartSample3 extends StatefulWidget {
//   final weekDays = const ['Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri','Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
//
//   final List<double> yValues = const [1.3, 1, 1.8, 1.5, 2.2, 1.8, 3,4,5,6,7,8,9];
//
//   const LineChartSample3({Key? key}) : super(key: key);
//
//   @override
//   State createState() => _LineChartSample3State();
// }
//
// class _LineChartSample3State extends State<LineChartSample3> {
//   late double touchedValue;
//
//   @override
//   void initState() {
//     touchedValue = -1;
//     super.initState();
//   }
//
//   Widget leftTitleWidgets(double value, TitleMeta meta) {
//     const style = TextStyle(color: Colors.black, fontSize: 10);
//     String text;
//     switch (value.toInt()) {
//       case 0:
//         text = '';
//         break;
//       case 1:
//         text = '1k calories';
//         break;
//       case 2:
//         text = '2k calories';
//         break;
//       case 3:
//         text = '3k calories';
//         break;
//       default:
//         return Container();
//     }
//
//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       space: 6,
//       child: Text(text, style: style, textAlign: TextAlign.center),
//     );
//   }
//
//   Widget bottomTitleWidgets(double value, TitleMeta meta) {
//     final isTouched = value == touchedValue;
//     final style = TextStyle(
//       color: isTouched ? Colors.green: Colors.grey,
//       fontWeight: FontWeight.bold,
//     );
//
//     return SideTitleWidget(
//       space: 4,
//       child: Text(widget.weekDays[value.toInt()], style: style),
//       axisSide: meta.axisSide,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         SizedBox(height: 200,),
//         Row(
//           mainAxisSize: MainAxisSize.min,
//           children: const <Widget>[
//             Text(
//               'Average Line',
//               style: TextStyle(
//                   color: Colors.green,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16),
//             ),
//             Text(
//               ' and ',
//               style: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16),
//             ),
//             Text(
//               'Indicators',
//               style: TextStyle(
//                   color: Colors.blue,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16),
//             ),
//           ],
//         ),
//         const SizedBox(
//           height: 18,
//         ),
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: SizedBox(
//             width: 1000,
//             height: 280,
//             child: LineChart(
//               LineChartData(
//                 lineTouchData: LineTouchData(
//                     getTouchedSpotIndicator:
//                         (LineChartBarData barData, List<int> spotIndexes) {
//                       return spotIndexes.map((spotIndex) {
//                         final spot = barData.spots[spotIndex];
//                         if (spot.x == 0 || spot.x == 6) {
//                           return null;
//                         }
//                         return TouchedSpotIndicatorData(
//                           FlLine(color: Colors.blue, strokeWidth: 4),
//                           FlDotData(
//                             getDotPainter: (spot, percent, barData, index) {
//                                 return FlDotCirclePainter(
//                                     radius: 8,
//                                     color: Colors.white,
//                                     strokeWidth: 5,
//                                     strokeColor: primarycolor);
//                                 },
//                           ),
//                         );
//                       }).toList();
//                     },
//                     touchTooltipData: LineTouchTooltipData(
//                         tooltipBgColor: Colors.blueAccent,
//                         getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
//                           return touchedBarSpots.map((barSpot) {
//                             final flSpot = barSpot;
//                             if (flSpot.x == 0 || flSpot.x == 6) {
//                               return null;
//                             }
//
//                             // TextAlign textAlign;
//                             // switch (flSpot.x.toInt()) {
//                             //   case 1:
//                             //     textAlign = TextAlign.left;
//                             //     break;
//                             //   case 5:
//                             //     textAlign = TextAlign.right;
//                             //     break;
//                             //   default:
//                             //     textAlign = TextAlign.center;
//                             // }
//
//                             return LineTooltipItem(
//                               '${widget.weekDays[flSpot.x.toInt()]} \n',
//                               const TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               children: [
//                                 TextSpan(
//                                   text: flSpot.y.toString(),
//                                   style: TextStyle(
//                                     color: Colors.grey[100],
//                                     fontWeight: FontWeight.normal,
//                                   ),
//                                 ),
//                                 const TextSpan(
//                                   text: ' k ',
//                                   style: TextStyle(
//                                     fontStyle: FontStyle.italic,
//                                     fontWeight: FontWeight.normal,
//                                   ),
//                                 ),
//                                 const TextSpan(
//                                   text: 'calories',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.normal,
//                                   ),
//                                 ),
//                               ],
//                             );
//                           }).toList();
//                         }),
//                     touchCallback:
//                         (FlTouchEvent event, LineTouchResponse? lineTouch) {
//                       if (!event.isInterestedForInteractions ||
//                           lineTouch == null ||
//                           lineTouch.lineBarSpots == null) {
//                         setState(() {
//                           touchedValue = -1;
//                         });
//                         return;
//                       }
//                       final value = lineTouch.lineBarSpots![0].x;
//
//                       if (value == 0 || value == 6) {
//                         setState(() {
//                           touchedValue = -1;
//                         });
//                         return;
//                       }
//
//                       setState(() {
//                         touchedValue = value;
//                       });
//                     }),
//
//                 lineBarsData: [
//                   LineChartBarData(
//
//                     spots: widget.yValues.asMap().entries.map((e) {
//                       return FlSpot(e.key.toDouble(), e.value);
//                     }).toList(),
//                     isCurved: true,
//                     barWidth: 4,
//                     color: primarycolor,
//                     belowBarData: BarAreaData(
//                       show: true,
//                       gradient: LinearGradient(
//                         colors: [
//                           Colors.green.withOpacity(0.5),
//                           Colors.green.withOpacity(0.0),
//                         ],
//                         stops: const [0.5, 1.0],
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                       ),
//                       spotsLine: BarAreaSpotsLine(
//                         show: true,
//                         flLineStyle: FlLine(
//                           color: Colors.blue,
//                           strokeWidth: 2,
//                         ),
//                         checkToShowSpotLine: (spot) {
//                           if (spot.x == 0 || spot.x == 6) {
//                             return false;
//                           }
//
//                           return true;
//                         },
//                       ),
//                     ),
//                     dotData: FlDotData(
//                         show: true,
//                         getDotPainter: (spot, percent, barData, index) {
//                             return FlDotCirclePainter(
//                                 radius: 6,
//                                 color: Colors.white,
//                                 strokeWidth: 4,
//                                 strokeColor: primarycolor);
//
//                         },
//                         checkToShowDot: (spot, barData) {
//                           return spot.x != 0 && spot.x != 6;
//                         }),
//                   ),
//                 ],
//                 minY: 0,
//                 gridData: FlGridData(
//                   show: false,
//
//                 ),
//                 titlesData: FlTitlesData(
//                   show: true,
//                   topTitles: AxisTitles(
//                     sideTitles: SideTitles(showTitles: false),
//                   ),
//                   rightTitles: AxisTitles(
//                     sideTitles: SideTitles(showTitles: false),
//                   ),
//                   leftTitles: AxisTitles(
//                     sideTitles: SideTitles(
//                       showTitles: true,
//                       reservedSize: 46,
//                       getTitlesWidget: leftTitleWidgets,
//                     ),
//                   ),
//                   bottomTitles: AxisTitles(
//                     sideTitles: SideTitles(
//                       showTitles: true,
//                       reservedSize: 40,
//                       getTitlesWidget: bottomTitleWidgets,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }


// Container(
// height: 500,
// width: 500,
// child: SfRadialGauge(
// axes: <RadialAxis>[
// // Create primary radial axis
// RadialAxis(
// minimum: 0,
// interval: 1,
// maximum: 360,
// showLabels: false,
// showLastLabel: false,
// showTicks: false,
// startAngle: 270,
// endAngle: 270,
// radiusFactor: 0.3,
// axisLineStyle: AxisLineStyle(
// thickness:0.2,
// color: Colors.grey.withOpacity(0.2),
// thicknessUnit: GaugeSizeUnit.factor,
// ),
// pointers: <GaugePointer>[
// RangePointer(
// value: 240,
// enableAnimation: true,
// animationDuration: 6000,
// animationType: AnimationType.slowMiddle,
// width: 0.21,
// sizeUnit: GaugeSizeUnit.factor,
// cornerStyle: CornerStyle.startCurve,
// gradient: const SweepGradient(colors: <Color>[
// primarycolor,
// Color(0xff96c8aa)
// ],
// stops: <double>[
// 0.74,
// 0.99
// ])),
// MarkerPointer(
// enableAnimation: true,
// animationDuration: 6000,
// animationType: AnimationType.slowMiddle,
// value: 240,
// markerWidth: 17,
// markerHeight: 17,
// borderWidth:5,
// borderColor:  Color(0xff96c8aa),
// markerType: MarkerType.circle,
// color: Colors.white,
// )
// ],
// annotations:<GaugeAnnotation> [
// GaugeAnnotation(angle: 0,positionFactor: 0.18,
// widget:Text("50%",textAlign: TextAlign.center,style: TextStyle(
// fontSize: 23,fontFamily: 'Urbanist',fontWeight: FontWeight.w600
// ),),
// )
//
// ],
//
// )
// ]),
// )

