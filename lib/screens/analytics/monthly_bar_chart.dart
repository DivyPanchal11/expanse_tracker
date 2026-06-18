import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MonthlyBarChart extends StatelessWidget {
  final List<double> monthlyData;

  const MonthlyBarChart({
    super.key,
    required this.monthlyData,
  });

  @override
  Widget build(BuildContext context) {
    double maxValue =
    monthlyData.isEmpty
        ? 1000
        : monthlyData.reduce((a, b) => a > b ? a : b);

    return SizedBox(
      height: 350,
      child: BarChart(
        BarChartData(
          borderData: FlBorderData(show: false),

          gridData: const FlGridData(
            show: true,
          ),

          maxY: maxValue == 0 ? 1000 : maxValue * 1.2,

          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                interval: maxValue == 0
                    ? 250
                    : (maxValue / 4),

                getTitlesWidget: (value, meta) {
                  if (value >= 1000) {
                    return Text(
                      '${(value / 1000).toStringAsFixed(0)}K',
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    );
                  }

                  return Text(
                    value.toInt().toString(),
                    style: const TextStyle(
                      fontSize: 10,
                    ),
                  );
                },
              ),
            ),

            rightTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),

            topTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),

            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,

                getTitlesWidget: (value, meta) {
                  const months = [
                    'Jan',
                    'Feb',
                    'Mar',
                    'Apr',
                    'May',
                    'Jun',
                    'Jul',
                    'Aug',
                    'Sep',
                    'Oct',
                    'Nov',
                    'Dec',
                  ];

                  int index = value.toInt();

                  if (index < 0 || index > 11) {
                    return const SizedBox();
                  }

                  return SideTitleWidget(
                    meta: meta,
                    child: Text(
                      months[index],
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          barGroups: List.generate(
            12,
                (index) => BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: monthlyData[index],
                  width: 14,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}