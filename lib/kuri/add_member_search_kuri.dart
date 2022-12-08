import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:threems/kuri/createkuri.dart';

import '../model/Kuri/kuriModel.dart';
import '../screens/home_screen.dart';
import '../screens/splash_screen.dart';
import '../utils/dummy.dart';
import '../utils/themes.dart';
import 'add_members_kuri.dart';

class AddMembersearch extends StatefulWidget {
  final KuriModel kuri;
  const AddMembersearch({
    Key? key,
    required this.kuri,
  }) : super(key: key);

  @override
  State<AddMembersearch> createState() => _AddMembersearchState();
}

class _AddMembersearchState extends State<AddMembersearch> {
  List<Contact> totalContactsSearch = [];
  List<Contact> totalContacts = [];
  List numberList = [];
  TextEditingController search = TextEditingController();

  String? _linkMessage;
  bool _isCreatingLink = false;

  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  final String dynamicLink = 'https://threems.page.link';
  final String link = 'https://threems.page.link/kuri_Invite';

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
    print(totalContacts.length);
    print(totalContactsSearch.length);
    // numberList = widget.numberList;
    // print(numberList.length);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(scrWidth * 0.34),
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
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsets.only(
                    top: scrHeight * 0.04,
                    left: scrWidth * 0.07,
                    right: scrWidth * 0.05),
                child: SvgPicture.asset(
                  "assets/icons/arrow.svg",
                ),
              ),
            ),
            title: Padding(
              padding: EdgeInsets.only(top: 30),
              child: Text(
                "Add Member Friend List",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: Container(
                margin: EdgeInsets.only(
                    top: scrWidth * 0.015,
                    bottom: scrWidth * 0.06,
                    left: scrWidth * 0.059,
                    right: scrWidth * 0.059),
                child: Container(
                  // width: scrWidth,
                  // height: textFormFieldHeight45,
                  width: 324,
                  height: 35,
                  padding: EdgeInsets.symmetric(
                    horizontal: scrWidth * 0.03,
                    vertical: 2.5,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xffE9EEF3),
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: TextFormField(
                    // cursorHeight: scrWidth * 0.055,
                    // cursorWidth: 1,
                    // cursorColor: Colors.black,
                    controller: search,
                    showCursor: false,
                    onChanged: ((txt) {
                      print(search.text);
                      totalContactsSearch = [];
                      if (search.text == '') {
                        totalContactsSearch.addAll(totalContacts);
                      } else {
                        searchContacts(search.text);
                      }
                    }),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: FontSize15,
                      fontFamily: 'Urbanist',
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: scrWidth * 0.015,
                          vertical: scrWidth * 0.015,
                        ),
                        child: SvgPicture.asset('assets/icons/search.svg',
                            fit: BoxFit.contain, color: Color(0xff8391A1)),
                      ),
                      hintText: 'Search members',
                      hintStyle: TextStyle(
                        color: Color(0xff8391A1),
                        fontWeight: FontWeight.w500,
                        fontSize: FontSize15,
                        fontFamily: 'Urbanist',
                      ),
                      fillColor: Color(0xffE9EEF3),
                      filled: true,
                      contentPadding: EdgeInsets.only(
                          top: scrWidth * 0.03, bottom: scrWidth * 0.03),
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: scrWidth * 0.059, vertical: 5),
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
                            backgroundImage:
                                MemoryImage(totalContactsSearch[index].avatar!),
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
                                'Inviting you to join *${widget.kuri.kuriName}* \n \n \n $_linkMessage');
                          },
                          child: Container(
                            // width: 50,
                            height: 27,
                            margin: EdgeInsets.only(right: 8),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color:
                                    // addFriend.contains(
                                    //         totalContactsSearch[index]
                                    //             .phones!
                                    //             .first
                                    //             .value!
                                    //             .trim()
                                    //             .replaceAll(' ', ''))
                                    //     ? Color(0xff8391A1)
                                    //     :
                                    primarycolor,
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Text(
                                // addFriend.contains(totalContactsSearch[index]
                                //         .phones!
                                //         .first
                                //         .value!
                                //         .trim()
                                //         .replaceAll(' ', ''))
                                //     ? "Added"
                                //     : numberList.contains(
                                //             totalContactsSearch[index]
                                //                 .phones!
                                //                 .first
                                //                 .value!
                                //                 .trim()
                                //                 .replaceAll(' ', ''))
                                //         ? '+ Add'
                                //         :
                                'Invite',
                                style: TextStyle(
                                    fontSize: FontSize14,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
                  );
            // StreamBuilder<QuerySnapshot>(
            //         stream: FirebaseFirestore.instance
            //             .collection('users')
            //             .where('phone',
            //                 isEqualTo: totalContacts[index]
            //                     .phones!
            //                     .first
            //                     .value!
            //                     .trim()
            //                     .replaceAll(' ', ''))
            //             .snapshots(),
            //         builder: (context, snapshot) {
            //           String value = '';
            //           if (snapshot.hasData) {
            //             value = '+ Add';
            //           } else {
            //             value = 'Invite';
            //           }
            //           return Container(
            //             width: 328,
            //             height: textFormFieldHeight45,
            //             padding: EdgeInsets.symmetric(
            //               horizontal: scrWidth * 0.015,
            //               vertical: 2,
            //             ),
            //             decoration: BoxDecoration(
            //                 border: Border.all(
            //                   color: Color(0xffDADADA),
            //                   width: 1,
            //                 ),
            //                 borderRadius:
            //                     BorderRadius.circular(scrWidth * 0.026)),
            //             child: Center(
            //                 child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Container(
            //                   margin: const EdgeInsets.only(left: 8),
            //                   child: CircleAvatar(
            //                     radius: 15,
            //                     backgroundColor: Colors.grey,
            //                     child: ClipRRect(
            //                       borderRadius: BorderRadius.circular(15),
            //                       child: CachedNetworkImage(
            //                         imageUrl:
            //                             'https://pbs.twimg.com/profile_images/1392793006877540352/ytVYaEBZ_400x400.jpg',
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //                 Center(
            //                   child: Text(
            //                     totalContacts[index].displayName!,
            //                     style: TextStyle(
            //                         fontSize: FontSize16,
            //                         fontFamily: 'Urbanist',
            //                         fontWeight: FontWeight.w600,
            //                         color: Colors.black),
            //                   ),
            //                 ),
            //                 GestureDetector(
            //                   onTap: () {
            //                     if (addFriend.contains(
            //                         totalContacts[index].displayName)) {
            //                       setState(() {
            //                         addFriend.remove(
            //                             totalContacts[index].displayName);
            //                         print("hi: $addFriend");
            //                       });
            //                     } else {
            //                       setState(() {
            //                         addFriend
            //                             .add(totalContacts[index].displayName!);
            //                         print("hi: $addFriend");
            //                       });
            //                     }
            //                   },
            //                   child: Container(
            //                     // width: 50,
            //                     height: 27,
            //                     margin: EdgeInsets.only(right: 8),
            //                     padding: EdgeInsets.all(5),
            //                     decoration: BoxDecoration(
            //                         color: addFriend.contains(
            //                                 totalContacts[index].displayName)
            //                             ? Color(0xff8391A1)
            //                             : primarycolor,
            //                         borderRadius: BorderRadius.circular(8)),
            //                     child: Center(
            //                       child: Text(
            //                         addFriend.contains(
            //                                 totalContacts[index].displayName)
            //                             ? "Added"
            //                             : value,
            //                         style: TextStyle(
            //                             fontSize: FontSize14,
            //                             fontFamily: 'Urbanist',
            //                             fontWeight: FontWeight.w700,
            //                             color: Colors.white),
            //                       ),
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             )),
            //           );
            //         });
          },
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          Navigator.pop(context);
          // addMember = [];
          // for (int i = 0; i < addFriend.length; i++) {
          //   addMember.add(useridByPhone[addFriend[i]]);
          // }
          // Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => AddMembersKuri(
          //               kuri: widget.kuri,
          //             )));
          // setState(() {});
        },
        child: Container(
          width: 100,
          height: 50,
          decoration: BoxDecoration(
              color: primarycolor, borderRadius: BorderRadius.circular(17)),
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
          child: Center(
              child: Text(
            "Done",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                fontFamily: 'Outfit',
                color: Colors.white),
          )),
        ),
      ),
    );
  }

  Future<void> _createDynamicLink(bool short) async {
    setState(() {
      _isCreatingLink = true;
    });

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://threems.page.link/kuri_Invite',
      longDynamicLink: Uri.parse(
        'https://threems.page.link/chit_invite?chitId=${widget.kuri.kuriId}&referralId=${widget.kuri.userID}',
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
