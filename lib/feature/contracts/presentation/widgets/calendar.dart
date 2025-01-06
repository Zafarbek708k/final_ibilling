import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCalendarWidget extends StatefulWidget {
  const CustomCalendarWidget({super.key, required this.pressData});

  final VoidCallback pressData;

  @override
  CustomCalendarWidgetState createState() => CustomCalendarWidgetState();
}

class CustomCalendarWidgetState extends State<CustomCalendarWidget> {
  int currentYear = DateTime.now().year;
  int currentMonth = DateTime.now().month;
  int today = DateTime.now().day;

  void _goToPreviousMonth() {
    setState(() {
      if (currentMonth == 1) {
        currentMonth = 12;
        currentYear--;
      } else {
        currentMonth--;
      }
    });
  }

  void _goToNextMonth() {
    setState(() {
      if (currentMonth == 12) {
        currentMonth = 1;
        currentYear++;
      } else {
        currentMonth++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final monthDays = CalendarUtils.getMonthDays(currentYear, currentMonth);
    return DecoratedBox(
      decoration: const BoxDecoration(color: Color(0xff1E1E20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top Section: Month and Year with navigation buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${CalendarUtils.monthNames[currentMonth - 1]}, $currentYear'),
                const Spacer(),
                IconButton(icon: const Icon(Icons.chevron_left, color: Colors.white, size: 35), onPressed: _goToPreviousMonth),
                IconButton(icon: const Icon(Icons.chevron_right, color: Colors.white, size: 35), onPressed: _goToNextMonth),
              ],
            ),
          ),
          // Horizontal ListView for days
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: monthDays.length,
              itemBuilder: (context, index) {
                final day = monthDays[index];
                return GestureDetector(
                  onTap: widget.pressData,
                  child: Container(
                    width: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: day['day'] == today  && currentMonth == 1 ? Colors.teal : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(day['dayName'], style: const TextStyle(color: Colors.white)),
                        5.verticalSpace,
                        Text(day['day'].toString(), style: const TextStyle(color: Colors.white, fontSize: 16)),
                        const Padding(
                          padding: EdgeInsets.only(left: 18.0, right: 18, top: 5),
                          child: Divider(color: Colors.white, height: 2, thickness: 4),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CalendarUtils {
  static const List<String> monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  static const List<String> dayNames = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];

  static List<Map<String, dynamic>> getMonthDays(int year, int month) {
    final firstDayOfMonth = DateTime(year, month, 1);
    final daysInMonth = DateTime(year, month + 1, 0).day;

    return List.generate(daysInMonth, (index) {
      final date = firstDayOfMonth.add(Duration(days: index));
      return {
        'dayName': dayNames[date.weekday - 1], // Weekday starts from 1 (Monday)
        'day': date.day,
        'date': date,
      };
    });
  }
}
