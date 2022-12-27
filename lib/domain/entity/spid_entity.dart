class SPID {
  String cf;
  String nome;
  String luogoNascita;
  DateTime dataNascita;
  String sesso;
  String tipoDocumento;
  String numeroDocumento;
  String domicilioFisico;
  String provinciaNascita;
  DateTime dataScadenzaDocumento;
  String numCellulare;
  String indirizzoEmail;
  String password;
  get getCf => this.cf;

  set setCf(cf) => this.cf = cf;

  get getNome => this.nome;

  set setNome(nome) => this.nome = nome;

  get getLuogoNascita => this.luogoNascita;

  set setLuogoNascita(luogoNascita) => this.luogoNascita = luogoNascita;

  get getDataNascita => this.dataNascita;

  set setDataNascita(dataNascita) => this.dataNascita = dataNascita;

  get getSesso => this.sesso;

  set setSesso(sesso) => this.sesso = sesso;

  get getTipoDocumento => this.tipoDocumento;

  set setTipoDocumento(tipoDocumento) => this.tipoDocumento = tipoDocumento;

  get getNumeroDocumento => this.numeroDocumento;

  set setNumeroDocumento(numeroDocumento) =>
      this.numeroDocumento = numeroDocumento;

  get getDomicilioFisico => this.domicilioFisico;

  set setDomicilioFisico(domicilioFisico) =>
      this.domicilioFisico = domicilioFisico;

  get getProvinciaNascita => this.provinciaNascita;

  set setProvinciaNascita(provinciaNascita) =>
      this.provinciaNascita = provinciaNascita;

  get getDataScadenzaDocumento => this.dataScadenzaDocumento;

  set setDataScadenzaDocumento(dataScadenzaDocumento) =>
      this.dataScadenzaDocumento = dataScadenzaDocumento;

  get getNumCellulare => this.numCellulare;

  set setNumCellulare(numCellulare) => this.numCellulare = numCellulare;

  get getIndirizzoEmail => this.indirizzoEmail;

  set setIndirizzoEmail(indirizzoEmail) => this.indirizzoEmail = indirizzoEmail;

  get getPassword => this.password;

  set setPassword(password) => this.password = password;

  SPID(
    this.cf,
    this.nome,
    this.luogoNascita,
    this.dataNascita,
    this.sesso,
    this.tipoDocumento,
    this.numeroDocumento,
    this.domicilioFisico,
    this.provinciaNascita,
    this.dataScadenzaDocumento,
    this.numCellulare,
    this.indirizzoEmail,
    this.password,
  );
}
