library;

import 'dart:convert';

import 'package:ema_cal_ai/states/states.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plan = ref.watch(currentNutritionPlanProvider);
    final profile = ref.watch(userProfileProvider);
    const encoder = JsonEncoder.withIndent('    ');

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const Text(
            'Plan',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          Text(encoder.convert(plan?.toJson())),
          const SizedBox(height: 20),
          const Divider(),
          const Text(
            'Profile',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          Text(encoder.convert(profile?.toJson())),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
