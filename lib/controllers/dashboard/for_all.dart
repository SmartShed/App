import 'dart:math';

import '../../models/section.dart';
import '../../models/form.dart';

// Dummy data
import '../../dummy/data.dart';

class DashboardForAllController {
  static Future<void> init() async {
    // Initialize any required data
  }

  static Future<List<SmartShedSection>> getSections() async {
    return await Future.delayed(Duration(milliseconds: Random().nextInt(2000)),
        () {
      return DummyData.getSections();
    });
  }

  static Future<List<SmartShedForm>> getFormsForSection(
      String sectionId) async {
    return await Future.delayed(Duration(milliseconds: Random().nextInt(2000)),
        () {
      return DummyData.getFormsForSection(sectionId);
    });
  }
}
