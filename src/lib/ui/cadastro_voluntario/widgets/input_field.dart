import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    required this.update,
    required this.error,
    required this.initialValue,
    required this.label,
    required this.hint,
    required this.validatorMessage,
    this.keyboardType,
    this.fillColor,
    super.key,
  });

  final Color? fillColor;

  final void Function(String) update;
  final String? error;
  final String initialValue;
  final String label;
  final String hint;
  final String validatorMessage;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF10A9D0),
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          onChanged: (value) => update(value),
          initialValue: initialValue,
          keyboardType: keyboardType,
          style: const TextStyle(
            color: Color(0xFF24304D),
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            hintText: hint,
            errorText: error,
            hintStyle: const TextStyle(color: Color(0xAA000000), fontSize: 13),
            filled: true,
            fillColor: fillColor ?? const Color(0xFFD8DDE6),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF2457F0),
                width: 1.2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
          validator: (value) {
            final text = (value ?? '').trim();
            if (text.isEmpty) return validatorMessage;
            return null;
          },
        ),
      ],
    );
  }
}
