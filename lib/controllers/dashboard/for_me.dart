import 'dart:math';

import '../../models/opened_form.dart';

// Dummy data
import '../../dummy/data.dart';

class DashboardForMeController {
  static Future<void> init() async {
    // Initialize any required data
  }

  static Future<List<OpenedSmartShedForm>> getRecentlyOpenedForms() async {
    return await Future.delayed(Duration(milliseconds: Random().nextInt(2000)),
        () {
      return DummyData.getRecentlyOpenedForms();
    });
  }

  static Future<List<OpenedSmartShedForm>> getRecentlyOpenedFormsByMeForSection(
      String sectionId) async {
    return await Future.delayed(Duration(milliseconds: Random().nextInt(2000)),
        () {
      return DummyData.getRecentlyOpenedFormsByMeForSection(sectionId);
    });
  }

  static Future<List<OpenedSmartShedForm>> getRecentlyOpenedFormsForSection(
      String sectionId) async {
    return await Future.delayed(Duration(milliseconds: Random().nextInt(2000)),
        () {
      return DummyData.getRecentlyOpenedFormsForSection(sectionId);
    });
  }
}
