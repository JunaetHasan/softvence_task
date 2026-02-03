import 'dart:async';
import 'package:flutter/material.dart';
import 'package:task_assignment/widgets/fetch_real_location.dart';
import 'package:task_assignment/helper_functions/notification_service.dart';
import '../../helper_functions/alarm_model.dart' show AlarmModel;
import '../../utils/app_color.dart' show AppColor;
import '../../widgets/alram_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotificationService _service = NotificationService();

  String _formatTime(DateTime time) {
    return TimeOfDay.fromDateTime(time).format(context);
  }

  String _formatDate(DateTime time) {
    return '${_weekDay(time.weekday)} ${time.day} ${_month(time.month)}';
  }

  String _weekDay(int day) =>
      ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][day - 1];

  String _month(int month) => [
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
  ][month - 1];
  int _alarmId = 0;
  final List<AlarmModel> alarms = [];

  Future<void> _addAlarm() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime == null) return;

    final DateTime now = DateTime.now();
    final DateTime alarmTime = DateTime(
      now.year,
      now.month,
      now.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    final alarm = AlarmModel(id: _alarmId++, time: alarmTime);

    setState(() => alarms.add(alarm));

    await _service.setAlarm(alarm.time, alarm.id);
  }

  Future<void> _editAlarm(AlarmModel alarm) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(alarm.time),
    );
    if (pickedTime == null) return;
    final DateTime now = DateTime.now();
    final DateTime newTime = DateTime(
      now.year,
      now.month,
      now.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    setState(() => alarm.time = newTime);

    await _service.cancelAlarm(alarm.id);
    await _service.setAlarm(alarm.time, alarm.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFF0B0F2F),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 16, bottom: 108),
        child: FloatingActionButton(
          backgroundColor: AppColor.buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(100),
          ),
          onPressed: _addAlarm,

          //_addAlarm,
          child: const Icon(
            Icons.add,
            size: 24,
            weight: 24,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [AppColor.backgroundColor, AppColor.liner],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //text
                  FetchRealLocation(),
                  SizedBox(height: 30),

                  AlramText.AlarmText(),
                  SizedBox(height: 20),

                  ...alarms.map((alarm) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      height: 70,
                      decoration: BoxDecoration(
                        color: Color(0XFF201A43),
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              final TimeOfDay? pickedTime =
                                  await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.fromDateTime(
                                      alarm.time,
                                    ),
                                  );

                              if (pickedTime == null) return;

                              final DateTime now = DateTime.now();
                              final DateTime newTime = DateTime(
                                now.year,
                                now.month,
                                now.day,
                                pickedTime.hour,
                                pickedTime.minute,
                              );

                              setState(() {
                                alarm.time = newTime;
                              });

                              await _service.cancelAlarm(alarm.id);
                              await _service.setAlarm(alarm.time, alarm.id);
                            },
                            child: Text(
                              _formatTime(alarm.time),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            _formatDate(alarm.time),
                            style: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            '2026',
                            style: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 5),
                          Switch(
                            inactiveThumbColor: Colors.black,
                            activeColor: Colors.white,
                            activeTrackColor: AppColor.buttonColor,
                            value: alarm.isOn,
                            onChanged: (value) async {
                              setState(() => alarm.isOn = value);
                              if (value) {
                                await _service.setAlarm(alarm.time, alarm.id);
                              } else {
                                await _service.cancelAlarm(alarm.id);
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
