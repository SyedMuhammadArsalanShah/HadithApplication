import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class Hadiths extends StatefulWidget {
  var slug;
  var number;
  Hadiths(this.slug, this.number, {super.key});

  @override
  State<Hadiths> createState() => _HadithsState();
}

class _HadithsState extends State<Hadiths> {
  late Map rawdatamap = {};
  late List datalist = [];
  void getapi() async {
    var bookslug = widget.slug;
    var number = widget.number;
    var apiKey =
        "\$2y\$10\$BylaBcXs5Lw7ZOtYmQ3PXO1x15zpp26oc1FeGktdmF6YeYoRd88e";
    var res = await http.get(Uri.parse(
        "https://hadithapi.com/public/api/hadiths?apiKey=$apiKey&book=$bookslug&chapter=$number&paginate=100000"));

    // print("SMASB" + res.body);

    if (res.statusCode == 200) {
      setState(() {
        rawdatamap = jsonDecode(res.body);

        datalist = rawdatamap["hadiths"]["data"];
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getapi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hadith Books Collection",
          style: TextStyle(color:Color(0XFFF2F2F2),),
        ),
        centerTitle: true,
        backgroundColor: Color(0XFF595959),
      ),
      body: datalist.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  color: Color(0XFFD9D9D9),
                  child: Column(
                    children: [
                      ListTile(
                          title: Text("Hadith Number #" +
                              datalist[index]["hadithNumber"].toString()),
                          trailing: Text("Status :" +
                              datalist[index]["status"].toString())),
                      Card(
                         color: Color(0XFFF2F2F2),
                        child: Container(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              datalist[index]["hadithArabic"].toString(),
                              style: const TextStyle(
                                fontFamily: "alq",
                                fontSize: 20,
                                color: Color.fromARGB(255, 0, 77, 64)
                              ),
                              textAlign: TextAlign.justify,
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                        ),
                      ),
                      Card(
                         color: Color(0XFFF2F2F2),
                        child: Container(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              datalist[index]["hadithUrdu"].toString(),
                              style: const TextStyle(
                                fontFamily: "jameel",
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.justify,
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                        ),
                      ),
                      Card(
                         color: Color(0XFFF2F2F2),
                        child: Container(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              datalist[index]["hadithEnglish"].toString(),
                              style: const TextStyle(
                                fontFamily: "alq",
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.justify,
                              textDirection: TextDirection.ltr,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: datalist.length,
            ),
    );
    
  }
}
