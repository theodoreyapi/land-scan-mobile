class Events {
  int? eventId;
  String? eventImage;
  String? eventName;
  String? eventLieu;
  String? eventDate;
  String? eventTime;
  List<Tickets>? tickets;

  Events({
    this.eventId,
    this.eventImage,
    this.eventName,
    this.eventLieu,
    this.eventDate,
    this.eventTime,
    this.tickets,
  });

  Events.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    eventImage = json['event_image'];
    eventName = json['event_name'];
    eventLieu = json['event_lieu'];
    eventDate = json['event_date'];
    eventTime = json['event_time'];
    if (json['tickets'] != null) {
      tickets = <Tickets>[];
      json['tickets'].forEach((v) {
        tickets!.add(new Tickets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['event_id'] = eventId;
    data['event_image'] = eventImage;
    data['event_name'] = eventName;
    data['event_lieu'] = eventLieu;
    data['event_date'] = eventDate;
    data['event_time'] = eventTime;
    if (tickets != null) {
      data['tickets'] = tickets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tickets {
  int? ticketId;
  String? ticketCode;
  String? ticketSt;
  String? ticketFree;
  String? ticketSeas;
  String? ticketPassed;
  String? ticketStatus;

  Tickets({
    this.ticketId,
    this.ticketCode,
    this.ticketSt,
    this.ticketFree,
    this.ticketSeas,
    this.ticketPassed,
    this.ticketStatus,
  });

  Tickets.fromJson(Map<String, dynamic> json) {
    ticketId = json['ticket_id'];
    ticketCode = json['ticket_code'];
    ticketSt = json['ticket_st'];
    ticketFree = json['ticket_free'];
    ticketSeas = json['ticket_seas'];
    ticketPassed = json['ticket_passed'];
    ticketStatus = json['ticket_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ticket_id'] = ticketId;
    data['ticket_code'] = ticketCode;
    data['ticket_st'] = ticketSt;
    data['ticket_free'] = ticketFree;
    data['ticket_seas'] = ticketSeas;
    data['ticket_passed'] = ticketPassed;
    data['ticket_status'] = ticketStatus;
    return data;
  }
}
