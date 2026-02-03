import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../helper_functions/notification_service.dart';
import '../../helper_functions/alarm_model.dart';
import '../../widgets/alram_text.dart';
import '../../widgets/fetch_real_location.dart';
import '../../utils/app_color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotificationService _service = NotificationService();
  final List<AlarmModel> alarms = [];
  int _alarmId = 0;

  @override
  void initState() {
    super.initState();
    _service.initNotification();
    requestNotificationPermission();
  }

  Future<void> requestNotificationPermission() async {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
  }

  String _formatTime(DateTime time) =>
      TimeOfDay.fromDateTime(time).format(context);

  String _formatDate(DateTime time) =>
      '${_weekDay(time.weekday)} ${time.day} ${_month(time.month)}';

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

  Future<void> _addAlarm() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime == null) return;

    final now = DateTime.now();
    final alarmTime = DateTime(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 108),
        child: FloatingActionButton(
          backgroundColor: AppColor.buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(100),
          ),
          onPressed: _addAlarm,
          child: const Icon(Icons.add, color: Colors.white, size: 30),
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
                  //SizedBox(height: 56,),
                  FetchRealLocation(),
                  const SizedBox(height: 24),

                  AlramText.AlarmText(),
                  const SizedBox(height: 20),
                  ...alarms.map(
                    (alarm) => Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      height: 70,
                      decoration: BoxDecoration(
                        color: const Color(0XFF201A43),
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              final pickedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.fromDateTime(alarm.time),
                              );
                              if (pickedTime == null) return;
                              final now = DateTime.now();
                              final newTime = DateTime(
                                now.year,
                                now.month,
                                now.day,
                                pickedTime.hour,
                                pickedTime.minute,
                              );
                              setState(() => alarm.time = newTime);
                              if (alarm.isOn) {
                                await _service.cancelAlarm(alarm.id);
                                await _service.setAlarm(alarm.time, alarm.id);
                              }
                            },
                            child: Text(
                              _formatTime(alarm.time),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                  fontWeight: FontWeight.w400

                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            _formatDate(alarm.time),
                            style: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 16,
                                fontWeight: FontWeight.w400

                            ),
                          ),
                          SizedBox(width: 8,),
                          Text('2026',style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 16,
                            fontWeight: FontWeight.w400
                          ),),
                          const SizedBox(width: 8),
                          Switch(
                            value: alarm.isOn,
                            activeColor: Colors.white,
                            activeTrackColor: AppColor.buttonColor,
                            inactiveThumbColor: Colors.black,
                            onChanged: (value) async {
                              setState(() => alarm.isOn = value);
                              if (value) {
                                await _service.setAlarm(alarm.time, alarm.id);
                              } else {
                                await _service.cancelAlarm(alarm.id);
                                if (await Permission.notification.isGranted) {
                                  await _service.showNotification(
                                    id: alarm.id,
                                    title: 'Alarm Off',
                                    body:
                                        'Your alarm has ${_formatTime(alarm.time)} been turned off.',
                                  );
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
