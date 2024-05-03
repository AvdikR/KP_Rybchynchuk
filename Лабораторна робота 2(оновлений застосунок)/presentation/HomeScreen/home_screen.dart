// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:what_u_cread/models/book.dart';
import 'package:what_u_cread/models/currentUser.dart';
import 'package:what_u_cread/models/userModel.dart';
import 'package:what_u_cread/presentation/BookInfoMenu/book_info_screen.dart';
import 'package:what_u_cread/service/database.dart';
import 'package:what_u_cread/widgets/book_rating.dart';
import 'package:what_u_cread/widgets/reading_card_list.dart';
import 'package:what_u_cread/widgets/searching_panel.dart';
import 'package:what_u_cread/widgets/top_menu.dart';
import 'package:what_u_cread/widgets/two_side_rounded_button.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //List<BookModel> booksList = booksContent;
  List<BookModel> filteredBooksList = [];
  UserModel? user = UserModel();
  final TextEditingController _searchController = TextEditingController();

  late Future<List<BookModel>> _booksFuture; // Future для отримання списку книг
  List<BookModel> booksList = [];

  @override
  void initState() {
    super.initState();
    _getUserData(); // отримуємо дані про користувача
    _loadBooks(); // Завантажуємо дані при ініціалізації віджету
    filterBooks(_searchController.text); // Викликаємо метод фільтрації книг при ініціалізації віджету
  }

  Future<void> _getUserData() async {
    try {
      // Отримання поточного користувача за допомогою Provider
      CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
      // Отримання даних користувача за допомогою UID поточного користувача
      UserModel? userData = await Database().getUserInfo(_currentUser.getCurrentUser!.uid!);
      setState(() {
        user = userData;
      });
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  // Метод для отримання списку книг з Firestore
  Future<void> _loadBooks() async {
    setState(() {
      _booksFuture = FirebaseFirestore.instance.collection('books').get().then((querySnapshot) {
        //List<BookModel> booksList = [];
        querySnapshot.docs.forEach((doc) {
          booksList.add(BookModel.fromDocumentSnapshot(doc: doc));
        });
        return booksList;
      });
    });
  }
/*
  Future<void> _loadBooks() async {
    setState(() {
      _booksFuture = FirebaseFirestore.instance.collection('books').get().then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          BookModel book = BookModel.fromDocumentSnapshot(doc: doc);
          // Перевіряємо, чи книга є улюбленою для користувача
          book.isFavorite = user?.favoriteBooks?.contains(book.id) ?? false;
          booksList.add(book);
        });
        return booksList;
      });
    });
  }*/

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background_bitmap.png"),
            alignment: Alignment.topCenter,
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TopMenu(
              size: size,
              userName: user!.userName,
            ),
            SizedBox(height: size.height * 0.01),
            SearchingPanel(
              size: size,
              onTextChanged: (searchText) {
                filterBooks(searchText);
              },
              searchController: _searchController, // Передаємо контролер
            ),
            Expanded(
              child: ListView(
                children: [
                  SizedBox(height: size.height * .025),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyLarge,
                        children: [
                          TextSpan(text: "What do you want to \nread"),
                          TextSpan(
                            text: " today?",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyLarge,
                        children: [
                          TextSpan(text: "Updated:"),
                        ],
                      ),
                    ),
                  ),
                  FutureBuilder(
                    future: _booksFuture, // Використовуємо Future для отримання списку книг
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (var book in filteredBooksList)
                              ReadingListCard(
                                userId: user!.uid!,
                                book: book,
                                pressDetails: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BookInfoScreen(
                                        bookUid: book.id,
                                        imageAddress: book.bookImage,
                                        name: book.name,
                                        author: book.author,
                                        description: book.description,
                                      ),
                                    ),
                                  );
                                },
                                pressRead: () {},
                              ),
                              SizedBox(width: 20),                         
                            ],
                          ),
                        );
                      }
                    }
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyLarge,
                        children: [
                          TextSpan(text: "All books:"),
                        ],
                      ),
                    ),
                  ),
                  FutureBuilder(
                    future: _booksFuture, // Використовуємо Future для отримання списку книг
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (var book in booksList)
                              ReadingListCard(
                                userId: user!.uid!,
                                book: book,
                                pressDetails: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BookInfoScreen(
                                        bookUid: book.id,
                                        imageAddress: book.bookImage,
                                        name: book.name,
                                        author: book.author,
                                        description: book.description,
                                      ),
                                    ),
                                  );
                                },
                                pressRead: () {},
                              ),
                              SizedBox(width: 20),                         
                            ],
                          ),
                        );
                      }
                    }
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyLarge,
                            children: [
                              TextSpan(text: "Best of the "),
                              TextSpan(
                                text: " week:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        bestOfTheDayCard(size: size),
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyLarge,
                            children: [
                              TextSpan(text: "Continue"),
                              TextSpan(
                                text: " reading:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          height: 80,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[50],
                            borderRadius: BorderRadius.circular(38.5),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 10),
                                blurRadius: 33,
                                color: Colors.black45.withOpacity(.85),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(38.5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(left: 30, right: 20),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "Harry Potter 3",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "J.K. Rowling",
                                                style: TextStyle(
                                                  color: Colors.black45,
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.bottomCenter,
                                                child: Text(
                                                  "Chapter 7 of 10",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                            ],
                                          ),
                                        ),
                                        Image.asset(
                                          "assets/images/img_bookIcon.png",
                                          width: 60,
                                          height: 60,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 7,
                                  width: size.width * .65,
                                  decoration: BoxDecoration(
                                    color: Colors.cyan[50],
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Метод фільтрація книг під час пошуку
  void filterBooks(String searchText) {
    setState(() {
      if (searchText.isEmpty) {
        filteredBooksList = booksList;
      } else {
        filteredBooksList = booksList.where((book) =>
            book.name!.toLowerCase().contains(searchText.toLowerCase()) || //пошук по назві книги
            book.author!.toLowerCase().contains(searchText.toLowerCase())).toList(); //пощук по імені автора
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose(); // Пам'ятайте про очистку контролера після використання
    super.dispose();
  }
}

class bestOfTheDayCard extends StatelessWidget {
  const bestOfTheDayCard({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      width: double.infinity,
      height: 205,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                left: 10, 
                top: 24, 
                right: size.width * .35
              ),
              height: 185,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 196, 202, 205),
                borderRadius: BorderRadius.circular(29),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "New York Time Best For 11th March 2028",
                    style: TextStyle(
                      fontSize: 9,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "How To Win \nFriends & Influence",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    "Gary Venchuk",
                    style: TextStyle(color: Colors.black54),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      BookRating(score: 4.9),
                      SizedBox(width: 10),
                      Expanded(child: Text(
                        "When the earth was falt and everyone wanted to win the game",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Image.asset(
              "assets/images/img_bookIcon.png", 
              width: size.width * .37,
              height: size.height * .3,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: SizedBox(
              height: 40,
              width: size.width * .3,
              child: TwoSideRoundedButton(
                text: "Read",
                radius: 24,
                press: (){},
              ),
            ),
          )
        ],
      ),
    );
  }
}










