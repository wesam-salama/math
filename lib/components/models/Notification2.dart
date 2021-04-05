class Notification2 {
  String event;
  String data;

  Notification2({this.event, this.data});

  Notification2.fromJson(Map<String, dynamic> json) {
    event = json['event'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event'] = this.event;
    data['data'] = this.data;
    return data;
  }
}
