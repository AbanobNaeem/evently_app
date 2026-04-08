import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/models/event_model.dart';
import 'package:evently_app/utils/collection_name.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_data_model.dart';


class FirebaseUtils {
  static CollectionReference<EventModel> getUserEventsCollection() {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection(CollectionName.usersCollection)
        .doc(userId)
        .collection(CollectionName.eventsCollection)
        .withConverter<EventModel>(
      fromFirestore: (snapshot, options) =>
          EventModel.fromFirestore(snapshot.data()!),
      toFirestore: (event, options) => event.toFirestore(),
    );
  }

  static DocumentReference<UserDataModel> getUserDataCollection() {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection(CollectionName.usersCollection).doc(userId).withConverter<UserDataModel>(
        fromFirestore: (snapshot, options) => UserDataModel.fromFirestore(snapshot.data()!),
        toFirestore: (data, options) => data.toFirestore(),
     );


}


  static Future<void> addToFireStore(EventModel eventModel) async {
    final eventCollection = getUserEventsCollection();
    final docRef = eventCollection.doc();
    eventModel.eventID = docRef.id;
    await docRef.set(eventModel);
  }


  static Future<void> saveUserData(UserDataModel user) async {
    await getUserDataCollection().set(user);
  }
}