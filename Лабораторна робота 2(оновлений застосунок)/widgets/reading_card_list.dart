//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:what_u_cread/models/book.dart';
import 'package:what_u_cread/models/userModel.dart';
import 'package:what_u_cread/widgets/book_rating.dart';
import 'package:what_u_cread/widgets/two_side_rounded_button.dart';

class ReadingListCard extends StatefulWidget {
  final BookModel book;
  final Function pressDetails;
  final Function pressRead;
  final String userId;

  const ReadingListCard({
    Key? key,
    required this.book,
    required this.pressDetails,
    required this.pressRead,
    required this.userId,
  }) : super(key: key);

  @override
  State<ReadingListCard> createState() => _ReadingListCardState();
}

class _ReadingListCardState extends State<ReadingListCard> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    // Перевірка, чи книга вже є у списку улюблених користувача 
    getFavoriteStatus(); // Виклик методу
  }

  // Отримання статусу улюблення книги
  Future<void> getFavoriteStatus() async {
    bool favoriteStatus = await UserModel().isBookInFavorites(widget.userId, widget.book);
    setState(() {
      isFavorite = favoriteStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 21, bottom: 40),
      height: 241,
      width: 190,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 20,
            left: 0,
            right: 3,
            child: Container(
              height: 225,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 5,
                    color: Color.fromARGB(255, 100, 99, 99).withOpacity(.50),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: 5,
            child: Column(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    // Зміна стану кнопки залежно від того додана книга до списку чи ні
                    setState((){
                      // Якщо книга не є улюбленою, робиться улюбленою, і навпаки
                      isFavorite = !isFavorite; // зміна стану кнопки "зірочки"
                    });
                    if (isFavorite) {
                      UserModel().addToFavorites(widget.userId, widget.book);
                    } else {
                      UserModel().removeFromFavorites(widget.userId, widget.book);
                    }
                  },
                  icon: Icon(
                    Icons.stars_sharp,
                    size: 30,
                  ),
                  color: isFavorite == true ? const Color.fromARGB(255, 255, 216, 59) : null,
                ),
                BookRating(score: widget.book.rating),
              ],
            ),
          ),
          Image.asset(
            widget.book.bookImage!,
            width: 140,
            height: 140,
          ),
          Positioned(
            top: 145,
            child: Container(
              height: 76,
              width: 188,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 24),
                    child: RichText(
                      maxLines: 2,
                      text: TextSpan(
                        style: TextStyle(color: Colors.black87),
                        children: [
                          TextSpan(
                            text: "${widget.book.name!.length <= 16 ? widget.book.name : widget.book.name!.substring(0, 16) + "..."}\n",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: "${widget.book.author}",
                            style: TextStyle(
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => widget.pressDetails(),
                        child: Container(
                          width: 101,
                          padding: EdgeInsets.symmetric(vertical: 2),
                          alignment: Alignment.center,
                          child: Text("Details"),
                        ),
                      ),
                      Expanded(
                        child: TwoSideRoundedButton(
                          text: "Read",
                          radius: 29,
                          press: () => widget.pressRead(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}