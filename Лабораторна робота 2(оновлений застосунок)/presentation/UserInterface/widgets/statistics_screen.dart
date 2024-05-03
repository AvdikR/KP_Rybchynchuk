import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StatisticsScreen extends StatelessWidget {
  final String? email;
  final Timestamp? accountCreated;

  const StatisticsScreen({
    Key? key,
    required this.email,
    required this.accountCreated,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String accountCreationDate = '';
    if (accountCreated != null) {
      DateTime dateTime = accountCreated!.toDate();
      accountCreationDate = '${dateTime.day}.${dateTime.month}.${dateTime.year}';
    }
    return Container(
      color: Colors.blueGrey,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Statistics',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          SizedBox(height: 15),
          ListTile(
            title: Text(
              'Email:',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              '$email',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            title: Text(
              'Account was created:',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              accountCreationDate,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}