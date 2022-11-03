import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:poipoi/Model/GlobalData.dart';
class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final formKey =GlobalKey<FormState>();
  final emailController = TextEditingController();
  @override
  void dispose(){
    emailController.dispose();
    super.dispose();
  }
  void resetPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) =>
          Scaffold(
              appBar: AppBar(
                title: Text('CHANGE PASSWORD', style: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'NotoSans',
                  letterSpacing: 2.0,)),
                centerTitle: true,
                backgroundColor: Colors.black,
              ),
              backgroundColor: Colors.black,
              body: Padding(
                  padding: EdgeInsets.all(16),
                  child: Form(
                      key: formKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Receive an email to\n reset your password,',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 24, color: Colors.white),),
                            SizedBox(height: 20),
                            TextFormField(
                              controller: emailController,
                              cursorColor: Colors.white,
                              style: TextStyle(
                                  color: Colors.white),
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(labelText: 'Email',
                                labelStyle: TextStyle(color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white)),),
                              autovalidateMode: AutovalidateMode
                                  .onUserInteraction,
                              validator: (email) =>
                              email != null && !EmailValidator.validate(email)
                                  ? 'Enter a valid email'
                                  : null,
                            ),
                            SizedBox(height: 20),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size.fromHeight(50),
                              ),
                              icon: Icon(Icons.email_outlined),
                              label: Text(
                                'Change Password',
                                style: TextStyle(fontSize: 24),
                              ),
                              onPressed: () {
                                resetPassword(emailController.text);
                              },
                            )
                          ]
                      )
                  )
              )
          ),
    );
  }
  }

