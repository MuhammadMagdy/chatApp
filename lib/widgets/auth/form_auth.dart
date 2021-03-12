import 'dart:io';

import 'package:chat_app1/widgets/pickers/user_image_picker.dart';
import 'package:flutter/material.dart';

class FormAuth extends StatefulWidget {
  final void Function(String email, String username, String password,File image,
      bool isLogin, BuildContext ctx) submitFn;

 final bool _isLoading;
  const FormAuth(this.submitFn, this._isLoading);

  @override
  _FormAuthState createState() => _FormAuthState();
}

class _FormAuthState extends State<FormAuth> {
  final formKey = GlobalKey<FormState>();
  bool isLogin = true;

  String _email = '';
  String _userName = '';
  String _password = '';

  File _userImageFile ;

  void _pickedImage(File pickedImage){

    _userImageFile = pickedImage;
  }
  void _submit() {
    final isValid = formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if(!isLogin && _userImageFile == null){

      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Please pick an image')));


      return;
    }
    if (isValid) {
      formKey.currentState.save();
      widget.submitFn(
          _email.trim(), _userName.trim(), _password.trim(), _userImageFile ,isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        // color: Colors.red,
        margin: EdgeInsets.all(15),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!isLogin) UserImagePicker(_pickedImage),
                TextFormField(
                  autocorrect: false,
                  enableSuggestions: false,
                  textCapitalization: TextCapitalization.none,
                  key: ValueKey('email'),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Email',
                    labelText: 'Email',
                  ),
                  // controller: email,
                  validator: (val) {
                    if (val.isEmpty || !val.contains('@')) {
                      return 'Please enter valid email';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (val) {
                    _email = val;
                  },
                ),
                if (!isLogin)
                  TextFormField(
                    autocorrect: true,
                    enableSuggestions: false,
                    textCapitalization: TextCapitalization.words,
                    key: ValueKey('userName'),
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: 'Enter UserName',
                      labelText: 'UserName',
                    ),
                    // controller: userName,
                    validator: (val) {
                      if (val.isEmpty || val.length < 4) {
                        return 'Please enter at least 4 characters !';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (val) {
                      _userName = val;
                    },
                  ),
                TextFormField(
                  key: ValueKey('password'),
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Password',
                    labelText: 'Password',
                  ),
                  // controller: password,
                  obscureText: true,
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Please enter password';
                    } else if (val.length < 8) {
                      return 'Password must be at least 8 characters! ';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (val) {
                    _password = val;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                if(widget._isLoading)
                  CircularProgressIndicator(),
                if(!widget._isLoading)
                RaisedButton(
                  onPressed: () {
                    _submit();
                  },
                  child: Text(
                    isLogin ? 'Login' : 'SignUp',
                  ),
                ),
                if(!widget._isLoading)
                FlatButton(
                  onPressed: () {
                    setState(() {
                      isLogin = !isLogin;
                    });
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    isLogin ? 'Create New Account !' : 'I have an account',
                    style: TextStyle(color: Theme.of(context).canvasColor),
                  ),
                  // color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
