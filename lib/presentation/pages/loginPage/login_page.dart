import 'package:bsi_general_affair_apps/data/models/users/logins_model.dart';
import 'package:bsi_general_affair_apps/domain/usecases/users_usecases.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../core/services/auth_services.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // Variabel
  final GlobalKey<FormState> _loginForm = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
      Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                width: 400,
                child: Image.asset('assets/images/20944145.jpg'),
              ),
              Consumer<AuthService>(
                builder: (context, authService, child) {
                  return Card(
                    margin: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Form(
                          key: _loginForm,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                  decoration:
                                  const InputDecoration(labelText: 'Username'),
                                  controller: _usernameController,
                                  enableSuggestions: false,
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.trim().length < 4) {
                                      return 'Please enter at least 4 characters.';
                                    }
                                    return null;
                                  },
                                ),
                              TextFormField(
                                decoration:
                                const InputDecoration(labelText: 'Password'),
                                controller: _passwordController,
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.trim().length < 6) {
                                    return 'Password must be at least 6 characters long.';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 12),
                              if (authService.getIsAuthenticating())
                                const CircularProgressIndicator(),
                              if (!authService.getIsAuthenticating())
                                ElevatedButton(
                                  onPressed: () async {
                                    if (_loginForm.currentState!.validate()){
                                      LoginsModel loginsData = LoginsModel(
                                          userUsername: _usernameController.text, userPassword: _passwordController.text
                                      );
                                      UsersUseCases().postUserLoginData(loginsModel: loginsData, context: context);
                                      _usernameController.text = "";
                                      _passwordController.text = "";
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                  ), child: const Text('Login'),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
