import 'package:flutter/material.dart';
import 'package:what_u_cread/models/book.dart';

/*
class FavoriteBooksScreen extends StatefulWidget {
  const FavoriteBooksScreen({Key? key}) : super(key: key);

  @override
  _FavoriteBooksScreenState createState() => _FavoriteBooksScreenState();
}

class _FavoriteBooksScreenState extends State<FavoriteBooksScreen> {
  List<BookModel> favoriteBooks = []; // Список улюблених книг

  @override
  void initState() {
    super.initState();
    // Додавання книг, які мають isFavorite = true, до списку favoriteBooks
    for (var book in booksContent) {
      if (book.isFavorite == true) {
        favoriteBooks.add(book);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: ListView.builder(
        itemCount: favoriteBooks.length,
        itemBuilder: (context, index) {
          final book = favoriteBooks[index];
          return _buildBookItem(
            title: book.name!,
            author: book.author!,
            imageUrl: book.bookImage!,
            onDelete: () {
              // Видалення книги зі списку улюблених
              setState(() {
                favoriteBooks.removeAt(index);
              });
            },
          );
        },
      ),
    );
  }

  Widget _buildBookItem({
    required String title,
    required String author,
    required String imageUrl,
    VoidCallback? onDelete,
  }) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(
            imageUrl,
            width: 60,
            height: 60,
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  author,
                  style: TextStyle(
                    color: Colors.black45,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onDelete, 
            icon: Icon(
              Icons.delete_forever_outlined
            )
          ),
        ],
      ),
    );
  }
}*/
/*
class FavoriteBooksScreen extends StatefulWidget {
  //final String? userId;
  final List<String> favoriteBooksID;

   // Додайте поле для зберігання ID користувача
  const FavoriteBooksScreen({
    Key? key, 
    //this.userId,
    required this.favoriteBooksID,
  }) : super(key: key);

  @override
  _FavoriteBooksScreenState createState() => _FavoriteBooksScreenState();
}

class _FavoriteBooksScreenState extends State<FavoriteBooksScreen> {
  List<BookModel> favoriteBooks = []; // Список улюблених книг користувача

  @override
  void initState() {
    super.initState();
    // Завантаження улюблених книг користувача під час ініціалізації віджету
   // _loadFavoriteBooks();
  }

  // Метод для отримання повної інформації про улюблені книги з їх ID
  Future<List<BookModel>> _getBooksInfo(List<String> bookIds) async {
    List<BookModel> userFavoriteBooks = [];
    for (String bookId in bookIds) {
      // Отримання інформації про книгу за її ID
      BookModel? book = await BookModel().getBookInfo(bookId);
      if (book != null) {
        userFavoriteBooks.add(book);
      }
    }
    return userFavoriteBooks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: ListView.builder(
        itemCount: favoriteBooks.length,
        itemBuilder: (context, index) {
          final book = favoriteBooks[index];
          return _buildBookItem(
            title: book.name!,
            author: book.author!,
            imageUrl: book.bookImage!,
            onDelete: () {
              // Видалення книги зі списку улюблених та з бази даних
              },
          );
        },
      ),
    );
  }

  Widget _buildBookItem({
    required String title,
    required String author,
    required String imageUrl,
    VoidCallback? onDelete,
  }) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(
            imageUrl,
            width: 60,
            height: 60,
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  author,
                  style: TextStyle(
                    color: Colors.black45,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onDelete, 
            icon: Icon(
              Icons.delete_forever_outlined
            )
          ),
        ],
      ),
    );
  }
}*/

class FavoriteBooksScreen extends StatefulWidget {
  final List<BookModel> favoriteBooks;
  //final String userId;
  final Function(String) onRemoveBook;

  const FavoriteBooksScreen({
    Key? key,
    //required this.userId,
    required this.favoriteBooks,
    required this.onRemoveBook,
  }) : super(key: key);

  @override
  _FavoriteBooksScreenState createState() => _FavoriteBooksScreenState();
}

class _FavoriteBooksScreenState extends State<FavoriteBooksScreen> {
  //List<BookModel> favoriteBooks = [];
  List<BookModel> booksList = [];

  
/*
  // Метод для отримання списку улюблених книг з Firestore
  Future<List<BookModel>> _loadFavoriteBooksList(List<String> bookIds) async {
  List<BookModel> booksList = [];
  
  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection('books').where('bookID', whereIn: bookIds).get();
      
    querySnapshot.docs.forEach((doc) {
      BookModel book = BookModel.fromDocumentSnapshot(doc: doc);
      booksList.add(book);
    });
  } catch (e) {
    print('Error loading book data: $e');
  }

  return booksList;
}
*/


/*
  late Future<List<BookModel>> _booksFuture; // Future для отримання списку книг

  Future<void> _loadBooks() async {
    setState(() {
      _booksFuture = FirebaseFirestore.instance.collection('books').get().then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          // Отримання bookID з документа книги
          String bookID = doc.data()['bookID'];
          
          // Перевірка, чи bookID міститься у списку favoriteBooksID
          if (widget.favoriteBooksID.contains(bookID)) {
            booksList.add(BookModel.fromDocumentSnapshot(doc: doc));
          }
        });
        return booksList;
      });
    });
  }

  Future<void> _loadBooks() async {
    setState(() {
      _booksFuture = FirebaseFirestore.instance.collection('books').get().then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          if (widget.favoriteBooksID.contains(doc['bookID'])) {
            booksList.add(BookModel.fromDocumentSnapshot(doc: doc));
          }
        });
      return booksList;});
    });
  }*/
  
  /*
  Future<void> _loadBooks() async {
  try {
    final querySnapshot = await FirebaseFirestore.instance.collection('books').get();
    final List<BookModel> loadedBooks = [];
    querySnapshot.docs.forEach((doc) {
      final bookID = doc['bookID']; // Отримати ідентифікатор книги з документа
      if (widget.favoriteBooksID.contains(bookID)) {
        loadedBooks.add(BookModel.fromDocumentSnapshot(doc: doc));
      }
    });
    setState(() {
      booksList = loadedBooks;
    });
  } catch (error) {
    // Обробка помилок: виведення повідомлення або інші дії
    print('Помилка під час завантаження книг: $error');
    // Додайте код для обробки помилок, якщо потрібно
  }
}*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        //child: booksList.isEmpty
        child: widget.favoriteBooks.isEmpty 
        ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'List is empty',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                'You can add favorite books here',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ) 
        : Column(
          children: [
            for (var favorite_books in widget.favoriteBooks)
            _buildBookItem(
              title: favorite_books.name!, 
              author: favorite_books.author!, 
              imageUrl: favorite_books.bookImage!,
            ),
            SizedBox(height: 3),                         
          ],
        ),
      ),
      
      /*
      ListView.builder(
        itemCount: favoriteBooks.length,
        itemBuilder: (context, index) {
          final book = favoriteBooks[index];
          return _buildBookItem(
            title: book.name!,
            author: book.author!,
            imageUrl: book.bookImage!,
            onDelete: () {
              widget.onRemoveBook(book.id!); // Видалення книги
            },
          );
        },
      ),*/
    );
  }

  Widget _buildBookItem({
    required String title,
    required String author,
    required String imageUrl,
    VoidCallback? onDelete,
  }) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(
            imageUrl,
            width: 60,
            height: 60,
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  author,
                  style: TextStyle(
                    color: Colors.black45,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onDelete,
            icon: Icon(
              Icons.delete_forever_outlined,
            ),
          ),
        ],
      ),
    );
  }
}
