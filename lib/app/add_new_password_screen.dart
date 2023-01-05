import 'package:flutter/material.dart';
import 'package:vault_007_3/database/database.dart';
import 'package:vault_007_3/util/add_new_password_form.dart';

class AddPassword extends StatefulWidget {
  const AddPassword({super.key, required this.isarService});

  final IsarService isarService;

  @override
  AddPasswordState createState() => AddPasswordState();
}

class AddPasswordState extends State<AddPassword> {
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
              "Add Password",
              style: TextStyle(color: Color(0xffe3e3e3)),
            ),
          ),

          // main App UI
          SliverToBoxAdapter(
            child: AddPasswordForm(isarService: widget.isarService,),
          )
        ],
      ),
    );
  }
}