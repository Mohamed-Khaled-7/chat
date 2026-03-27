import 'package:chatapp/business_logic/cubit/auth_cubit.dart';
import 'package:chatapp/business_logic/cubit/chat/chat_cubit.dart';
import 'package:chatapp/const/app_router.dart';
import 'package:chatapp/const/constants.dart';
import 'package:chatapp/presentation/views/chatPage.dart';
import 'package:chatapp/presentation/views/register_page.dart';
import 'package:chatapp/presentation/widgets/customButton.dart';
import 'package:chatapp/presentation/widgets/customShowDialog.dart';
import 'package:chatapp/presentation/widgets/customSnakPar.dart';
import 'package:chatapp/presentation/widgets/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class loginView extends StatelessWidget {
  String? email;
  String? pass;
  GlobalKey<FormState> formKey = GlobalKey();
  loginView({super.key});
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
                    'Sign In',
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
                  //SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: customTextField(
                      isSecure: true,
                      Hint: 'Enter your password',
                      Lable: 'Password',
                      onChange: (value) => pass = value,
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
                        customShowDialog(context);
                      }
                      if (state is AuthAuthenticated &&
                          state.authType == AuthType.signIn) {
                        Navigator.pop(context);
                        showSnakBar(
                          context,
                          'Login successfully',
                          Colors.green[700],
                          Icons.done,
                        );
                        context.read<ChatCubit>().getMessages();
                        GoRouter.of(context).push(AppRouter.chat, extra: state.user.email);
                      }
                      if (state is AuthError) {
                        Navigator.pop(context);
                        showSnakBar(
                          context,
                          state.message,
                          Colors.red,
                          Icons.error,
                        );
                      }
                    },
                    child: CustomButton(
                      nameButton: 'Sign In',
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthCubit>().signIn(
                            email: email!,
                            password: pass!,
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      const SizedBox(width: 70),
                      Center(
                        child: Text(
                          'don\'t have an account? ',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            //fontFamily: 'pacifico',
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => {
                          GoRouter.of(context).push(AppRouter.register),
                        },
                        child: Text(
                          'Register',
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
}
