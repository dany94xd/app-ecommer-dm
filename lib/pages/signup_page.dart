import 'package:ecommerce/api_service.dart';
import 'package:ecommerce/models/customer.dart';
import 'package:ecommerce/utils/ProgressHUD.dart';
import 'package:ecommerce/utils/form_helper.dart';
import 'package:ecommerce/utils/validator_service.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  APISeervice apiSeervice;
  CustomerModel model;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool hidePassword = true;
  bool isApiCallProcess = false;

  @override
  void initState() {
    apiSeervice = APISeervice();
    model = CustomerModel();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        automaticallyImplyLeading: true,
        title: const Text("Sign Up"),
      ),
      body: ProgressHUD(
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
        child: Form(
          key: globalKey,
          child: _formUI(),
        ),
      ),
    );
  }

  /// interfaz del formulario registro

  Widget _formUI() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormHelper.fieldLabel("First Name"),
              FormHelper.textInput(
                  context,
                  model.firstName,
                  (value) => {
                        model.firstName = value,
                      }, onValidate: (value) {
                if (value.toString().isEmpty) {
                  return 'Please enter first name';
                }
                return null;
              }),
              FormHelper.fieldLabel("Last Name"),
              FormHelper.textInput(
                  context,
                  model.lastName,
                  (value) => {
                        model.lastName = value,
                      }, onValidate: (value) {
                if (value.toString().isEmpty) {
                  return 'Please enter the lastname';
                }
                return null;
              }),
              FormHelper.fieldLabel("Email Id"),
              FormHelper.textInput(
                  context,
                  model.email,
                  (value) => {
                        model.email = value,
                      }, onValidate: (value) {
                if (value.toString().isEmpty) {
                  return 'Please enter email Id:';
                }
                if (value.isNotEmpty && !value.toString().isValidEmail()) {
                  return 'Please enter valid email Id';
                }
                return null;
              }),
              FormHelper.fieldLabel("Password"),
              FormHelper.textInput(
                  context,
                  model.password,
                  (value) => {
                        model.password = value,
                      }, onValidate: (value) {
                if (value.toString().isEmpty) {
                  return 'Please enter Password';
                }
                return null;
              },
                  obscureText: hidePassword,
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                      color: Theme.of(context).colorScheme.secondary,
                      icon: Icon(
                        hidePassword ? Icons.visibility_off : Icons.visibility,
                      ))),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: FormHelper.saveButton("Register", () {
                  if (validateAndSave()) {
                    // ignore: avoid_print
                    print(model.toJson());
                    setState(() {
                      isApiCallProcess = true;
                    });

                    apiSeervice.createCustomer(model).then((ret) {
                      setState(() {
                        isApiCallProcess = false;
                      });

                      if (ret) {
                        FormHelper.showMessage(
                          context,
                          "Woocommerce App",
                          "Registartion sucesfull",
                          "Ok",
                          () {
                            Navigator.of(context).pop();
                          },
                        );
                      } else {
                        FormHelper.showMessage(
                          context,
                          "Woocommerce App",
                          "Email Id Already Register",
                          "ok",
                          () {
                            Navigator.of(context).pop();
                          },
                        );
                      }
                    });
                  }
                }),
              ),
            ],
          ),
        ),
      ),
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
