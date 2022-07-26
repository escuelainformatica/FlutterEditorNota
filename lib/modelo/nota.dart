class Nota {
  int? idNote;
  String? title;
  String? description;

  Nota({this.idNote=0, this.title, this.description});

  Nota.fromJson(Map<String, dynamic> json) {
    idNote = json['IdNote'];
    title = json['Title'];
    description = json['Description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IdNote'] = this.idNote;
    data['Title'] = this.title;
    data['Description'] = this.description;
    return data;
  }
}