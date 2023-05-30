import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/history_model.dart';

class DatabaseService {
  final _firestoreInstance = FirebaseFirestore.instance;

  // Added Singleton pattern instance
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

  Future<void> delete(HistoryModel historyModel) async {
    QuerySnapshot querySnapshot = await _firestoreInstance
        .collection('history')
        .where('id', isEqualTo: historyModel.id)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      await _firestoreInstance.collection('history').doc(querySnapshot.docs.first.id).delete();
    }
  }
}



// class DatabaseService {
//   final _firebaseAuth = FirebaseAuth.instance;
//   final _firestore = FirebaseFirestore.instance;
//
//   Future<void> createUser(String email, String password) async {
//     try {
//       await _firebaseAuth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//     } on FirebaseAuthException catch (e) {
//       // handle exception
//       print(e.message);
//     }
//   }
//
//   Future<void> signIn(String email, String password) async {
//     try {
//       await _firebaseAuth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//     } on FirebaseAuthException catch (e) {
//       // handle exception
//       print(e.message);
//     }
//   }
//
//   Future<void> signOut() async {
//     await _firebaseAuth.signOut();
//   }
//
//   Future<void> create(HistoryModel historyModel) async {
//     try {
//       User? user = _firebaseAuth.currentUser;
//       if (user != null) {
//         await _firestore.collection(user.uid).add(historyModel.toMap());
//       }
//     } on FirebaseException catch (e) {
//       // handle exception
//       print(e.message);
//     }
//   }
//
//   Future<List<HistoryModel>> readAll() async {
//     User? user = _firebaseAuth.currentUser;
//     if (user != null) {
//       QuerySnapshot querySnapshot = await _firestore.collection(user.uid).get();
//       return querySnapshot.docs.map((doc) => HistoryModel.fromMap(doc.data())).toList();
//     }
//     return [];
//   }
// }
