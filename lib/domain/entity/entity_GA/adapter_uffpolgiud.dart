import 'package:report_it/domain/entity/adapter.dart';
import 'package:report_it/domain/entity/entity_GA/tipo_ufficiale.dart';
import 'package:report_it/domain/entity/entity_GA/uffPolGiud_entity.dart';

class AdapterUffPolGiud implements Adapter {
  @override
  fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return UffPolGiud(json["ID"], json["Nome"], json["Cognome"], json["Grado"],
        TipoUfficiale.values.firstWhere(
      (element) {
        // ignore: prefer_interpolation_to_compose_strings
        return element.toString() == "TipoUfficiale." + json["TipoUfficiale"];
      },
    ),
        json["Email"],
        json["Password"],
        json["NomeCaserma"],
        json["CoordCaserma"],
        json["CapCaserma"],
        json["CittaCaserma"],
        json["IndirizzoCaserma"],
        json["ProvinciaCaserma"]);
  }

  @override
  fromMap(map) {
    // TODO: implement fromMap
    return UffPolGiud(
      map["ID"],
      map["Nome"],
      map["Cognome"],
      map["Grado"],
      TipoUfficiale.values.firstWhere((element) =>
          // ignore: prefer_interpolation_to_compose_strings
          element.toString() == "TipoUfficiale" + map["TipoUfficiale"]),
      map["Email"],
      map["Password"],
      map["NomeCaserma"],
      map["CoordCaserma"],
      map["CapCaserma"],
      map["CittaCaserma"],
      map["IndirizzoCaserma"],
      map["ProvinciaCaserma"],
    );
  }

  @override
  toMap(dynamic uff) {
    // TODO: implement toMap
    return {
      "ID": uff.id,
      "Nome": uff.nome,
      "Cognome": uff.cognome,
      "Grado": uff.grado,
      "TipoUfficiale": uff.tipoUff.toString(),
      "Email": uff.email,
      "Password": uff.password,
      "NomeCaserma": uff.nomeCaserma,
      "CoordCaserma": uff.coordinate,
      "CapCaserma": uff.capCaserma,
      "CittaCaserma": uff.cittaCaserma,
      "IndirizzoCaserma": uff.indirizzoCaserma,
      "ProvinciaCaserma": uff.provinciaCaserma,
    };
  }
}
