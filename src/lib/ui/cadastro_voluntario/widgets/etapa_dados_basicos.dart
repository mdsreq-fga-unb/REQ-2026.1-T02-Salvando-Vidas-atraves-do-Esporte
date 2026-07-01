import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:salvando_vidas/data/stores/cadastro_aluno/cadastro_aluno.dart';
import 'package:salvando_vidas/domain/aluno/aluno.dart';
import 'package:salvando_vidas/main_imports.dart';
import 'package:salvando_vidas/ui/cadastro_voluntario/widgets/input_field.dart';
import 'package:salvando_vidas/ui/global/masks.dart';
import 'package:salvando_vidas/ui/global/themes/colors.dart';
import 'package:salvando_vidas/ui/global/widgets/faixa_badge.dart';

class EtapaDadosBasicos extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKey;

  const EtapaDadosBasicos({super.key, required this.formKey});

  @override
  ConsumerState<EtapaDadosBasicos> createState() => _EtapaDadosBasicosState();
}

class _EtapaDadosBasicosState extends ConsumerState<EtapaDadosBasicos> {
  late final MaskTextInputFormatter formatCPF;
  late final MaskTextInputFormatter formatTelefone;
  late final MaskTextInputFormatter
  formatTelefoneEmergencia; // Máscara dedicada para evitar conflitos
  late final MaskTextInputFormatter formatData;
  final TextEditingController _dataController = TextEditingController();

  @override
  void initState() {
    super.initState();
    formatCPF = maskCPF();
    formatTelefone = maskTelefone();
    formatTelefoneEmergencia =
        maskTelefone(); // Instância separada para o emergência
    formatData = MaskTextInputFormatter(
      mask: '##/##/####',
      filter: {"#": RegExp(r'[0-9]')},
    );
  }

