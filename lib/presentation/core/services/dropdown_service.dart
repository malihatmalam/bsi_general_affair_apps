import 'package:flutter/widgets.dart';

class DropdownService extends ChangeNotifier{
  String? _selectedStatusApproval;

  void changeStatusApproval(province){
    _selectedStatusApproval = province;
    notifyListeners();
  }

  String? getSelectedStatusApproval() => _selectedStatusApproval;
}