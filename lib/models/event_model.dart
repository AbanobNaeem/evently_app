class EventModel {
  String eventID ;
  String title ;
  String eventName ;
  String eventImage ;
  DateTime eventDateTime ;
  String eventTime;
  String eventDescription ;
  String eventLocation ;
  bool isFavorite ;
  double? latitude ;
  double? longitude ;


  EventModel({
    this.eventID = "",
    required this.title,
    required this.eventName,
    required this.eventImage,
    required this.eventDateTime,
    required this.eventTime,
    required this.eventDescription,
    required this.eventLocation,
    required this.latitude,
    required this.longitude,
    this.isFavorite = false,
}) ;


  EventModel.fromFirestore(Map<String , dynamic>data):this(
     latitude: data["latitude"]?? 0 ,
     longitude: data["longitude"]?? 0,
     eventLocation: data["eventLocation"] ?? "unknown location",
     eventID: data["eventID"],
     title: data["title"],
     eventName: data["eventName"],
     eventImage: data["eventImage"],
     eventDateTime: DateTime.fromMillisecondsSinceEpoch(data["eventDateTime"]),
     eventTime: data["eventTime"],
     eventDescription: data["eventDescription"],
     isFavorite: data["isFavorite"],
  );



  Map<String , dynamic>toFirestore(){
    return {
      "latitude" : latitude,
      "longitude" : longitude,
      "eventLocation" : eventLocation,
      "eventID" : eventID,
      "title" : title,
      "eventName" : eventName,
      "eventImage" : eventImage,
      "eventDateTime" : eventDateTime.millisecondsSinceEpoch,
      "eventTime" : eventTime,
      "eventDescription" : eventDescription,
      "isFavorite" : isFavorite,
    };
  }

}