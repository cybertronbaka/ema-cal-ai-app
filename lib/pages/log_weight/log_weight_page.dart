library;

import 'package:ema_cal_ai/config/app_config.dart';
import 'package:ema_cal_ai/controllers/profile_controller.dart';
import 'package:ema_cal_ai/models/unit_weight.dart';
import 'package:ema_cal_ai/states/states.dart';
import 'package:ema_cal_ai/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LogWeightPage extends HookConsumerWidget {
  const LogWeightPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appConfig = AppConfig();
    final profile = ref.watch(userProfileProvider)!;
    final weightNotifier = useValueNotifier<UnitWeight>(profile.weight);
    final controller = ref.watch(profileControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Log Weight')),
      body: SafeArea(
        child: Column(
          spacing: 24,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxHeight <= 0) {
                    return const SizedBox.shrink();
                  }
                  return SingleChildScrollView(
                    padding: appConfig.hPadding,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Center(
                        child: SizedBox(
                          height: 250,
                          child: WeightPicker(
                            initialWeight: profile.weight,
                            isMetric: profile.isMetric,
                            onValueChanged: (value) {
                              weightNotifier.value = value;
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: appConfig.hPadding.copyWith(bottom: 16, top: 16),
              width: double.infinity,
              child: ValueListenableBuilder(
                valueListenable: weightNotifier,
                builder: (context, value, _) {
                  return FutureCustomFilledButton(
                    enabled: profile.weight != value,
                    onPressed: () async {
                      await controller.setWeight(context, value);
                      if (context.mounted) {
                        context.pop();
                      }
                    },
                    label: 'Save',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
