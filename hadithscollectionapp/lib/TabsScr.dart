import 'package:flutter/material.dart';
import 'HadithBooks.dart';
import 'SearchHadith.dart';

class TabsScr extends StatefulWidget {
  const TabsScr({super.key});

  @override
  State<TabsScr> createState() => _TabsScrState();
}

class _TabsScrState extends State<TabsScr> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              " احادیث نبویﷺ",
              style: TextStyle(fontFamily: "alq",),
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.justify,
            ),
            centerTitle: true,
            bottom: TabBar(
              labelColor: Color(0XFF404040),
              unselectedLabelColor: Colors.grey,
              indicatorColor: Color(0XFF0D0D0D),
              tabs: [
                Tab(
                  text: "Hadith Books",
                ),
                Tab(
                  text: "Search Hadiths",
                ),
              ],
            ),
          ),
          body: TabBarView(children: [
            HadithBooks(),
            SearchHadith(),
          ])),
    );
  }
}
