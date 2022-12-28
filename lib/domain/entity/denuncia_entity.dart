class Denuncia {
  String? id,
      nomeDenunciante,
      cognomeDenunciante,
      indirizzoDenunciante,
      capDenunciante,
      provinciaDenunciante,
      cellulareDenunciante,
      emailDenunciante,
      tipoDocDenunciante,
      nomeVittima,
      cognomeVittima,
      denunciato,
      descrizione,
      nomeCaserma,
      coordCaserma,
      nomeUff,
      cognomeUff;

  DateTime? scadenzaDocDenunciante, dataDenuncia;
  bool consenso = false, alreadyFiled = false;

  String? get getId => id;
  set setId(String? id) => this.id = id;

  get getNomeDenunciante => nomeDenunciante;
  set setNomeDenunciante(nomeDenunciante) =>
      this.nomeDenunciante = nomeDenunciante;

  get getCognomeDenunciante => cognomeDenunciante;
  set setCognomeDenunciante(cognomeDenunciante) =>
      cognomeDenunciante = cognomeDenunciante;

  get getIndirizzoDenunciante => indirizzoDenunciante;
  set setIndirizzoDenunciante(indirizzoDenunciante) =>
      this.indirizzoDenunciante = indirizzoDenunciante;

  get getCapDenunciante => capDenunciante;
  set setCapDenunciante(capDenunciante) => this.capDenunciante = capDenunciante;

  get getProvinciaDenunciante => provinciaDenunciante;
  set setProvinciaDenunciante(provinciaDenunciante) =>
      this.provinciaDenunciante = provinciaDenunciante;

  get getCellulareDenunciante => cellulareDenunciante;
  set setCellulareDenunciante(cellulareDenunciante) =>
      this.cellulareDenunciante = cellulareDenunciante;

  get getEmailDenunciante => emailDenunciante;
  set setEmailDenunciante(emailDenunciante) =>
      this.emailDenunciante = emailDenunciante;

  get getTipoDocDenunciante => tipoDocDenunciante;
  set setTipoDocDenunciante(tipoDocDenunciante) =>
      this.tipoDocDenunciante = tipoDocDenunciante;

  get getNomeVittima => nomeVittima;
  set setNomeVittima(nomeVittima) => this.nomeVittima = nomeVittima;

  get getCognomeVittima => cognomeVittima;
  set setCognomeVittima(cognomeVittima) => this.cognomeVittima = cognomeVittima;

  get getDenunciato => denunciato;
  set setDenunciato(denunciato) => this.denunciato = denunciato;

  get getDescrizione => descrizione;
  set setDescrizione(descrizione) => this.descrizione = descrizione;

  get getNomeCaserma => nomeCaserma;
  set setNomeCaserma(nomeCaserma) => this.nomeCaserma = nomeCaserma;

  get getCoordCaserma => coordCaserma;
  set setCoordCaserma(coordCaserma) => this.coordCaserma = coordCaserma;

  get getNomeUff => nomeUff;
  set setNomeUff(nomeUff) => this.nomeUff = nomeUff;

  get getCognomeUff => cognomeUff;
  set setCognomeUff(cognomeUff) => this.cognomeUff = cognomeUff;

  get getDataDenuncia => dataDenuncia;
  set setDataDenuncia(dataDenuncia) => this.dataDenuncia = dataDenuncia;

  get getAlreadyFiled => alreadyFiled;
  set setAlreadyFiled(alreadyFiled) => this.alreadyFiled = alreadyFiled;
}
