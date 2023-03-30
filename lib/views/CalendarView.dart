import 'package:flutter/material.dart';
//import 'package:flutter_advanced_calendar/flutter_advanced_calendar.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  //final _calendarControllerToday = AdvancedCalendarController.today();

  DateTime setDate = DateTime.now();

  final List<DateTime> events = [
    DateTime.now(),
    DateTime(2022, 10, 10),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CalendarDatePicker(

                  initialDate: setDate,
                  firstDate: DateTime.now().subtract(const Duration(days: 730)),
                  lastDate: DateTime.now().add(const Duration(days: 730)),
                  onDateChanged: (DateTime value) => {},
              ),
              /*AdvancedCalendar(
                controller: _calendarControllerToday,
                events: events,
                preloadMonthViewAmount: 25,
                preloadWeekViewAmount: 41,
                startWeekDay: 1,
                headerStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),*/
              /*Theme(
                data: ThemeData.light().copyWith(
                  textTheme: ThemeData.light().textTheme.copyWith(
                        titleMedium: ThemeData.light().textTheme.titleMedium?.copyWith(
                              fontSize: 16,
                              color: theme.colorScheme.secondary,
                            ),
                        bodyLarge: ThemeData.light().textTheme.bodyLarge?.copyWith(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                        bodyMedium: ThemeData.light().textTheme.bodyMedium?.copyWith(
                              fontSize: 12,
                              color: Colors.black87,
                            ),
                      ),
                  primaryColor: Colors.red,
                  highlightColor: Colors.yellow,
                  disabledColor: Colors.green,
                ),
                child: AdvancedCalendar(
                  controller: _calendarControllerCustom,
                  events: events,
                  weekLineHeight: 48.0,
                  startWeekDay: 1,
                  innerDot: true,
                  keepLineSize: true,
                  calendarTextStyle: const TextStyle(
                    fontSize: 14,
                    height: 1.3125,
                    letterSpacing: 0,
                  ),
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
