// Виджет для панелі пошуку
import 'package:flutter/material.dart';

class SearchingPanel extends StatelessWidget {
  final Size size;
  final TextEditingController searchController;
  final Function(String) onTextChanged;

  const SearchingPanel({
    required this.size,
    required this.searchController,
    required this.onTextChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(size.height * 0.05),
      child: Container(
        width: size.width * 0.9,
        height: size.height * 0.07,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(size.height * 0.05),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: constraints.maxHeight * 0.9,
                  width: constraints.maxWidth * 0.2,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Icon(
                      Icons.search,
                      size: 30,
                      color: Colors.black.withOpacity(0.4),
                    ),
                  ),
                ),
                Container(
                  width: constraints.maxWidth * 0.6,
                  height: constraints.maxHeight,
                  child: TextField(
                    controller: searchController, // Підключаємо контролер
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      filled: false,
                      hintText: "Search by Title, Author",
                    ),
                    cursorColor: Colors.black45,
                    onChanged: (value) {
                      // Викликаємо функцію onTextChanged при зміні тексту
                      onTextChanged(value);
                    },
                  ),
                ),
                Container(
                  height: constraints.maxHeight * 0.9,
                  width: constraints.maxWidth * 0.192,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Icon(
                      Icons.filter_list,
                      size: 30,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}