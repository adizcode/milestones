import 'package:cloud_firestore/cloud_firestore.dart' as firebase;
import 'package:milestones/models/milestone.dart';

class DatabaseService {
  String uid;

  DatabaseService(this.uid);

  // Users collection reference
  firebase.CollectionReference users =
      firebase.FirebaseFirestore.instance.collection('users');

  // Create (or update, if doc id is provided) milestone to the milestones collection
  Future<void> setMilestone(
    Map<String, dynamic> milestoneMap, {
    String? id,
  }) async {
    await users.doc(uid).collection('milestones').doc(id).set(milestoneMap);
  }

  // Delete milestone from the milestones collection
  Future<void> deleteMilestone(String id) async {
    await users.doc(uid).collection('milestones').doc(id).delete();
  }

  // Stream of the user's list of milestones
  Stream<List<Milestone>> get milestones {
    return users
        .doc(uid)
        .collection('milestones')
        .snapshots()
        .map(_milestoneFromQuerySnapshot);
  }

  // Helper Method:
  // List of Milestones from a QuerySnapshot (collection)
  List<Milestone> _milestoneFromQuerySnapshot(firebase.QuerySnapshot snapshot) {
    return snapshot.docs.map(_milestoneFromQueryDocSnapshot).toList();
  }

  // Helper Method:
  // Milestone from a Document Query Snapshot (document)
  Milestone _milestoneFromQueryDocSnapshot(
      firebase.QueryDocumentSnapshot queryDocSnapshot) {
    Map milestoneMap = queryDocSnapshot.data() as Map;
    return Milestone(queryDocSnapshot.reference.id, milestoneMap['task']);
  }
}
