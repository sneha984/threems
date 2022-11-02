import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:threems/utils/themes.dart';

class FlGraph extends StatefulWidget {
  const FlGraph({super.key});

  @override
  State<FlGraph> createState() => _FlGraphState();
}

class _FlGraphState extends State<FlGraph> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 360,
          width: 320,
          child: LineChart(
            LineChartData(
                titlesData: FlTitlesData(
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(
                  border: Border(
                    top: BorderSide.none,
                    right: BorderSide.none,
                    left: BorderSide(
                        color: Color(0xff454459).withOpacity(0.1), width: 2),
                    bottom: BorderSide(
                        color: Color(0xff454459).withOpacity(0.1), width: 2),
                  ),
                ),
                lineTouchData: LineTouchData(
                  handleBuiltInTouches: true,
                  touchTooltipData: LineTouchTooltipData(
                    tooltipBgColor: Colors.white.withOpacity(0.6),
                    tooltipRoundedRadius: 8,
                    tooltipBorder:
                        BorderSide(color: Color(0xff28B446), width: 1),
                  ),
                ),
                minX: 0,
                maxX: 11,
                minY: 0,
                maxY: 6,
                gridData: FlGridData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    color: primarycolor,
                    isStrokeCapRound: true,
                    belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [.01, 1],
                            colors: gradientColors
                                .map((color) => color.withOpacity(0.1))
                                .toList())),
                    barWidth: 4,
                    dotData: FlDotData(
                      show: true,
                    ),
                    isCurved: true,
                    curveSmoothness: .5,
                    spots: [
                      FlSpot(0, 3),
                      FlSpot(2, 2),
                      FlSpot(4, 5),
                      FlSpot(6, 2),
                      FlSpot(8, 4),
                      FlSpot(9, 3),
                      FlSpot(11, 4),
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }

  List<Color> gradientColors = [
    const Color(0xff008036).withOpacity(0.59),
    const Color(0xffDAFFE2).withOpacity(0),
  ];
}
