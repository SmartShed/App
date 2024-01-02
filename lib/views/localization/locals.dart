// ignore_for_file: constant_identifier_names

import 'package:flutter_localization/flutter_localization.dart';

import 'approve_forms.dart';
import 'create_form.dart';
import 'dashboard.dart';
import 'drawer.dart';
import 'employees.dart';
import 'form.dart';
import 'logout.dart';
import 'manage_create_form.dart';
import 'manage_create_section.dart';
import 'manage_forms.dart';
import 'manage_manage_form.dart';
import 'notifications.dart';
import 'profile.dart';
import 'search.dart';
import 'section.dart';
import 'settings.dart';
import 'toast.dart';

class Locale {
  static const String en = "en";
  static const String hi = "hi";
}

const List<MapLocale> LOCALES = [
  MapLocale(Locale.en, LocaleData.EN),
  MapLocale(Locale.hi, LocaleData.HI),
];

mixin LocaleData {
  static const Map<String, dynamic> EN = {
    ...ApproveForms_LocaleData.EN,
    ...CreateForm_LocaleData.EN,
    ...Dashboard_LocaleData.EN,
    ...Drawer_LocaleData.EN,
    ...Employees_LocaleData.EN,
    ...Form_LocaleData.EN,
    ...Logout_LocaleData.EN,
    ...Manage_CreateForm_LocaleData.EN,
    ...Manage_CreateSection_LocaleData.EN,
    ...ManageForms_LocaleData.EN,
    ...Manage_ManageForm_LocaleData.EN,
    ...Notifications_LocaleData.EN,
    ...Profile_LocaleData.EN,
    ...Search_LocaleData.EN,
    ...Section_LocaleData.EN,
    ...Settings_LocaleData.EN,
    ...Toast_LocaleData.EN,
  };

  static const Map<String, dynamic> HI = {
    ...ApproveForms_LocaleData.HI,
    ...CreateForm_LocaleData.HI,
    ...Dashboard_LocaleData.HI,
    ...Drawer_LocaleData.HI,
    ...Employees_LocaleData.HI,
    ...Form_LocaleData.HI,
    ...Logout_LocaleData.HI,
    ...Manage_CreateForm_LocaleData.HI,
    ...Manage_CreateSection_LocaleData.HI,
    ...ManageForms_LocaleData.HI,
    ...Manage_ManageForm_LocaleData.HI,
    ...Notifications_LocaleData.HI,
    ...Profile_LocaleData.HI,
    ...Search_LocaleData.HI,
    ...Section_LocaleData.HI,
    ...Settings_LocaleData.HI,
    ...Toast_LocaleData.HI,
  };
}
