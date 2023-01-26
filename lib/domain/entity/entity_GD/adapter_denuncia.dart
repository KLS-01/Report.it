import 'package:report_it/domain/entity/adapter.dart';
import 'package:report_it/domain/entity/entity_GA/tipo_ufficiale.dart';
import 'package:report_it/domain/entity/entity_GD/categoria_denuncia.dart';
import 'package:report_it/domain/entity/entity_GD/denuncia_entity.dart';
import 'package:report_it/domain/entity/entity_GD/stato_denuncia.dart';

class AdapterDenuncia implements Adapter {
  @override
  fromJson(Map<String, dynamic> json) {
    return Denuncia(
        id: json["ID"],
        idUtente: json["IDUtente"],
        nomeDenunciante: json["NomeDenunciante"],
        cognomeDenunciante: json["CognomeDenunciante"],
        indirizzoDenunciante: json["IndirizzoDenunciante"],
        capDenunciante: json["CapDenunciante"],
        provinciaDenunciante: json["ProvinciaDenunciante"],
        cellulareDenunciante: json["CellulareDenunciante"],
        emailDenunciante: json["EmailDenunciante"],
        tipoDocDenunciante: json["TipoDocDenunciante"],
        numeroDocDenunciante: json["NumeroDocDenunciante"],
        scadenzaDocDenunciante: json["ScadenzaDocDenunciante"],
        dataDenuncia: json["DataDenuncia"],
        categoriaDenuncia:
            CategoriaDenuncia.values.byName(json["CategoriaDenuncia"]),
        nomeVittima: json["NomeVittima"],
        denunciato: json["Denunciato"],
        alreadyFiled: json["AlreadyFiled"],
        consenso: json["Consenso"],
        descrizione: json["Descrizione"],
        statoDenuncia: StatoDenuncia.values.byName(json["Stato"]),
        nomeCaserma: json["NomeCaserma"],
        coordCaserma: json["CoordCaserma"],
        nomeUff: json["NomeUff"],
        cognomeUff: json["CognomeUff"],
        cognomeVittima: json["CognomeVittima"],
        idUff: json["IDUff"],
        tipoUff: json["TipoUff"] == null
            ? null
            : TipoUfficiale.values.byName(json["TipoUff"]),
        indirizzoCaserma: json["IndirizzoCaserma"],
        gradoUff: json["GradoUff"]);
  }

  @override
  fromMap(map) {
    return Denuncia(
        id: map["ID"],
        idUtente: map["IDUtente"],
        nomeDenunciante: map["NomeDenunciante"],
        cognomeDenunciante: map["CognomeDenunciante"],
        indirizzoDenunciante: map["IndirizzoDenunciante"],
        capDenunciante: map["CapDenunciante"],
        provinciaDenunciante: map["ProvinciaDenunciante"],
        cellulareDenunciante: map["CellulareDenunciante"],
        emailDenunciante: map["EmailDenunciante"],
        tipoDocDenunciante: map["TipoDocDenunciante"],
        numeroDocDenunciante: map["NumeroDocDenunciante"],
        scadenzaDocDenunciante: map["ScadenzaDocDenunciante"],
        dataDenuncia: map["DataDenuncia"],
        categoriaDenuncia: map["CategoriaDenuncia"],
        nomeVittima: map["NomeVittima"],
        denunciato: map["Denunciato"],
        alreadyFiled: map["AlreadyFiled"],
        consenso: map["Consenso"],
        descrizione: map["Descrizione"],
        statoDenuncia: map["Stato"],
        nomeCaserma: map["NomeCaserma"],
        coordCaserma: map["CoordCaserma"],
        nomeUff: map["NomeUff"],
        cognomeUff: map["CognomeUff"],
        cognomeVittima: map["CognomeVittima"],
        idUff: map["IDUff"],
        tipoUff: map["TipoUff"],
        indirizzoCaserma: map["IndirizzoiCaserma"],
        gradoUff: map["GradoUff"]);
  }

  @override
  toMap(dynamic denuncia) {
    denuncia = denuncia as Denuncia;
    return {
      "ID": denuncia.id,
      "IDUtente": denuncia.idUtente,
      "NomeDenunciante": denuncia.nomeDenunciante,
      "CognomeDenunciante": denuncia.cognomeDenunciante,
      "IndirizzoDenunciante": denuncia.indirizzoDenunciante,
      "CapDenunciante": denuncia.capDenunciante,
      "ProvinciaDenunciante": denuncia.provinciaDenunciante,
      "CellulareDenunciante": denuncia.cellulareDenunciante,
      "EmailDenunciante": denuncia.emailDenunciante,
      "TipoDocDenunciante": denuncia.tipoDocDenunciante,
      "NumeroDocDenunciante": denuncia.numeroDocDenunciante,
      "ScadenzaDocDenunciante": denuncia.scadenzaDocDenunciante,
      "DataDenuncia": denuncia.dataDenuncia,
      "CategoriaDenuncia": denuncia.categoriaDenuncia.name,
      "NomeVittima": denuncia.nomeVittima,
      "Denunciato": denuncia.denunciato,
      "AlreadyFiled": denuncia.alreadyFiled,
      "Consenso": denuncia.consenso,
      "Descrizione": denuncia.descrizione,
      "Stato": denuncia.statoDenuncia.name,
      "NomeCaserma": denuncia.nomeCaserma,
      "IndirizzoCaserma": denuncia.indirizzoCaserma,
      "CoordCaserma": denuncia.coordCaserma,
      "NomeUff": denuncia.nomeUff,
      "CognomeUff": denuncia.cognomeUff,
      "CognomeVittima": denuncia.cognomeVittima,
      "IDUff": denuncia.idUff,
      "TipoUff": denuncia.tipoUff,
      "GradoUff": denuncia.gradoUff
    };
  }
}
