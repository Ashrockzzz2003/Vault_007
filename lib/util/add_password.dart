import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaultzerozeroseven_marktwo/db/database.dart';
import 'package:vaultzerozeroseven_marktwo/model/passwords.dart';
import 'package:vaultzerozeroseven_marktwo/util/crypto.dart';

class AddPasswordForm extends StatefulWidget {
  const AddPasswordForm({Key? key, required this.isarService})
      : super(key: key);

  final IsarService isarService;

  @override
  State<AddPasswordForm> createState() => _AddPasswordFormState();
}

class _AddPasswordFormState extends State<AddPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  String hint = "";

  final TextEditingController _titleNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _hintController = TextEditingController();

  int _selectedIndex = 0;
  final List<String> _options = ["I have a password", "Autogenerate"];

  Widget _buildChips() {
    List<Widget> chips = [];
    for (int i = 0; i < _options.length; i++) {
      ChoiceChip choiceChip = ChoiceChip(
        checkmarkColor: Theme.of(context).brightness == Brightness.light
            ? Theme.of(context).colorScheme.onSecondaryContainer
            : Theme.of(context).colorScheme.onPrimary,
        selected: _selectedIndex == i,
        label: _selectedIndex == i
            ? Text(_options[i],
                style: GoogleFonts.lato(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Theme.of(context).colorScheme.onSecondaryContainer
                      : Theme.of(context).colorScheme.secondaryContainer,
                ))
            : Text(
                _options[i],
                style: GoogleFonts.lato(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Theme.of(context).colorScheme.onSecondaryContainer
                      : Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
        elevation: 3,
        pressElevation: 3,
        selectedColor: Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).colorScheme.onPrimaryContainer
            : Theme.of(context).colorScheme.secondaryContainer,
        onSelected: (bool selected) {
          setState(() {
            if (_selectedIndex == 1) {
              _hintController.clear();
              // _passwordController.clear();
            }
            _selectedIndex = i;
          });
        },
      );
      chips.add(choiceChip);
      chips.add(const SizedBox(
        width: 10,
      ));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: chips,
      ),
    );
  }

  _addData() {
    setState(() {
      final newPassword = Passwords()
        ..serviceName = _titleNameController.text.trim().replaceFirst(
            _titleNameController.text[0],
            _titleNameController.text[0].toUpperCase())
        ..userName = _userNameController.text.trim()
        ..password = Crypto().encryptMyData(_passwordController.text)
        ..createdAt = DateTime.now()
        ..updatedAt = DateTime.now()
        ..tags = ["All"]
        ..hint = _selectedIndex == 1 ? Crypto().encryptMyData(_hintController.text) : null
        ..isAutoGenerated = _selectedIndex == 1;

      widget.isarService.createPassword(newPassword);
      Fluttertoast.showToast(
        msg: "${newPassword.serviceName}'s Password added successfully!",
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        textColor: Theme.of(context).colorScheme.onSecondaryContainer,
        toastLength: Toast.LENGTH_LONG,
        timeInSecForIosWeb: 1,
        gravity: ToastGravity.BOTTOM,
        fontSize: 14.0,
      );
    });
    Navigator.of(context).pop();
  }

  // Validate Helper Function
  String? _fieldValidator(String? value) {
    if (value == null || value.isEmpty || value.trim().isEmpty) {
      return 'Field can\'t be empty!';
    }
    return null;
  }

  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              keyboardType: TextInputType.name,
              style: GoogleFonts.raleway(),
              controller: _titleNameController,
              validator: _fieldValidator,
              decoration: InputDecoration(
                labelText: "Site or App name",
                prefixIcon: const Icon(Icons.temple_hindu_rounded),
                hintText: "Enter Site or App name",
                helperText:
                    "The site/app for which you are storing the password.\neg. Instagram, Google, WhatsApp...",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onPrimaryContainer),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onPrimaryContainer),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onErrorContainer),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onErrorContainer),
                ),
                labelStyle: GoogleFonts.raleway(),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              keyboardType: TextInputType.name,
              style: GoogleFonts.raleway(),
              controller: _userNameController,
              validator: _fieldValidator,
              decoration: InputDecoration(
                labelText: "Username",
                prefixIcon: const Icon(Icons.person_rounded),
                hintText: "Enter your Username",
                helperText: "The username/ID you use in that app",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onPrimaryContainer),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onPrimaryContainer),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onErrorContainer),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onErrorContainer),
                ),
                labelStyle: GoogleFonts.raleway(),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            _buildChips(),
            if (_selectedIndex == 0) ...[
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                keyboardType: TextInputType.name,
                style: GoogleFonts.sourceCodePro(),
                obscureText: _isObscure,
                controller: _passwordController,
                validator: _fieldValidator,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.lock_rounded),
                  hintText: "Enter your password",
                  helperText:
                      "Make sure that you are saving your current password.",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        color:
                            Theme.of(context).colorScheme.onPrimaryContainer),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        color:
                            Theme.of(context).colorScheme.onPrimaryContainer),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onErrorContainer),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onErrorContainer),
                  ),
                  labelStyle: GoogleFonts.raleway(),
                  suffixIcon: IconButton(
                      icon: Icon(
                        !_isObscure ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      }),
                ),
              ),
            ] else if (_selectedIndex == 1) ...[
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                keyboardType: TextInputType.name,
                style: GoogleFonts.raleway(),
                controller: _hintController,
                validator: _selectedIndex == 1 ? _fieldValidator : null,
                onChanged: (String hintDone) {
                  setState(() {
                    hint = hintDone;
                    _passwordController.text = Crypto().generatePassword(hint);
                  });
                },
                decoration: InputDecoration(
                  labelText: "Hint",
                  prefixIcon: const Icon(Icons.tips_and_updates_rounded),
                  helperText: "Enter a hint to Generate Password.",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        color:
                            Theme.of(context).colorScheme.onPrimaryContainer),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        color:
                            Theme.of(context).colorScheme.onPrimaryContainer),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onErrorContainer),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onErrorContainer),
                  ),
                  labelStyle: GoogleFonts.raleway(),
                ),
              ),
              if (hint.isNotEmpty) ...[
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  key: Key(hint),
                  style: GoogleFonts.sourceCodePro(),
                  obscureText: _isObscure,
                  controller: _passwordController,
                  validator: _fieldValidator,
                  decoration: InputDecoration(
                    labelText: "Autogenerated Password",
                    prefixIcon: const Icon(Icons.lock_rounded),
                    hintText: "Enter your password",
                    helperText:
                        "Make sure that you are saving your current password.",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).colorScheme.onErrorContainer),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).colorScheme.onErrorContainer),
                    ),
                    labelStyle: GoogleFonts.raleway(),
                    suffixIcon: IconButton(
                        icon: Icon(
                          !_isObscure ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        }),
                  ),
                ),
              ]
            ],
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async => {
                  if (_formKey.currentState!.validate())
                    {
                      if (await widget.isarService
                          .isNew(_titleNameController.text.trim()))
                        {_addData()}
                      else
                        {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                actionsAlignment: MainAxisAlignment.center,
                                icon: const Icon(
                                    Icons.notification_important_rounded),
                                title: Text(
                                  'Alert',
                                  style: GoogleFonts.raleway(),
                                ),
                                content: Text(
                                  "Password already exists for ${_titleNameController.text.trim().replaceFirst(_titleNameController.text[0], _titleNameController.text[0].toUpperCase())}. Please use a different name.",
                                  style: GoogleFonts.raleway(),
                                  textAlign: TextAlign.center,
                                ),
                                actionsOverflowAlignment:
                                    OverflowBarAlignment.center,
                                actions: <Widget>[
                                  FilledButton.tonal(
                                    child: Text(
                                      'Okay',
                                      style: GoogleFonts.raleway(),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          )
                        }
                    }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 8.0),
                  child: Text(
                    "Add Password",
                    style: GoogleFonts.raleway(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}