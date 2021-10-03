import 'package:flutter/material.dart';
import 'package:milestones/screens/authenticate/widgets/auth_form_card.dart';
import 'package:milestones/services/auth.dart';
import 'package:milestones/shared/constants.dart';
import 'package:milestones/shared/validators.dart';
import 'package:milestones/widgets/milestones_scaffold.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
    required this.toggleView,
  }) : super(key: key);

  final void Function() toggleView;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return MilestonesScaffold(
      onActionPressed: widget.toggleView,
      actionIcon: Icons.app_registration,
      actionLabel: 'Register',
      child: AuthFormCard(
        formKey: _formKey,
        children: [
          TextFormField(
            onChanged: (value) => email = value,
            validator: emptyTextValidator,
            decoration: textInputDecoration.copyWith(
              labelText: 'Email',
            ),
          ),
          SizedBox(
            height: 5.w,
          ),
          TextFormField(
            onChanged: (value) => password = value,
            validator: emptyTextValidator,
            decoration: textInputDecoration.copyWith(
              labelText: 'Password',
            ),
            obscureText: true,
          ),
          SizedBox(
            height: 10.w,
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState?.validate() ?? false) {
                try {
                  await AuthService().signInWithEmail(email, password);
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
              }
            },
            child: Text(
              'Sign In',
              style: TextStyle(fontSize: 12.sp),
            ),
          ),
        ],
      ),
    );
  }
}
