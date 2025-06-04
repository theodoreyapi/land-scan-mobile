class Events {
  int? eventId;
  String? eventImage;
  String? eventName;
  String? eventLieu;
  String? eventDate;
  String? eventTime;
  String? porteName;
  int? totalTickets;
  int? ticketsScannes;

  Events({
    this.eventId,
    this.eventImage,
    this.eventName,
    this.eventLieu,
    this.eventDate,
    this.eventTime,
    this.porteName,
    this.totalTickets,
    this.ticketsScannes,
  });

  Events.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    eventImage = json['event_image'];
    eventName = json['event_name'];
    eventLieu = json['event_lieu'];
    eventDate = json['event_date'];
    eventTime = json['event_time'];
    porteName = json['porte_name'];
    totalTickets = json['total_tickets'];
    ticketsScannes = json['tickets_scannes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['event_id'] = eventId;
    data['event_image'] = eventImage;
    data['event_name'] = eventName;
    data['event_lieu'] = eventLieu;
    data['event_date'] = eventDate;
    data['event_time'] = eventTime;
    data['porte_name'] = porteName;
    data['total_tickets'] = totalTickets;
    data['tickets_scannes'] = ticketsScannes;
    return data;
  }
}
