// Material.dart adalah library yang berisi widget yang sering digunakan
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tugasakhirmobile/screens/login/login_screen.dart';
import 'package:tugasakhirmobile/viewmodel/auth_repository.dart';
import 'package:flutter/gestures.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final namaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
    namaController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    final double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: const Color(0xff84A3CF),
        // bottomNavigationBar:
        body: Form(
          key: _formKey,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    "assets/bg.jpg",
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SafeArea(
                      child: SingleChildScrollView(
                          child: Padding(
                    padding: deviceHeight < 600
                        ? const EdgeInsets.only(left: 20, right: 20, bottom: 10)
                        : const EdgeInsets.only(left: 20, right: 20, bottom: 70),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Center(
                          //     child: Image.asset(
                          //   "assets/logo.png",
                          //   width: 100,
                          //   height: 100,
                          // )),
                          const Center(
                              child: Text("Masukkan Akun Kamu",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))),
                          const SizedBox(height: 30),
                          SizedBox(
                            height: 40,
                            child: TextFormField(
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (_) => FocusScope.of(context)
                                    .nextFocus(), // focus to next
                                controller: namaController,
                                decoration: InputDecoration(
                                    fillColor: Colors.grey[200],
                                    filled: true,
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                    prefixIcon:
                                        const Icon(Icons.face, size: 15),
                                    hintText: "Masukkan Nama...",
                                    border: const OutlineInputBorder())),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 40,
                            child: TextFormField(
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (_) => FocusScope.of(context)
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
                              height: 40,
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                  onPressed: () {
                                    authViewModel.loginUser(
                                        context,
                                        usernameController.text,
                                        passwordController.text);
                                  },
                                  child: const Text("Daftar"))),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  const TextSpan(text: 'Sudah Punya Akun? '),
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap =
                                          () => Get.off(const LoginScreen()),
                                    text: 'Sign In',
                                    style: const TextStyle(
                                        color: Color(0xff84A3CF),
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
              )
            ],
          ),
        ));
  }
}
