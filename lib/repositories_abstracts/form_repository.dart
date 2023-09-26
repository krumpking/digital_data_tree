import '../models/form_model.dart';

abstract class FormRepository {
  void insertForm(FormModel form);

  Future deleteForm(FormModel form);

  Future deleteAllForms();

  Future<List<dynamic>> getForms();
}
