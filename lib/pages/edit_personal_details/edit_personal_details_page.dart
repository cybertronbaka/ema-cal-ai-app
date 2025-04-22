library;

import 'package:ema_cal_ai/app/colors.dart';
import 'package:ema_cal_ai/states/states.dart';
import 'package:ema_cal_ai/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class EditPersonalDetailsPage extends StatelessWidget {
  const EditPersonalDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const CustomBackButton.transparentBg(),
        title: const Text('Personal details'),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              _GoalSection(),
              SizedBox(height: 24),
              _PersonalInfoSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class _GoalSection extends ConsumerWidget {
  const _GoalSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileProvider)!;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.cardBorder),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Goal Weight', style: TextStyle(fontSize: 14)),
                  Text(
                    profile.weightGoal.toString(),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.black,
              ),
              child: const Text(
                'Change Goal',
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PersonalInfoSection extends ConsumerWidget {
  const _PersonalInfoSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileProvider)!;
    final List<(String, String, void Function())> datas = [
      ('Current Weight', profile.weight.toString(), () {}),
      ('Height', profile.height.toString(), () {}),
      ('Date of birth', DateFormat('dd/MM/yyyy').format(profile.dob), () {}),
      ('Gender', profile.gender.label, () {}),
    ];

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.cardBorder),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          for (var i = 0; i < datas.length; i++) ...[
            InkWell(
              onTap: datas[i].$3,
              borderRadius: BorderRadius.circular(200),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(datas[i].$1),
                    const SizedBox(width: 8),
                    const Spacer(),
                    Text(
                      datas[i].$2,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 8),
                    const FaIcon(
                      FontAwesomeIcons.pencil,
                      size: 14,
                      color: AppColors.darkGrey,
                    ),
                  ],
                ),
              ),
            ),
            if (i < datas.length - 1) const Divider(),
          ],
        ],
      ),
    );
  }
}
