import 'package:flutter/material.dart';
import 'package:vault_007_3/database/database.dart';
import 'package:vault_007_3/model/passwords.dart';
import 'package:vault_007_3/util/update_password_form.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key, required this.isarService, required this.currentPassword});

  final IsarService isarService;
  final Passwords currentPassword;

  @override
  UpdatePasswordState createState() => UpdatePasswordState();
}

class UpdatePasswordState extends State<UpdatePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          // AppBar
          SliverAppBar.medium(
            leading: IconButton(
              onPressed: () {Navigator.of(context).pop();},
              icon: const Icon(
                Icons.close,
                color: Color(0xffe3e3e3),
              ),
            ),
            title: const Text(
              "Update Password",
              style: TextStyle(color: Color(0xffe3e3e3)),
            ),
          ),

          // main App UI
          SliverToBoxAdapter(
            child: UpdatePasswordForm(isarService: widget.isarService, currentPassword: widget.currentPassword,),
          )
        ],
      ),
    );
  }
}