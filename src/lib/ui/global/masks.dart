import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

MaskTextInputFormatter maskCPF() => MaskTextInputFormatter(
  mask: '###.###.###-##',
  filter: {'#': RegExp(r'[0-9]')},
);

MaskTextInputFormatter maskTelefone() => MaskTextInputFormatter(
  mask: '(##) #####-####',
  filter: {"#": RegExp(r'[0-9]')},
);

MaskTextInputFormatter maskData() =>
    MaskTextInputFormatter(mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});
