library;

import 'package:ema_cal_ai/app/colors.dart';
import 'package:ema_cal_ai/app/routes.dart';
import 'package:ema_cal_ai/states/states.dart';
import 'package:ema_cal_ai/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

part 'widgets/goal_section.dart';
part 'widgets/personal_info_section.dart';

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
