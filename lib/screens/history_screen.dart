import 'package:flutter/material.dart';
import '../model/history_model.dart';
import '../services/database_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HistoryScreen extends StatelessWidget {
  final DatabaseService _dbService = DatabaseService.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('History', style: TextStyle(fontSize: 24)),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<List<HistoryModel>>(
        future: _dbService.readAll(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(  // Wrap ListTile with a Card.
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 2,
                  child: ListTile(
                    title: Text(snapshot.data![index].calculation, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    subtitle: Text(snapshot.data![index].timestamp.toIso8601String(), style: TextStyle(color: Colors.grey[600])),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
