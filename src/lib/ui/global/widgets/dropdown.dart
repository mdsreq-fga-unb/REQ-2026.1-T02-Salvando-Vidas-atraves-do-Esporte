import 'package:salvando_vidas/main_imports.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';

Widget buildDropdownField<T>({
  required String label,
  required T? value,
  required List<T> items,
  required String Function(T) labelBuilder,
  required ValueChanged<T?> onChanged,
  String? validatorMessage,
}) {
  return Builder(
    builder: (context) {
      final isDark = Theme.of(context).brightness == Brightness.dark;
      final fill = isDark ? AppColors.darkInputFill : AppColors.platinum;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildLabel(label),
          DropdownButtonFormField<T>(
            value: value,
            decoration: InputDecoration(
              filled: true,
              fillColor: fill,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
            dropdownColor: isDark ? AppColors.darkSurface : Colors.white,
            hint: Text(label.replaceAll('*', ''), style: TextStyle(color: isDark ? Colors.white70 : Colors.black54)),
            items: items.map((T item) {
              return DropdownMenuItem<T>(
                value: item,
                child: Text(labelBuilder(item), style: TextStyle(color: isDark ? Colors.white : Colors.black87)),
              );
            }).toList(),
            onChanged: onChanged,
            validator: validatorMessage != null
                ? (v) => v == null ? validatorMessage : null
                : null,
          ),
        ],
      );
    },
  );
}
