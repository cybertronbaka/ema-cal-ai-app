part of '../settings_page.dart';

class _VersionSection extends ConsumerWidget {
  const _VersionSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = TextTheme.of(context);
    final version = ref.read(packageInfoProvider)?.version ?? 'Unknown';

    return Text('Version $version', style: textTheme.bodySmall);
  }
}
