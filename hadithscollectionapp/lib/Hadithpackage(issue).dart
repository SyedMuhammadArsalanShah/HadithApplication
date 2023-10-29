import 'package:flutter/material.dart';

import 'package:hadith/hadith.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void hadith() {
    // Get available collections
    // print(getCollections());

    // Get a single collection
    // print(getCollection(Collections.bukhari));

    // // Get collection data
    // print(getCollectionData(Collections.bukhari, Languages.en));

    //Get books of a collection
    // print(getBooks(Collections.bukhari));

    // Get a single book
    // print(getBook(Collections.bukhari, 1));

    // // Get book data
    // print(getBookData(Collections.bukhari, 1, Languages.en));

    // // Get hadiths of a book
    // print(getHadiths(Collections.bukhari, 1));

    // // Get a single hadith
    // print(getHadith(Collections.bukhari, 1, 1));

    // Get hadith data
    // print(getHadithData(Collections.bukhari, 1, 1, Languages.en));

    // // Get hadith data by hadith number
    // print(getHadithDataByNumber(Collections.bukhari, '1', Languages.en));
    // print(getHadithDataByNumber(Collections.muslim, '36 b', Languages.en));

    // // Get collection URL
    // print(getCollectionURL(Collections.bukhari));

    // // Get book URL
    // print(getBookURL(Collections.bukhari, 1));
  }

  List datalist = Collections.values;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hadith();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hadith Collections "),
        centerTitle: true,
      ),
      backgroundColor: Colors.indigo[900],
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              var name = datalist[index];
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BOHadith(name),
                  ));

              ;
            },
            leading: Text("${index + 1}"),
            tileColor: Colors.indigo[900],
            textColor: Colors.white,
            title: Text(
              getCollection(datalist[index]).collection[1].title.toString(),
              style: TextStyle(fontFamily: "alq", fontSize: 20),
            ),
            subtitle: Text(
                getCollection(datalist[index]).collection[0].title.toString()),
            trailing:
                Text(getCollection(datalist[index]).totalHadith.toString()),
          );
        },
        itemCount: datalist.length,
      ),
    );
  }
}

class BOHadith extends StatefulWidget {
  final nameofcollection;
  BOHadith(this.nameofcollection, {super.key});

  @override
  State<BOHadith> createState() => _BOHadithState();
}

class _BOHadithState extends State<BOHadith> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Books of Hadiths "),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {},
            leading: Text("${index + 1}"),
            title: Text(
              getBooks(widget.nameofcollection)[index].book[1].name.toString(),
              style: TextStyle(fontFamily: "alq", fontSize: 20),
            ),
            subtitle: Text(getBooks(widget.nameofcollection)[index]
                .book[0]
                .name
                .toString()),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("Hadiths" +
                    getBooks(widget.nameofcollection)[index]
                        .hadithStartNumber
                        .toString() +
                    " To " +
                    getBooks(widget.nameofcollection)[index]
                        .hadithEndNumber
                        .toString()),
                Text("Total Hadiths :" +
                    getBooks(widget.nameofcollection)[index]
                        .numberOfHadith
                        .toString()),
              ],
            ),
          );
        },
        itemCount: getBooks(widget.nameofcollection).length,
      ),
    );
  }
}
