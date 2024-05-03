import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:what_u_cread/models/userModel.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Функція для генерації рандомного ID
  String generateRandomID() {
    // Генеруємо рандомний ID, наприклад, складаючи 6 випадкових цифр
    Random random = Random();
    String id = '';
    for (int i = 0; i < 6; i++) {
      id += random.nextInt(10).toString();
    }
     return id;
  }

  // Функція для додавання даних користувача до Firestore 
  Future<String> createUser(UserModel user) async {
    String retVal = "error";
    bool isUniqueID = false;

    // Повторюємо генерацію рандомного ID і перевірку його унікальності, доки не буде знайдено унікальний ID
    while (!isUniqueID) {
      // Генеруємо новий рандомний ID
      String randomID = generateRandomID();
      // Перевіряємо, чи є ID унікальним
      isUniqueID = await isIDUnique(randomID);
      
      // Якщо ID унікальний, додаємо дані до Firestore та завершуємо цикл
      if (isUniqueID) {
        try {
        await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
          'userName': user.userName,
          'email': user.email,
          'favoriteBooks': user.favoriteBooks,
          'userID': randomID, // Додаємо рандомний унікальний ID
          'accountCreated': Timestamp.now(),
          });
          retVal = "success";
        } catch (e) {
          print("Помилка при додаванні даних до Firestore: $e");
        }
      }
    }
    return retVal;
  }

  Future<UserModel> getUserInfo(String uid) async {
    UserModel retVal = UserModel();

    try{
      DocumentSnapshot _docSnapshot = await _firestore.collection("users").doc(uid).get();
      retVal.uid = uid;
      retVal.userName = _docSnapshot.get("userName");
      retVal.email = _docSnapshot.get("email");
      retVal.favoriteBooks = _docSnapshot.get("favoriteBooks");
      retVal.userID = _docSnapshot.get("userID");
      retVal.accountCreated = _docSnapshot.get("accountCreated");
    }catch(e){
      print(e);
    }

    return retVal;
  }

  // Функція для перевірки унікальності ID в базі даних Firestore
  Future<bool> isIDUnique(String id) async {
    bool isUnique = true;
    
    try {
      // Отримуємо посилання на колекцію "users" у Firestore
      CollectionReference usersRef = FirebaseFirestore.instance.collection('users');
      // Виконуємо запит до бази даних для перевірки наявності ID
      QuerySnapshot querySnapshot = await usersRef.where('ID', isEqualTo: id).get();

      // Якщо кількість документів знайдених за запитом дорівнює 0, ID є унікальним
      if (querySnapshot.size == 0) {
        isUnique = true;
      } else {
        isUnique = false; // Інакше, ID вже використовується
      }
    } catch (e) {
      print('Помилка при перевірці унікальності ID: $e');
      // У разі помилки повертаємо значення true для запобігання можливих конфліктів
      isUnique = true;
    }

  return isUnique;
}

  void addToFavorites(String userId, String bookId) {
    // Отримайте посилання на документ користувача в колекції "users"
    DocumentReference userDocRef = FirebaseFirestore.instance.collection('users').doc(userId);
    
    // Оновіть дані користувача, додавши ідентифікатор книги у список улюблених
    userDocRef.update({
      'favoriteBooks': FieldValue.arrayUnion([bookId]),
    });
  }

  void removeFromFavorites(String userId, String bookId) {
    // Отримайте посилання на документ користувача в колекції "users"
    DocumentReference userDocRef = FirebaseFirestore.instance.collection('users').doc(userId);

    // Оновіть дані користувача, видаливши ідентифікатор книги зі списку улюблених
    userDocRef.update({
      'favoriteBooks': FieldValue.arrayRemove([bookId]),
    });
  }
}

