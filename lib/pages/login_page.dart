import 'package:ecommerce/api_service.dart';
import 'package:ecommerce/utils/ProgressHUD.dart';
import 'package:ecommerce/utils/form_helper.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hidePassword = true;
  bool isApiCallProcess = false;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String username;
  String password;
  APISeervice apiSeervice;

  @override
  void initState() {
    apiSeervice = APISeervice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
      child: _uiSetup(context),
    );
  }

// interfaz del formulario login

  Widget _uiSetup(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                margin:
                    const EdgeInsets.symmetric(vertical: 85, horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 20,
                        color: Theme.of(context).hintColor.withOpacity(0.2),
                        offset: const Offset(0, 10),
                      ),
                    ]),
                child: Form(
                  key: globalKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        "Login",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (input) => username = input,
                        validator: (input) => !input.contains('@')
                            ? "Email Id Should be valid "
                            : null,
                        decoration: InputDecoration(
                            hintText: "Email Address",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor)),
                            prefixIcon: Icon(
                              Icons.email,
                              color: Theme.of(context).colorScheme.primary,
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        style: const TextStyle(color: Colors.black),
                        keyboardType: TextInputType.text,
                        onSaved: (input) => password = input,
                        validator: (input) => input.length < 3
                            ? "Password Should be more than 3 characters"
                            : null,
                        obscureText: hidePassword,
                        decoration: InputDecoration(
                            hintText: "Password",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor)),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              color: Colors.black,
                              icon: Icon(hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            )),
                      ),
                      const SizedBox(height: 30),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 80),
                        ),
                        onPressed: () {
                          if (validateAndSave()) {
                            setState(() {
                              isApiCallProcess = true;
                            });
                            apiSeervice
                                .loginCustomer(username, password)
                                .then((ret) {
                              if (ret != null) {
                                setState(() {
                                  isApiCallProcess = false;
                                });
                                FormHelper.showMessage(
                                  context,
                                  "Woocommerce App",
                                  "Login Success",
                                  "ok",
                                  () {},
                                );
                              } else {
                                FormHelper.showMessage(
                                    context,
                                    "Woocommerce App",
                                    "Invalid Login!!",
                                    "Ok",
                                    () {});
                              }
                            });
                          }
                        },
                        child: const Text(
                          'Iniciar Sesión',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      )),
    );
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
