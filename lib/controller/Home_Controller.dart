// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
//
// class GeolocatorPage extends StatefulWidget {
//   const GeolocatorPage({Key? key}) : super(key: key);
//
//   @override
//   State<GeolocatorPage> createState() => _GeolocatorPageState();
// }
//
// class _GeolocatorPageState extends State<GeolocatorPage> {
//   void getPosition()async{
//     LocationPermission permission=await Geolocator.checkPermission();
//     if(permission==LocationPermission.denied||permission==LocationPermission.deniedForever){
//       print("permission not given");
//       LocationPermission asked=await Geolocator.requestPermission();
//     }else{
//       Position currentPosition=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
//       print("latitude${currentPosition.latitude.toString()}");
//       print("longitude${currentPosition.longitude.toString()}");
//     }
//
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//           onPressed: (){
//             getPosition();
//           },
//           child: Text("ndjfdnjdfv"),
//         ),
//       ),
//     );
//   }
// }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
// //Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
// //Position position = await Geolocator.getLastKnownPosition()
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
//
// class GeolocatorPage extends StatefulWidget {
//   const GeolocatorPage({Key? key}) : super(key: key);
//
//   @override
//   State<GeolocatorPage> createState() => _GeolocatorPageState();
//
// }
//
// class _GeolocatorPageState extends State<GeolocatorPage> {
//   String currentAddress = 'My Address';
//
//   Position? currentposition;
//
//   Future<Position> _determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       Fluttertoast.showToast(msg: 'Please enable Your Location Service');
//     }
//
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         Fluttertoast.showToast(msg: 'Location permissions are denied');
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       Fluttertoast.showToast(
//           msg:
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//
//     try {
//       List<Placemark> placemarks =
//       await placemarkFromCoordinates(position.latitude, position.longitude);
//
//       Placemark place = placemarks[0];
//
//       setState(() {
//         currentposition = position;
//         currentAddress = "${place.locality}";
//             //" ${place.postalCode},"
//             //" ${place.country}";
//       });
//     } catch (e) {
//       print(e);
//     }
//     throw '';
//
//   }
//   @override
//
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Location'),
//       ),
//       body: Center(
//           child: Column(
//             children: [
//               Text(currentAddress),
//
//               TextButton(
//                   onPressed: () {
//                     _determinePosition();
//                   },
//                   child: Text('Locate me'))
//             ],
//           )),
//     );
//
//   }
// }


