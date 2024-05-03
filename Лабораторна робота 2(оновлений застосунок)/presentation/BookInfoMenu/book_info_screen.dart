// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:what_u_cread/models/book.dart';
import 'package:what_u_cread/presentation/ReadingWindow/reading_window.dart';
import 'package:what_u_cread/widgets/book_rating.dart';
import 'package:what_u_cread/widgets/rounded_button.dart';

class BookInfoScreen extends StatefulWidget{
  String? bookUid;
  String? imageAddress;
  String? name;
  String? author;
  String? description;

  BookInfoScreen({
    Key? key,
    this.bookUid,
    this.imageAddress,
    this.author,
    this.name,
    this.description,
  }) : super(key: key);

  @override
  State<BookInfoScreen> createState() => _BookInfoScreenState();
}

class _BookInfoScreenState extends State<BookInfoScreen> {
  //List<BookChapter> chapterList = [];
  List<BookChapter> chapterList = book1Chapters;
  
  late Future<List<BookChapter>> _chaptersFuture;

  Future<void> _loadBookChapters() async {
    setState(() {
      _chaptersFuture = FirebaseFirestore.instance
        .collection('books')
        .doc(widget.bookUid)
        .collection('bookChapters')
        .get()
        .then((querySnapshot) {
          List<BookChapter> chapters = [];
          querySnapshot.docs.forEach((doc) {
            chapters.add(BookChapter.fromDocumentSnapshot(doc: doc));
          });
      return chapters;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _loadBookChapters(); // Ініціалізуємо _chaptersFuture при створенні віджету
  }

  @override
  Widget build(BuildContext context){
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Container(
                  height: size.height * .4,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/background_bitmap.png"),
                      fit:BoxFit.fitWidth,
                    ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: size.height * .1,),
                        BookInfo(
                          name: widget.name,
                          description: widget.description,
                          imageAddress: widget.imageAddress,
                          readBook: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReadingPage(
                                  bookUid: widget.bookUid,
                                  bookName: widget.name,
                                  chapterNumber: chapterList[0].number.toString(),
                                  mainText: chapterList[0].mainText,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),/*
                Padding(
                  padding: EdgeInsets.only(top: size.height * .4 - 10),
                  child: Container(
                    height: size.height * 0.5,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.10),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 33,
                          color: Color(0xFFD3D3D3).withOpacity(.84),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          for (var chapter in chapterList)
                          ChapterCard(
                            chapter: chapter,
                            press: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReadingPage(
                                    bookName: widget.name,
                                    chapterNumber: chapter.number.toString(),
                                    mainText: chapter.mainText,
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 3),                         
                        ],
                      ),
                    ),
                  )
                ),*/
                Padding(
                  padding: EdgeInsets.only(top: size.height * .4 - 10),
                  child: Container(
                    height: size.height * 0.5,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.10),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 33,
                          color: Color(0xFFD3D3D3).withOpacity(.84),
                        ),
                      ],
                    ),
                    child: FutureBuilder<List<BookChapter>>(
                      future: _chaptersFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator(); // Показуємо індикатор завантаження, якщо дані ще не завантажені
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}'); // Повідомлення про помилку, якщо виникає помилка під час завантаження
                        } else {
                          // Якщо дані успішно завантажені, показуємо список розділів
                          List<BookChapter> chapters = snapshot.data!;
                          return SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                ...chapters
                                .map((chapter) => ChapterCard(
                                  chapter: chapter,
                                  press: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ReadingPage(
                                          bookName: widget.name,
                                          chapterNumber: chapter.number,
                                          mainText: chapter.mainText,
                                          ),
                                        ),
                                      );
                                    },
                                  ))
                                .toList()
                                ..sort((a, b) {
                                  // Перетворюємо номери розділів з рядків у цілі числа для порівняння
                                  int aNumber = int.parse(a.chapter.number!);
                                  int bNumber = int.parse(b.chapter.number!);
                                  // Порівнюємо номери розділів і повертаємо результат
                                  return aNumber.compareTo(bNumber);
                                }),
                                SizedBox(height: 3),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: -10,
                  left: -10,
                  child: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: BackButton(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyLarge,
                      children: [
                        TextSpan(
                          text: "Related ",
                        ),
                        TextSpan(
                          text: "book:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}

class ChapterCard extends StatelessWidget {
  final BookChapter chapter;
  final Function press;
  
  const ChapterCard({
    Key? key, 
    required this.chapter,
    required this.press, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: 
          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      margin: EdgeInsets.only(bottom: 16),
      width: size.width * .9 - 40,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
          offset: Offset(0, 10),
          blurRadius: 33,
          color: Color(0xFFD3D3D3).withOpacity(.84),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  //text: "Chapter $chapterNumber : ${name!.length <= 18 ? name : name!.substring(0, 16) + '...'}\n", 
                  text: "Chapter ${chapter.number} : ${chapter.name!.length <= 18 ? chapter.name : chapter.name!.substring(0, 16) + '...'}\n", 
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 14,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold, 
                  ),
                ),
                TextSpan(
                  //text: tag, 
                  text: "some date",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                    ),
                ),
              ],
            ),
          ),
          Spacer(),
          IconButton(
            onPressed:() => press(), 
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class BookInfo extends StatelessWidget {
  final String? name;
  final String? description;
  final String? imageAddress;
  final Function readBook;

  const BookInfo({
    Key? key,
    this.name, 
    this.description, 
    this.imageAddress,
    required this.readBook
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name!,
                maxLines: 2,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                )
              ),
              SizedBox(height: 5),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(
                          description!,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: 2),
                        RoundedButton(
                          text: "Read",
                          press: () => readBook(),
                          verticalPadding: 10,
                          )
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.stars_sharp), 
                        onPressed: (){},
                      ),
                      BookRating(score: 4.8),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Image.asset(
          imageAddress!,
          height: 140,
          width: 140,
        )
      ],
    );
  }
}