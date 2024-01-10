// Material.dart adalah library yang berisi widget yang sering digunakan
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tugasakhirmobile/screens/register/register_screen.dart';
import 'package:tugasakhirmobile/viewmodel/auth_viewmodel.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isFocus = false;

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
    _formKey.currentState?.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    return KeyboardDismissOnTap(
      child: Scaffold(
          backgroundColor: const Color(0xff345FB4),
          body: Form(
            key: _formKey,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SafeArea(
                        child: SingleChildScrollView(
                            child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40))),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 30.0, right: 30, top: 30),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Hi Student",
                              style: TextStyle(
                                  fontSize: 34, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text("Silahkan login untuk lanjut",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff777777))),
                            const SizedBox(height: 30),
                            const Text("Username"),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              height: 40,
                              child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (final _) =>
                                      FocusScope.of(context)
                                          .nextFocus(), // focus to next
                                  controller: usernameController,
                                  decoration: InputDecoration(
                                      fillColor: Colors.grey[200],
                                      filled: true,
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero,
                                      prefixIcon:
                                          const Icon(Icons.person, size: 15),
                                      hintText: "Masukkan Username...",
                                      border: const OutlineInputBorder())),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text("Password"),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              height: 40,
                              child: TextFormField(
                                  controller: passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      fillColor: Colors.grey[200],
                                      filled: true,
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero,
                                      prefixIcon:
                                          const Icon(Icons.lock, size: 15),
                                      hintText: "Masukkan Password...",
                                      border: const OutlineInputBorder())),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xff345FB4)),
                                    onPressed: () {
                                      authViewModel.signInUser(
                                          usernameController.text
                                              .replaceAll(" ", ""),
                                          passwordController.text
                                              .replaceAll(" ", ""));
                                    },
                                    child: const Text("Sign In"))),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(text: 'Belum Punya Akun? '),
                                    TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () =>
                                            Get.to(const RegisterScreen()),
                                      text: 'Sign Up',
                                      style: const TextStyle(
                                          color: Color(0xff345FB4),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                          )
                          ],
                        ),
                      ),
                    ))),
                  ),
                ),
                // KeyboardVisibilityBuilder(
                //     builder: (final context, final visible) {
                //   if (visible) {
                //     return const SizedBox();
                //   } else {
                //     return Positioned.fill(
                //       top: 0,
                //       child: Align(
                //           alignment: Alignment.topCenter,
                //           child: Image.asset(
                //             "assets/login_screen.png",
                //             width: 400,
                //             height: 400,
                //           )),
                //     );
                //   }
                // })
              ],
            ),
          )),
    );
  }
}
