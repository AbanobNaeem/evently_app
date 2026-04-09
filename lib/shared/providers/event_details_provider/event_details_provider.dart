import 'package:evently_app/shared/component/navigator_component/navigators.dart';
import 'package:flutter/foundation.dart';

import '../../../utils/firebase_utils.dart';

class EventDetailsProvider extends ChangeNotifier {
  Future<void> deleteEvent(String eventId) async {
    try {
      await FirebaseUtils.deleteEvent(eventId);
      NavigationService.instance.pop(true);
      notifyListeners();
    } catch (e) {
      print("Delete error: $e");
    }
  }
}
