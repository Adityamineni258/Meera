import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:collection/collection.dart'; // This import is for groupBy, ensure it's available
import 'mood_entry.dart';
import 'local_mood_service.dart';
import 'package:meera/constants/app_theme.dart';

class HistoryPage extends StatefulWidget {
  final LocalMoodService localMoodService;

  const HistoryPage({super.key, required this.localMoodService});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late Future<List<MoodEntry>> _moodEntriesFuture;

  @override
  void initState() {
    super.initState();
    _moodEntriesFuture = _getMoodHistory();
  }

  Future<List<MoodEntry>> _getMoodHistory() async {
    final entries = await widget.localMoodService.getMoodEntries();
    if (entries.isEmpty) {
      await widget.localMoodService.addDummyEntries();
      return widget.localMoodService.getMoodEntries(); // Fetch again after adding dummies
    }
    return entries;
  }

  void _showProactiveInsight() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: const Text('Your Weekly Insight',
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: const Text(
              "Taking the time to track your mood is a great step towards self-awareness. Keep it up!"),
          actions: <Widget>[
            TextButton(
              child: const Text('Thanks', style: TextStyle(color: AppTheme.primaryColor)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mood History',
          style: TextStyle(
              color: AppTheme.textColor,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins'),
        ),
        centerTitle: true,
        backgroundColor: AppTheme.scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: AppTheme.textColor), // Back arrow color
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.cardColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryColor.withAlpha(26),
                      spreadRadius: 5,
                      blurRadius: 15,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FutureBuilder<List<MoodEntry>>(
                    future: _moodEntriesFuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                            child: Text('Error loading history.', style: TextStyle(color: AppTheme.textColor)));
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final moodHistory = snapshot.data ?? [];
                      if (moodHistory.isEmpty) {
                        return Center(
                            child: Text('No history to display.', style: TextStyle(color: AppTheme.textColor)));
                      }
                      return MoodChart(moodHistory: moodHistory);
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _showProactiveInsight,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.cardColor,
                foregroundColor: AppTheme.primaryColor,
                elevation: 5,
                shadowColor: AppTheme.primaryColor.withAlpha(51),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text(
                'Show Proactive Insight',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class MoodChart extends StatelessWidget {
  final List<MoodEntry> moodHistory;

  const MoodChart({super.key, required this.moodHistory});

  @override
  Widget build(BuildContext context) {
    final dailyAverages = _calculateDailyAverages(moodHistory);

    return LineChart(
      LineChartData(
        maxY: 5,
        minY: 1,
        gridData: const FlGridData(show: false),
        titlesData: FlTitlesData(
          show: true,
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32,
              interval: 1,
              getTitlesWidget: (value, meta) {
                String emoji;
                switch (value.toInt()) {
                  case 1:
                    emoji = '😔';
                    break;
                  case 2:
                    emoji = '😟';
                    break;
                  case 3:
                    emoji = '😐';
                    break;
                  case 4:
                    emoji = '🙂';
                    break;
                  case 5:
                    emoji = '😄';
                    break;
                  default:
                    return Container();
                }
                return Text(emoji, style: const TextStyle(fontSize: 20));
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: (double value, TitleMeta meta) {
                const style = TextStyle(
                  color: AppTheme.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                );
                Widget text;
                switch (value.toInt()) {
                  case 0:
                    text = const Text('Mon', style: style);
                    break;
                  case 1:
                    text = const Text('Tue', style: style);
                    break;
                  case 2:
                    text = const Text('Wed', style: style);
                    break;
                  case 3:
                    text = const Text('Thu', style: style);
                    break;
                  case 4:
                    text = const Text('Fri', style: style);
                    break;
                  case 5:
                    text = const Text('Sat', style: style);
                    break;
                  case 6:
                    text = const Text('Sun', style: style);
                    break;
                  default:
                    text = const Text('', style: style);
                    break;
                }
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  space: 8.0,
                  child: text,
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: dailyAverages.entries
                .map((entry) => FlSpot(entry.key.toDouble(), entry.value))
                .toList(),
            isCurved: true,
            gradient: LinearGradient(
              colors: [
                AppTheme.primaryColor, // Use AppTheme color
                AppTheme.accentColor, // Use AppTheme color
              ],
            ),
            barWidth: 4,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  AppTheme.primaryColor.withAlpha(77), // Use AppTheme color
                  AppTheme.accentColor.withAlpha(77) // Use AppTheme color
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Map<int, double> _calculateDailyAverages(List<MoodEntry> moodHistory) {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final weekStartMarker = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);

    final recentEntries = moodHistory.where((entry) {
      return !entry.timestamp.isBefore(weekStartMarker);
    }).toList();

    final groupedByDay = groupBy(recentEntries, (MoodEntry entry) => entry.timestamp.weekday - 1);

    final Map<int, double> dailyAverages = {};
    for (int i = 0; i < 7; i++) {
      if (groupedByDay.containsKey(i)) {
        final dayEntries = groupedByDay[i]!;
        final average = dayEntries.map((e) => e.mood).reduce((a, b) => a + b) / dayEntries.length;
        dailyAverages[i] = average;
      } else {
        // You might want to handle days with no entries differently
        // For now, let's not add a spot for them to avoid a line to zero
      }
    }
    return dailyAverages;
  }
}