import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:notebox/store/settings.dart';
import 'package:notebox/utils/theme.dart';

class SettingsSectionSplitter extends StatelessWidget {
  const SettingsSectionSplitter({Key? key, required this.title})
      : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.headline5,
        ),
        const Divider(),
      ],
    );
  }
}

class AboutSettingsSection extends StatelessWidget {
  const AboutSettingsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'MADE BY Iori',
          style: context.textTheme.bodySmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text('ALPHA BUILD', style: context.textTheme.bodySmall)
      ],
    );
  }
}

class SystemSettingsSection extends ConsumerWidget {
  const SystemSettingsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: const Text('Theme'),
          subtitle: const Text('Change theme color'),
          trailing: DropdownButton(
            value: settings.themeMode,
            items: const [
              DropdownMenuItem(child: Text('System'), value: ThemeMode.system),
              DropdownMenuItem(child: Text('Dark'), value: ThemeMode.dark),
              DropdownMenuItem(child: Text('Light'), value: ThemeMode.light),
            ],
            onChanged: (ThemeMode? value) {
              if (value != null) {
                ref.read(settingsProvider.notifier).setThemeMode(value);
              }
            },
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTileTheme(
      dense: true,
      minLeadingWidth: 0,
      minVerticalPadding: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        children: const [
          SizedBox(height: 20),
          SettingsSectionSplitter(title: 'System'),
          SystemSettingsSection(),
          SettingsSectionSplitter(title: 'User'),
          SizedBox(height: 80),
          AboutSettingsSection(),
        ],
      ),
    );
  }
}
