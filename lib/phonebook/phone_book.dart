import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';

import '../screens/home_screen.dart';
import '../screens/splash_screen.dart';
import '../utils/themes.dart';

class PhoneBookPage extends StatefulWidget {
  const PhoneBookPage({Key? key}) : super(key: key);

  @override
  State<PhoneBookPage> createState() => _PhoneBookPageState();
}

class _PhoneBookPageState extends State<PhoneBookPage> {
  List<Contact> totalContactsSearch = [];
  List<Contact> totalContacts = [];

  String? _linkMessage;
  bool _isCreatingLink = false;

  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  final String dynamicLink = 'https://threems.page.link';
  final String link = 'https://threems.page.link/invite';

  TextEditingController search = TextEditingController();

  searchContacts(String txt) {
    print(totalContacts.length);
    print(totalContactsSearch.length);
    totalContactsSearch = [];
    for (int i = 0; i < totalContacts.length; i++) {
      if (totalContacts[i]
          .displayName!
          .toLowerCase()
          .contains(txt.toLowerCase())) {
        totalContactsSearch.add(totalContacts[i]);

      }
    }
    setState(() {});
  }

  @override
  void initState() {
    totalContactsSearch = contacts;
    totalContacts = contacts;

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(scrWidth * 0.2),
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  offset: Offset(0, 4),
                  blurRadius: 25),
            ]),
            child: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  // color: Colors.red,
                  width: 13,
                  height: 12,
                  padding: EdgeInsets.all(scrWidth * 0.05),
                  child: SvgPicture.asset(
                    'assets/icons/back.svg',
                    width: 13,
                    height: 11,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              title: Text(
                "Phone Book",
                style: TextStyle(
                    fontSize: FontSize17,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              // actions: [
              //   Container(
              //     margin: EdgeInsets.symmetric(vertical: 15),
              //     width: 60,
              //     height: 20,
              //     // color: Colors.red,
              //     child: Center(
              //       child: RichText(
              //         text: TextSpan(
              //           children: <TextSpan>[
              //             TextSpan(
              //               text: "12",
              //               style: TextStyle(
              //                   fontSize: FontSize16,
              //                   fontFamily: 'Urbanist',
              //                   fontWeight: FontWeight.w600,
              //                   color: primarycolor),
              //             ),
              //             TextSpan(
              //               text: '/',
              //               style: TextStyle(
              //                   fontSize: FontSize16,
              //                   fontFamily: 'Urbanist',
              //                   fontWeight: FontWeight.w600,
              //                   color: Colors.black),
              //             ),
              //             TextSpan(
              //               text:"12",
              //               style: TextStyle(
              //                   fontSize: FontSize16,
              //                   fontFamily: 'Urbanist',
              //                   fontWeight: FontWeight.w600,
              //                   color: Colors.black),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              //   SizedBox(
              //     width: scrWidth * 0.059,
              //     // width: 21,
              //   ),
              // ],
              // bottom: PreferredSize(
              //   preferredSize: Size.fromHeight(50),
              //   child: Container(
              //     margin: EdgeInsets.only(
              //         top: scrWidth * 0.015,
              //         bottom: scrWidth * 0.06,
              //         left: scrWidth * 0.059,
              //         right: scrWidth * 0.059),
              //     child: Container(
              //       // width: scrWidth,
              //       // height: textFormFieldHeight45,
              //       width: 324,
              //       height: 35,
              //       padding: EdgeInsets.symmetric(
              //         horizontal: scrWidth * 0.03,
              //         vertical: 2.5,
              //       ),
              //       decoration: BoxDecoration(
              //         color: Color(0xffE9EEF3),
              //         borderRadius: BorderRadius.circular(17),
              //       ),
              //       child: TextFormField(
              //         controller: search,
              //         onChanged: ((txt) {
              //           print(search.text);
              //           totalContactsSearch = [];
              //           if (search.text == '') {
              //             totalContactsSearch.addAll(totalContacts);
              //           } else {
              //             searchContacts(search.text);
              //           }
              //         }),
              //         // cursorHeight: scrWidth * 0.055,
              //         // cursorWidth: 1,
              //         // cursorColor: Colors.black,
              //         showCursor: false,
              //         style: TextStyle(
              //           color: Colors.black,
              //           fontWeight: FontWeight.w600,
              //           fontSize: FontSize15,
              //           fontFamily: 'Urbanist',
              //         ),
              //         decoration: InputDecoration(
              //           prefixIcon: Padding(
              //             padding: EdgeInsets.symmetric(
              //               horizontal: scrWidth * 0.015,
              //               vertical: scrWidth * 0.015,
              //             ),
              //             child: SvgPicture.asset('assets/icons/search.svg',
              //                 fit: BoxFit.contain, color: Color(0xff8391A1)),
              //           ),
              //           hintText: 'Search members',
              //           hintStyle: TextStyle(
              //             color: Color(0xff8391A1),
              //             fontWeight: FontWeight.w500,
              //             fontSize: FontSize15,
              //             fontFamily: 'Urbanist',
              //           ),
              //           fillColor: Color(0xffE9EEF3),
              //           filled: true,
              //           contentPadding: EdgeInsets.only(
              //               top: scrWidth * 0.03, bottom: scrWidth * 0.03),
              //           disabledBorder: InputBorder.none,
              //           enabledBorder: InputBorder.none,
              //           errorBorder: InputBorder.none,
              //           border: InputBorder.none,
              //           focusedBorder: InputBorder.none,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding:
        EdgeInsets.symmetric(horizontal: scrWidth * 0.059),
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(
            height: scrWidth * 0.02,
          ),
          physics: BouncingScrollPhysics(),
          itemCount: totalContactsSearch.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return totalContactsSearch[index].phones!.isEmpty
                ? SizedBox()
                : Container(
              width: 328,
              height: textFormFieldHeight45,
              padding: EdgeInsets.symmetric(
                horizontal: scrWidth * 0.015,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xffDADADA),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(scrWidth * 0.026)),
              child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.grey,
                          backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFzJQ6mTB2vG53lTC7SR6w9FBSdbyK6SQoOg&usqp=CAU")
                          // MemoryImage(totalContactsSearch[index].avatar!),
                        ),
                      ),
                      Center(
                        child: Text(
                          totalContactsSearch[index].displayName!,
                          style: TextStyle(
                              fontSize: FontSize16,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await _createDynamicLink(false);
                          Share.share(
                              'Inviting you to join  3MS App\n \n \n $_linkMessage');
                        },
                        child: Container(
                          // width: 50,
                          height: 27,
                          margin: EdgeInsets.only(right: 8),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: primarycolor,
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                            child: Text(
                              'Invite',
                              style: TextStyle(
                                  fontSize: FontSize14,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            );
          },
        ),
      ),
      // bottomNavigationBar: InkWell(
      //   onTap: () {
      //     addMember = [];
      //     for (int i = 0; i < addFriend.length; i++) {
      //       addMember.add(useridByPhone[addFriend[i]]);
      //     }
      //
      //     setState(() {});
      //   },
      //   child: Container(
      //     width: 100,
      //     height: 50,
      //     decoration: BoxDecoration(
      //         color: primarycolor, borderRadius: BorderRadius.circular(17)),
      //     margin: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
      //     child: Center(
      //         child: Text(
      //       "Add Member",
      //       style: TextStyle(color: Colors.white),
      //     )),
      //   ),
      // ),
    );

  }
  Future<void> _createDynamicLink(bool short) async {
    setState(() {
      _isCreatingLink = true;
    });

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://threems.page.link/invite',
      longDynamicLink: Uri.parse(
        'https://threems.page.link/APP JOIN_invite?JoinId=&refferalId=',
      ),
      link: Uri.parse(dynamicLink),
      androidParameters: const AndroidParameters(
        packageName: 'com.firstlogicmetalab.threems',
        minimumVersion: 0,
      ),
      iosParameters: const IOSParameters(
        bundleId: 'io.flutter.plugins.firebase.dynamiclinksexample',
        minimumVersion: '0',
      ),
    );

    Uri url;
    if (short) {
      final ShortDynamicLink shortLink =
      await dynamicLinks.buildShortLink(parameters);
      url = shortLink.shortUrl;
    } else {
      url = await dynamicLinks.buildLink(parameters);
    }

    setState(() {
      _linkMessage = url.toString();
      _isCreatingLink = false;

      print(_linkMessage);
    });
  }
}
