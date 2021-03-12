import 'package:ChatTER/widget/pickers/userImagePicker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AuthForm extends StatefulWidget {
  final bool isLoading;
  final void Function(
    String email,
    String username,
    String password,
    String loginName,
    String checkedPassword,
    File image,
    bool _isSignUp,
    BuildContext ctx,
  ) submitFn;
//constructeur

  AuthForm(
    this.submitFn,
    this.isLoading,
  );

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';
  var _userLoginName = '';
  var _userCheckedPassword = '';
  File _userImageFile;
  bool _isSignUp = false;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _formSubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (_userImageFile == null && _isSignUp) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Please pick an image.'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }
    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
        _userEmail.trim(),
        _userName.trim(),
        _userPassword.trim(),
        _userLoginName.trim(),
        _userCheckedPassword.trim(),
        _userImageFile,
        _isSignUp,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(18),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_isSignUp) UserImagePicker(_pickedImage),

                  //Login avec soit l'address mail ou le nom d'utilisateur
                  // if (!_isSignUp)
                  //   TextFormField(
                  //     key: ValueKey('email'),
                  //     validator: (value) {
                  //       if (value.isEmpty)
                  //         return 'No such username or email address';

                  //       return null;
                  //       // if (value.isEmpty || value.length < 4) {
                  //       // }
                  //     },
                  //     onSaved: (value) {
                  //       _userLoginName = value;
                  //     },
                  //     keyboardType: TextInputType.emailAddress,
                  //     decoration: InputDecoration(
                  //       labelText: 'Username or Email address',
                  //     ),
                  //   ),
                  //  if (_isSignUp)
                  TextFormField(
                    key: ValueKey('email'),
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    enableSuggestions: false,
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userEmail = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email address',
                    ),
                  ),
                  if (_isSignUp)
                    TextFormField(
                      key: ValueKey('username'),
                      autocorrect: true,
                      textCapitalization: TextCapitalization.words,
                      enableSuggestions: false,
                      validator: (value) {
                        if (value.isEmpty || value.length < 4) {
                          return 'invalid username';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userName = value;
                      },
                      decoration: InputDecoration(labelText: 'Username'),
                    ),
                  TextFormField(
                    key: ValueKey('Password'),
                    validator: (value) {
                      if (value.isEmpty || value.length < 8) {
                        return 'Password must be at least 8 characters long.';
                      }
                      return null;
                    },
                    decoration:
                        InputDecoration(labelText: 'Enter the password'),
                    obscureText: true,
                    onSaved: (value) {
                      _userPassword = value;
                    },
                  ),
                  if (_isSignUp)
                    TextFormField(
                      key: ValueKey('check password'),
                      validator: (value) {
                        if (value.isEmpty || value.length < 8) {
                          return 'Password must be at least 8 characters long.';
                        } else if (value == _userPassword) {
                          return 'Passwords are not the same';
                        } else
                          return null;
                      },
                      decoration:
                          InputDecoration(labelText: 'Repeat the password'),
                      obscureText: true,
                      onSaved: (value) {
                        _userCheckedPassword = value;
                      },
                    ),
                  SizedBox(
                    height: 15,
                  ),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    RaisedButton(
                      child: Text(
                        !_isSignUp ? 'Login' : 'Sign up',
                      ),
                      onPressed: _formSubmit,
                    ),
                  if (!widget.isLoading)
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: () {
                        setState(() {
                          _isSignUp = !_isSignUp;
                        });
                      },
                      child: Text(!_isSignUp
                          ? 'Don\'t have an account? Create new account'
                          : 'Already have an account? Login'),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
