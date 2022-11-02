import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:threems/screens/splash_screen.dart';
import 'package:threems/utils/themes.dart';
import '../ByeandSell/buy_and_sell.dart';
import '../screens/expense.dart';
import '../screens/home_screen.dart';
import '../screens/utilities.dart';

class ScreenLayout extends StatefulWidget {
  const ScreenLayout({Key? key}) : super(key: key);

  @override
  State<ScreenLayout> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<ScreenLayout> {
  // double selectedIndex = 0;
  final PageStorageBucket _bucket = PageStorageBucket();
  Widget _currentScreen = HomeScreen();
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          extendBody: true,
          body: PageStorage(
            bucket: _bucket,
            child: _currentScreen,
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(
                left: scrWidth * 0.059,
                right: scrWidth * 0.059,
                bottom: scrWidth * 0.059
            ),
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
                          _index = 0;
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
                            color:
                                _index == 0 ? primarycolor : navBarUnSelColor,
                          ),
                          Text(
                            'Home',
                            style: TextStyle(
                              color:
                                  _index == 0 ? primarycolor : navBarUnSelColor,
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
                          _index = 1;
                          _currentScreen = BuyAndSell();
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
                            color:
                                _index == 1 ? primarycolor : navBarUnSelColor,
                          ),
                          Text(
                            'Buy & Sell',
                            style: TextStyle(
                              color:
                                  _index == 1 ? primarycolor : navBarUnSelColor,
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
                          _index = 2;
                          _currentScreen = Expense();
                          // _currentScreen = LoginOrSignupPage();
                        });
                      },
                      minWidth: scrWidth * 0.1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/icons/expense.svg",
                            color:
                                _index == 2 ? primarycolor : navBarUnSelColor,
                            height: bottomNavbarIconSize,
                            width: bottomNavbarIconSize,
                          ),
                          Text(
                            'Expense',
                            style: TextStyle(
                              color:
                                  _index == 2 ? primarycolor : navBarUnSelColor,
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
                          _index = 3;
                          _currentScreen=Utilities();
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
                            color:
                                _index == 3 ? primarycolor : navBarUnSelColor,
                            height: bottomNavbarIconSize,
                            width: bottomNavbarIconSize,
                          ),
                          Text(
                            'Utilities',
                            style: TextStyle(
                              color:
                                  _index == 3 ? primarycolor : navBarUnSelColor,
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

  // void bottomsheets(context) {
  //   showModalBottomSheet(
  //     context: context,
  //     backgroundColor: Colors.transparent,
  //     builder: (context) => StatefulBuilder(
  //       builder:
  //           (BuildContext context, void Function(void Function()) setState) {
  //         return Container(
  //           height: scrHeight * 0.36,
  //           decoration: const BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.only(
  //                 topLeft: Radius.circular(40),
  //                 topRight: Radius.circular(40),
  //               )),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               SizedBox(
  //                 height: scrHeight * 0.05,
  //               ),
  //               Padding(
  //                 padding: EdgeInsets.only(left: 30),
  //                 child: Text(
  //                   "Create New Room",
  //                   style: TextStyle(
  //                       fontFamily: 'Urbanist',
  //                       fontWeight: FontWeight.w700,
  //                       fontSize: scrWidth * 0.053),
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: scrHeight * 0.03,
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                 children: [
  //                   InkWell(
  //                     onTap: () {
  //                       setState(() {
  //                         selectedIndex = 1;
  //                       });
  //                     },
  //                     child: Column(
  //                       children: [
  //                         Badge(
  //                           animationType: BadgeAnimationType.slide,
  //                           showBadge: selectedIndex == 1 ? true : false,
  //                           padding: EdgeInsets.all(scrWidth * 0.005),
  //                           badgeContent: Icon(
  //                             Icons.check,
  //                             color: primarycolor,
  //                             size: createRoomIconSize,
  //                           ),
  //                           child: Container(
  //                             width: scrWidth * 0.23,
  //                             height: scrHeight * 0.11,
  //                             decoration: BoxDecoration(
  //                               shape: BoxShape.circle,
  //                               color: Colors.grey.shade100,
  //                               border: selectedIndex == 1
  //                                   ? Border.all(
  //                                       color: primarycolor,
  //                                       width: 3,
  //                                     )
  //                                   : Border.all(color: Colors.transparent),
  //                             ),
  //                             child: Padding(
  //                               padding: EdgeInsets.all(scrWidth * 0.05),
  //                               child: SvgPicture.asset(
  //                                 "assets/icons/chiti_funds.svg",
  //                                 fit: BoxFit.contain,
  //                               ),
  //                             ),
  //                           ),
  //                           badgeColor: Colors.white,
  //                           position: BadgePosition(
  //                             bottom: -7,
  //                           ),
  //                         ),
  //                         SizedBox(
  //                           height: scrHeight * 0.01,
  //                         ),
  //                         Text(
  //                           "Chit",
  //                           style: TextStyle(
  //                               fontFamily: 'Urbanist',
  //                               fontWeight: FontWeight.w500,
  //                               fontSize: CardFont2),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   InkWell(
  //                     onTap: () {
  //                       setState(() {
  //                         selectedIndex = 0;
  //                       });
  //                     },
  //                     child: Column(
  //                       children: [
  //                         Badge(
  //                           animationType: BadgeAnimationType.slide,
  //                           showBadge: selectedIndex == 0 ? true : false,
  //                           padding: EdgeInsets.all(scrWidth * 0.005),
  //                           badgeContent: Icon(
  //                             Icons.check,
  //                             color: primarycolor,
  //                             size: createRoomIconSize,
  //                           ),
  //                           child: Container(
  //                             width: scrWidth * 0.23,
  //                             height: scrHeight * 0.11,
  //                             decoration: BoxDecoration(
  //                               shape: BoxShape.circle,
  //                               color: Colors.grey.shade100,
  //                               border: selectedIndex == 0
  //                                   ? Border.all(
  //                                       color: primarycolor,
  //                                       width: 3,
  //                                     )
  //                                   : Border.all(color: Colors.transparent),
  //                             ),
  //                             child: Padding(
  //                               padding: EdgeInsets.all(scrWidth * 0.05),
  //                               child: SvgPicture.asset(
  //                                 "assets/icons/kuri_funds.svg",
  //                                 fit: BoxFit.contain,
  //                               ),
  //                             ),
  //                           ),
  //                           badgeColor: Colors.white,
  //                           position: BadgePosition(
  //                             bottom: -7,
  //                           ),
  //                         ),
  //                         SizedBox(
  //                           height: scrHeight * 0.01,
  //                         ),
  //                         Text("Kuri",
  //                             style: TextStyle(
  //                                 fontFamily: 'Urbanist',
  //                                 fontWeight: FontWeight.w500,
  //                                 fontSize: CardFont2))
  //                       ],
  //                     ),
  //                   ),
  //                   InkWell(
  //                     onTap: () {
  //                       setState(() {
  //                         selectedIndex = 2;
  //                       });
  //                     },
  //                     child: Column(
  //                       children: [
  //                         Badge(
  //                           animationType: BadgeAnimationType.slide,
  //                           showBadge: selectedIndex == 2 ? true : false,
  //                           padding: EdgeInsets.all(scrWidth * 0.005),
  //                           badgeContent: Icon(
  //                             Icons.check,
  //                             color: primarycolor,
  //                             size: createRoomIconSize,
  //                           ),
  //                           child: Container(
  //                             width: scrWidth * 0.23,
  //                             height: scrHeight * 0.11,
  //                             decoration: BoxDecoration(
  //                               shape: BoxShape.circle,
  //                               color: Colors.grey.shade100,
  //                               border: selectedIndex == 2
  //                                   ? Border.all(
  //                                       color: primarycolor,
  //                                       width: 3,
  //                                     )
  //                                   : Border.all(color: Colors.transparent),
  //                             ),
  //                             child: Padding(
  //                               padding: EdgeInsets.all(scrWidth * 0.05),
  //                               child: SvgPicture.asset(
  //                                 "assets/icons/charity.svg",
  //                                 fit: BoxFit.contain,
  //                               ),
  //                             ),
  //                           ),
  //                           badgeColor: Colors.white,
  //                           position: BadgePosition(
  //                             bottom: -7,
  //                           ),
  //                         ),
  //                         SizedBox(
  //                           height: scrHeight * 0.01,
  //                         ),
  //                         Text(
  //                           "Charity",
  //                           style: TextStyle(
  //                               fontFamily: 'Urbanist',
  //                               fontWeight: FontWeight.w500,
  //                               fontSize: CardFont2),
  //                         ),
  //                       ],
  //                     ),
  //                   )
  //                 ],
  //               ),
  //               SizedBox(
  //                 height: scrHeight * 0.025,
  //               ),
  //               Center(
  //                 child: Container(
  //                   height: scrHeight * 0.07,
  //                   width: scrWidth * 0.9,
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(10),
  //                     color: primarycolor,
  //                   ),
  //                   child: Center(
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         Icon(
  //                           Icons.add,
  //                           size: createRoomIconSize,
  //                           color: Colors.white,
  //                         ),
  //                         SizedBox(
  //                           width: scrWidth * 0.01,
  //                         ),
  //                         Text(
  //                           "Create Room",
  //                           style: TextStyle(
  //                               color: Colors.white,
  //                               fontSize: FontSize17,
  //                               fontFamily: 'Urbanist',
  //                               fontWeight: FontWeight.w500),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(
  //                 height: scrWidth * 0.005,
  //               )
  //             ],
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
}
