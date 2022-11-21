import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/servicesModel.dart';
import '../../utils/themes.dart';
import '../charity/verification_details.dart';
import '../splash_screen.dart';

class ServiceDetailsPage extends StatefulWidget {
  final String category;
  const ServiceDetailsPage({Key? key, required this.category})
      : super(key: key);

  @override
  State<ServiceDetailsPage> createState() => _ServiceDetailsPageState();
}

class _ServiceDetailsPageState extends State<ServiceDetailsPage> {
  String selectedCity2 = '';
  TextEditingController city2 = TextEditingController();
  List<String> serviceCity = [];
  List<ServiceDetails>? serviceList;

  getService() {
    print(widget.category);
    FirebaseFirestore.instance
        .collection('services')
        .where('serviceCategory', isEqualTo: widget.category)
        .snapshots()
        .listen((event) {
      serviceList = [];
      for (DocumentSnapshot<Map<String, dynamic>> doc in event.docs) {
        serviceList!.add(ServiceDetails.fromJson(doc.data()!));
      }

      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getService();
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
        elevation: 0.1,
        backgroundColor: Colors.white,

        title: Text(
          widget.category,
          style: TextStyle(
              fontSize: scrWidth * 0.046,
              color: Colors.black,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w600),
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 18.0),
        //     child: Icon(Icons.)
        //     // SvgPicture.asset('assets/images/expense tracker.svg',height: 35,width: 35,),
        //   )
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     children: [
            //       Container(
            //         width: scrWidth * 0.44,
            //         // width: scrWidth,
            //         height: textFormFieldHeight45,
            //         padding: EdgeInsets.symmetric(
            //           horizontal: scrWidth * 0.015,
            //           vertical: scrWidth * 0.002,
            //         ),
            //         decoration: BoxDecoration(
            //           border: Border.all(
            //             color: Color(0xffDADADA),
            //           ),
            //           color: textFormFieldFillColor,
            //           borderRadius: BorderRadius.circular(scrWidth * 0.026),
            //         ),
            //
            //         child: CustomDropdown.search(
            //           hintText: selectedCity2 == '' ? 'City ' : selectedCity2,
            //           items: serviceCity,
            //           controller: city2,
            //           excludeSelected: false,
            //           onChanged: (value) {
            //             setState(() {
            //               selectedCity2 = value;
            //             });
            //             // print( userMap[selectedUser]);
            //           },
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Container(
                height: MediaQuery.of(context).size.height,
                child: serviceList == null
                    ? Center(
                        child: Text('No list Found'),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.05,
                        ),
                        itemCount: serviceList!.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final serviceItems = serviceList![index];
                          return Padding(
                            padding: const EdgeInsets.only(
                              left: 15.0,
                              right: 15,
                              bottom: 10,
                            ),
                            child: Material(
                              color: Colors.transparent,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0xFFE3F2FD),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                serviceItems.image.toString(),
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Name : ${serviceItems.name.toString()}',
                                            style: GoogleFonts.urbanist(
                                                fontSize: 14),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          // Text(
                                          //   'Phone Number : ${serviceItems.phoneNumber.toString()}',
                                          //   style: GoogleFonts.urbanist(
                                          //       fontSize: 14),
                                          // ),
                                          // Text(
                                          //   'Email Id : ${serviceItems.emailId.toString()}',
                                          //   style: GoogleFonts.urbanist(
                                          //       fontSize: 14),
                                          // ),
                                          Text(
                                            'Wage : ${serviceItems.wage} / ${serviceItems.serviceUnit}',
                                            style: GoogleFonts.urbanist(
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          Uri call = Uri.parse(
                                              'tel://${serviceList![index].phoneNumber!}');

                                          launchUrl(call);
                                        },
                                        child: Icon(Icons.phone))
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )),
          ],
        ),
      ),
    );
  }
}
