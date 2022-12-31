class OperatoreCUP {
  String id;
  String password;
  String email;
  String asl;

  get getId => this.id;

  set setId(id) => this.id = id;

  get getPassword => this.password;

  set setPassword(password) => this.password = password;

  get getEmail => this.email;

  set setEmail(email) => this.email = email;

  get getAsl => this.asl;

  set setAsl(asl) => this.asl = asl;

  OperatoreCUP(this.id, this.password, this.email, this.asl);

  factory OperatoreCUP.fromJson(Map<String, dynamic> json) {
    return OperatoreCUP(
      json["ID"],
      json["Password"],
      json["Email"],
      json["ASL"],
    );
  }

  factory OperatoreCUP.fromMap(map) {
    return OperatoreCUP(
      map["ID"],
      map["Password"],
      map["Email"],
      map["ASL"],
    );
  }

  Map<String?, dynamic> toMap() {
    return {
      "ID": id,
      "Password": password,
      "Email": email,
      "ASL": asl,
    };
  }
}
