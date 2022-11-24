// //@dart=2.9
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// // import 'package:geoflutterfire/geoflutterfire.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_fonts/google_fonts.dart';
// // import 'package:myvahan/backend/backend.dart';
// // import 'package:myvahan/flutter_flow/upload_media.dart';
// // import 'package:myvahan/home/loginMyVahan.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart' as gMap;
// // import 'package:google_maps_place_picker/google_maps_place_picker.dart' as gMapPlacePicker;
//
// // import '../home/workshopview.dart';
// import '../kuri/createkuri.dart';
//
//
// class AddLocation extends StatefulWidget {
//   const AddLocation({Key key}) : super(key: key);
//
//   @override
//   _AddLocationState createState() => _AddLocationState();
// }
//
// class _AddLocationState extends State<AddLocation> {
//
//   // final geo = Geoflutterfire();
//   // gMapPlacePicker.PickResult result;
//
//   double lat;
//   double long;
//   TextEditingController latController = TextEditingController();
//   TextEditingController longController = TextEditingController();
//   TextEditingController place = TextEditingController();
//   TextEditingController city = TextEditingController();
//   TextEditingController pincode = TextEditingController();
//   TextEditingController district = TextEditingController();
//
//   double editLat;
//   double editLong;
//   TextEditingController editLatController = TextEditingController();
//   TextEditingController editLongController = TextEditingController();
//   TextEditingController editPlace = TextEditingController();
//   TextEditingController editCity = TextEditingController();
//   TextEditingController editPincode = TextEditingController();
//   TextEditingController editDistrict = TextEditingController();
//
//   get gMap => null;
//
//   get gMapPlacePicker => null;
//
//   set(){
//     setState(() {
//     });
//   }
//
//   var location;
//
//   // getAddedLocation(){
//   //   FirebaseFirestore.instance.collection('workshop').doc(currentShop.reference.id)
//   //       .collection('Location').doc('Location').snapshots().listen((event) {
//   //     location=event.data();
//   //     if(location!=null){
//   //
//   //       editPincode.text=location['pincode']??'';
//   //       editPlace.text=location['place']??'';
//   //       editDistrict.text=location['district']??'';
//   //       editLatController.text=location['lat'].toString()??'';
//   //       editLongController.text=location['long'].toString()??'';
//   //       editCity.text=location['city']??'';
//   //     }
//   //     if(mounted){
//   //       setState(() {
//   //
//   //       });
//   //     }
//   //   });
//   //
//   //
//   //
//   // }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // getLocation();
//     // getAddedLocation();
//   }
//
//   // Position currentLoc;
//   // getLocation() async {
//   //   currentLoc=await Geolocator.getCurrentPosition();
//   //
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor:Colors.grey,
//       appBar: AppBar(
//         backgroundColor:Colors.grey,
//         title: Text('Location',style: GoogleFonts.poppins(
//             fontSize: 20,color: Colors.white,fontWeight: FontWeight.w600),),
//         centerTitle: true,
//       ),
//       body:Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height * .91,
//         decoration: BoxDecoration(
//           image: const DecorationImage(
//               image: AssetImage('assets/images/Background.jpg'),
//               fit: BoxFit.fill),
//           borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(20),
//               topRight: Radius.circular(20)),
//           color: Colors.grey,
//         ),
//         child:
//         location!=null?
//         //EDIT
//
//         ListView(
//           children: [
//             Column(
//               children: [
//                 SizedBox(height: 20,),
//                 Text('Edit Location',style: GoogleFonts.poppins(
//                     fontSize: 18,color: Colors.black,fontWeight: FontWeight.w600),),
//                 SizedBox(height: 20,),
//                 InkWell(
//                   onTap: () async {
//                     Position location =await Geolocator.getCurrentPosition(
//                         desiredAccuracy: LocationAccuracy.high
//                     );
//                     await Navigator.push(
//                       context,
//                       MaterialPageRoute(
//
//                         builder: (context) => gMapPlacePicker.PlacePicker(
//                           apiKey: "AIzaSyCUZFUZ1yMpkzh6QUnKj54Q2N4L2iT4tBY",
//                           initialPosition: gMap.LatLng(
//                               location.latitude,location.longitude
//                           ),
//                           // Put YOUR OWN KEY here.
//                           searchForInitialValue: false,
//                           selectInitialPosition: true,
//                           // initialPosition: LatLng(currentLoc==null?0:currentLoc!.latitude,currentLoc==null?0:currentLoc!.longitude),
//                           onPlacePicked: (res) async {
//                             Navigator.of(context).pop();
//                             var result;
//
//                             // Address address=await geoCode.reverseGeocoding(latitude: res.geometry.location.lat,longitude: res.geometry.location.lng);
//                             result=res;
//
//                             List<Placemark> placemarks = await placemarkFromCoordinates(res.geometry.location.lat, res.geometry.location.lng);
//                             Placemark places = placemarks[0];
//                             editDistrict.text=places.subAdministrativeArea;
//                             String address=result.formattedAddress;
//                             if(result.formattedAddress.contains("+")){
//                               address=address.substring(address.indexOf(" ")+1,address.length);
//
//                             }
//
//                             print('============================================');
//                             print(result.formattedAddress);
//                             print('++++++++++++++++++++++++++++++++++++++++++++');
//
//                             editPlace.text=address.split(" ").first.replaceAll(",", "");
//                             editCity.text=places.locality;
//                             editPincode.text=places.postalCode;
//                             editLatController.text=res.geometry.location.lat.toString();
//                             editLongController.text=res.geometry.location.lng.toString();
//                             editLat=res.geometry.location.lat;
//                             editLong=res.geometry.location.lng;
//                             set();
//                           },
//                           useCurrentLocation: true,
//                         ),
//                       ),
//                     );
//                   },
//                   child:
//                   Container(
//                     width: MediaQuery.of(context).size.width*0.6,
//                     height: MediaQuery.of(context).size.width*0.1,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(3),
//                         border: Border.all(
//                             color: Colors.blue,width: 1
//                         )
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text('Choose your location', style: TextStyle(
//                             color:Color(0xff034a82), fontSize: 15),),
//                         Icon(
//                           Icons.location_on, color: Colors.pink, size: 30,),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 // editLat!=null&&editLong!=null?
//                 Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: SizedBox(
//                         height: MediaQuery.of(context).size.height*.055,
//                         child: TextFormField(
//                           controller: editPlace,
//                           style: GoogleFonts.poppins(color: Colors.grey,fontSize: 14),
//                           decoration: InputDecoration(
//                             contentPadding:   EdgeInsets.only(top: 5,left: 10),
//                             hintText: 'Place:',
//                             hintStyle: GoogleFonts.poppins(
//                                 color: Colors.grey,fontSize: 12),
//                             enabledBorder:  const OutlineInputBorder(borderSide: BorderSide(
//                                 color: Color(0xffEAEAEA),width: 2),
//                                 borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(10),topRight:Radius.circular(10),
//                                     bottomLeft: Radius.circular(10),
//                                     bottomRight: Radius.circular(10) )),
//                             focusedBorder:   OutlineInputBorder(borderSide: BorderSide(
//                                 color: Colors.grey,width: 1),
//                                 borderRadius:  BorderRadius.circular(10)),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: SizedBox(
//                         height: MediaQuery.of(context).size.height*.055,
//                         child: TextFormField(
//                           controller: editCity,
//                           style: GoogleFonts.poppins(color: Colors.grey,fontSize: 14),
//                           decoration: InputDecoration(
//                             contentPadding:   EdgeInsets.only(top: 5,left: 10),
//                             hintText: 'City Name:',
//                             hintStyle: GoogleFonts.poppins(
//                                 color: Colors.grey,fontSize: 12),
//                             enabledBorder:  OutlineInputBorder(borderSide: BorderSide(
//                                 color: Color(0xffEAEAEA),width: 2),
//                                 borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(10),topRight:Radius.circular(10),
//                                     bottomLeft: Radius.circular(10),
//                                     bottomRight: Radius.circular(10) )),
//                             focusedBorder:   OutlineInputBorder(borderSide: BorderSide(
//                                 color: Colors.grey,width: 1),
//                                 borderRadius:  BorderRadius.circular(10)),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: SizedBox(
//                         height: MediaQuery.of(context).size.height*.055,
//                         child: TextFormField(
//                           controller: editPincode,
//                           style: GoogleFonts.poppins(color: Colors.grey,fontSize: 14),
//                           decoration: InputDecoration(
//                             contentPadding:   EdgeInsets.only(top: 5,left: 10),
//                             hintText: 'Pincode :',
//                             hintStyle: GoogleFonts.poppins(
//                                 color: Colors.grey,fontSize: 12),
//                             enabledBorder:  OutlineInputBorder(borderSide: BorderSide(
//                                 color: Color(0xffEAEAEA),width: 2),
//                                 borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(10),topRight:Radius.circular(10),
//                                     bottomLeft: Radius.circular(10),
//                                     bottomRight: Radius.circular(10) )),
//                             focusedBorder:   OutlineInputBorder(borderSide: BorderSide(
//                                 color:Colors.grey,width: 1),
//                                 borderRadius:  BorderRadius.circular(10)),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: SizedBox(
//                         height: MediaQuery.of(context).size.height*.055,
//                         child: TextFormField(
//                           controller: editDistrict,
//                           style: GoogleFonts.poppins(color: Colors.grey,fontSize: 14),
//                           decoration: InputDecoration(
//                             contentPadding:   EdgeInsets.only(top: 5,left: 10),
//                             hintText: 'District Name :',
//                             hintStyle: GoogleFonts.poppins(
//                                 color: Colors.grey,fontSize: 12),
//                             enabledBorder:  OutlineInputBorder(borderSide: BorderSide(
//                                 color: Color(0xffEAEAEA),width: 2),
//                                 borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(10),topRight:Radius.circular(10),
//                                     bottomLeft: Radius.circular(10),
//                                     bottomRight: Radius.circular(10) )),
//                             focusedBorder:   OutlineInputBorder(borderSide: BorderSide(
//                                 color: Colors.grey,width: 1),
//                                 borderRadius:  BorderRadius.circular(10)),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: SizedBox(
//                         height: MediaQuery.of(context).size.height*.055,
//                         child: TextFormField(
//                           controller: editLatController,
//                           style: GoogleFonts.poppins(color: Colors.grey,fontSize: 14),
//                           decoration: InputDecoration(
//                             contentPadding:   EdgeInsets.only(top: 5,left: 10),
//                             hintText: 'Lat :',
//                             hintStyle: GoogleFonts.poppins(
//                                 color: Colors.grey,fontSize: 12),
//                             enabledBorder:  OutlineInputBorder(borderSide: BorderSide(
//                                 color: Color(0xffEAEAEA),width: 2),
//                                 borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(10),topRight:Radius.circular(10),
//                                     bottomLeft: Radius.circular(10),
//                                     bottomRight: Radius.circular(10) )),
//                             focusedBorder:   OutlineInputBorder(borderSide: BorderSide(
//                                 color: Colors.grey,width: 1),
//                                 borderRadius:  BorderRadius.circular(10)),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: SizedBox(
//                         height: MediaQuery.of(context).size.height*.055,
//                         child: TextFormField(
//                           controller: editLongController,
//                           style: GoogleFonts.poppins(color: Colors.grey,fontSize: 14),
//                           decoration: InputDecoration(
//                             contentPadding:   EdgeInsets.only(top: 5,left: 10),
//                             hintText: 'Long :',
//                             hintStyle: GoogleFonts.poppins(
//                                 color: Colors.grey,fontSize: 12),
//                             enabledBorder:  OutlineInputBorder(borderSide: BorderSide(
//                                 color: Color(0xffEAEAEA),width: 2),
//                                 borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(10),topRight:Radius.circular(10),
//                                     bottomLeft: Radius.circular(10),
//                                     bottomRight: Radius.circular(10) )),
//                             focusedBorder:   OutlineInputBorder(borderSide: BorderSide(
//                                 color: Colors.grey,width: 1),
//                                 borderRadius:  BorderRadius.circular(10)),
//                           ),
//                         ),
//                       ),
//                     ),
//
//
//                     SizedBox(height: 20,),
//                     InkWell(
//                       onTap: (){
//                         // FirebaseFirestore.instance.collection('workshop').doc(currentShop.reference.id)
//                         //     .collection('Location').doc('Location').update({
//                         //
//                         //   'place':editPlace.text,
//                         //   'district':editDistrict.text,
//                         //   'city':editCity.text,
//                         //   'pincode':editPincode.text,
//                         //   'lat':double.tryParse(editLatController.text),
//                         //   'long':double.tryParse(editLongController.text)
//                         //
//                         // });
//
//                         // FirebaseFirestore.instance.collection('workshop').doc(currentShop.reference.id).update({
//                         //   'lat':double.tryParse(editLatController.text),
//                         //   'long':double.tryParse(editLongController.text),
//                         //   'location':result.formattedAddress,
//                         //
//                         // });
//                         showSnackbar(context, 'Location Added SuccessFully');
//                         editPlace.text='';
//                         editDistrict.text='';
//                         editCity.text='';
//                         editPincode.text='';
//                         editLatController.text='';
//                         editLongController.text='';
//                         editLat=null;
//                         editLong=null;
//                       },
//                       child: Container(
//                         width: MediaQuery.of(context).size.width*0.15,
//                         height: 50,
//                         decoration: BoxDecoration(
//                             color: Colors.grey,
//                             borderRadius: BorderRadius.circular(15)
//                         ),
//                         child: Center(child: Text('Update',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
//                       ),
//                     )
//                   ],
//                 )
//                 // :Container(),
//
//               ],
//             ),
//           ],
//         )
//
//         //ADD
//             :ListView(
//           children: [
//             Column(
//               children: [
//                 SizedBox(height: 20,),
//                 Text('Add Location',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
//                 SizedBox(height: 20,),
//                 InkWell(
//                   onTap: () async {
//                     Position location =await Geolocator.getCurrentPosition(
//                         desiredAccuracy: LocationAccuracy.high
//                     );
//                     await Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => gMapPlacePicker.PlacePicker(
//                           apiKey: "AIzaSyCUZFUZ1yMpkzh6QUnKj54Q2N4L2iT4tBY",
//                           initialPosition: gMap.LatLng(
//                               location.latitude,location.longitude
//                           ),
//                           // Put YOUR OWN KEY here.
//                           searchForInitialValue: false,
//                           selectInitialPosition: true,
//                           // initialPosition: LatLng(currentLoc==null?0:currentLoc!.latitude,currentLoc==null?0:currentLoc!.longitude),
//                           onPlacePicked: (res) async {
//                             Navigator.of(context).pop();
//                             var result;
//
//                             // Address address=await geoCode.reverseGeocoding(latitude: res.geometry.location.lat,longitude: res.geometry.location.lng);
//                             result=res;
//                             List<Placemark> placemarks = await placemarkFromCoordinates(res.geometry.location.lat, res.geometry.location.lng);
//                             Placemark places = placemarks[0];
//                             district.text=places.subAdministrativeArea;
//                             String address=result.formattedAddress;
//                             if(result.formattedAddress.contains("+")){
//                               address=address.substring(address.indexOf(" ")+1,address.length);
//
//                             }
//                             place.text=address.split(" ").first.replaceAll(",", "");
//                             city.text=places.locality;
//                             pincode.text=places.postalCode;
//                             latController.text=res.geometry.location.lat.toString();
//                             longController.text=res.geometry.location.lng.toString();
//                             lat=res.geometry.location.lat;
//                             long=res.geometry.location.lng;
//                             set();
//                           },
//                           useCurrentLocation: true,
//                         ),
//                       ),
//                     );
//                   },
//                   child:
//                   Container(
//                     width: MediaQuery.of(context).size.width*0.6,
//                     height: MediaQuery.of(context).size.width*0.1,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(3),
//                         border: Border.all(
//                             color: Colors.blue,width: 1
//                         )
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text('Choose your location', style: TextStyle(
//                             color:Color(0xff034a82), fontSize: 15),),
//                         Icon(
//                           Icons.location_on, color: Colors.pink, size: 30,),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 lat!=null&&long!=null?
//                 Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: SizedBox(
//                         height: MediaQuery.of(context).size.height*.055,
//                         child: TextFormField(
//                           controller: place,
//                           style: GoogleFonts.poppins(color: Colors.grey,fontSize: 14),
//                           decoration: InputDecoration(
//                             contentPadding:   EdgeInsets.only(top: 5,left: 10),
//                             hintText: 'Place:',
//                             hintStyle: GoogleFonts.poppins(
//                                 color: Colors.grey,fontSize: 12),
//                             enabledBorder:  OutlineInputBorder(borderSide: BorderSide(
//                                 color: Color(0xffEAEAEA),width: 2),
//                                 borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(10),topRight:Radius.circular(10),
//                                     bottomLeft: Radius.circular(10),
//                                     bottomRight: Radius.circular(10) )),
//                             focusedBorder:   OutlineInputBorder(borderSide: BorderSide(
//                                 color: Colors.grey,width: 1),
//                                 borderRadius:  BorderRadius.circular(10)),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: SizedBox(
//                         height: MediaQuery.of(context).size.height*.055,
//                         child: TextFormField(
//                           controller: city,
//                           style: GoogleFonts.poppins(color: Colors.grey,fontSize: 14),
//                           decoration: InputDecoration(
//                             contentPadding:   EdgeInsets.only(top: 5,left: 10),
//                             hintText: 'City Name:',
//                             hintStyle: GoogleFonts.poppins(
//                                 color: Colors.grey,fontSize: 12),
//                             enabledBorder:  OutlineInputBorder(borderSide: BorderSide(
//                                 color: Color(0xffEAEAEA),width: 2),
//                                 borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(10),topRight:Radius.circular(10),
//                                     bottomLeft: Radius.circular(10),
//                                     bottomRight: Radius.circular(10) )),
//                             focusedBorder:   OutlineInputBorder(borderSide: BorderSide(
//                                 color: Colors.grey,width: 1),
//                                 borderRadius:  BorderRadius.circular(10)),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: SizedBox(
//                         height: MediaQuery.of(context).size.height*.055,
//                         child: TextFormField(
//                           controller: pincode,
//                           style: GoogleFonts.poppins(color: Colors.grey,fontSize: 14),
//                           decoration: InputDecoration(
//                             contentPadding:   EdgeInsets.only(top: 5,left: 10),
//                             hintText: 'Pincode :',
//                             hintStyle: GoogleFonts.poppins(
//                                 color: Colors.grey,fontSize: 12),
//                             enabledBorder:  OutlineInputBorder(borderSide: BorderSide(
//                                 color: Color(0xffEAEAEA),width: 2),
//                                 borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(10),topRight:Radius.circular(10),
//                                     bottomLeft: Radius.circular(10),
//                                     bottomRight: Radius.circular(10) )),
//                             focusedBorder:   OutlineInputBorder(borderSide: BorderSide(
//                                 color: Colors.grey,width: 1),
//                                 borderRadius:  BorderRadius.circular(10)),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: SizedBox(
//                         height: MediaQuery.of(context).size.height*.055,
//                         child: TextFormField(
//                           controller: district,
//                           style: GoogleFonts.poppins(color: Colors.grey,fontSize: 14),
//                           decoration: InputDecoration(
//                             contentPadding:   EdgeInsets.only(top: 5,left: 10),
//                             hintText: 'District Name :',
//                             hintStyle: GoogleFonts.poppins(
//                                 color: Colors.grey,fontSize: 12),
//                             enabledBorder:  OutlineInputBorder(borderSide: BorderSide(
//                                 color: Color(0xffEAEAEA),width: 2),
//                                 borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(10),topRight:Radius.circular(10),
//                                     bottomLeft: Radius.circular(10),
//                                     bottomRight: Radius.circular(10) )),
//                             focusedBorder:   OutlineInputBorder(borderSide: BorderSide(
//                                 color: Colors.grey,width: 1),
//                                 borderRadius:  BorderRadius.circular(10)),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: SizedBox(
//                         height: MediaQuery.of(context).size.height*.055,
//                         child: TextFormField(
//                           controller: latController,
//                           style: GoogleFonts.poppins(color: Colors.grey,fontSize: 14),
//                           decoration: InputDecoration(
//                             contentPadding:   EdgeInsets.only(top: 5,left: 10),
//                             hintText: 'Lat :',
//                             hintStyle: GoogleFonts.poppins(
//                                 color: Colors.grey,fontSize: 12),
//                             enabledBorder:  OutlineInputBorder(borderSide: BorderSide(
//                                 color: Color(0xffEAEAEA),width: 2),
//                                 borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(10),topRight:Radius.circular(10),
//                                     bottomLeft: Radius.circular(10),
//                                     bottomRight: Radius.circular(10) )),
//                             focusedBorder:   OutlineInputBorder(borderSide: BorderSide(
//                                 color: Colors.grey,width: 1),
//                                 borderRadius:  BorderRadius.circular(10)),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: SizedBox(
//                         height: MediaQuery.of(context).size.height*.055,
//                         child: TextFormField(
//                           controller: longController,
//                           style: GoogleFonts.poppins(color: Colors.grey,fontSize: 14),
//                           decoration: InputDecoration(
//                             contentPadding:   EdgeInsets.only(top: 5,left: 10),
//                             hintText: 'Long :',
//                             hintStyle: GoogleFonts.poppins(
//                                 color: Colors.grey,fontSize: 12),
//                             enabledBorder:  OutlineInputBorder(borderSide: BorderSide(
//                                 color: Color(0xffEAEAEA),width: 2),
//                                 borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(10),topRight:Radius.circular(10),
//                                     bottomLeft: Radius.circular(10),
//                                     bottomRight: Radius.circular(10) )),
//                             focusedBorder:   OutlineInputBorder(borderSide: BorderSide(
//                                 color: Colors.grey,width: 1),
//                                 borderRadius:  BorderRadius.circular(10)),
//                           ),
//                         ),
//                       ),
//                     ),
//
//
//                     SizedBox(height: 20,),
//                     InkWell(
//                       onTap: (){
//                         // FirebaseFirestore.instance.collection('workshop').doc(currentShop.reference.id).collection('Location').doc('Location').set({
//                         //   'place':place.text,
//                         //   'district':district.text,
//                         //   'city':city.text,
//                         //   'pincode':pincode.text,
//                         //   'lat':lat,
//                         //   'long':long
//                         //
//                         // });
//                         // FirebaseFirestore.instance.collection('workshop').doc(currentShop.reference.id).update({
//                         //   'lat':lat,
//                         //   'long':long,
//                         //   'address':result.formattedAddress,
//                         //
//                         //
//                         // });
//                         showSnackbar(context, 'Location Added SuccessFully');
//                         place.text='';
//                         district.text='';
//                         city.text='';
//                         pincode.text='';
//                         latController.text='';
//                         longController.text='';
//                         lat=null;
//                         long=null;
//                       },
//                       child: Container(
//                         width: MediaQuery.of(context).size.width*0.15,
//                         height: 50,
//                         decoration: BoxDecoration(
//                             color: Colors.grey,
//                             borderRadius: BorderRadius.circular(15)
//                         ),
//                         child: Center(child: Text('Add',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
//                       ),
//                     )
//                   ],
//                 )
//                     :Container(),
//
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}