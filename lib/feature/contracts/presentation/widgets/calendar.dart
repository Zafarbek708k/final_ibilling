import 'package:flutter/material.dart';

class CustomCalendarWidget extends StatefulWidget {
  const CustomCalendarWidget({super.key, required this.onDateSelected});
  final Function({required DateTime date}) onDateSelected;

  @override
  CustomCalendarWidgetState createState() => CustomCalendarWidgetState();
}

class CustomCalendarWidgetState extends State<CustomCalendarWidget> {
  int currentYear = DateTime.now().year;
  int currentMonth = DateTime.now().month;
  int today = DateTime.now().day;
  int? selectedDay;

  void _goToPreviousMonth() {
    setState(() {
      if (currentMonth == 1) {
        currentMonth = 12;
        currentYear--;
      } else {
        currentMonth--;
      }
      selectedDay = null; // Reset selected day when month changes
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
      selectedDay = null; // Reset selected day when month changes
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
                Text(
                  '${CalendarUtils.monthNames[currentMonth - 1]}, $currentYear',
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.chevron_left, color: Colors.white, size: 35),
                  onPressed: _goToPreviousMonth,
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right, color: Colors.white, size: 35),
                  onPressed: _goToNextMonth,
                ),
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
                final isSelected = selectedDay == day['day'];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDay = day['day'];
                    });
                    // Pass the selected date to the callback
                    widget.onDateSelected(date: day['date']);
                  },
                  child: Container(
                    width: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.teal : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: isSelected
                          ? Border.all(color: Colors.tealAccent, width: 2)
                          : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          day['dayName'],
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          day['day'].toString(),
                          style: const TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        if (isSelected)
                          const Padding(
                            padding: EdgeInsets.only(left: 18.0, right: 18, top: 5),
                            child: Divider(
                              color: Colors.white,
                              height: 2,
                              thickness: 4,
                            ),
                          ),
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

