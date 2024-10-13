class Company {
  final String? id;
  final String? name;

  Company({this.id, this.name});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['iProductCompanyID'],
      name: json['sCompanyName'],
    );
  }
}

class Groups {
  final String? id;
  final String? name;

  Groups({this.id, this.name});
  factory Groups.fromJson(Map<String, dynamic> json) {
    return Groups(
      id: json['iProductGroupID'],
      name: json['sGroupName'],
    );
  }
}

class Prouducts {
  final String? id;
  final String? name;

  Prouducts({this.id, this.name});

  factory Prouducts.fromJson(Map<String, dynamic> json) {
    return Prouducts(
      id: json['proId'],
      name: json['proName'],
    );
  }
}

class Stores {
  final String? id;
  final String? name;

  Stores({this.id, this.name});

  factory Stores.fromJson(Map<String, dynamic> json) {
    return Stores(
      id: json['pid'],
      name: json['storename'],
    );
  }
}
