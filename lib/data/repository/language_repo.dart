import 'package:du_an_1/data/model/response/language_model.dart';
import 'package:flutter/material.dart';
import '../../utils/app_constants.dart';

class LanguageRepo {
  List<LanguageModel> getAllLanguages({required BuildContext context}) {
    return AppConstants.languages;
  }
}
