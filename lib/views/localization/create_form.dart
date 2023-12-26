// ignore_for_file: constant_identifier_names

mixin CreateForm_LocaleData {
  static const String title = "create_form_title";
  static const String loco_name = "create_form_loco_name";
  static const String loco_number = "create_form_loco_number";
  static const String open_form = "create_form_open_form";
  static const String opening_form = "create_form_opening_form";

  static const Map<String, dynamic> EN = {
    title: "CREATE %a FORM",
    loco_name: "Enter Loco Type",
    loco_number: "Enter Loco Number",
    open_form: "Open Form",
    opening_form: "Opening Form...",
  };

  static const Map<String, dynamic> HI = {
    title: "%a फॉर्म खोलें",
    loco_name: "लोको का प्रकार दर्ज करें",
    loco_number: "लोको का नंबर दर्ज करें",
    open_form: "फॉर्म खोलें",
    opening_form: "फॉर्म खोला जा रहा है...",
  };
}
