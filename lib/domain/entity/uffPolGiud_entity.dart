import 'package:report_it/domain/entity/tipo_ufficiale.dart';

class UffPolGiud {
  int id;
  String nome;
  String cognome;
  String grado;
  TipoUfficiale tipoUff;
  String email;
  String password;
  String nomeCaserma;
  String coordinate;

  get getId => this.id;

  set setId(id) => this.id = id;

  get getNome => this.nome;

  set setNome(nome) => this.nome = nome;

  get getCognome => this.cognome;

  set setCognome(cognome) => this.cognome = cognome;

  get getGrado => this.grado;

  set setGrado(grado) => this.grado = grado;

  get getTipoUff => this.tipoUff;

  set setTipoUff(tipoUff) => this.tipoUff = tipoUff;

  get getEmail => this.email;

  set setEmail(email) => this.email = email;

  get getPassword => this.password;

  set setPassword(password) => this.password = password;

  get getNomeCaserma => this.nomeCaserma;

  set setNomeCaserma(nomeCaserma) => this.nomeCaserma = nomeCaserma;

  get getCoordinate => this.coordinate;

  set setCoordinate(coordinate) => this.coordinate = coordinate;

  UffPolGiud(this.id, this.nome, this.cognome, this.grado, this.tipoUff,
      this.email, this.password, this.nomeCaserma, this.coordinate);
}
