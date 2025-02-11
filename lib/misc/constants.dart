import 'package:flutter/material.dart';

const enabledBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: Colors.lightGreenAccent,
    width: 1,
  ),
  borderRadius: BorderRadius.all(
    Radius.circular(10),
  ),
);

const focusedBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: Colors.green,
    width: 2,
  ),
  borderRadius: BorderRadius.all(
    Radius.circular(10),
  ),
);

const errorBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: Colors.red,
    width: 2,
  ),
  borderRadius: BorderRadius.all(
    Radius.circular(10),
  ),
);

const focusedErrorBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: Colors.red,
    width: 2,
  ),
  borderRadius: BorderRadius.all(
    Radius.circular(10),
  ),
);

class StyledFormField extends StatelessWidget {
  final TextEditingController? controller;
  final bool isPassword;
  final String? Function(String?)? validator;
  final InputDecoration? decoration;
  final VoidCallback? onPressed;
  final void Function(String)? onChanged;
  final bool readonly;
  final Future<void>? future;

  const StyledFormField({
    super.key,
    this.controller,
    this.isPassword = false,
    this.validator,
    this.decoration,
    this.onPressed,
    this.onChanged,
    this.readonly = false,
    this.future,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readonly,
      controller: controller,
      onTap: onPressed,
      onChanged: onChanged,
      obscureText: isPassword,
      validator: validator,
      decoration: decoration,
    );
  }
}

InputDecoration formS(String labelText, String? hintText, IconData iconData) {
  return InputDecoration(
    errorStyle: const TextStyle(
      fontSize: 12,
    ),
    errorMaxLines: 3,
    prefixIcon: Icon(
      iconData,
      color: Colors.green,
    ),
    enabled: true,
    hintText: hintText,
    labelText: labelText,
    labelStyle: const TextStyle(
      color: Colors.green,
    ),
    focusedBorder: focusedBorder,
    enabledBorder: enabledBorder,
    errorBorder: errorBorder,
    focusedErrorBorder: focusedErrorBorder,
  );
}

Container rslButton(BuildContext context, String isLogin, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return Colors.green;
          }
          return Colors.lightGreen;
        }),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      child: Text(
        isLogin,
        style: const TextStyle(
            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
  );
}

class OptionsButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const OptionsButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.lightGreen, // Text color
        fixedSize: const Size(160, 150), // Set minimum button size
        padding: const EdgeInsets.all(20), // Add padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Square shape
        ),
        elevation: 3,
        shadowColor: Colors.grey,
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 20), // Increase font size
      ),
    );
  }
}

class UserInf extends StatelessWidget {
  const UserInf({
    super.key,
    required this.text,
    required this.boxName,
    this.onPressed,
    this.iconButton,
    this.iconButton2,
    this.email,
  });
  final String text;
  final String? email;
  final void Function()? onPressed;
  final String boxName;
  final IconButton? iconButton;
  final IconButton? iconButton2;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border:
            Border.all(style: BorderStyle.solid, color: Colors.green, width: 2),
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      padding: const EdgeInsets.only(left: 15, bottom: 15),
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  boxName,
                  style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.lightGreen,
                      fontSize: 17),
                ),
                Container(
                  child: iconButton,
                ),
                Container(
                  child: iconButton2,
                )
              ]),
          Text(
            text,
            style: const TextStyle(color: Colors.green, fontSize: 16),
          )
        ],
      ),
    );
  }
}
