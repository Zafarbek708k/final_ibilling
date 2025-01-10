import 'package:final_ibilling/assets/colors/app_colors.dart';
import 'package:final_ibilling/core/utils/extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCalendarWidget extends StatefulWidget {
  const CustomCalendarWidget({super.key, required this.onDateSelected});

  final Function({required DateTime date}) onDateSelected;

  @override
  CustomCalendarWidgetState createState() => CustomCalendarWidgetState();
}

class CustomCalendarWidgetState extends State<CustomCalendarWidget> {
  int currentYear = DateTime.now().year;
  int currentMonth = DateTime.now().month;
  int currentWeekIndex = 0;
  int today = DateTime.now().day;
  int? selectedDay;

  void _goToPreviousWeek() {
    setState(() {
      if (currentWeekIndex > 0) {
        currentWeekIndex--;
      } else {
        if (currentMonth == 1) {
          currentMonth = 12;
          currentYear--;
        } else {
          currentMonth--;
        }
        currentWeekIndex = _calculateWeeksInMonth(currentYear, currentMonth) - 1;
      }
      selectedDay = null;
    });
  }

  void _goToNextWeek() {
    setState(() {
      final totalWeeks = _calculateWeeksInMonth(currentYear, currentMonth);
      if (currentWeekIndex < totalWeeks - 1) {
        currentWeekIndex++;
      } else {
        if (currentMonth == 12) {
          currentMonth = 1;
          currentYear++;
        } else {
          currentMonth++;
        }
        currentWeekIndex = 0;
      }
      selectedDay = null;
    });
  }

  int _calculateWeeksInMonth(int year, int month) {
    final daysInMonth = CalendarUtils.getMonthDays(year, month).length;
    return (daysInMonth / 6).ceil(); // 6 ta kunlik qism hisoblash
  }

  List<Map<String, dynamic>> _getCurrentWeekDays() {
    final monthDays = CalendarUtils.getMonthDays(currentYear, currentMonth);
    final startIndex = currentWeekIndex * 6;
    final endIndex = (startIndex + 6).clamp(0, monthDays.length);
    return monthDays.sublist(startIndex, endIndex);
  }

  @override
  Widget build(BuildContext context) {
    final weekDays = _getCurrentWeekDays();

    return DecoratedBox(
      decoration: const BoxDecoration(color: Color(0xff1E1E20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
                  onPressed: _goToPreviousWeek,
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right, color: Colors.white, size: 35),
                  onPressed: _goToNextWeek,
                ),
              ],
            ),
          ),
          8.verticalSpace,
          SizedBox(
            height: 100,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: weekDays.length,
              itemBuilder: (context, index) {
                final day = weekDays[index];
                final isSelected = selectedDay == day['day'];
                final isToday = day['day'] == today;
                final textColor =
                    isToday ? (isSelected ? AppColors.white : AppColors.greenDark) : (isSelected ? AppColors.white : AppColors.grayShadow);
                final underlineColor =
                    isToday ? (isSelected ? AppColors.white : AppColors.greenDark) : (isSelected ? AppColors.white : AppColors.grayShadow);

                return GestureDetector(
                  onTap: () {
                    setState(() => selectedDay = day['day']);
                    widget.onDateSelected(date: day['date']);
                  },
                  child: Container(
                    width: 55,
                    margin: const EdgeInsets.only(left: 4, right: 4, bottom: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.greenDark : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          day['dayName'],
                          style: context.bodyLarge?.copyWith(color: textColor),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          day['day'].toString(),
                          style: context.bodyLarge?.copyWith(color: textColor),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0, right: 18, top: 5),
                          child: Divider(
                            color: underlineColor,
                            height: 1,
                            thickness: 1,
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

// class CustomCalendarWidget extends StatefulWidget {
//   const CustomCalendarWidget({super.key, required this.onDateSelected});
//
//   final Function({required DateTime date}) onDateSelected;
//
//   @override
//   CustomCalendarWidgetState createState() => CustomCalendarWidgetState();
// }
//
// class CustomCalendarWidgetState extends State<CustomCalendarWidget> {
//   int currentYear = DateTime.now().year;
//   int currentMonth = DateTime.now().month;
//   int today = DateTime.now().day;
//   int? selectedDay;
//
//   void _goToPreviousMonth() {
//     setState(() {
//       if (currentMonth == 1) {
//         currentMonth = 12;
//         currentYear--;
//       } else {
//         currentMonth--;
//       }
//       selectedDay = null;
//     });
//   }
//
//   void _goToNextMonth() {
//     setState(() {
//       if (currentMonth == 12) {
//         currentMonth = 1;
//         currentYear++;
//       } else {
//         currentMonth++;
//       }
//       selectedDay = null; // Reset selected day when month changes
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final monthDays = CalendarUtils.getMonthDays(currentYear, currentMonth);
//     return DecoratedBox(
//       decoration: const BoxDecoration(color: Color(0xff1E1E20)),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 18.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   '${CalendarUtils.monthNames[currentMonth - 1]}, $currentYear',
//                   style: const TextStyle(color: Colors.white, fontSize: 18),
//                 ),
//                 const Spacer(),
//                 IconButton(
//                   icon: const Icon(Icons.chevron_left, color: Colors.white, size: 35),
//                   onPressed: _goToPreviousMonth,
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.chevron_right, color: Colors.white, size: 35),
//                   onPressed: _goToNextMonth,
//                 ),
//               ],
//             ),
//           ),
//           8.verticalSpace,
//           SizedBox(
//             height: 100,
//             child: ListView.builder(
//               physics: const NeverScrollableScrollPhysics(),
//               scrollDirection: Axis.horizontal,
//               itemCount: monthDays.length,
//               itemBuilder: (context, index) {
//                 final day = monthDays[index];
//                 final isSelected = selectedDay == day['day'];
//
//                 return GestureDetector(
//                   onTap: () {
//                     setState(() => selectedDay = day['day']);
//                     widget.onDateSelected(date: day['date']);
//                   },
//                   child: Container(
//                     width: 55,
//                     margin: const EdgeInsets.only(left: 4, right: 4, bottom: 10),
//                     decoration: BoxDecoration(
//                       color: isSelected ? Colors.teal : Colors.transparent,
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           day['dayName'],
//                           style: context.bodyLarge?.copyWith(
//                             color: day["day"] == DateTime.now().day ? (isSelected ? AppColors.white : AppColors.greenDark) : AppColors.grayShadow,
//                           ),
//                         ),
//                         const SizedBox(height: 5),
//                         Text(
//                           day['day'].toString(),
//                           style: context.bodyLarge?.copyWith(
//                             color: day["day"] == DateTime.now().day ? (isSelected ? AppColors.white : AppColors.greenDark) : AppColors.grayShadow,
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 18.0, right: 18, top: 5),
//                           child: Divider(
//                             color: day["day"] == DateTime.now().day ? (isSelected ? AppColors.white : AppColors.greenDark) : AppColors.grayShadow,
//                             height: 1,
//                             thickness: 1,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
