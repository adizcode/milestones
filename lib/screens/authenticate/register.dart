import 'package:flutter/material.dart';
import 'package:milestones/screens/authenticate/widgets/auth_form_card.dart';
import 'package:milestones/services/auth.dart';
import 'package:milestones/shared/constants.dart';
import 'package:milestones/shared/validators.dart';
import 'package:milestones/widgets/milestones_background.dart';
import 'package:milestones/widgets/milestones_bar.dart';
import 'package:sizer/sizer.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    Key? key,
    required this.toggleView,
  }) : super(key: key);

  final void Function() toggleView;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MilestonesBackground(
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
                      await AuthService().registerWithEmail(email, password);
                    } catch (e) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  }
                },
                child: Text(
                  'Sign Up',
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
            actionIcon: Icons.login,
            actionLabel: 'Login',
          ),
        )
      ],
    );
  }
}
