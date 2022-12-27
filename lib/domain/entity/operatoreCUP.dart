class OperatoreCUP {
  int id;
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
}
