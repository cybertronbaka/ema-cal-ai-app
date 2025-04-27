part of 'widgets.dart';

enum ChartDateType { weekDays, months, years }

class DateChartItem {
  const DateChartItem({required this.date, required this.value});

  final DateTime date;
  final double value;
}

class DateChart extends HookWidget {
  const DateChart({super.key, required this.items, required this.dateType});
  final List<DateChartItem> items;
  final ChartDateType dateType;

  intl.DateFormat get _dateFormat {
    return switch (dateType) {
      ChartDateType.weekDays => intl.DateFormat('EEEEE'),
      ChartDateType.months => intl.DateFormat('MMM'),
      ChartDateType.years => intl.DateFormat('yyyy'),
    };
  }

  @override
  Widget build(BuildContext context) {
    final touchedSpot = useState<FlSpot?>(null);
    final showingTooltipOnSpots = useState<List<int>>([]);
    final dateSortedItems = useMemoized(() {
      return items.sorted((a, b) => a.date.compareTo(b.date));
    }, [items]);

    final valueSortedItems = useMemoized(() {
      return items.sorted((a, b) => a.value.compareTo(b.value));
    }, [items]);

    final spots = useMemoized(() {
      return dateSortedItems
          .mapIndexed((i, e) => FlSpot(i.toDouble(), e.value))
          .toList();
    }, [dateSortedItems]);
    final minY = useMemoized(() {
      if (valueSortedItems.isEmpty) return 0.0;

      return valueSortedItems.first.value;
    }, [valueSortedItems]);

    final maxY = useMemoized(() {
      if (valueSortedItems.isEmpty) return 0.0;

      return valueSortedItems.last.value;
    }, [valueSortedItems]);

    final maxX = useMemoized(() {
      return dateSortedItems.length.toDouble();
    }, [dateSortedItems]);

    final lineBarsData = useMemoized(() {
      return [
        LineChartBarData(
          color: Colors.black,
          barWidth: 1.0,
          spots: spots,
          isCurved: false,
          dotData: FlDotData(
            show: true,
            getDotPainter:
                (spot, percent, barData, index) => FlDotCirclePainter(
                  radius: 4,
                  color: Colors.white,
                  strokeWidth: 1,
                  strokeColor: Colors.black,
                ),
          ),
        ),
      ];
    }, [spots]);

    final tooltipsOnBar = lineBarsData[0];
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(200),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: LineChart(
          LineChartData(
            minX: -1,
            maxX: maxX,
            minY: minY,
            maxY: maxY,
            lineTouchData: LineTouchData(
              enabled: true,
              handleBuiltInTouches: false,
              touchCallback: (FlTouchEvent event, LineTouchResponse? response) {
                if (response?.lineBarSpots != null &&
                    response!.lineBarSpots!.isNotEmpty) {
                  final spot = response.lineBarSpots!.first;
                  showingTooltipOnSpots.value = [spot.spotIndex];
                  touchedSpot.value = spot;
                }
              },
              getTouchedSpotIndicator: (_, spotIndexes) {
                return spotIndexes.map((e) => null).toList();
              },
              touchTooltipData: LineTouchTooltipData(
                getTooltipColor: (touchedSpot) => Colors.blue,
                fitInsideHorizontally: true,
                fitInsideVertically: true,
                tooltipPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                getTooltipItems: (touchedSpots) {
                  return touchedSpots.map((LineBarSpot touchedSpot) {
                    const textStyle = TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                    );
                    return LineTooltipItem(touchedSpot.y.toString(), textStyle);
                  }).toList();
                },
              ),
            ),
            showingTooltipIndicators:
                showingTooltipOnSpots.value.map((index) {
                  return ShowingTooltipIndicators([
                    LineBarSpot(
                      tooltipsOnBar,
                      lineBarsData.indexOf(tooltipsOnBar),
                      tooltipsOnBar.spots[index],
                    ),
                  ]);
                }).toList(),
            extraLinesData: ExtraLinesData(
              horizontalLines: [
                if (touchedSpot.value != null)
                  HorizontalLine(
                    y: touchedSpot.value!.y,
                    dashArray: [4],
                    color: Colors.black.withAlpha(100),
                  ),
              ],
              verticalLines: [
                if (touchedSpot.value != null)
                  VerticalLine(
                    x: touchedSpot.value!.x,
                    dashArray: [4],
                    color: Colors.black.withAlpha(100),
                  ),
              ],
              extraLinesOnTop: false,
            ),

            lineBarsData: lineBarsData,
            titlesData: FlTitlesData(
              rightTitles: const AxisTitles(),
              topTitles: const AxisTitles(),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                  interval: 1,
                  getTitlesWidget: (value, meta) {
                    return SideTitleWidget(
                      meta: meta,
                      child:
                          value == spots.length || value == -1
                              ? Container()
                              : Text(
                                _dateFormat.format(
                                  dateSortedItems[value.toInt()].date,
                                ),
                                style: const TextStyle(fontSize: 12),
                              ),
                    );
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 50,
                  getTitlesWidget: (value, meta) {
                    return SideTitleWidget(
                      meta: meta,
                      child:
                          value == spots.length || value == -1
                              ? Container()
                              : Text(
                                value.toStringAsFixed(1),
                                style: const TextStyle(fontSize: 12),
                              ),
                    );
                  },
                ),
              ),
            ),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              getDrawingHorizontalLine:
                  (v) =>
                      const FlLine(color: AppColors.cardBorder, strokeWidth: 1),
              horizontalInterval: 1,
            ),
            borderData: FlBorderData(
              show: true,
              border: const Border(
                left: BorderSide(color: AppColors.cardBorder),
                bottom: BorderSide(color: AppColors.cardBorder),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
