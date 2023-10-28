import 'package:flutter/material.dart';
import 'package:hadith/classes.dart';
import 'package:hadith/hadith.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void hadith() {
    // // Get available collections
    // print(getCollections());

    // // Get a single collection
    // print(getCollection(Collections.bukhari));

    // // Get collection data
    // print(getCollectionData(Collections.bukhari, Languages.en));

    // // Get books of a collection
    // print(getBooks(Collections.bukhari));

    // // Get a single book
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

    // Get collection URL
    print(getCollectionURL(Collections.bukhari));

    // Get book URL
    print(getBookURL(Collections.bukhari, 1));
  }

  List datalist = getCollections();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hadith();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hadith Collections "),
      centerTitle: true,),
      backgroundColor: Colors.indigo[900],
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              
            },
            leading: Text("${index + 1}"),
            tileColor: Colors.indigo[900],
            textColor: Colors.white,
            title: Text(
              datalist[index].collection[1].title.toString(),
              style: TextStyle(fontFamily: "alq", fontSize: 20),
            ),
            subtitle: Text(datalist[index].collection[0].title.toString()),
          );
        },
        itemCount: datalist.length,
      ),
    );
  }
}
