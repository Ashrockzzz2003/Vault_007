import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaultzerozeroseven_marktwo/db/database.dart';
import 'package:vaultzerozeroseven_marktwo/util/add_password.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key, required this.isarService});

  final IsarService isarService;

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
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
                "Add New Password",
                style: GoogleFonts.raleway(
                    color: Theme.of(context).colorScheme.onSurface),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: AddPasswordForm(
              isarService: widget.isarService,
            ),
          )
        ],
      ),
    );
  }
}
