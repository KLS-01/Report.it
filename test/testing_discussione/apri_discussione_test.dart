// ignore_for_file: sdk_version_async_exported_from_core
// ignore_for_file: unawaited_futures
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:report_it/data/models/forum_dao.dart';
import 'package:report_it/domain/entity/entity_GF/discussione_entity.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

import 'apri_discussione_test.mocks.dart';

/*
@GenerateMocks([
  ForumDao
], customMocks: [
  MockSpec<ForumDao>(as: #MockForumDaoRelaxed),
])
*/
void main() {
  late ForumDao dao;
  late MockUser user;
  late MockFirebaseAuth auth;

  setUp(() {
    // Create mock object.
    dao = MockForumDao();
    user = MockUser(
      isAnonymous: false,
      uid: 'someuid',
      email: 'bob@somedomain.com',
      displayName: 'Bob',
    );
    auth = MockFirebaseAuth(mockUser: user, signedIn: true);
  });

  funzioneTest(String titolo, String testo, [FilePickerResult? file]) {
    if (titolo.length > 80 || titolo.isEmpty) {
      return "lunghezza titolo non rispettata";
    }

    if (testo.length > 400) {
      return "lunghezza corpo non rispettata";
    }

    var tipo = "Utente";
    final User? user = auth.currentUser;

    if (file != null) {
      if (file.files.first.size > 10485760) {
        return "file troppo grande";
      }

      if (file.files.first.extension != "png" &&
          file.files.first.extension != "jpeg") {
        return "estensione del file non supportata (caricare un file in formato png o jpg)";
      }

      when(dao.caricaImmagne(file)).thenAnswer((realInvocation) => Future((() {
            return "http://roba.com";
          })));
      var c = dao.caricaImmagne(file);

      Discussione d = Discussione(
          DateTime.now(), user!.uid, 0, testo, titolo, "Aperta", [], tipo);

      when(dao.AggiungiDiscussione(d))
          .thenAnswer((realInvocation) => Future((() {
                return "aggiunto";
              })));

      c.then((value) {
        d.setpathImmagine(value);
      });
      dao.AggiungiDiscussione(d);
      return "Corretto";
    } else {
      Discussione d = Discussione(
          DateTime.now(),
          user!.uid,
          0,
          testo,
          titolo,
          "Aperta",
          pathImmagine: "",
          [],
          tipo);

      when(dao.AggiungiDiscussione(d))
          .thenAnswer((realInvocation) => Future((() {
                return "aggiunto";
              })));
      dao.AggiungiDiscussione(d);
      return "Corretto";
    }
  }

  group("apri discussione", () {
    test("TC_GF.2_1", (() {
      var titolo =
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean fermentum mi a nibh rutrum, sed scelerisque enim efficitur. Fusce accumsan id mi quis hendrerit. Vivamus ut tincidunt orci. Sed nunc neque, faucibus vel feugiat eu, " +
              "fermentum ornare metus. Etiam volutpat sed lacus eu efficitur. Sed tincidunt mauris id cursus rutrum. Praesent pellentesque ultrices lectus, vel porta felis eleifend sed. Etiam ac molestie eros. ";
      var testo =
          "Salve, vorrei parlare delle discriminazioni riguardanti l’identità di genere. ";
      List<PlatformFile> files = List.empty(growable: true);
      files.add(PlatformFile(name: "IMG.png", size: 5242880));
      var file = FilePickerResult(files);

      assert(funzioneTest(titolo, testo, file) ==
          "lunghezza titolo non rispettata");
    }));

    test("TC_GF.2_2", (() {
      var titolo =
          "Discriminazioni di genere nella scelta del cast di un film.";
      var testo =
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean fermentum mi a nibh rutrum, sed scelerisque enim efficitur. Fusce accumsan id mi quis hendrerit. Vivamus ut tincidunt orci. Sed nunc neque, faucibus vel feugiat eu, fermentum ornare metus. Etiam volutpat sed lacus eu efficitur. Sed tincidunt mauris id cursus rutrum. Praesent pellentesque ultrices lectus, vel porta felis eleifend sed. Etiam ac molestie eros. Curabitur ac faucibus diam. Maecenas vitae metus hendrerit, rhoncus ex quis, condimentum lorem. Integer ornare imperdiet metus vitae pellentesque. Praesent pretium diam eget tristique tincidunt. Quisque justo turpis, finibus a fringilla non, condimentum non enim. Proin eget eros nec lacus luctus malesuada. Donec sit amet mattis ante. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.  Cras ut quam tincidunt, lacinia nulla id, tempor justo. Phasellus suscipit facilisis metus, at suscipit tortor pharetra auctor. Ut et vestibulum erat. Nunc eget luctus diam, et ornare dui. Nulla facilisi. Aliquam erat volutpat. Curabitur varius, sem non aliquam mattis, mauris tellus tempus erat, at pretium nisl enim eu velit. Nullam condimentum libero at dictum commodo. Duis sit amet quam mollis, condimentum nulla a, ultricies lacus.Vestibulum pharetra enim ipsum, et consectetur arcu dapibus in. Suspendisse rhoncus ullamcorper quam, eget facilisis dolor rutrum in. Sed et blandit dui. Fusce ut accumsan nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Fusce ut lacus vel sapien suscipit accumsan. Fusce gravida ultrices egestas. Ut non nisl vel massa condimentum ultricies vitae sed ligula. Suspendisse a ante dapibus dui bibendum suscipit ut sit amet tellus. Maecenas eget consectetur mi, vel molestie odio.Fusce commodo turpis ut aliquet congue. Vestibulum lobortis lacus odio. Donec volutpat non leo id euismod. Curabitur efficitur molestie orci. Suspendisse sed enim vitae sem tincidunt hendrerit et ac nulla. Suspendisse lobortis odio vitae bibendum lacinia. Curabitur tincidunt, nibh ac interdum pharetra, dui ex volutpat nulla, sed sagittis diam libero sed nulla. Morbi tempor aliquet augue. Donec malesuada augue eu venenatis vehicula. Cras in purus nisi. Quisque eu est elit. Donec faucibus tortor in pretium malesuada. Quisque iaculis neque a dapibus ullamcorper. Nam ac vulputate sapien. Aenean sagittis, diam et posuere egestas.";
      List<PlatformFile> files = List.empty(growable: true);
      files.add(PlatformFile(name: "IMG.png", size: 5242880));
      var file = FilePickerResult(files);

      assert(funzioneTest(titolo, testo, file) ==
          "lunghezza corpo non rispettata");
    }));

    test("TC_GF.2_3", (() {
      var titolo =
          "Discriminazioni di genere nella scelta del cast di un film.";
      var testo =
          "Salve a tutti, recentemente sono andato a vedere un film della Marvel al cinema e ho notato che la maggioranza del cast erano uomini e le poche donne presenti erano semplicemente delle sagome, senza spessore, buone solo per il loro aspetto, più che per il loro ruolo nel film. Io ritengo che questo sia un enorme problema che non viene presentato abbastanza frequentemente, voi che ne pensate?  ";
      List<PlatformFile> files = List.empty(growable: true);
      files.add(PlatformFile(name: "IMG.png", size: 52428800));
      var file = FilePickerResult(files);

      assert(funzioneTest(titolo, testo, file) == "file troppo grande");
    }));

    test("TC_GF.2_4", (() {
      var titolo =
          "Discriminazioni di genere nella scelta del cast di un film.";
      var testo =
          "Salve a tutti, recentemente sono andato a vedere un film della Marvel al cinema e ho notato che la maggioranza del cast erano uomini e le poche donne presenti erano semplicemente delle sagome, senza spessore, buone solo per il loro aspetto, più che per il loro ruolo nel film. Io ritengo che questo sia un enorme problema che non viene presentato abbastanza frequentemente, voi che ne pensate?  ";
      List<PlatformFile> files = List.empty(growable: true);
      files.add(PlatformFile(name: "IMG.xml", size: 5242880));
      var file = FilePickerResult(files);

      assert(funzioneTest(titolo, testo, file) ==
          "estensione del file non supportata (caricare un file in formato png o jpg)");
    }));

    test("TC_GF.2_5", (() {
      var titolo =
          "Discriminazioni di genere nella scelta del cast di un film.";
      var testo =
          "Salve a tutti, recentemente sono andato a vedere un film della Marvel al cinema e ho notato che la maggioranza del cast erano uomini e le poche donne presenti erano semplicemente delle sagome, senza spessore, buone solo per il loro aspetto, più che per il loro ruolo nel film. Io ritengo che questo sia un enorme problema che non viene presentato abbastanza frequentemente, voi che ne pensate?  ";
      List<PlatformFile> files = List.empty(growable: true);
      files.add(PlatformFile(name: "IMG.png", size: 5242880));
      var file = FilePickerResult(files);

      assert(funzioneTest(titolo, testo, file) == "Corretto");
    }));
  });
}
