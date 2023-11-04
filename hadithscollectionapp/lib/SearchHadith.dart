import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';

class SearchHadith extends StatefulWidget {
  const SearchHadith({super.key});

  @override
  State<SearchHadith> createState() => _SearchHadithState();
}

class _SearchHadithState extends State<SearchHadith> {
  late Map rawdatamap = {};
  late List datalist = [];
  late String searchInput = "";
  late String selectlang = "";
  bool isLoading = false;

  void getapi(String value) async {
    setState(() {
      isLoading = true;
    });

    var apiKey =
        "\$2y\$10\$BylaBcXs5Lw7ZOtYmQ3PXO1x15zpp26oc1FeGktdmF6YeYoRd88e";

    var hadithApiBase =
        "https://hadithapi.com/public/api/hadiths?apiKey=$apiKey&paginate=100000";

    String queryParam = '';

    if (value == 'Arabic') {
      queryParam = 'hadithArabic';
    } else if (value == 'Urdu') {
      queryParam = 'hadithUrdu';
    } else if (value == 'English') {
      queryParam = 'hadithEnglish';
    } else if (value == 'Hadith No') {
      queryParam = 'hadithNumber';
    } else {
      print("Please select a search type first.");
      return;
    }

    var res =
        await http.get(Uri.parse("$hadithApiBase&$queryParam=$searchInput"));
    if (res.statusCode == 200) {
      setState(() {
        rawdatamap = jsonDecode(res.body);
        datalist = rawdatamap["hadiths"]["data"];
        isLoading = false;
      });
    }
    // print("SMASB" + res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search In All Hadith Books ",
          style: TextStyle(
            color: Color(0XFFF2F2F2),
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0XFF595959),
      ),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "سرچ کے لیے مندرجہ ذیل آپشن کو پہلے  منتخب کیجیے",
                style: const TextStyle(
                  fontFamily: "jameel",
                  fontSize: 20,
                ),
                textAlign: TextAlign.justify,
                textDirection: TextDirection.rtl,
              )),
          CustomRadioButton(
            absoluteZeroSpacing: true,
            elevation: 0,
            unSelectedBorderColor: Color(0XFFD9D9D9),
            enableShape: true,
            selectedBorderColor: Color(0XFF0D0D0D),
            selectedColor: Color(0XFF0D0D0D),
            unSelectedColor: Color(0XFFD9D9D9),
            buttonLables: ['Arabic', 'Urdu', 'English', 'Hadith No'],
            buttonValues: ['Arabic', 'Urdu', 'English', 'Hadith No'],
            buttonTextStyle: const ButtonTextStyle(
                selectedColor: Colors.white,
                unSelectedColor: Colors.black,
                textStyle: TextStyle(fontSize: 16)),
            radioButtonValue: (value) {
              setState(() {
                selectlang = value;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: selectlang == 'Urdu' || selectlang == 'Arabic'
                  ? InputDecoration(
                      hintText: " ..... تلاش کریں ",
                      suffixIcon: Icon(Icons.search_rounded))
                  : InputDecoration(
                      hintText: "Search Here.....  ",
                      prefixIcon: Icon(Icons.search_rounded)),
              onChanged: (value) {
                searchInput = value;
                print("search value smas=>" + searchInput);
              },
              style: selectlang == 'Urdu' || selectlang == 'Arabic'
                  ? TextStyle(fontFamily: "jameel")
                  : TextStyle(fontFamily: "alq"),
              textAlign: selectlang == 'Urdu' || selectlang == 'Arabic'
                  ? TextAlign.right
                  : TextAlign.left,
              textDirection: selectlang == 'Urdu' || selectlang == 'Arabic'
                  ? TextDirection.rtl
                  : TextDirection.ltr,
            ),
          ),
          ElevatedButton(
              onPressed: () {
                getapi(selectlang);
              },
              child: Text("Search")),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemBuilder: (context, index) {
                      String hadithdata = '';

                      if (selectlang == 'Arabic') {
                        hadithdata = 'hadithArabic';
                      } else if (selectlang == 'Urdu') {
                        hadithdata = 'hadithUrdu';
                      } else if (selectlang == 'English') {
                        hadithdata = 'hadithEnglish';
                      } else {
                        print("Please select a search type first.");
                      }

                      String searchResult =
                          datalist[index][hadithdata].toString();
                      print("below smas" + hadithdata);
                      String searchTerm = searchInput;
                      int startIndex = searchResult.indexOf(searchTerm);

                      if (startIndex != -1) {
                        String first20Words = searchResult.substring(startIndex,
                            min(startIndex + 50, searchResult.length));

                        return Card(
                          color: Color(0XFFD9D9D9),
                          child: Column(
                            children: [
                              ListTile(
                                  title: Text("Hadith Number #" +
                                      datalist[index]["hadithNumber"]
                                          .toString()),
                                  trailing: Text("Status :" +
                                      datalist[index]["status"].toString())),
                              Card(
                                color: Color(0XFFF2F2F2),
                                child: Container(
                                  width: double.infinity,
                                  child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        first20Words.toString(),
                                        style: selectlang == 'Urdu' ||
                                                selectlang == 'Arabic'
                                            ? TextStyle(fontFamily: "jameel")
                                            : TextStyle(fontFamily: "alq"),
                                        textAlign: selectlang == 'Urdu' ||
                                                selectlang == 'Arabic'
                                            ? TextAlign.right
                                            : TextAlign.left,
                                        textDirection: selectlang == 'Urdu' ||
                                                selectlang == 'Arabic'
                                            ? TextDirection.rtl
                                            : TextDirection.ltr,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    itemCount: datalist.length,
                  ),
          ),
        ],
      ),
    );
  }
}
