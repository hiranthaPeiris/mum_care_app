import 'package:mun_care_app/models/Notification.model.dart';

class DataHolder{
  static final DataHolder _dataHolder = DataHolder._internal();
  static String uid;

  factory DataHolder(){
    return _dataHolder;
  }
  
  DataHolder._internal();

  List<NotificationM> notifications = [
    new NotificationM("Test header1", "test Content 1", "test topic data","test topic ref",new DateTime(2000),"clinic")
  ];

  void addNotification(Map<String, dynamic> message) {
    //var notification = message['notification'];
    var data = message['data'];
    print(data);
    print("from data");
    notifications.add(new NotificationM(
        data.customData, data.click_action, "test topic data","test topic ref", new DateTime.now(), "clinic"));
    print(notifications[1].title);
  }
  List<NotificationM> getList(){
    return notifications;
  }
}
