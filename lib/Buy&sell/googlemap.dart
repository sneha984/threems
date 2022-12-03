// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:threems/screens/home_screen.dart';
//
// class GooglePage extends StatefulWidget {
//   const GooglePage({Key? key}) : super(key: key);
//   static final kInitialPosition = LatLng(10.954697, 76.2208631);
//
//   @override
//   State<GooglePage> createState() => _GooglePageState();
// }
//
// class _GooglePageState extends State<GooglePage> {
//   // late PickResult selectedPlace;
//
//
//   @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //       appBar: AppBar(
//   //         title: Text("Google Map Place Picer Demo"),
//   //       ),
//   //       body: Center(
//   //         child: Column(
//   //           mainAxisAlignment: MainAxisAlignment.center,
//   //           crossAxisAlignment: CrossAxisAlignment.center,
//   //           children: <Widget>[
//   //             ElevatedButton(
//   //               child: Text("Load Google Map"),
//   //               onPressed: () {
//   //                 Navigator.push(
//   //                   context,
//   //                   MaterialPageRoute(
//   //                     builder: (context) {
//   //                       // return PlacePicker(
//   //                       //   apiKey: 'AIzaSyCUZFUZ1yMpkzh6QUnKj54Q2N4L2iT4tBY',
//   //                       //    initialPosition:currenPlace,
//   //                       //   useCurrentLocation: true,
//   //                       //   selectInitialPosition: true,
//   //                       //
//   //                       //   //usePlaceDetailSearch: true,
//   //                       //   onPlacePicked: (result) {
//   //                       //     var selectedPlace = result;
//   //                       //     Navigator.of(context).pop();
//   //                       //     setState(() {});
//   //                       //   },
//   //                       //   //forceSearchOnZoomChanged: true,
//   //                       //   //automaticallyImplyAppBarLeading: false,
//   //                       //   //autocompleteLanguage: "ko",
//   //                       //   //region: 'au',
//   //                       //   //selectInitialPosition: true,
//   //                       //   // selectedPlaceWidgetBuilder: (_, selectedPlace, state, isSearchBarFocused) {
//   //                       //   //   print("state: $state, isSearchBarFocused: $isSearchBarFocused");
//   //                       //   //   return isSearchBarFocused
//   //                       //   //       ? Container()
//   //                       //   //       : FloatingCard(
//   //                       //   //           bottomPosition: 0.0, // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
//   //                       //   //           leftPosition: 0.0,
//   //                       //   //           rightPosition: 0.0,
//   //                       //   //           width: 500,
//   //                       //   //           borderRadius: BorderRadius.circular(12.0),
//   //                       //   //           child: state == SearchingState.Searching
//   //                       //   //               ? Center(child: CircularProgressIndicator())
//   //                       //   //               : RaisedButton(
//   //                       //   //                   child: Text("Pick Here"),
//   //                       //   //                   onPressed: () {
//   //                       //   //                     // IMPORTANT: You MUST manage selectedPlace data yourself as using this build will not invoke onPlacePicker as
//   //                       //   //                     //            this will override default 'Select here' Button.
//   //                       //   //                     print("do something with [selectedPlace] data");
//   //                       //   //                     Navigator.of(context).pop();
//   //                       //   //                   },
//   //                       //   //                 ),
//   //                       //   //         );
//   //                       //   // },
//   //                       //   // pinBuilder: (context, state) {
//   //                       //   //   if (state == PinState.Idle) {
//   //                       //   //     return Icon(Icons.favorite_border);
//   //                       //   //   } else {
//   //                       //   //     return Icon(Icons.favorite);
//   //                       //   //   }
//   //                       //   // },
//   //                       // );
//   //                     },
//   //                   ),
//   //                 );
//   //               },
//   //             ),
//   //             // selectedPlace == null ? Container() : Text(selectedPlace.formattedAddress ?? ""),
//   //           ],
//   //         ),
//   //       ));
//   // }
// }
