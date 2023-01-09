import 'package:flutter/material.dart';
import 'package:report_it/presentation/widget/theme.dart';
import 'package:report_it/presentation/widget/widget_info.dart';

class ForumForm extends StatefulWidget {
  const ForumForm({super.key});

  @override
  State<ForumForm> createState() => _ForumFormState();
}

class _ForumFormState extends State<ForumForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController categoriaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme().build()!.backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(219, 29, 69, 1),
        ),
        title: const Text(
          "Apri una discussione",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        elevation: 3,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 10,
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * 0.04, 0, 0, 0),
                    child: Text(
                      "Titolo",
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Inserisci un titolo",
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20)),
                        contentPadding: EdgeInsets.all(20.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * 0.04, 0, 0, 0),
                    child: Text(
                      "Testo della discussione",
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Scrivi il testo della tua discussione...",
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20)),
                        contentPadding: EdgeInsets.all(20.0),
                      ),
                      maxLines: 10,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * 0.04, 0, 0, 0),
                    child: Text(
                      "Categoria",
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Inserisci la categoria del tuo post",
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20)),
                        contentPadding: EdgeInsets.all(20.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Pubblica'),
        heroTag: null,
        onPressed: () {
          //
        },
        backgroundColor: const Color.fromRGBO(219, 29, 69, 1),
      ),
    );
  }
}
