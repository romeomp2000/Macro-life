import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String? hinttext;
  final bool? obsecuretext;
  final String? label;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final bool
      focus; // Nuevo parámetro para determinar si el campo debe enfocarse

  const CustomTextFormField(
      {super.key,
      this.hinttext,
      this.obsecuretext = false,
      this.label,
      this.controller,
      this.keyboardType,
      this.validator,
      this.suffixIcon,
      this.focus = false, // Valor predeterminado de `false`
      this.onChanged});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  final FocusNode _focusNode = FocusNode(); // FocusNode para manejar el foco
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    super.initState();

    // Solicita el foco si el parámetro `focus` es verdadero
    if (widget.focus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _focusNode.requestFocus();
      });
    }
  }

  @override
  void dispose() {
    _focusNode.dispose(); // Libera el FocusNode al destruir el widget
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode, // Asocia el FocusNode
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      validator: widget.validator,
      maxLines: null,
      onChanged: widget.onChanged,
      obscureText: widget.obsecuretext != null && widget.obsecuretext!
          ? _obscureText
          : false, // Aplica la lógica solo si es verdadero
      readOnly: false,
      decoration: InputDecoration(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                widget.label ?? '',
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                ),
                overflow: TextOverflow
                    .ellipsis, // Recorta si el texto es demasiado largo
              ),
            ),
            if (widget.validator != null)
              const Row(
                children: [
                  SizedBox(width: 3),
                  Text(
                    '*',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
          ],
        ),
        contentPadding: const EdgeInsets.all(18),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black54, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black54, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black54, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        hintText: widget.hinttext ?? '',
        hintStyle: const TextStyle(
          fontSize: 15,
          color: Color.fromARGB(255, 127, 127, 127),
        ),
        suffixIcon: widget.obsecuretext != null && widget.obsecuretext!
            ? IconButton(
                icon: Icon(
                  _obscureText
                      ? Icons.remove_red_eye_outlined
                      : Icons.visibility_off_outlined,
                ),
                onPressed: _togglePasswordVisibility,
              )
            : widget.suffixIcon,
      ),
    );
  }
}
