import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flowly/core/widgets/widgets.dart';
import 'package:flowly/viewmodels/viewmodels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemePicker extends StatelessWidget {
  const ThemePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final configVM = context.watch<SettingsViewModel>();
    final scheme = FlexColor.schemes[configVM.currentScheme]!;
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showThemePickerModal(context),
        child: Ink(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Tema de Cores',
                  style: TextStyle(fontSize: 18, color: colors.onSurface),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 3, vertical: 0),
                child: Row(
                  children: [
                    Text(
                      configVM.currentScheme.name.capitalize,
                      style: TextStyle(
                        fontSize: 15,
                        color: scheme.dark.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10),
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: scheme.dark.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showThemePickerModal(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final configVM = context.read<SettingsViewModel>();
    showModalBottomSheet(
      context: context,
      backgroundColor: colors.surface,
      builder: (_) {
        return AppBottomSheet(
          title: 'Selecione um tema',
          child: SizedBox(
            height: 380,

            child: ListView(
              children: FlexScheme.values.map((item) {
                final scheme = FlexColor.schemes[item];
                final isSelected = item == configVM.currentScheme;
                if (scheme == null) {
                  return SizedBox.shrink();
                }
                return ListTile(
                  leading: CircleAvatar(backgroundColor: scheme.dark.primary),
                  title: Text(item.name.capitalize),
                  tileColor: isSelected
                      ? colors.primaryContainer
                      : Colors.transparent,
                  subtitle: Text(
                    scheme.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    configVM.changeScheme(item);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
