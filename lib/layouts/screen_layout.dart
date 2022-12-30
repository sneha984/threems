import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:threems/layouts/personalInfoPopUp.dart';
import 'package:threems/screens/splash_screen.dart';
import 'package:threems/utils/themes.dart';
import '../Authentication/auth.dart';
import '../Authentication/root.dart';
import '../Buy&sell/buy_and_sell.dart';
import '../Expenses/Expense_first_page.dart';
import '../Expenses/recentexpenses.dart';
import '../Income/expense_income_tababr.dart';
import '../InviteLink/ChitInvite.dart';
import '../kuri/createkuri.dart';
import '../main.dart';
import '../screens/home_screen.dart';
import '../screens/Utilities/utilities.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

import '../topbar/settings.dart';
import '../model/usermodel.dart';
import 'package:threems/phonebook/phone_book.dart';

import '../Authentication/root.dart';

import '../Notes/notes.dart';

List<Contact> contacts = [];

class ScreenLayout extends StatefulWidget {
  final int index;
  final int tabIndex;
  ScreenLayout({
    Key? key,
    this.index = 0,
    this.tabIndex = 0,
  }) : super(key: key);

  @override
  State<ScreenLayout> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<ScreenLayout> {
  final Authentication _authentication = Authentication();

  // double selectedIndex = 0;
  final PageStorageBucket _bucket = PageStorageBucket();
  var _currentScreen;
  int index = 0;
  GlobalKey<ScaffoldState> _scaffoldKey2 = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    index = widget.index ?? 0;
    _currentScreen = index == 0
        ? HomeScreen()
        : index == 1
            ? BuyAndSell(
                index: widget.tabIndex ?? 0,
              )
            : index == 2
                ? ExpenseIncomeTabPage()
                : Utilities();
    print('hehe');
    print(inviteLinkId);
    if (inviteLinkId != '') {
      if (inviteLinkType == 'chit') {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => ChitInvite(id: inviteLinkId),
        //     ));
      }
    }

    super.initState();
    askPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          key: _scaffoldKey2,
          endDrawer: Drawer(
            elevation: 10.0,
            child: ListView(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    // Navigator.push(context,
                    //                MaterialPageRoute(builder: (context) => ProfilePage(user: user![0],)));

                    showDialog(
                      context: context,
                      builder: (context) => PersonalInfoPopUp(),
                    );
                  },
                  child: DrawerHeader(
                    decoration: BoxDecoration(color: primarycolor),
                    child: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(currentuser?.userImage ?? ''),
                              radius: 30.0,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  currentuser?.userName ?? '',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 22.0),
                                ),
                                SizedBox(height: 10.0),
                                Flexible(
                                  child: Container(
                                    width: 160,
                                    child: Text(
                                      currentuser?.userEmail ?? '',
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 14.0),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'V 1.8',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                //Here you place your menu items
                ListTile(
                  leading: Container(
                    height: 30,
                    width: 34,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdlgdYbuGqOnWzk_isI5q_in4KYYbFwO1lCw&usqp=CAU"),
                            fit: BoxFit.fill)),
                  ),
                  title: Text('Settings', style: TextStyle(fontSize: 18)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsPage()));

                    // Here you can give your route to navigate
                  },
                ),
                Divider(height: 3.0),
                ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: Container(
                      height: 20,
                      width: 26,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxfOzBxK8ISdCdErcVR0EFWHPL1I_SNQvEOw&usqp=CAU"),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  title: Text('Diary', style: TextStyle(fontSize: 18)),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NotesPage()));

                    // Here you can give your route to navigate
                  },
                ),
                Divider(height: 3.0),
                ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: Container(
                      height: 23,
                      width: 24,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQgDNYGs8jqizlcPof-wNOx2dLJmmoioCfEZw&usqp=CAU"),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  title: Text('Phone Book', style: TextStyle(fontSize: 18)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PhoneBookPage()));

                    // Here you can give your route to navigate
                  },
                ),
                SizedBox(
                  height: scrHeight * 0.3,
                ),

                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        content: const Text("do you want to exit this app"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: const Text("No"),
                          ),
                          TextButton(
                            onPressed: () {
                              _authentication.signOut(context);
                            },
                            child: const Text(
                              "Yes",
                              style: TextStyle(color: primarycolor),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 17, right: 17),
                    child: Container(
                      height: 45,
                      width: scrWidth * 0.3,
                      // color: Colors.grey,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black)),
                      child: Center(
                        child: Text("Logout"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          extendBody: true,
          body: PageStorage(
            bucket: _bucket,
            child: Stack(
              children: [
                _currentScreen,
                index == 0
                    ? Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: kToolbarHeight, right: scrWidth * 0.05),
                          child: InkWell(
                            onTap: () =>
                                _scaffoldKey2.currentState!.openEndDrawer(),
                            child: Icon(
                              Icons.menu,
                            ),
                          ),
                        ),
                      )
                    : SizedBox()
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(
                left: scrWidth * 0.059,
                right: scrWidth * 0.059,
                bottom: scrWidth * 0.059),
            child: Container(
              width: scrWidth * .85,
              // height: 72,
              height: scrWidth * .2,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(.06),
                      offset: const Offset(0, 4),
                      blurRadius: 15,
                      spreadRadius: 5)
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(scrWidth * 0.6),
              ),
              child: Center(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(
                      left: scrWidth * 0.028, right: scrWidth * 0.028),
                  children: [
                    MaterialButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        setState(() {
                          index = 0;
                          _currentScreen = HomeScreen();
                        });
                      },
                      minWidth: scrWidth * 0.1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/icons/home.svg",
                            height: bottomNavbarIconSize,
                            width: bottomNavbarIconSize,
                            color: index == 0 ? primarycolor : navBarUnSelColor,
                          ),
                          Text(
                            'Home',
                            style: TextStyle(
                              color:
                                  index == 0 ? primarycolor : navBarUnSelColor,
                              fontFamily: 'Poppins',
                              fontSize: FontSize10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        setState(() {
                          index = 1;
                          _currentScreen = BuyAndSell(
                            index: widget.tabIndex ?? 0,
                          );
                          // _currentScreen = CreateRoomScreen();
                        });
                      },
                      minWidth: scrWidth * 0.1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/icons/buyandsell.svg",
                            height: bottomNavbarIconSize,
                            width: bottomNavbarIconSize,
                            color: index == 1 ? primarycolor : navBarUnSelColor,
                          ),
                          Text(
                            'Buy & Sell',
                            style: TextStyle(
                              color:
                                  index == 1 ? primarycolor : navBarUnSelColor,
                              fontFamily: 'Poppins',
                              fontSize: FontSize10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        setState(() {
                          index = 2;
                          // _currentScreen = AddExpensesPage();
                          _currentScreen = ExpenseIncomeTabPage();
                        });
                      },
                      minWidth: scrWidth * 0.1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/icons/expense.svg",
                            color: index == 2 ? primarycolor : navBarUnSelColor,
                            height: bottomNavbarIconSize,
                            width: bottomNavbarIconSize,
                          ),
                          Text(
                            'Cash book',
                            style: TextStyle(
                              color:
                                  index == 2 ? primarycolor : navBarUnSelColor,
                              fontFamily: 'Poppins',
                              fontSize: FontSize10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        setState(() {
                          index = 3;
                          _currentScreen = Utilities();
                          // _currentScreen = Utilities();
                          // _currentScreen = CreateNewChitScreen();
                        });
                      },
                      minWidth: scrWidth * 0.1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/icons/utilities.svg",
                            color: index == 3 ? primarycolor : navBarUnSelColor,
                            height: bottomNavbarIconSize,
                            width: bottomNavbarIconSize,
                          ),
                          Text(
                            'Utilities',
                            style: TextStyle(
                              color:
                                  index == 3 ? primarycolor : navBarUnSelColor,
                              fontFamily: 'Poppins',
                              fontSize: FontSize10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )

          // bottomNavigationBar: BottomAppBar(
          //   elevation: 1,
          //   color: Colors.white,
          //   child: Container(
          //     padding: EdgeInsets.only(left: 10, right: 10),
          //     height: scrWidth * 0.15,
          //     width: scrWidth,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: [
          //         MaterialButton(
          //           splashColor: Colors.transparent,
          //           highlightColor: Colors.transparent,
          //           onPressed: () {
          //             setState(() {
          //               _index = 0;
          //               _currentScreen = HomeScreen();
          //             });
          //           },
          //           minWidth: scrWidth * 0.1,
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               SvgPicture.asset(
          //                 "assets/icons/home.svg",
          //                 height: bottomNavbarIconSize,
          //                 width: bottomNavbarIconSize,
          //                 color: _index == 0 ? primarycolor : Colors.black,
          //               ),
          //               Text(
          //                 'Home',
          //                 style: TextStyle(
          //                   color: _index == 0 ? primarycolor : Colors.black,
          //                   fontFamily: 'Poppins',
          //                   fontSize: FontSize10,
          //                   fontWeight: FontWeight.w500,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //         MaterialButton(
          //           splashColor: Colors.transparent,
          //           highlightColor: Colors.transparent,
          //           onPressed: () {
          //             setState(() {
          //               _index = 1;
          //               _currentScreen = BuyAndSell();
          //               // _currentScreen = CreateRoomScreen();
          //             });
          //           },
          //           minWidth: scrWidth * 0.1,
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               SvgPicture.asset(
          //                 "assets/icons/buyandsell.svg",
          //                 height: bottomNavbarIconSize,
          //                 width: bottomNavbarIconSize,
          //                 color: _index == 1 ? primarycolor : Colors.black,
          //               ),
          //               Text(
          //                 'Buy & Sell',
          //                 style: TextStyle(
          //                   color: _index == 1 ? primarycolor : Colors.black,
          //                   fontFamily: 'Poppins',
          //                   fontSize: FontSize10,
          //                   fontWeight: FontWeight.w500,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //         MaterialButton(
          //           splashColor: Colors.transparent,
          //           highlightColor: Colors.transparent,
          //           onPressed: () {
          //             setState(() {
          //               _index = 2;
          //               // _currentScreen = Expense();
          //               _currentScreen = LoginOrSignupPage();
          //             });
          //           },
          //           minWidth: scrWidth * 0.1,
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               SvgPicture.asset(
          //                 "assets/icons/expense.svg",
          //                 color: _index == 2 ? primarycolor : Colors.black,
          //                 height: bottomNavbarIconSize,
          //                 width: bottomNavbarIconSize,
          //               ),
          //               Text(
          //                 'Expense',
          //                 style: TextStyle(
          //                   color: _index == 2 ? primarycolor : Colors.black,
          //                   fontFamily: 'Poppins',
          //                   fontSize: FontSize10,
          //                   fontWeight: FontWeight.w500,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //         MaterialButton(
          //           splashColor: Colors.transparent,
          //           highlightColor: Colors.transparent,
          //           onPressed: () {
          //             setState(() {
          //               _index = 3;
          //               // _currentScreen = Utilities();
          //               _currentScreen = CreateRoomScreen();
          //             });
          //           },
          //           minWidth: scrWidth * 0.1,
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //             children: [
          //               SvgPicture.asset(
          //                 "assets/icons/utilities.svg",
          //                 color: _index == 3 ? primarycolor : Colors.black,
          //                 height: bottomNavbarIconSize,
          //                 width: bottomNavbarIconSize,
          //               ),
          //               Text(
          //                 'Utilities',
          //                 style: TextStyle(
          //                   color: _index == 3 ? primarycolor : Colors.black,
          //                   fontFamily: 'Poppins',
          //                   fontSize: FontSize10,
          //                   fontWeight: FontWeight.w500,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),

          // floatingActionButton:
          //     Bounceable(
          //   onTap: () {},
          //   child: Container(
          //     width: scrWidth * .52,
          //     height: scrWidth * 0.13,
          //     child: ElevatedButton.icon(
          //       icon: Icon(Icons.add),
          //       style: ButtonStyle(
          //           backgroundColor: MaterialStateProperty.all(primarycolor),
          //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //               RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(20.0),
          //           ))),
          //       onPressed: () {
          //         bottomsheets(context);
          //       },
          //       label: Text(
          //         "Create Room",
          //         style: TextStyle(
          //           fontSize: FontSize17,
          //           fontFamily: 'Urbanist',
          //           fontWeight: FontWeight.w600,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          ),
    );
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

      print('================ContactLength=================');
      print(contacts.length);
    });
  }
}
