library;

import 'package:ema_cal_ai/app/colors.dart';
import 'package:ema_cal_ai/app/routes.dart';
import 'package:ema_cal_ai/states/states.dart';
import 'package:ema_cal_ai/utils/age.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
              UserInfoSection(),
              Divider(),
              CustomizationSection(),
              Divider(),
              VersionSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class UserInfoSection extends ConsumerWidget {
  const UserInfoSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.read(userProfileProvider)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: const Text('Age'),
          trailing: Text(
            getAge(profile.dob).toString(),
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        ListTile(
          title: const Text('Height'),
          trailing: Text(
            profile.height.toString(),
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        ListTile(
          title: const Text('Current Weight'),
          trailing: Text(
            profile.weight.toString(),
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

class CustomizationSection extends ConsumerWidget {
  const CustomizationSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = TextTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Customization', style: textTheme.titleMedium),
        ListTile(
          onTap: () {
            context.pushNamed(Routes.editPersonalDetails.name);
          },
          title: const Text('Personal Details'),
          trailing: const FaIcon(
            FontAwesomeIcons.chevronRight,
            size: 18,
            color: AppColors.darkGrey,
          ),
        ),
        ListTile(
          onTap: () {},
          title: const Text('Adjust Goals'),
          subtitle: const Text('Calories, carbs, fats, and protein'),
          trailing: const FaIcon(
            FontAwesomeIcons.chevronRight,
            size: 18,
            color: AppColors.darkGrey,
          ),
        ),
      ],
    );
  }
}

class VersionSection extends ConsumerWidget {
  const VersionSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = TextTheme.of(context);
    final version = ref.read(packageInfoProvider)?.version ?? 'Unknown';

    return Text('Version $version', style: textTheme.bodySmall);
  }
}
