part of '../edit_personal_details_page.dart';

class _PersonalInfoSection extends ConsumerWidget {
  const _PersonalInfoSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileProvider)!;
    final List<(String, String, String, String)> datas = [
      (
        'Current Weight',
        profile.weight.toString(),
        Routes.editHeightWeight.name,
        'current-weight',
      ),
      (
        'Height',
        profile.height.toString(),
        Routes.editHeightWeight.name,
        'height',
      ),
      (
        'Date of birth',
        DateFormat('dd/MM/yyyy').format(profile.dob),
        Routes.editDob.name,
        'dob',
      ),
      ('Gender', profile.gender.label, Routes.editGender.name, 'gender'),
      ('Diet', profile.diet.label, Routes.editDiet.name, 'diet'),
      (
        'Workout Rate',
        profile.workoutFrequency.label,
        Routes.editWorkoutFrequency.name,
        'workout-rate',
      ),
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
              onTap: () {
                context.pushNamed(datas[i].$3);
              },
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
                    FaIcon(
                      key: Key('edit-${datas[i].$4}-btn'),
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
