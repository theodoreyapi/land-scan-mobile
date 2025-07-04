class Events {
  int? eventId;
  String? eventImage;
  String? eventName;
  String? eventLieu;
  String? eventDate;
  String? eventTime;
  List<String>? portes;
  int? totalTickets;
  int? ticketsScannes;

  Events(
      {this.eventId,
        this.eventImage,
        this.eventName,
        this.eventLieu,
        this.eventDate,
        this.eventTime,
        this.portes,
        this.totalTickets,
        this.ticketsScannes});

  Events.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    eventImage = json['event_image'];
    eventName = json['event_name'];
    eventLieu = json['event_lieu'];
    eventDate = json['event_date'];
    eventTime = json['event_time'];
    portes = json['portes'].cast<String>();
    totalTickets = json['total_tickets'];
    ticketsScannes = json['tickets_scannes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_id'] = this.eventId;
    data['event_image'] = this.eventImage;
    data['event_name'] = this.eventName;
    data['event_lieu'] = this.eventLieu;
    data['event_date'] = this.eventDate;
    data['event_time'] = this.eventTime;
    data['portes'] = this.portes;
    data['total_tickets'] = this.totalTickets;
    data['tickets_scannes'] = this.ticketsScannes;
    return data;
  }
}