// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class Flchartpage extends StatefulWidget {
//   const Flchartpage({Key? key}) : super(key: key);
//
//   @override
//   State<Flchartpage> createState() => _FlchartpageState();
// }
//
// class _FlchartpageState extends State<Flchartpage> {
//   List<Color> lineColor = [
//     Color(0xfff3f169),
//   ];
//
//   List<LineChartBarData> lineChartBarData = [
//     LineChartBarData(
//         color:Color(0xfff3f169),
//
//         isCurved: true,
//         spots: [
//           FlSpot(1, 8),
//           FlSpot(2, 12.4),
//           FlSpot(3, 10.8),
//           FlSpot(4, 9),
//           FlSpot(5, 8),
//           FlSpot(6, 8.6),
//           FlSpot(7, 10)
//         ]
//     )
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: 200,
//         height: 400,
//         child: LineChart(
//           LineChartData(
//             minX: 1,
//             minY: 0,
//             maxX: 7,
//             maxY: 16,
//             lineBarsData:[
//               LineChartBarData(
//
//
//               ),],
//             titlesData: FlTitlesData(
//               bottomTitles: AxisTitles(
//                 sideTitles: SideTitles(
//                   showTitles: true,
//                   getTitlesWidget: (value,meta) {
//                     Widget axisTitle = Text(value.toString());
//                     // A workaround to hide the max value title as FLChart is overlapping it on top of previous
//                     if (value == meta.max) {
//                       final remainder = value % meta.appliedInterval;
//                       if (remainder != 0.0 && remainder / meta.appliedInterval < 0.5) {
//                         axisTitle = const SizedBox.shrink();
//                       }
//                     }
//                     return SideTitleWidget(axisSide: meta.axisSide, child: axisTitle);
//                   }
//                 )
//               )
//             )
//
//
//           ),
//
//         ),
//       ),
//     );
//   }
// }
