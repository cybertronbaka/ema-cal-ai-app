part of '../settings_page.dart';

class _UserInfoSection extends ConsumerWidget {
  const _UserInfoSection();

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
