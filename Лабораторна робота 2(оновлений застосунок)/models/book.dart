import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_storage/firebase_storage.dart';

class BookChapter {
  String? id;
  String? numberText;
  String? name;
  String? number;
  String? mainText;

  BookChapter({
    this.numberText,
    this.name,
    this.number,
    this.mainText,
  });

  // Парсинг даних з об'єкта DocumentSnapshot
  BookChapter.fromDocumentSnapshot({required DocumentSnapshot<Map<String, dynamic>> doc}) {
    id = doc.id;
    Map<String, dynamic>? data = doc.data();
    if (data != null) {
      id = data["numberText"];
      name = data["name"];
      number = data["number"];
      mainText = data["mainText"];    
    }
  }
}

class BookModel {
  String? id; // ідентифікаційний номер книги
  String? name; // назва книги
  String? author; // автор
  String? description; // опис
  String? bookID; // номер книги
  String? bookImage; // зображення книги
  double? rating; // рейтинг книги
  bool? isFavorite; // Параметр для визначення чи є книга в списку "Улюблені"
  List<BookChapter>? chapterList;

  BookModel({
    this.id,
    this.name,
    this.author,
    this.description,
    this.bookID,
    this.bookImage,
    this.rating,
    this.chapterList,
    this.isFavorite = false, // Початкове значення isFavorite - false
    //this.dateCompleted,
  });

  BookModel.fromDocumentSnapshot({required DocumentSnapshot<Map<String, dynamic>> doc}) {
    id = doc.id;
    Map<String, dynamic>? data = doc.data();
    if (data != null) {
      name = data["name"];
      author = data["author"];
      description = data["description"];
      bookID = data["bookID"];
      bookImage = data["bookImage"];
      rating = data["rating"];
      isFavorite = data["isFavorite"];
      
      // Отримання списку глав із документа
      if (data["chapterList"] != null) {
        List<dynamic> chapterDataList = data["chapterList"];
        chapterList = chapterDataList.map((chapterData) => BookChapter.fromDocumentSnapshot(doc: chapterData)).toList();
      }
    }
  }

  // Метод для отримання інформації про книгу за її ID
  Future<BookModel?> getBookInfo(String bookId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> bookData = await FirebaseFirestore.instance.collection('books').doc(bookId).get();
      if (bookData.exists) {
        // Отримайте дані про книгу з документу
        BookModel book = BookModel(
          // Ініціалізуйте об'єкт книги з отриманих даних
          // Наприклад:
          name: bookData.get('name'),
          author: bookData.get('author'),
          bookImage: bookData.get('bookImage'),
          rating: bookData.get('rating'),
          isFavorite: bookData.get('isFavorite'),
          // тощо
        );
        return book;
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting book info: $e');
      return null;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'author': author,
      'description': description,
      'bookID': bookID,
      'bookImage': bookImage,
      'rating': rating,
      'isFavorite': isFavorite,
      // Тут ви можете додати інші властивості, якщо вони є
    };
  }

  factory BookModel.fromMap(Map<String, dynamic> map) {
  return BookModel(
    id: map['id'],
    name: map['name'],
    author: map['author'],
    description: map['description'],
    bookID: map['bookID'],
    bookImage: map['bookImage'],
    rating: map['rating'],
    isFavorite: map['isFavorite'],
    // Якщо є ще властивості, ви можете їх додати тут
  );
}
}



//Початковий список книг без бази данних
List<BookModel> booksContent = [
  BookModel(
    bookID: "000001",
    name: "Harry Potter and The Sorcerer's Stone",
    author: "J. K. Rowling",
    bookImage: "assets/images/img_bookIcon.png",
    rating: 4.6,
    description: "some data",
    chapterList: book1Chapters,
    isFavorite: false,
  ),
  BookModel(
    bookID: "000002",
    name: "Harry Potter 2",
    author: "J. K. Rowling",
    bookImage: "assets/images/img_bookIcon.png",
    rating: 4.6,
    description: "some data",
    isFavorite: false,
  ),
  BookModel(
    bookID: "000003",
    name: "Harry Potter 3",
    author: "J. K. Rowling",
    bookImage: "assets/images/img_bookIcon.png",
    rating: 4.6,
    description: "some data",
    isFavorite: false,
  ),
  BookModel(
    bookID: "000004",
    name: "Percy Jackson and The Lightning Thief",
    author: "Rick Riordan",
    bookImage: "assets/images/img_bookIcon.png",
    rating: 4.6,
    description: "some data",
    isFavorite: false,
  ),
  BookModel(
    bookID: "000005",
    name: "Percy Jackson 2",
    author: "Rick Riordan",
    bookImage: "assets/images/img_bookIcon.png",
    rating: 4.6,
    description: "some data",
    isFavorite: false,
  ),
  BookModel(
    bookID: "000006",
    name: "Percy Jackson 3",
    author: "Rick Riordan",
    bookImage: "assets/images/img_bookIcon.png",
    rating: 4.6,
    description: "some data",
    isFavorite: false,
  ),
];

List<BookChapter> book1Chapters = [
  BookChapter(
    numberText: "Chapter 1:", 
    name: "The Boy Who Lived", 
    number: "1", 
    mainText: "Містер і місіс Дурслі, що жили в будинку номер чотири на вуличці Прівіт-драйв, пишалися тим, що були, слава Богу, абсолютно нормальними. Кого-кого, але тільки не їх можна було б запідозрити, що вони пов'язані з таємницями чи дивами, бо такими дурницями вони не цікавилися. Містер Дурслі керував фірмою Ґраннінґс, яка виготовляла свердла. То був такий дебелий чолов'яга, що, здається, й шиї не мав, зате його обличчя прикрашали пишні вуса. Натомість місіс Дурслі була худорлява, білява, а її шия була майже вдвічі довша, ніж у звичайних людей, і це ставало їй у великій пригоді: надто вже вона полюбляла зазирати через паркан, підглядаючи за сусідами. Подружжя Дурслі мало синочка Дадлі, що був, на думку батьків, найкращим у світі. Дурслі мали все, що хотіли, а до того ж і один секрет, і найдужче вони боялися, що хтось довідається про нього. Їм здавалося, що вони помруть, коли хтось почує про Поттерів. Місіс Поттер була сестрою місіс Дурслі, але вони не бачились уже кілька років. Місіс Дурслі вдавала, ніби взагалі не має сестри, бо сестра та її нікчема-чоловік були повною протилежністю Дурслі. Подружжя Дурслі тремтіло на саму думку про те, що сказали б сусіди, побачивши Поттерів на вулиці. Дурслі знали, що й Поттери мають сина, але ніколи його не бачили. Той хлопчик був ще однією причиною не знатися з Поттерами: Дурслі не хотіли, щоб їхній Дадлі спілкувався з такими дітьми"),
  BookChapter(numberText: "Chapter 2:", name: "The Vanishing Glass", number: "2"),
  BookChapter(numberText: "Chapter 3:", name: "The Letters from no one", number: "3"),
  BookChapter(numberText: "Chapter 4:", name: "The Keeper of The Keys", number: "4"),
  BookChapter(numberText: "Chapter 5:", name: "Diagon Alley", number: "5"),
  // Додайте інші глави за необхідності
];

