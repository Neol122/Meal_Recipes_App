import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Add a favorite
  Future<void> addFavorite(String userId, Map<String, dynamic> mealData) async {
    final docRef = _db.collection('users').doc(userId).collection('favorites').doc(mealData['id']);
    await docRef.set(mealData);
  }

  // Remove a favorite
  Future<void> removeFavorite(String userId, String mealId) async {
    final docRef = _db.collection('users').doc(userId).collection('favorites').doc(mealId);
    await docRef.delete();
  }

  // Get all favorites for a user
  Stream<QuerySnapshot> getFavorites(String userId) {
    return _db.collection('users').doc(userId).collection('favorites').snapshots();
  }
}
