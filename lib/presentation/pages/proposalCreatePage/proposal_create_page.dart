import 'package:bsi_general_affair_apps/data/models/proposals/proposals_create_model.dart';
import 'package:bsi_general_affair_apps/domain/usecases/proposals_usecases.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

import '../../../domain/usecases/users_usecases.dart';

class ProposalCreatePage extends StatefulWidget {
  const ProposalCreatePage({super.key});

  @override
  _ProposalCreatePageState createState() {
    return _ProposalCreatePageState();
  }
}

class _ProposalCreatePageState extends State<ProposalCreatePage> {
  // Variable
  GlobalKey<FormState> _createProposalForm = GlobalKey<FormState>();
  TextEditingController _objectiveController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  TextEditingController _requireDateController = TextEditingController();
  TextEditingController _budgetController = TextEditingController();
  var box = Hive.box('userdata');

  @override
  Widget build(BuildContext context) {
    UsersUseCases().checkSession(context: context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Padding(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Create",
                                style: TextStyle(
                                    fontSize: 35, fontWeight: FontWeight.bold,color: Colors.blueAccent)),
                            Text("New Procurement",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold,color: Colors.blueAccent)),
                          ],
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Form(
                      key: _createProposalForm,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.blue.withOpacity(0.1),
                                ),
                                child: Icon(
                                    Icons.drive_file_rename_outline_sharp,
                                    color: Colors.blueAccent,
                                    size: 30),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: _objectiveController,
                                  minLines: 1,
                                  maxLines: 2,
                                  decoration: InputDecoration(
                                    labelText: 'Objective',
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                                  ),
                                  validator: (value) {
                                    if (value!.length == 0) {
                                      return 'Objective tidak boleh kosong!';
                                    }
                                    return null;
                                  },
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.blue.withOpacity(0.1),
                                ),
                                child: Icon(
                                    Icons.description,
                                    color: Colors.blueAccent,
                                    size: 30),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child:
                                TextFormField(
                                  controller: _descriptionController,
                                  minLines: 2,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    labelText: 'Description',
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                                  ),
                                  validator: (value) {
                                    if (value!.length == 0) {
                                      return 'Deskripsi tidak boleh kosong!';
                                    }
                                    return null;
                                  },
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.blue.withOpacity(0.1),
                                ),
                                child: Icon(
                                    Icons.money,
                                    color: Colors.blueAccent,
                                    size: 30),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child:
                                TextFormField(
                                  controller: _budgetController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    RupiahInputFormatter(),
                                  ],
                                  decoration: InputDecoration(
                                    labelText: 'Budget (Rp)',
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                                  ),
                                  validator: (value) {
                                    if (value!.length == 0) {
                                      return 'Budget tidak boleh kosong!';
                                    }
                                    return null;
                                  },
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _requireDateController,
                            readOnly: true,
                            decoration: InputDecoration(
                                labelText: 'Require Date',
                                fillColor: Colors.white,
                                filled: true,
                                prefixIcon: Icon(Icons.calendar_today),
                                enabledBorder: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                border: OutlineInputBorder()),
                            onTap: () {
                              _selectDate();
                            },
                            validator: (value) {
                              if (value!.length == 0) {
                                return 'Budget tidak boleh kosong!';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _noteController,
                            minLines: 2,
                            maxLines: null,
                            decoration: InputDecoration(
                              labelText: 'Note (Optional)',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_createProposalForm.currentState!
                                  .validate()) {
                                print(
                                    'Objective: ${_objectiveController.text},');
                                print(
                                    'Description: ${_descriptionController.text},');
                                print(
                                    'Required: ${_requireDateController.text},');
                                print(
                                    'Budget: ${int.tryParse(_budgetController.text.replaceAll('.', '')) ?? 0},');
                                print('Note: ${_noteController.text},');
                                print(
                                    'Employee Number: ${box.get('employeeNumber')},');

                                ProposalsCreateModel proposalsCreateModel =
                                    ProposalsCreateModel(
                                        employeeIdnumber:
                                            box.get('employeeNumber'),
                                        assetNumber: "",
                                        proposalObjective:
                                            _objectiveController.text,
                                        proposalDescription:
                                            _descriptionController.text,
                                        proposalRequireDate: DateTime.parse(
                                            _requireDateController.text),
                                        proposalBudget: int.tryParse(
                                                _budgetController.text
                                                    .replaceAll('.', '')) ??
                                            0,
                                        proposalNote: _noteController.text,
                                        proposalType: "Procurement");

                                ProposalsUseCases().postProposalCreateData(
                                    proposalsCreateModel);
                                // context.go('/');

                                _objectiveController.text = "";
                                _descriptionController.text = "";
                                _requireDateController.text = "";
                                _budgetController.text = "";
                                _noteController.text = "";

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        backgroundColor: Colors.lightBlueAccent,
                                        content: Text(
                                          'Berhasil mengajukan pengadaan',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )));
                              }
                            },
                            child: Text('Submit Procurement', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50),
                              backgroundColor: Colors.cyan
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ))));
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (_picked != null) {
      setState(() {
        _requireDateController.text = _picked.toString().split(" ")[0];
      });
    }
  }
}

class RupiahInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    int value = int.tryParse(newValue.text.replaceAll('.', '')) ?? 0;
    String formattedValue = _formatAsRupiah(value);

    return newValue.copyWith(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }

  String _formatAsRupiah(int value) {
    String result = '';
    String digits = value.toString();
    int length = digits.length;
    for (int i = 0; i < length; i++) {
      result += digits[length - 1 - i];
      if ((i + 1) % 3 == 0 && i + 1 != length) {
        result += '.';
      }
    }
    return result.split('').reversed.join('');
  }
}