  @override
  void dispose() {
    _dataController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cadastro = ref.watch(cadastroAlunoProvider);
    final notifier = ref.read(cadastroAlunoProvider.notifier);

    // Sincroniza a data do estado com o controller caso venha do DatePicker
    if (cadastro.nascimento != null) {
      final dia = cadastro.nascimento!.day.toString().padLeft(2, '0');
      final mes = cadastro.nascimento!.month.toString().padLeft(2, '0');
      final ano = cadastro.nascimento!.year.toString();
      final dataFormatada = "$dia/$mes/$ano";
      if (_dataController.text != dataFormatada) {
        _dataController.text = dataFormatada;
      }
    }

    return Form(
      key: widget.formKey,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
                InputField(
                  initialValue: cadastro.nome,
                  update: notifier.updateNome,
                  error: cadastro.nomeError,
                  label: 'Nome*',
                  hint: 'Digite o nome completo',
                  validatorMessage: 'O nome é obrigatório',
                ),
                const SizedBox(height: 14),
                InputField(
                  initialValue: cadastro.apelido ?? '',
                  update: notifier.updateApelido,
                  error: null,
                  label: 'Apelido (opcional)',
                  hint: 'Como o aluno gosta de ser chamado',
                ),
                if (cadastro.apelido != null &&
                    cadastro.apelido!.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text(
                      'Usar apelido como referência principal nas chamadas e listas',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    value: cadastro.usarApelido,
                    onChanged: notifier.updateUsarApelido,
                    activeColor: AppColors.royalAzure,
                  ),
                ],
                const SizedBox(height: 14),
                InputField(
                  initialValue: formatCPF.maskText(cadastro.cpf),
                  update: (_) =>
                      notifier.updateCPF(formatCPF.getUnmaskedText()),
                  error: cadastro.cpfError,
                  label: 'CPF*',
                  hint: '000.000.000-00',
                  keyboardType: TextInputType.number,
                  validatorMessage: 'O CPF é obrigatório',
                  inputFormatters: [formatCPF],
                ),
                const SizedBox(height: 14),
                InputField(
                  initialValue: formatTelefone.maskText(cadastro.contato),
                  update: (_) =>
                      notifier.updateContato(formatTelefone.getUnmaskedText()),
                  error: cadastro.contatoError,
                  label: 'Telefone*',
                  hint: '(00) 00000-0000',
                  keyboardType: TextInputType.phone,
                  validatorMessage: 'O telefone é obrigatório',
                  inputFormatters: [formatTelefone],
                ),
                const SizedBox(height: 14),

                // NOVO CAMPO: Contato de Emergência
                InputField(
                  // Assume que o estado retorna uma string vazia se for nulo para não quebrar a máscara
                  initialValue: formatTelefoneEmergencia.maskText(
                    cadastro.contatoEmergencia ?? '',
                  ),
                  update: (_) => notifier.updateContatoEmergencia(
                    formatTelefoneEmergencia.getUnmaskedText(),
                  ),
                  error: cadastro.contatoEmergenciaError,
                  label: 'Contato de Emergência*',
                  hint: '(00) 00000-0000',
                  keyboardType: TextInputType.phone,
                  validatorMessage: 'O contato de emergência é obrigatório',
                  inputFormatters: [formatTelefoneEmergencia],
                ),
                const SizedBox(height: 14),

                InputField(
                  initialValue: cadastro.email,
                  update: notifier.updateEmail,
                  error: cadastro.emailError,
                  label: 'Email*',
                  hint: 'email@email.com',
                  keyboardType: TextInputType.emailAddress,
                  validatorMessage: 'O email é obrigatório',
                ),
                const SizedBox(height: 14),

                buildLabel('Aniversário*'),
                const SizedBox(height: 6),
                Builder(
                  builder: (context) {
                    final isDark =
                        Theme.of(context).brightness == Brightness.dark;
                    final textColor = isDark
                        ? Colors.white
                        : AppColors.deepNavy;
                    final fill = isDark
                        ? AppColors.darkSurface
                        : AppColors.inputFill;
                    final hint = isDark ? Colors.white54 : Colors.black54;
                    return TextFormField(
                      controller: _dataController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [formatData],
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w600,
                      ),
                      autovalidateMode: AutovalidateMode.disabled,
                      decoration: InputDecoration(
                        hintText: 'DD/MM/AAAA',
                        hintStyle: TextStyle(color: hint),
                        errorText: cadastro.nascimentoError,
                        filled: true,
                        fillColor: fill,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.calendar_today,
                            color: isDark
                                ? AppColors.cyanPrimary
                                : AppColors.deepNavy,
                          ),
                          onPressed: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate:
                                  cadastro.nascimento ?? DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            if (pickedDate != null) {
                              notifier.updateNascimento(pickedDate);
                            }
                          },
                        ),
                      ),
                      onChanged: (value) {
                        if (value.length == 10) {
                          try {
                            final partes = value.split('/');
                            final data = DateTime(
                              int.parse(partes[2]),
                              int.parse(partes[1]),
                              int.parse(partes[0]),
                            );
                            notifier.updateNascimento(data);
                          } catch (e) {
                            // Data inválida ignorada
                          }
                        }
                      },
                      validator: (value) =>
                          (value == null || value.isEmpty || value.length < 10)
                          ? 'A data é obrigatória e deve ser válida'
                          : null,
                    );
                  },
                ),
                const SizedBox(height: 14),
                buildDropdownField(
                  label: 'Tipo sanguíneo*',
                  value: cadastro.tipoSanguineo,
                  items: TipoSanguineo.values,
                  labelBuilder: (tipo) => tipo.nomeVisivel,
                  onChanged: (value) {
                    if (value != null) {
                      notifier.updateTipoSanguineo(value);
                    }
                  },
                  validatorMessage: 'Selecione o tipo sanguíneo',
                ),
                const SizedBox(height: 14),
                FaixaDropdownField(
                  value: cadastro.faixa,
                  onChanged: (value) {
                    if (value != null) {
                      notifier.updateFaixa(value);
                    }
                  },
                  validator: (v) => v == null ? 'Selecione a faixa' : null,
                ),
                const SizedBox(height: 14),
                InputField(
                  initialValue: cadastro.idFicha,
                  update: notifier.updateIdFicha,
                  error: cadastro.idFichaError,
                  label: 'ID da ficha',
                  hint: 'Digite o id da ficha',
                ),
              ],
            ),
          ),
        ),
    );
  }
}
