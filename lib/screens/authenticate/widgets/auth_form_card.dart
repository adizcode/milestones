import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AuthFormCard extends StatelessWidget {
  const AuthFormCard({
    Key? key,
    required GlobalKey<FormState> formKey,
    required List<Widget> children,
  })  : _formKey = formKey,
        _children = children,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final List<Widget> _children;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3.w),
      ),
      margin: EdgeInsets.all(4.5.w),
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: _children,
          ),
        ),
      ),
    );
  }
}
