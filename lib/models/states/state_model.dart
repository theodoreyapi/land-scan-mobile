class States {
  int? totalEvenements;
  int? totalTickets;
  int? ticketsScannes;

  States({this.totalEvenements, this.totalTickets, this.ticketsScannes});

  States.fromJson(Map<String, dynamic> json) {
    totalEvenements = json['total_evenements'];
    totalTickets = json['total_tickets'];
    ticketsScannes = json['tickets_scannes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_evenements'] = totalEvenements;
    data['total_tickets'] = totalTickets;
    data['tickets_scannes'] = ticketsScannes;
    return data;
  }
}
