import 'package:flutter/material.dart' hide InputDecoration;
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:material_ui/material_ui.dart' show InputDecoration;

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/fbc_button.dart';
import '../../../../core/widgets/fbc_modal_shell.dart';
import '../controllers/registration_controller.dart';
import '../controllers/registration_state.dart';

class ClaimCardModal extends StatefulWidget {
  final VoidCallback? onCardCreated;

  const ClaimCardModal({super.key, this.onCardCreated});

  static Future<void> show(BuildContext context, {VoidCallback? onCardCreated}) {
    return showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.75),
      builder: (_) => ClaimCardModal(onCardCreated: onCardCreated),
    );
  }

  @override
  State<ClaimCardModal> createState() => _ClaimCardModalState();
}

class _ClaimCardModalState extends State<ClaimCardModal> {
  final _formKey = GlobalKey<FormBuilderState>();
  late final RegistrationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = RegistrationController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final values = _formKey.currentState!.value;
      final success = await _controller.submitCard(
        name: values['name'] as String,
        role: values['role'] as String,
        skillsRaw: values['skills'] as String,
        interests: values['interests'] as String,
        githubHandle: values['github'] as String?,
      );

      if (success && mounted) {
        widget.onCardCreated?.call();
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: FbcColors.cardElevated,
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: FbcColors.emerald, size: 20),
                const SizedBox(width: 10),
                Text(
                  'Card synthesized & published to the live wall!',
                  style: FbcTypography.bodyMedium,
                ),
              ],
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FbcModalShell(
      title: 'Claim Your Engineer Card',
      subtitle: 'Synthesize your persona and join the real-time live community wall.',
      child: ValueListenableBuilder<RegistrationState>(
        valueListenable: _controller,
        builder: (context, state, _) {
          return FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (state.errorMessage != null) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.15),
                      borderRadius: FbcDecorations.borderRadiusMd,
                      border: Border.all(color: Colors.redAccent.withValues(alpha: 0.4)),
                    ),
                    child: Text(
                      state.errorMessage!,
                      style: FbcTypography.caption.copyWith(color: Colors.redAccent),
                    ),
                  ),
                ],

                // Full Name
                FormBuilderTextField(
                  name: 'name',
                  decoration: const InputDecoration(
                    labelText: 'Full Name / Handle *',
                    hintText: 'e.g. Chioma Adeyemi',
                    prefixIcon: Icon(Icons.person_outline, size: 18, color: FbcColors.muted),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: 'Name is required'),
                    FormBuilderValidators.maxLength(60, errorText: 'Max 60 characters'),
                  ]),
                ),
                const SizedBox(height: 16),

                // Engineering Role
                FormBuilderTextField(
                  name: 'role',
                  decoration: const InputDecoration(
                    labelText: 'Primary Role / Specialty *',
                    hintText: 'e.g. Staff Mobile Engineer, Backend Lead',
                    prefixIcon: Icon(Icons.work_outline, size: 18, color: FbcColors.muted),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: 'Role is required'),
                    FormBuilderValidators.maxLength(60, errorText: 'Max 60 characters'),
                  ]),
                ),
                const SizedBox(height: 16),

                // Core Skills
                FormBuilderTextField(
                  name: 'skills',
                  decoration: const InputDecoration(
                    labelText: 'Core Skills (Comma separated) *',
                    hintText: 'e.g. Flutter, Serverpod, Riverpod, Dart',
                    prefixIcon: Icon(Icons.terminal, size: 18, color: FbcColors.muted),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: 'At least one skill is required'),
                  ]),
                ),
                const SizedBox(height: 16),

                // Interests / What you want to build
                FormBuilderTextField(
                  name: 'interests',
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Project Interests / What You Want to Build *',
                    hintText: 'e.g. Building offline-first clinical AI note taking with Flutter & Serverpod.',
                    alignLabelWithHint: true,
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: 'Please share what you want to build'),
                    FormBuilderValidators.maxLength(300, errorText: 'Max 300 characters'),
                  ]),
                ),
                const SizedBox(height: 16),

                // GitHub Handle
                FormBuilderTextField(
                  name: 'github',
                  decoration: const InputDecoration(
                    labelText: 'GitHub Username (Optional)',
                    hintText: 'e.g. chioma-dev (for avatar and profile link)',
                    prefixIcon: Icon(Icons.code, size: 18, color: FbcColors.muted),
                  ),
                ),
                const SizedBox(height: 24),

                // Submit
                FbcButton(
                  label: 'Synthesize & Publish to Wall',
                  icon: Icons.auto_awesome,
                  isLoading: state.isLoading,
                  onPressed: state.isLoading ? null : _submit,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
