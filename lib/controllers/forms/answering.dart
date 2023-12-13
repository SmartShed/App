import '../../models/full_form.dart';
import '../../models/question.dart';
import '../../models/sub_form.dart';
import '../../utils/api/form_anwer.dart';
import '../logger/log.dart';
import '../toast/toast.dart';

class FormAnsweringController {
  static final _logger = LoggerService.getLogger('FormAnsweringController');
  static final FormsAnswerAPIHandler _formsAnswerAPIHandler =
      FormsAnswerAPIHandler();

  static Future<Map<String, dynamic>> saveForm(SmartShedForm form) async {
    _logger.info('Saving form');

    List<Map<String, dynamic>> answers = [];

    for (SmartShedQuestion question in form.questions) {
      if (question.ans == null) continue;
      answers.add({
        'question_id': question.id,
        'answer': question.ans,
      });
    }

    for (SmartShedSubForm subForm in form.subForms) {
      for (SmartShedQuestion question in subForm.questions) {
        if (question.ans == null) continue;
        answers.add({
          'question_id': question.id,
          'answer': question.ans,
        });
      }
    }

    Map<String, dynamic> response =
        await _formsAnswerAPIHandler.saveForm(form.id, answers);

    if (response['status'] == 'success') {
      _logger.info('Form saved successfully');
      ToastController.success('Form saved successfully');
    } else {
      _logger.error('Error saving form');
      ToastController.error('Error saving form');
    }

    return response;
  }

  static Future<Map<String, dynamic>> submitForm(SmartShedForm form) async {
    _logger.info('Submitting form');

    List<Map<String, dynamic>> answers = [];

    for (SmartShedQuestion question in form.questions) {
      answers.add({
        'question_id': question.id,
        'answer': question.ans ?? '',
      });
    }

    for (SmartShedSubForm subForm in form.subForms) {
      for (SmartShedQuestion question in subForm.questions) {
        answers.add({
          'question_id': question.id,
          'answer': question.ans ?? '',
        });
      }
    }

    Map<String, dynamic> response =
        await _formsAnswerAPIHandler.submitForm(form.id, answers);

    if (response['status'] == 'success') {
      _logger.info('Form submitted successfully');
      ToastController.success('Form submitted successfully');
    } else {
      _logger.error('Error submitting form');
      ToastController.error('Error submitting form');
    }

    return response;
  }
}
