import 'package:flowly/views/settings/widgets/settings_section.dart';
import 'package:flowly/views/settings/widgets/theme_picker.dart';
import 'package:flutter/material.dart';

class ConfigsScreen extends StatefulWidget {
  const ConfigsScreen({super.key});

  @override
  State<ConfigsScreen> createState() => _ConfigsScreenState();
}

class _ConfigsScreenState extends State<ConfigsScreen> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text('Configurações'), actions: []),
      body: SettingsSection(title: 'Aparência', children: [ThemePicker()]),
    );
  }
}
