import 'package:evently_app/models/event_model.dart';
import 'package:evently_app/utils/firebase_utils.dart';
import 'package:flutter/material.dart';

class LoveProvider extends ChangeNotifier {
  LoveProvider() {
    getFavoriteEvents();
  }

  List<EventModel> favEvent = [];
  List<EventModel> searchedEvents = [];
  TextEditingController searchController = TextEditingController();

  Future<void> getFavoriteEvents() async {
    try {
      final snapshot = await FirebaseUtils.getUserEventsCollection().get();
      favEvent = snapshot.docs
          .map((doc) => doc.data())
          .where((event) => event.isFavorite == true)
          .toList();
      searchedEvents = List.of(favEvent);
      notifyListeners();
    } catch (e) {
      print("Error fetching favorite events: $e");
    }
  }

  Future<void> toggleFavorite(EventModel event) async {
    event.isFavorite = !event.isFavorite;
    final docRef = FirebaseUtils.getUserEventsCollection().doc(event.eventID);
    await docRef.update({"isFavorite": event.isFavorite});

    // تحديث الـ list المحلية
    if (event.isFavorite) {
      favEvent.add(event);
    } else {
      favEvent.removeWhere((e) => e.eventID == event.eventID);
    }
    notifyListeners();
  }

  void searchEvents({required String searchEvent}){
    final searchQuery = searchEvent.toLowerCase();
    if (searchQuery.isEmpty){
      searchedEvents = favEvent.toList();
    }else {
      searchedEvents = favEvent.where((event) =>
          event.title.toLowerCase().contains(searchQuery) ||
          event.eventDescription.toLowerCase().contains(searchQuery) ||
          event.eventName.toLowerCase().contains(searchQuery)
      ).toList();
    }
    notifyListeners() ;
  }
}