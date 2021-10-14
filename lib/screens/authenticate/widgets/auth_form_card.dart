import 'package:flutter/material.dart';
import 'package:milestones/shared/constants.dart';
import 'package:sizer/sizer.dart';

class AuthFormCard extends StatefulWidget {
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
  State<AuthFormCard> createState() => _AuthFormCardState();
}

class _AuthFormCardState extends State<AuthFormCard> {
  bool isVisible = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 0), () {
        setState(() => isVisible = true);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isVisible ? 1 : 0,
      duration: fadeDuration,
      child: Card(
        color: Colors.white.withOpacity(0.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3.w),
        ),
        margin: EdgeInsets.all(4.5.w),
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
          child: Form(
            key: widget._formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: widget._children,
            ),
          ),
        ),
      ),
    );
  }
}
