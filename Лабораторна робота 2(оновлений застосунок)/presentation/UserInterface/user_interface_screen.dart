// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:what_u_cread/models/book.dart';
import 'package:what_u_cread/models/currentUser.dart';
import 'package:what_u_cread/service/database.dart';
import 'package:flutter/material.dart';
import 'package:what_u_cread/models/userModel.dart';
import 'package:what_u_cread/presentation/UserInterface/widgets/favorite_books_screen.dart';
import 'package:what_u_cread/presentation/UserInterface/widgets/reading_books_screen.dart';
import 'package:what_u_cread/presentation/UserInterface/widgets/statistics_screen.dart';

class UserInterface extends StatefulWidget {

  UserInterface({
    Key? key,
  }) : super(key: key);

  @override
  _UserInterfaceState createState() => _UserInterfaceState();
}

class _UserInterfaceState extends State<UserInterface> {
  UserModel? user = UserModel();
  List<BookModel> favoriteBooks = [];

  int favoriteBooksCount = 0;
  int readingBooksCount = 0;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _getUserData() async {
    try {
      // Отримання поточного користувача за допомогою Provider
      CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
      // Отримання даних користувача за допомогою UID поточного користувача
      UserModel? userData = await Database().getUserInfo(_currentUser.getCurrentUser!.uid!);
      //UserModel? userInfo = await UserModel().getUserData(_currentUser.getCurrentUser!.uid!);
      setState(() {
        user = userData;
        //user = userInfo;
      });
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }


  // Метод для завантаження улюблених книг користувача з бази даних
  Future<List<BookModel>> _getFavoriteBooks() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
      if (userData.exists) {
        // Отримайте список улюблених книг з даних користувача
        List<dynamic> favoriteBooksData = userData.get('favoriteBooks') ?? [];
        favoriteBooks = favoriteBooksData.map((bookData) => BookModel.fromMap(bookData)).toList();
        favoriteBooksCount = favoriteBooks.length; // Кількість улюблених книг
        return favoriteBooks;
      } else {
        return [];
      }
    } catch (e) {
      print('Error getting user favorite books: $e');
      return [];
    }
  }

  Future<void> _initData() async {
    try {
      await _getUserData();
      await _getFavoriteBooks();
    } catch (e) {
      print('Error initializing data: $e');
    }
  }
  
  void _addBookToFavorites(String bookId) {
    // Тут додайте логіку для додавання книги до списку улюблених користувача
  }

  void _removeBookFromFavorites(String bookId) {
    // Тут додайте логіку для видалення книги зі списку улюблених користувача
  }

  void _addBookToReadingList(String bookId) {
    // Тут додайте логіку для додавання книги до списку читання користувача
  }

  void _removeBookFromReadingList(String bookId) {
    // Тут додайте логіку для видалення книги зі списку читання користувача
  }

  int activeScreenIndex = 1; //Ініціалізація activeScreenIndex
  List<String> favoriteBooksIndex = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Image.asset(
                "assets/images/img_settinguserbutton.png",
                height: 20,
                width: 20,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  onTapUserSettings(context);
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage(
                          "assets/images/img_usericon.png",
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 24,
                          top: 34,
                          bottom: 4,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${user!.userName}',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            SizedBox(height: 8),
                            Text(
                              //'ID: 012345',
                              "ID: ${user!.userID}",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            _buildCountsRow(context),
            SizedBox(height: 15),
            _buildMenuRow(context),
            SizedBox(height: 5),
            FutureBuilder(
              future: null,
              builder:(context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return Expanded(
                  child: IndexedStack(
                    index: activeScreenIndex,
                    children: [
                      FavoriteBooksScreen(
                        favoriteBooks: favoriteBooks,
                        onRemoveBook: _removeBookFromFavorites,
                        //userId: '',
                      ),
                      ReadingBooksScreen(),
                      StatisticsScreen(
                        email: user!.email,
                        accountCreated: user!.accountCreated,
                      ),
                    ],
                  ),
                );
                }
              }
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCountsRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text("All Books", style: TextStyle(fontSize: 14)),
              SizedBox(height: 10),
              Text(
                '${favoriteBooksCount+ readingBooksCount}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          _buildBooksColumn(
            context,
            booksText: "Reading books",
            zipcodeText: '$readingBooksCount',
          ),
          _buildBooksColumn(
            context,
            booksText: "Favorite books",
            zipcodeText: "$favoriteBooksCount",
          ),
        ],
      ),
    );
  }

  Widget _buildMenuRow(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
      color: Colors.grey[300],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildMenuButton(
            "assets/images/img_favoriteList.png",
            isActive: activeScreenIndex == 0,
            index: 0,
          ),
          _buildMenuButton(
            "assets/images/img_readingList.png",
            isActive: activeScreenIndex == 1,
            index: 1,
          ),
          _buildMenuButton(
            "assets/images/img_statistics.png",
            isActive: activeScreenIndex == 2,
            index: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton(
    String imagePath, {
    required bool isActive,
    required int index,
  }) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black, width: 2),
        color: isActive ? Colors.blueGrey[200] : Colors.blueGrey[150],
      ),
      child: IconButton(
        icon: ImageIcon(AssetImage(imagePath)),
        onPressed: () {
          setState(() {
            activeScreenIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildBooksColumn(BuildContext context,
      {required String booksText, required String zipcodeText}) {
    return Column(
      children: [
        Text(booksText, style: TextStyle(fontSize: 14, color: Colors.grey)),
        SizedBox(height: 10),
        Text(
          zipcodeText,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  onTapUserSettings(BuildContext context) {}
  
}






