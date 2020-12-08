class NotificationM {
  final String title;
  final String body;
  final String type;
  final String topicDate;
  final String topicRef;
  int count = 0;
  var dateTime;

  Map<String, dynamic> getMap() {
    return {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'id': '1',
      'status': 'done',
      'title': this.title,
      'body': this.body,
      'topicDate': this.topicDate,
      'topicRef': this.topicRef,
      'type':this.type
    };
  }

  NotificationM(
      this.title, this.body, this.topicDate, this.topicRef, this.dateTime, this.type);
}
