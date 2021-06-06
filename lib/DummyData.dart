class DataCollection {
  DummyDetails dummyDetails;

  DataCollection({this.dummyDetails});

  DataCollection.fromJson(Map<String, dynamic> json) {
    dummyDetails = json['Dummy Details'] != null
        ? new DummyDetails.fromJson(json['Dummy Details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dummyDetails != null) {
      data['Dummy Details'] = this.dummyDetails.toJson();
    }
    return data;
  }
}

class DummyDetails {
  List<DummyData> dummyData;

  DummyDetails({this.dummyData});

  DummyDetails.fromJson(Map<String, dynamic> json) {
    if (json['Dummy data'] != null) {
      dummyData = <DummyData>[];
      json['Dummy data'].forEach((v) {
        dummyData.add(new DummyData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dummyData != null) {
      data['Dummy data'] = this.dummyData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DummyData {
  String image;
  String title;
  String description;
  String date;
  String time;

  DummyData({this.image, this.title, this.description, this.date, this.time});

  DummyData.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
    description = json['description'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['title'] = this.title;
    data['description'] = this.description;
    data['date'] = this.date;
    data['time'] = this.time;
    return data;
  }
}
