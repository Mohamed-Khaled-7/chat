import 'package:chatapp/business_logic/cubit/auth_cubit.dart';
import 'package:chatapp/const/constants.dart';
import 'package:chatapp/presentation/widgets/customButton.dart';
import 'package:chatapp/presentation/widgets/customSnakPar.dart';
import 'package:chatapp/presentation/widgets/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class registerView extends StatelessWidget {
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();
  registerView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 22),
        color: primaryColor,
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 23),
                  Center(
                    child: Image.asset(
                      'assets/images/scholar.png',
                      height: 160,
                    ),
                  ),
                  Text(
                    'Scholar chat',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'pacifico',
                    ),
                  ),
                  const SizedBox(height: 99),
                  Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 23,
                      color: Colors.white,
                      fontFamily: 'pacifico',
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: customTextField(
                      isSecure: false,
                      Hint: 'Enter your email',
                      Lable: 'Email',
                      onChange: (value) => email = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }
                        if (!value.contains('@')) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: customTextField(
                      isSecure: true,
                      Hint: 'Enter your password',
                      Lable: 'Password',
                      onChange: (value) => password = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                  ),
                  BlocListener<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthLoading) {
                        showDialgo(context);
                      }
                      if (state is AuthAuthenticated &&
                          state.authType == AuthType.signUp) {
                        Navigator.pop(context);
                        showSnakBar(
                          context,
                          'Registered successfully',
                          Colors.green[700],
                          Icons.done,
                        );
                        Navigator.pop(context);
                      }
                      if (state is AuthError) {
                        Navigator.pop(context);
                      }
                    },
                    child: CustomButton(
                      nameButton: 'Sign Up',
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthCubit>().register(
                            email: email!,
                            password: password!,
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      const SizedBox(width: 83),
                      Center(
                        child: Text(
                          'already have an account? ',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => {Navigator.pop(context)},
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'pacifico',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showDialgo(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          Center(child: SpinKitFadingCircle(color: Colors.white, size: 60.0)),
    );
  }
}
