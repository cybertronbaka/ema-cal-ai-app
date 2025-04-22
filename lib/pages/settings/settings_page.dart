library;

import 'package:ema_cal_ai/app/colors.dart';
import 'package:ema_cal_ai/app/routes.dart';
import 'package:ema_cal_ai/states/states.dart';
import 'package:ema_cal_ai/utils/age.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'widgets/customization_section.dart';
part 'widgets/user_info_section.dart';
part 'widgets/version_section.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _UserInfoSection(),
              Divider(),
              _CustomizationSection(),
              Divider(),
              _VersionSection(),
            ],
          ),
        ),
      ),
    );
  }
}
