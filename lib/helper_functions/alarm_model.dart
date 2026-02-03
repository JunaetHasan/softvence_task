class AlarmModel {
  int id;
  DateTime time;
  bool isOn;

  AlarmModel({required this.id, required this.time, this.isOn = true});
}
