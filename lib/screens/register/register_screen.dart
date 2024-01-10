// Material.dart adalah library yang berisi widget yang sering digunakan
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tugasakhirmobile/screens/login/login_screen.dart';
import 'package:tugasakhirmobile/viewmodel/auth_viewmodel.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final retypePasswordController = TextEditingController();
  final namaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
    namaController.dispose();
    retypePasswordController.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    return Scaffold(
        backgroundColor: const Color(0xff345FB4),
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  top: 10,
                  left: 10,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.arrow_left_outlined,
                            color: Colors.white,
                            size: 40,
                          )),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SafeArea(
                        child: SingleChildScrollView(
                            child: Container(
                      height: 650,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40))),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 30),
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
                            const Text("Registrasi akun terlebih dahulu",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff777777))),
                            const SizedBox(height: 30),
                            SizedBox(
                              height: 45,
                              child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (final _) =>
                                      FocusScope.of(context)
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
                              height: 30,
                            ),
                            SizedBox(
                              height: 45,
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
                              height: 30,
                            ),
                            SizedBox(
                              height: 45,
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
                              height: 30,
                            ),
                            SizedBox(
                              height: 45,
                              child: TextFormField(
                                  controller: retypePasswordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      fillColor: Colors.grey[200],
                                      filled: true,
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero,
                                      prefixIcon:
                                          const Icon(Icons.lock, size: 15),
                                      hintText: "Masukkan Ulang Password...",
                                      border: const OutlineInputBorder())),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xff345FB4),
                                    ),
                                    onPressed: () async {
                                      if (passwordController.text ==
                                              retypePasswordController.text &&
                                          passwordController.text.isNotEmpty &&
                                          retypePasswordController
                                              .text.isNotEmpty) {
                                        authViewModel.signUpUser(
                                            namaController.text,
                                            usernameController.text,
                                            passwordController.text);
                                      } else if (usernameController
                                              .text.isEmpty &&
                                          namaController.text.isEmpty &&
                                          passwordController.text.isEmpty &&
                                          retypePasswordController
                                              .text.isEmpty) {
                                        await EasyLoading.showError(
                                            "Semua Form Wajib Diisi");
                                      } else if (passwordController.text !=
                                              retypePasswordController.text &&
                                          passwordController.text.isNotEmpty &&
                                          retypePasswordController
                                              .text.isNotEmpty) {
                                        await EasyLoading.showError(
                                            "Password Tidak Sesuai");
                                      }
                                    },
                                    child: const Text("Daftar Akun"))),
                            const SizedBox(
                              height: 30,
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
                )
              ],
            ),
          ),
        ));
  }
}
