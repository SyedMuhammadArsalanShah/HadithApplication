import 'dart:convert';
import 'package:hadithscollectionapp/Hadiths.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HadithChapters extends StatefulWidget {
  var bookSlug;
  HadithChapters(this.bookSlug, {super.key});

  @override
  State<HadithChapters> createState() => _HadithChaptersState();
}

class _HadithChaptersState extends State<HadithChapters> {
  late String rawdata = "";
  late Map rawdatamap = {};
  late List<dynamic> datalist = [];
  void getChaptersofHadith() async {
    var slug=widget.bookSlug;
    var response = await http.get(Uri.parse(
        "https://hadithapi.com/api/$slug/chapters?apiKey=\$2y\$10\$BylaBcXs5Lw7ZOtYmQ3PXO1x15zpp26oc1FeGktdmF6YeYoRd88e"));
    // print("SMASB =>" + response.body.toString());

    if (response.statusCode == 200) {
      setState(() {
        // rawdata = response.body.toString();

        rawdatamap = jsonDecode(response.body.toString());

        datalist = rawdatamap["chapters"];
      });
    }
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getChaptersofHadith();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Chapters of Hadiths "),
          centerTitle: true,
        ),
        body: ListView.builder(
            itemBuilder: (context, index) {
              if (datalist[index] == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Card(
                  child: ListTile(
                    onTap: () {
                      var chapterNumber = datalist[index]["chapterNumber"];
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Hadiths(chapterNumber),
                          ));
                    },
                    tileColor: Colors.indigo[900],
                    textColor: Colors.white,
                    title: Text(
                      datalist[index]["chapterArabic"].toString(),
                         style: TextStyle(fontFamily: "alq")
                    ),
                    leading: Text("${index + 1}"),
                    subtitle: Text(datalist[index]["chapterEnglish"].toString()),
                    trailing: Text(
                       datalist[index]["chapterUrdu"].toString(),
                    
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                );
              }
            },
            itemCount: datalist.length));
  }
}
