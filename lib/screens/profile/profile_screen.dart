import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugasakhirmobile/viewmodel/settings_viewmodel.dart';

class ProfilePage extends StatefulWidget {
  final String imageNetwork;
  const ProfilePage({super.key, required this.imageNetwork});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(final BuildContext context) {
    return Consumer<SettingsViewModel>(
        builder: (final context, final settingsVM, final _) {
      return Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff185FA9)),
              onPressed: () {},
              child: const Text("Submit Edit"),
            ),
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    "${settingsVM.getUrlImage}/img-profile/${widget.imageNetwork}",
                    fit: BoxFit.fill,
                    width: 150,
                    height: 150,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: "Nama"),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ))),
      );
    });
  }
}
