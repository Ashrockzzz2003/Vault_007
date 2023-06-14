import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaultzerozeroseven_marktwo/db/database.dart';
import 'package:vaultzerozeroseven_marktwo/model/passwords.dart';
import 'package:vaultzerozeroseven_marktwo/screens/user/update_password.dart';
import 'package:vaultzerozeroseven_marktwo/util/crypto.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomListTile extends StatefulWidget {
  const CustomListTile(
      {Key? key,
      required this.isarService,
      required this.password,
      required this.isFirst,
      required this.isLast,
      required this.isOnlyOne})
      : super(key: key);

  final Passwords password;
  final IsarService isarService;
  final bool isFirst;
  final bool isLast;
  final bool isOnlyOne;

  @override
  CustomListTileState createState() => CustomListTileState();
}

class CustomListTileState extends State<CustomListTile> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UpdatePasswordScreen(
                      isarService: widget.isarService,
                      currentPassword: widget.password)));
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? const Color.fromRGBO(27, 28, 28, 1)
                : Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: widget.isFirst
                ? const BorderRadius.only(
                    topLeft: Radius.circular(32), topRight: Radius.circular(32))
                : widget.isLast
                    ? const BorderRadius.only(
                        bottomLeft: Radius.circular(32),
                        bottomRight: Radius.circular(32))
                    : widget.isOnlyOne
                        ? BorderRadius.circular(32)
                        : BorderRadius.zero,
          ),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            leading: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.brightness ==
                          Brightness.dark
                      ? Theme.of(context).colorScheme.onPrimaryContainer
                      : Theme.of(context).colorScheme.onPrimaryContainer,
                  shape: BoxShape.circle),
              child: Center(
                child: Text(
                  widget.password.serviceName![0].toUpperCase(),
                  style: GoogleFonts.lato(
                      textStyle: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.merge(TextStyle(
                            color: Theme.of(context).brightness ==
                                    Brightness.dark
                                ? Theme.of(context).colorScheme.primaryContainer
                                : Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                            fontWeight: FontWeight.w500,
                          ))),
                ),
              ),
            ),
            title: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                Center(
                  child: Text(
                    widget.password.serviceName.toString().replaceFirst(
                        widget.password.serviceName.toString()[0],
                        widget.password.serviceName
                            .toString()[0]
                            .toUpperCase()),
                    style: GoogleFonts.raleway(
                      color: Theme.of(context).colorScheme.brightness ==
                              Brightness.dark
                          ? null
                          : Theme.of(context).colorScheme.onPrimaryContainer,
                      textStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Divider(
                  color: Theme.of(context).colorScheme.brightness ==
                          Brightness.dark
                      ? Theme.of(context).colorScheme.onSurfaceVariant
                      : Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ],
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Theme.of(context).colorScheme.brightness ==
                            Brightness.dark
                        ? Theme.of(context).colorScheme.onSurfaceVariant
                        : Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdatePasswordScreen(
                                isarService: widget.isarService,
                                currentPassword: widget.password)));
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xffFFB4A3)
                        : Theme.of(context).colorScheme.onErrorContainer,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          actionsAlignment: MainAxisAlignment.center,
                          icon: const Icon(Icons.delete_forever_rounded),
                          title: Text(
                            'Confirm Delete',
                            style: GoogleFonts.raleway(),
                          ),
                          content: Text(
                            "Are you sure you want to delete ${widget.password.serviceName}'s password?",
                            style: GoogleFonts.raleway(),
                            textAlign: TextAlign.center,
                          ),
                          actions: <Widget>[
                            FilledButton.tonal(
                              child: Text(
                                'Cancel',
                                style: GoogleFonts.raleway(),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            FilledButton.tonal(
                              child: Text(
                                'Delete',
                                style: GoogleFonts.raleway(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onErrorContainer),
                              ),
                              onPressed: () {
                                setState(() {
                                  setState(() {
                                    widget.isarService
                                        .deletePassword(widget.password.id);
                                  });
                                  Navigator.of(context).pop();
                                });
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.copy,
                    color: Theme.of(context).colorScheme.brightness ==
                            Brightness.dark
                        ? Theme.of(context).colorScheme.onSurfaceVariant
                        : Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(
                            text: Crypto().decryptMyData(
                                widget.password.password.toString())))
                        .then((result) {
                      Fluttertoast.showToast(
                        msg:
                            "${widget.password.serviceName}'s Password Copied to Clipboard!",
                        backgroundColor:
                            Theme.of(context).colorScheme.secondaryContainer,
                        textColor:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                        toastLength: Toast.LENGTH_LONG,
                        timeInSecForIosWeb: 1,
                        gravity: ToastGravity.BOTTOM,
                        fontSize: 14.0,
                      );
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
