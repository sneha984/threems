import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../kuri/createkuri.dart';
import '../layouts/screen_layout.dart';
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

  List<String> userList = [];
  getUsers() {
    FirebaseFirestore.instance.collection('users').snapshots().listen((event) {
      userList = [];
      for (var doc in event.docs) {
        userList.add(
            doc['phone'].toString().replaceAll(' ', '').replaceAll('+91', ''));
      }
      if (mounted) {
        setState(() {
          print(userList.length);
          getInstalledUsers();
        });
      }
    });
  }

  getInstalledUsers() {
    List<Contact> installed = [];
    List<Contact> notInstalled = [];
    for (int i = 0; i < totalContacts.length; i++) {
      if (totalContacts[i].phones!.isNotEmpty) {
        if (userList.contains(totalContacts[i]
            .phones![0]
            .value
            .toString()
            .replaceAll(' ', '')
            .replaceAll('+91', ''))) {
          installed.add(totalContacts[i]);
        } else {
          notInstalled.add(totalContacts[i]);
        }
      }
    }

    setState(() {
      totalContactsSearch = [];
      totalContactsSearch.addAll(installed);
      totalContactsSearch.addAll(notInstalled);
    });
  }

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

  grabContacts() async {
    if (contacts.isNotEmpty) {
      await getContacts();
      totalContactsSearch = contacts;
      totalContacts = contacts;
    } else {
      askPermissions();
    }

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsers();
    grabContacts();
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
                child: Padding(
                  padding: EdgeInsets.only(
                      // top: scrHeight * 0.09,
                      left: scrWidth * 0.05,
                      // bottom: scrHeight * 0.02,
                      right: scrWidth * 0.04),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 25,
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
            ),
          ),
        ),
      ),
      body: totalContactsSearch.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: scrWidth * 0.059),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: totalContactsSearch.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return totalContactsSearch[index].phones!.isEmpty
                      ? SizedBox(
                          // width: 0.0001,
                          // height: 0.0001,
                          )
                      : Padding(
                          padding: EdgeInsets.all(scrWidth * 0.01),
                          child: Container(
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
                                borderRadius:
                                    BorderRadius.circular(scrWidth * 0.026)),
                            child: Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 8),
                                  child: CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Colors.grey,
                                      backgroundImage: NetworkImage(
                                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFzJQ6mTB2vG53lTC7SR6w9FBSdbyK6SQoOg&usqp=CAU")
                                      // MemoryImage(totalContactsSearch[index].avatar!),
                                      ),
                                ),
                                Flexible(
                                  child: Center(
                                    child: Text(
                                      totalContactsSearch[index].displayName!,
                                      overflow: TextOverflow.visible,
                                      style: TextStyle(
                                          fontSize: FontSize16,
                                          fontFamily: 'Urbanist',
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    print(totalContactsSearch[index]
                                        .phones![0]
                                        .value
                                        .toString());

                                    if (userList.contains(
                                        totalContactsSearch[index]
                                            .phones![0]
                                            .value
                                            .toString()
                                            .replaceAll(' ', '')
                                            .replaceAll('+91', ''))) {
                                      showSnackbar(context, 'Already a user.');
                                    } else {
                                      await _createDynamicLink(false);

                                      var whatsappUrl =
                                          "whatsapp://send?phone=91${totalContactsSearch[index].phones![0].value.toString().replaceAll(' ', '').replaceAll('+91', '')}" +
                                              "&text=${Uri.encodeComponent(_linkMessage!)}";
                                      try {
                                        launchUrl(Uri.tryParse(whatsappUrl)!)
                                            .onError((error, stackTrace) {
                                          Share.share(
                                              'Inviting you to join *3MS App* \n \n \n $_linkMessage');

                                          return showSnackbar(context,
                                              'Unable to open whatsapp');
                                        });
                                      } catch (e) {
                                        //To handle error and display error message

                                        showSnackbar(
                                            context, 'Unable to open whatsapp');

                                        // Helper.errorSnackBar(
                                        //     context: context,
                                        //     message: "Unable to open whatsapp");
                                      }

                                      // Share.share(
                                      //     'Inviting you to join  3MS App\n \n \n $_linkMessage');
                                    }
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
                                        userList.contains(
                                                totalContactsSearch[index]
                                                    .phones![0]
                                                    .value
                                                    .toString()
                                                    .replaceAll(' ', '')
                                                    .replaceAll('+91', ''))
                                            ? 'Joined'
                                            : 'Invite',
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
                          ),
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

  // ACCESS CONTACTS BY REQUESTING PERMISSION
  askPermissions() async {
    PermissionStatus permission = await getContactPermission();
    if (permission == PermissionStatus.granted) {
      getContacts();
    } else {
      handleInvalidPermission(permission);
    }
  }

  handleInvalidPermission(PermissionStatus permission) {
    if (permission == PermissionStatus.denied) {
      showSnackbar(context, 'Permission denied by user');
    } else if (permission == PermissionStatus.permanentlyDenied) {
      showSnackbar(context, 'Permission denied by user');
    }
  }

  getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  getContacts() async {
    List<Contact> _contacts = await ContactsService.getContacts();

    setState(() {
      contacts = _contacts;
      totalContactsSearch = _contacts;
      totalContacts = _contacts;

      print('================ContactLength=================');
      print(contacts.length);
    });
  }
}
