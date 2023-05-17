import '../models/form_model.dart';

abstract class FormRepository {
  void insertForm(FormModel form);

  Future deleteForm(FormModel form);

  Future<List<dynamic>> getForms();
}
