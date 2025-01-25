/// status : true
/// events : [{"event_id":2,"event_name":"16mi Raat Jaman","event_code":"16MI-16","event_date":"12-02-2025","event_location":"Dubai, Kuwait","event_description":"Lorem Ipsum Lorem Ipsum"},{"event_id":3,"event_name":"16mi Raat Jaman","event_code":"16MI","event_date":"12-02-2025","event_location":"Dubai","event_description":"Lorem Ipsum"},{"event_id":4,"event_name":"16mi Raat Jaman","event_code":"16MI","event_date":"12-02-2025","event_location":"Dubai","event_description":"Lorem Ipsum"},{"event_id":5,"event_name":"16mi Raat Jaman","event_code":"16MI-16","event_date":"12-02-2025","event_location":"Dubai, Kuwait","event_description":"Lorem Ipsum"},{"event_id":6,"event_name":"16mi Raat Jaman","event_code":"16MI-12","event_date":"11-02-2025","event_location":"Dubai, Kuwait","event_description":"Lorem Ipsum Lorem Ipsum"}]
/// message : "List of all Events"
/// error : ""

class UserEventListDataModel {
  UserEventListDataModel({
      this.status, 
      this.events, 
      this.message, 
      this.error,});

  UserEventListDataModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['events'] != null) {
      events = [];
      json['events'].forEach((v) {
        events?.add(Events.fromJson(v));
      });
    }
    message = json['message'];
    error = json['error'];
  }
  bool? status;
  List<Events>? events;
  String? message;
  String? error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (events != null) {
      map['events'] = events?.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    map['error'] = error;
    return map;
  }

}

/// event_id : 2
/// event_name : "16mi Raat Jaman"
/// event_code : "16MI-16"
/// event_date : "12-02-2025"
/// event_location : "Dubai, Kuwait"
/// event_description : "Lorem Ipsum Lorem Ipsum"

class Events {
  Events({
      this.eventId, 
      this.eventName, 
      this.eventCode, 
      this.eventDate, 
      this.eventLocation, 
      this.eventDescription,});

  Events.fromJson(dynamic json) {
    eventId = json['event_id'];
    eventName = json['event_name'];
    eventCode = json['event_code'];
    eventDate = json['event_date'];
    eventLocation = json['event_location'];
    eventDescription = json['event_description'];
  }
  num? eventId;
  String? eventName;
  String? eventCode;
  String? eventDate;
  String? eventLocation;
  String? eventDescription;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['event_id'] = eventId;
    map['event_name'] = eventName;
    map['event_code'] = eventCode;
    map['event_date'] = eventDate;
    map['event_location'] = eventLocation;
    map['event_description'] = eventDescription;
    return map;
  }

}