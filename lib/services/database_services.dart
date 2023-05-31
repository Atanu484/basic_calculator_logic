import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/history_model.dart';

class DatabaseService {
  final _firestoreInstance = FirebaseFirestore.instance;

  static final DatabaseService instance = DatabaseService._();
  DatabaseService._();

  Future<void> create(HistoryModel historyModel) async {
    await _firestoreInstance.collection('history').add(historyModel.toMap());
  }

  Future<List<HistoryModel>> readAll() async {
    QuerySnapshot querySnapshot = await _firestoreInstance.collection('history').get();
    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs
          .map((doc) => HistoryModel.fromMap(doc.data() as Map<String, dynamic>))  // Adjusted to Map<String, dynamic>
          .toList();
    }
    return [];
  }
}
