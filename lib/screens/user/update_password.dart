import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaultzerozeroseven_marktwo/db/database.dart';
import 'package:vaultzerozeroseven_marktwo/model/passwords.dart';
import 'package:vaultzerozeroseven_marktwo/util/update_password.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen(
      {Key? key, required this.isarService, required this.currentPassword})
      : super(key: key);

  final IsarService isarService;
  final Passwords currentPassword;

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.brightness == Brightness.dark ? Colors.black : Theme.of(context).colorScheme.surface,
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            backgroundColor: Theme.of(context).colorScheme.brightness == Brightness.dark ? Colors.black : Theme.of(context).colorScheme.surface,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "Update Password",
                style: GoogleFonts.raleway(
                    color: Theme.of(context).colorScheme.onSurface),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: UpdatePasswordForm(
              isarService: widget.isarService,
              currentPassword: widget.currentPassword,
            ),
          )
        ],
      ),
    );
  }
}
