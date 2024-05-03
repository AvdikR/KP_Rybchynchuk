import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:what_u_cread/models/book.dart';

class UserModel {
  String? uid; // індіфікаційний номер користувача
  String? email; // елекктрона пошта
  String? userName; // ім'я або назва
  String? userID; // номер користувача
  List<dynamic>? favoriteBooks; // список улюблених книг
  Timestamp? accountCreated; // час створення/реєстрації

  UserModel({
    this.uid,
    this.email,
    this.userName,
    this.userID,
    this.favoriteBooks,
    this.accountCreated,
  });

  UserModel.fromDocumentSnapshot({required DocumentSnapshot<Map<String, dynamic>> doc}) {
    uid = doc.id;
    email = doc.get('email');
    userName = doc.get('userName');
    userID = doc.get('userID');
    favoriteBooks = doc.get("favoriteBooks");
    accountCreated = doc.get('accountCreated');
  }

  // Метод для отримання даних користувача з бази даних Firestore
  Future<UserModel?> getUserData(String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userData =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (userData.exists) {
        return UserModel(
          uid: userData.id,
          email: userData.get('email'),
          userName: userData.get('userName'),
          userID: userData.get('userID'),
          favoriteBooks: List<dynamic>.from(userData.get('favoriteBooks') ?? []),
          accountCreated: userData.get('accountCreated'),
        );
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting user data: $e');
      return null;
    }
  }
/*
  void addToFavorites(String uid, String bookId) {
    // Отримайте посилання на документ користувача в колекції "users"
    DocumentReference userDocRef = FirebaseFirestore.instance.collection('users').doc(uid);
    
    // Оновіть дані користувача, додавши ідентифікатор книги у список улюблених
    userDocRef.update({
      'favoriteBooks': FieldValue.arrayUnion([bookId]),
    });
  }

  void removeFromFavorites(String uid, String bookId) {
    // Отримайте посилання на документ користувача в колекції "users"
    DocumentReference userDocRef = FirebaseFirestore.instance.collection('users').doc(uid);

    // Оновіть дані користувача, видаливши ідентифікатор книги зі списку улюблених
    userDocRef.update({
      'favoriteBooks': FieldValue.arrayRemove([bookId]),
    });
  }
*/
  void addToFavorites(String uid, BookModel book) {
    // Отримайте посилання на документ користувача в колекції "users"
    DocumentReference userDocRef = FirebaseFirestore.instance.collection('users').doc(uid);
    
    // Оновіть дані користувача, додавши об'єкт книги до списку улюблених
    userDocRef.update({
      'favoriteBooks': FieldValue.arrayUnion([book.toMap()]), // Перетворення BookModel в Map
    });
  }

  void removeFromFavorites(String uid, BookModel book) {
    // Отримайте посилання на документ користувача в колекції "users"
    DocumentReference userDocRef = FirebaseFirestore.instance.collection('users').doc(uid);
  
    // Оновіть дані користувача, видаливши об'єкт книги зі списку улюблених
    userDocRef.update({
      'favoriteBooks': FieldValue.arrayRemove([book.toMap()]), // Перетворення BookModel в Map
    });
  }

  // Метод для перевірки, чи книга знаходиться в списку улюблених користувача
  Future<bool> isBookInFavorites(String userId, BookModel book) async {
    // Cписок улюблених книг користувача за його ID
    List<dynamic>? favoriteBooks = await getUserFavorites(userId);
    
    // Перевірка, чи ID книги знаходиться у списку улюблених книг користувача
    if (favoriteBooks != null && favoriteBooks.contains(book.id)) {
      return true; // Книга знаходиться у списку улюблених
    } else {
      return false; // Книга не знаходиться у списку улюблених
    }
  }

  // Метод для отримання списку улюблених книг користувача за його ID
  Future<List<dynamic>?> getUserFavorites(String userId) async {
    try {
      // Отримання документу користувача з бази даних
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      
      // Перевірка, чи документ існує та чи містить він список улюблених книг
      if (userDoc.exists && userDoc.data() != null) {
        Map<String, dynamic> userData = userDoc.data()!;
        return userData['favoriteBooks'] as List<dynamic>?; // Повернення списку улюблених книг
      } else {
        return null; // Якщо користувач не має списку улюблених книг або документ не існує
      }
    } catch (e) {
      print('Error getting user favorites: $e');
      return null; // Повертаємо null у разі помилки
    }
  }
}