import 'package:flutter/material.dart';
import 'package:what_u_cread/presentation/BookInfoMenu/book_info_screen.dart';

class ReadingBooksScreen extends StatelessWidget {
  const ReadingBooksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: ListView.builder(
        itemCount: 5, // Змініть це на кількість вашої інформації
        itemBuilder: (context, index) {
          return _buildBookItem(
            title: "Book Title",
            author: "Author Name",
            imageUrl: "assets/images/img_bookIcon.png",
            onDelete: () {
              // Додайте код для видалення об'єкта зі списку
            },
            onDetailsPressed: () {
              // Код для відкриття сторінки з інформацією про книгу
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookInfoScreen(
                    // Передайте необхідні дані про книгу
                  ),
                ),
              );
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
    VoidCallback? onDetailsPressed,
  }) {
    return GestureDetector(
      onTap: onDetailsPressed,
      child: Container(
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
              icon: Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }

}