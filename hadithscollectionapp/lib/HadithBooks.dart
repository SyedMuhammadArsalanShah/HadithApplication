import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hadithscollectionapp/HadithChapters.dart';
import 'package:http/http.dart' as http;

class HadithBooks extends StatefulWidget {
  const HadithBooks({super.key});

  @override
  State<HadithBooks> createState() => _HadithBooksState();
}

class _HadithBooksState extends State<HadithBooks> {
  late String rawdata = "";
  late Map rawdatamap = {};
  late List<dynamic> datalist = [];
  void getBooksofHadith() async {
    var response = await http.get(Uri.parse(
        "https://hadithapi.com/api/books?apiKey=\$2y\$10\$BylaBcXs5Lw7ZOtYmQ3PXO1x15zpp26oc1FeGktdmF6YeYoRd88e"));
    // print("SMASB =>" + response.body.toString());

    if (response.statusCode == 200) {
      setState(() {
        // rawdata = response.body.toString();

        rawdatamap = jsonDecode(response.body.toString());

        datalist = rawdatamap["books"];
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBooksofHadith();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Books of Hadiths "),
          centerTitle: true,
        ),
        body: ListView.builder(
            itemBuilder: (context, index) {
              if (datalist[index] == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListTile(
                  onTap: () {
                    var slugname = datalist[index]["bookSlug"];
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HadithChapters(slugname),
                        ));
                  },
                  tileColor: Colors.indigo[900],
                  textColor: Colors.white,
                  title: Text(
                    datalist[index]["bookName"].toString(),
                  ),
                  leading: Text("${index + 1}"),
                  subtitle: Text(datalist[index]["writerName"].toString()),
                  trailing: Column(
                    children: [
                      datalist[index]["hadiths_count"] == "0"
                          ? Text("")
                          : Text("Ahadiths :" +
                              datalist[index]["hadiths_count"].toString()),
                      Text(
                        "Chapters :" +
                            datalist[index]["chapters_count"].toString(),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                );
              }
            },
            itemCount: datalist.length));
  }
}














