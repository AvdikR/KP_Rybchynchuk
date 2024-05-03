// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:what_u_cread/models/book.dart';

class ReadingPage extends StatefulWidget {
  String? bookUid;
  String? bookName;
  String? chapterNumber;
  String? mainText;

  ReadingPage({
    this.bookUid,
    this.bookName,
    this.chapterNumber,
    this.mainText,
  });

  @override
  _ReadingPageState createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
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
  Widget build(BuildContext context) {
    String? text;
    if(widget.mainText == null){
      text = "Empty";
    }else{
      text = widget.mainText;
    }
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
              height: size.height * 0.085,
              width: size.width,
              color: Colors.red,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: EdgeInsets.all(constraints.maxHeight * 0.18),
                          height: constraints.maxHeight * 0.8,
                          width: constraints.maxWidth * 0.15,
                          child: FittedBox(
                              child: Icon(
                            Icons.arrow_back_ios,
                            color: Color.fromRGBO(66, 66, 86, 1),
                          )),
                        ),
                      ),
                      Container(
                        height: constraints.maxHeight * 0.85,
                        width: constraints.maxWidth * 0.51,
                        child: Column(
                          children: [
                            Container(
                              height: constraints.maxHeight * 0.85 * 0.7,
                              width: constraints.maxWidth * 0.35,
                              child: FittedBox(
                                  child: Text(
                                    '${widget.bookName}'     
                              )),
                            ),
                            Container(
                              height: constraints.maxHeight * 0.85 * 0.3,
                              width: constraints.maxWidth * 0.35,
                              child: FittedBox(
                                  child: Text(
                                "Chapter ${widget.chapterNumber}",
                              )),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(constraints.maxHeight * 0.18),
                        height: constraints.maxHeight * 0.8,
                        width: constraints.maxWidth * 0.15,
                        child: FittedBox(
                            child: Icon(
                          Icons.share,
                          color: Color.fromRGBO(66, 66, 86, 1),
                        )),
                      ),
                    ],
                  );
                },
              ),
            ),
            Container(
              height: size.height * 0.7,
              width: size.width,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.all(size.height * 0.01),
                child: Center(
                    child: Text(
                      text!,
                  overflow: TextOverflow.fade,
                  style: TextStyle(),
                )),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(235, 235, 237, 1),
                borderRadius: BorderRadius.circular(size.height * 0.006)
              ),
              height: size.height * 0.012,
              width: size.width * 0.93,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(78, 0, 0, 1),
                      borderRadius: BorderRadius.circular(size.height * 0.006)
                    ),
                    height: size.height * 0.012,
                    width: size.width * 0.93 * (173 / 230),
                  ),
                ],
              )
            ),
            SizedBox(
              height: size.height * 0.015,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Container(
              height: size.height * 0.1,
              color: Colors.blueGrey[50],
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Material(
                        borderRadius:
                            BorderRadius.circular(constraints.maxHeight * 0.3),
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(
                              constraints.maxHeight * 0.45 / 2),
                          child: Container(
                            height: constraints.maxHeight * 0.5,
                            width: constraints.maxWidth * 0.9 / 5,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    constraints.maxHeight * 0.45 / 2)),
                            child: FittedBox(
                                child: Icon(
                              Icons.book,
                              color: Color.fromRGBO(69, 69, 88, 1),
                            )),
                          ),
                        ),
                      ),
                      Material(
                        borderRadius:
                            BorderRadius.circular(constraints.maxHeight * 0.3),
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(
                              constraints.maxHeight * 0.45 / 2),
                          child: Container(
                            height: constraints.maxHeight * 0.5,
                            width: constraints.maxWidth * 0.9 / 5,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    constraints.maxHeight * 0.45 / 2)),
                            child: FittedBox(
                                child: Icon(
                              Icons.text_format,
                              color: Color.fromRGBO(69, 69, 88, 1),
                            )),
                          ),
                        ),
                      ),
                      Material(
                        borderRadius:
                            BorderRadius.circular(constraints.maxHeight * 0.3),
                        child: InkWell(
                          onTap: (){_showLeftSideMenu(context);},
                          borderRadius: BorderRadius.circular(
                              constraints.maxHeight * 0.45 / 2),
                          child: Container(
                            height: constraints.maxHeight * 0.5,
                            width: constraints.maxWidth * 0.9 / 5,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    constraints.maxHeight * 0.45 / 2)),
                            child: FittedBox(
                                child: Icon(
                              Icons.list,
                              color: Color.fromRGBO(69, 69, 88, 1),
                            )),
                          ),
                        ),
                      ),
                      Material(
                        borderRadius:
                            BorderRadius.circular(constraints.maxHeight * 0.3),
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(
                              constraints.maxHeight * 0.45 / 2),
                          child: Container(
                            height: constraints.maxHeight * 0.5,
                            width: constraints.maxWidth * 0.9 / 5,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    constraints.maxHeight * 0.45 / 2)),
                            child: FittedBox(
                                child: Icon(
                              Icons.brightness_3,
                              color: Color.fromRGBO(191, 191, 191, 1),
                            )),
                          ),
                        ),
                      ),
                      Material(
                        borderRadius:
                            BorderRadius.circular(constraints.maxHeight * 0.3),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReadingPage(
                                  bookUid: widget.bookUid,
                                  bookName: widget.bookName,
                                  chapterNumber: chapterList[1].number.toString(),
                                  mainText: chapterList[1].mainText,
                                ),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(
                              constraints.maxHeight * 0.45 / 2),
                          child: Container(
                            height: constraints.maxHeight * 0.5,
                            width: constraints.maxWidth * 0.9 / 5,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    constraints.maxHeight * 0.45 / 2)),
                            child: FittedBox(
                                child: Icon(
                              Icons.keyboard_double_arrow_right_sharp,
                              color: Color.fromRGBO(69, 69, 88, 1),
                            )),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      )),
    );
  }

  void _showLeftSideMenu(BuildContext context) {
    showGeneralDialog(
      context: context,
      //barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Color.fromARGB(255, 147, 147, 147).withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
        return Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.45, // Ширина вікна меню
            height: MediaQuery.of(context).size.height,
            color: Colors.blueGrey[50],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Chapter List",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[700],
                  ),
                ),
                SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      for (var chapter in chapterList)
                      FractionallySizedBox(
                        widthFactor: 0.9,
                        child: ElevatedButton.icon(  
                          onPressed: () {
                          // Дії при натисканні на кнопку "Settings"
                          },
                          style: ButtonStyle(
                            alignment: Alignment.centerLeft, // Вирівнюємо з ліва
                            textStyle: MaterialStateProperty.resolveWith<TextStyle>(
                              (Set<MaterialState> states) {
                                // Налаштовуємо розмір та колір тексту
                                return TextStyle(
                                  fontSize: 16, // Розмір тексту
                                  color: Colors.black, // Колір тексту
                                );
                              },
                            ),
                          ),
                          label: Text("Chapter ${chapter.number.toString()}"),
                          icon: Icon(Icons.arrow_right_rounded),
                        ),
                      ),
                      SizedBox(height: 1),                         
                    ],
                  ),
                ),
                SizedBox(height: 10),
                IconButton(
                  iconSize: 40,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.cancel_sharp),
                ),
              ],
            ),
          ),
        );
      },
      transitionBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(-1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }
}