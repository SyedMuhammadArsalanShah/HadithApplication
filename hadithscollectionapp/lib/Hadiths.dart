import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Hadiths extends StatefulWidget {
  var chapterNumber;
  Hadiths(chapterNumber, {super.key});

  @override
  State<Hadiths> createState() => _HadithsState();
}

class _HadithsState extends State<Hadiths> {
  late String rawdata = "";
  late Map rawdatamap = {};
  late List<dynamic> datalist = [];
  late List<dynamic> datalist1 = [];
  void getHadiths() async {
    var response = await http.get(Uri.parse(
        "https://hadithapi.com/public/api/hadiths?apiKey=\$2y\$10\$BylaBcXs5Lw7ZOtYmQ3PXO1x15zpp26oc1FeGktdmF6YeYoRd88e"));

    if (response.statusCode == 200) {
      setState(() {
        // rawdata = response.body.toString();

        rawdatamap = jsonDecode(response.body.toString());

        datalist = rawdatamap["hadiths"]["data"];

        print("SMASB MAP =>" + datalist.toString());
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHadiths();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          if (datalist[index] == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Card(
                    color: Colors.indigo,
                    child: ListTile(
                    
                        title: Text(datalist[index]["headingArabic"].toString(),
                            style: TextStyle(fontFamily: "alq"),
                            textDirection: TextDirection.rtl)),
                  ),
                  Card(
                      child: Text(datalist[index]["hadithArabic"].toString(),
                          style: TextStyle(fontFamily: "alq"),
                          textDirection: TextDirection.rtl)),
                  Card(
                    child: Text(
                      datalist[index]["hadithUrdu"].toString(),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                  Card(
                    child: Text(
                      datalist[index]["hadithEnglish"].toString(),
                    ),
                  ),
                ],
              ),
            );
          }
        },
        itemCount: datalist.length,
      ),
    );
  }
}
