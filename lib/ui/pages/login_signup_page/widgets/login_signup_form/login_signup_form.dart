import 'package:flutter/material.dart';
import 'package:crud_app/redux/auth_state/auth_state.dart';
import 'widgets/widgets.dart';

class LogInSignUpForm extends StatefulWidget {
  final AuthStateViewModel _viewModel;

  LogInSignUpForm(this._viewModel);
  @override
  State<StatefulWidget> createState() => new _LogInSignUpFormState();
}

class _LogInSignUpFormState extends State<LogInSignUpForm> {
  final _formKey = new GlobalKey<FormState>();
  FocusNode _focusNodeEmailInput;
  String _email;
  String _password;

  @override
  void initState() {
    super.initState();
    _focusNodeEmailInput = FocusNode();
  }

  @override
  void dispose() {
    _focusNodeEmailInput.dispose();
    super.dispose();
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() {
    if (validateAndSave()) {
      try {
        if (widget._viewModel.isLoginForm) {
          widget._viewModel
              .signInUser(_email, _password, resetForm);
        } else {
          widget._viewModel.signUpUser(_email, _password, resetForm);
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  void resetForm() {
    _formKey.currentState.reset();
  }

  Function _toggleFormMode() {
    if (widget._viewModel.isLoading) {
      return null;
    } else {
      return () {
        resetForm();
        widget._viewModel.setIsLoginForm(!widget._viewModel.isLoginForm);
        _focusNodeEmailInput.requestFocus();
      };
    }
  }

  Widget renderEmailTextInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
      child: TextFormField(
        focusNode: this._focusNodeEmailInput,
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: InputDecoration(
            hintText: 'Email',
            icon: Icon(
              Icons.mail,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
      ),
    );
  }

  Widget renderPasswordTextInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: InputDecoration(
            hintText: 'Password',
            icon: Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
      ),
    );
  }

  Widget renderConfirmPassTextInput() {
    final bool _isLoginForm = widget._viewModel.isLoginForm;
    double top = !_isLoginForm ? 15.0 : 0.0;
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, top, 0.0, 0.0),
      child: !_isLoginForm
          ? TextFormField(
              maxLines: 1,
              obscureText: true,
              autofocus: false,
              decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  icon: Icon(
                    Icons.lock,
                    color: Colors.grey,
                  )),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Confirm password can\'t be empty';
                } else if (value.isNotEmpty && value.trim() != _password) {
                  return 'Password don\'t match.';
                } else
                  return null;
              },
            )
          : null,
    );
  }

  Widget renderSecondaryButton() {
    return FlatButton(
        child: Text(
            widget._viewModel.isLoginForm
                ? 'Create an account'
                : 'Have an account? Sign in',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
        onPressed: _toggleFormMode());
  }

  Widget renderPrimaryButton() {
    return Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: RaisedButton(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            color: Colors.blue,
            child: Text(
                widget._viewModel.isLoading
                    ? 'Loading...'
                    : widget._viewModel.isLoginForm
                        ? 'Login'
                        : 'Create account',
                style: TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: validateAndSubmit,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: false,
            children: <Widget>[
              FormLogo(),
              renderEmailTextInput(),
              renderPasswordTextInput(),
              renderConfirmPassTextInput(),
              renderPrimaryButton(),
              renderSecondaryButton(),
              ErrorText(),
            ],
          ),
        ));
  }
}
