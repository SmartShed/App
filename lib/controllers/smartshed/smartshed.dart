import '../../models/full_unopened_form.dart';
import '../../utils/api/smartshed.dart';
import '../logger/log.dart';

class SmartShedController {
  static final _logger = LoggerService.getLogger('SmartShedController');

  static final _smartShedApiHandler = SmartShedApiHandler();

  static Future<bool> addSection(String sectionName) async {
    _logger.info('Creating section with sectionName: $sectionName');

    final response = await _smartShedApiHandler.addSection(sectionName);

    if (response['status'] == 'success') {
      return true;
    }
    return false;
  }

  static Future<bool> addForm(
    String sectionName,
    String formTitle,
    String descriptionEnglish,
    String descriptionHindi,
  ) async {
    _logger.info(
      'Creating form with sectionName: $sectionName, formName: $formTitle, descriptionEnglish: $descriptionEnglish, descriptionHindi: $descriptionHindi',
    );

    final response = await _smartShedApiHandler.addForm(
      formTitle,
      descriptionHindi,
      descriptionEnglish,
      sectionName,
    );

    if (response['status'] == 'success') {
      return true;
    }
    return false;
  }

  static Future<SmartShedUnopenedFormSubForm?> addSubForm(
    String titleHindi,
    String titleEnglish,
    String note,
    String formID,
  ) async {
    _logger.info(
      'Creating subform with titleEnglish: $titleEnglish, titleHindi: $titleHindi, note: $note, formID: $formID',
    );

    final response = await _smartShedApiHandler.addSubForm(
      titleEnglish,
      titleHindi,
      note,
      formID,
    );

    if (response['status'] == 'success') {
      return SmartShedUnopenedFormSubForm.fromJson(response['subForm']);
    }
    return null;
  }

  static Future<SmartShedUnopenedFormQuestion?> addQuestion(
    String textEnglish,
    String textHindi,
    String ansType,
    String formID,
    String? subFormID,
  ) async {
    String id;

    if (subFormID == null || subFormID.isEmpty) {
      id = formID;
    } else {
      id = subFormID;
    }

    bool isForSubForm = subFormID != null && subFormID.isNotEmpty;

    _logger.info(
      'Creating question with textEnglish: $textEnglish, textHindi: $textHindi, ansType: $ansType, isForSubForm: $isForSubForm, id: $id',
    );

    final response = await _smartShedApiHandler.addQuestion(
      textEnglish,
      textHindi,
      ansType,
      isForSubForm,
      id,
    );

    if (response['status'] == 'success') {
      return SmartShedUnopenedFormQuestion.fromJson(response['question']);
    }
    return null;
  }
}
