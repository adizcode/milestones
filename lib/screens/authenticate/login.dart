import 'package:flutter/material.dart';
import 'package:milestones/screens/authenticate/widgets/auth_form_card.dart';
import 'package:milestones/services/auth.dart';
import 'package:milestones/shared/constants.dart';
import 'package:milestones/shared/validators.dart';
import 'package:milestones/widgets/milestones_background.dart';
import 'package:milestones/widgets/milestones_bar.dart';
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MilestonesBackground(
          child: AuthFormCard(
            formKey: _formKey,
            children: [
              TextFormField(
                validator: emptyTextValidator,
                decoration: textInputDecoration.copyWith(
                  labelText: 'Email',
                ),
              ),
              SizedBox(
                height: 5.w,
              ),
              TextFormField(
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
                    // TODO: Sign In With Email
                    await AuthService().signInAnon();
                  }
                },
                child: Text(
                  'Sign In',
                  style: TextStyle(fontSize: 12.sp),
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: const Alignment(0, -1),
          child: MilestonesBar(
            onActionPressed: widget.toggleView,
            actionIcon: Icons.app_registration,
            actionLabel: 'Register',
          ),
        )
      ],
    );
  }
}
