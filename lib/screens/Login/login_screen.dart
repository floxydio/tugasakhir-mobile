// Material.dart adalah library yang berisi widget yang sering digunakan
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugasakhirmobile/repovm/auth_repository.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthRepository>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 74, left: 20, right: 20),
        child: SizedBox(
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
                onPressed: () {
                  authViewModel.loginUser(context, usernameController.text,
                      passwordController.text);
                },
                child: Text("Masuk"))),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 75,
            ),
            Center(child: Image.asset("assets/logo.png")),
            SizedBox(height: 20),
            Center(
                child: Text("Login",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
            SizedBox(height: 30),
            Text("Username"),
            SizedBox(
              height: 5,
            ),
            TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                    hintText: "Input your Username",
                    border: OutlineInputBorder())),
            SizedBox(
              height: 20,
            ),
            Text("Password"),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Input your Password",
                    border: OutlineInputBorder())),
          ],
        ),
      ))),
    );
  }
}
