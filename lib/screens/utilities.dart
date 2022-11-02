import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:threems/screens/splash_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../utils/themes.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_linkify/flutter_linkify.dart';




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

class _UtilitiesState extends State<Utilities> {

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


  var linkText =TextStyle(color: Colors.red,);

  var defaultText =TextStyle(color: Colors.blue,);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

