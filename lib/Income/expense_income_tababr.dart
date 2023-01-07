import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Expenses/Expense_first_page.dart';
import '../Expenses/Report/ExpenseReportByYear.dart';
import '../IncomeExpenceReport/IncomeExpenceReportByYear.dart';
import '../IncomeExpenceReport/IncomeExpenseReportBydate.dart';
import '../screens/splash_screen.dart';
import '../utils/themes.dart';
import 'Report/IncomeReportByYear.dart';
import 'income_firstPage.dart';
class ExpenseIncomeTabPage extends StatefulWidget {
  const ExpenseIncomeTabPage({Key? key}) : super(key: key);

  @override
  State<ExpenseIncomeTabPage> createState() => _ExpenseIncomeTabPageState();
}

class _ExpenseIncomeTabPageState extends State<ExpenseIncomeTabPage>with TickerProviderStateMixin {

  late TabController _tabController;
  bool isShopNotCreated = false;
  @override
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    super.initState();
  }
  void dispose() {
    super.dispose();
    _tabController.dispose();
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
        elevation:0.1,
        backgroundColor: Colors.white,


        title: Text(
          " Your CashBook",
          style: TextStyle(
              fontSize: scrWidth*0.046,
              color: Colors.black,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w600),
        ),
        actions: [
          Padding(
            padding:  const EdgeInsets.only(right: 18.0),
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>IncomeExpenseByDatePage()));
              },
              child: Container(
                child: SvgPicture.asset(
              'assets/images/expense tracker.svg',height: 35,width: 35,
                 ),
              ),
            ),
          )
          // Padding(
          //   padding: const EdgeInsets.only(right: 18.0),
          //   child:  PopupMenuButton<MenuItem>(
          //     constraints: BoxConstraints(
          //         maxWidth: 180,
          //         minWidth: 150,
          //         maxHeight: 100,
          //         minHeight: 100),
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(8)),
          //     position: PopupMenuPosition.under,
          //     child: SvgPicture.asset(
          //       'assets/images/expense tracker.svg',height: 35,width: 35,
          //     ),
          //     itemBuilder: (context) => [
          //       PopupMenuItem(
          //         onTap: () {
          //           Navigator.pop(context);
          //           // Uri call = Uri.parse('http://wa.me/91${ku!}');
          //           //
          //           // launchUrl(call);
          //         },
          //         height: 30,
          //         child: InkWell(
          //           onTap: () {
          //             // Navigator.push(context, MaterialPageRoute(builder: (context)=>ExpenseReportPage()));
          //              Navigator.push(context, MaterialPageRoute(builder: (context)=>ExpenseReportPage()));
          //             // Uri call = Uri.parse('http://wa.me/91${ku!}');
          //             //
          //             // launchUrl(call);
          //           },
          //
          //           child: Text(
          //             "Expense Report",
          //             style: TextStyle(
          //               color: Colors.black,
          //               fontSize: FontSize15,
          //               fontFamily: "Urbanist",
          //               fontWeight: FontWeight.w500,
          //             ),
          //           ),
          //         ),
          //       ),
          //       PopupMenuItem(
          //         onTap: () {
          //           // Uri call = Uri.parse('http://wa.me/91${ku!}');
          //           //
          //           // launchUrl(call);
          //         },
          //         height: 10,
          //         child:SizedBox(height: 2,)
          //       ),
          //       PopupMenuItem(
          //         onTap: () {
          //           Navigator.pop(context);
          //           // Uri call = Uri.parse('http://wa.me/91${ku!}');
          //           //
          //           // launchUrl(call);
          //         },
          //         height: 30,
          //         child: InkWell(
          //           onTap: () {
          //             Navigator.push(context, MaterialPageRoute(builder: (context)=>IncomeReportPage()));
          //             // Uri call = Uri.parse('http://wa.me/91${ku!}');
          //             //
          //             // launchUrl(call);
          //           },
          //           child: Text(
          //             "Income Report",
          //             style: TextStyle(
          //               color: Colors.black,
          //               fontSize: FontSize15,
          //               fontFamily: "Urbanist",
          //               fontWeight: FontWeight.w500,
          //             ),
          //           ),
          //         ),
          //       ),
          //
          //     ],
          //   ),
          //
          // )
        ],
      ),
      body:  Column(
        children: [
          SizedBox(height: scrHeight * 0.015,),
          Padding(
            padding: EdgeInsets.only(
                left: scrWidth * 0.05, right: scrWidth * 0.05),
            child: Container(
              height: scrHeight * 0.05,
              decoration: BoxDecoration(
                color: primarycolor,
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
              ),
              child: TabBar(
                controller: _tabController,
                // give the indicator a decoration (color and border radius)
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                  color: Color(0xff02B558),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white,
                tabs: [
                  Text("INCOME", style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: scrWidth*0.04,
                      fontWeight: FontWeight.w700
                  ),),
                  Text("EXPENSE", style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize:scrWidth*0.04 ,
                      fontWeight: FontWeight.w700
                  ),),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
                controller: _tabController,
                children: [
                  IncomeFirstPage(),
                  AddExpensesPage(),

                ]
            ),

          )
        ],
      ),

    );
  }
}
