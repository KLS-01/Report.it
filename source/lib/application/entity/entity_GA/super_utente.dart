import 'package:report_it/application/entity/entity_GA/tipo_utente.dart';

class SuperUtente {
  String id;
  TipoUtente tipo;
  String? cap;
  String? provincia;
  String? indirizzo;
  String? citta;

  SuperUtente(this.id, this.tipo,
      {this.cap, this.provincia, this.indirizzo, this.citta});
}
