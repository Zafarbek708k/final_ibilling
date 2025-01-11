import 'package:final_ibilling/assets/colors/app_colors.dart';
import 'package:final_ibilling/core/utils/extention.dart';
import 'package:flutter/material.dart';


class NewCalendar extends StatefulWidget {
  const NewCalendar({super.key, required this.onDateSelected});

  final Function({required DateTime date}) onDateSelected;

  @override
  State<NewCalendar> createState() => _NewCalendarState();
}

class _NewCalendarState extends State<NewCalendar> {
  DateTime currentWeek = DateTime.now();
  DateTime today = DateTime.now();
  DateTime? selectedDate;

  List<DateTime> _generateCurrentWeekDays() {
    final firstDayOfWeek = currentWeek.subtract(Duration(days: currentWeek.weekday - 1));
    return List.generate(7, (index) => firstDayOfWeek.add(Duration(days: index)));
  }

  void goNextWeek() {
    setState(() {
      currentWeek = currentWeek.add(const Duration(days: 7));
    });
  }

  void goPreviousWeek() {
    setState(() {
      currentWeek = currentWeek.subtract(const Duration(days: 7));
    });
  }

  String checkMonth(int num) {
    switch (num) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
      default:
        return "Invalid month";
    }
  }

  @override
  Widget build(BuildContext context) {
    final weekDays = _generateCurrentWeekDays();

    return SizedBox(
      height: 150,
      child: DecoratedBox(
        decoration: const BoxDecoration(color: AppColors.darkGray),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${checkMonth(currentWeek.month)}, ${currentWeek.year}", style: context.headlineMedium),
                  Row(
                    children: [
                      IconButton(
                        onPressed: goPreviousWeek,
                        icon: const Icon(Icons.arrow_back_ios),
                      ),
                      IconButton(
                        onPressed: goNextWeek,
                        icon: const Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Days of the week
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(weekDays.length - 1, (index) {
                  final date = weekDays[index];
                  final isSelected = selectedDate == date;
                  final isToday = date.day == today.day && date.month == today.month && date.year == today.year;

                  final color = isToday ? (isSelected ? Colors.white : AppColors.greenDark) : (isSelected ? Colors.white : Colors.grey);

                  final backgroundColor = isSelected ? AppColors.greenDark : Colors.transparent;

                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedDate = date;
                      });
                      widget.onDateSelected(date: date);
                    },
                    child: Container(
                      width: 50,
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 4.0, top: 2),
                        child: Column(
                          children: [
                            Text(
                              _getDayName(date.weekday),
                              style: context.headlineMedium?.copyWith(color: color),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "${date.day}",
                              style: context.headlineMedium?.copyWith(color: color),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0, right: 15, top: 5),
                              child: Divider(
                                color: color,
                                height: 1,
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return "Mo";
      case DateTime.tuesday:
        return "Tu";
      case DateTime.wednesday:
        return "We";
      case DateTime.thursday:
        return "Th";
      case DateTime.friday:
        return "Fr";
      case DateTime.saturday:
        return "Sa";
      case DateTime.sunday:
        return "Su";
      default:
        return "";
    }
  }
}