part of 'widgets.dart';

class CustomOptionsBottomSheetItem {
  factory CustomOptionsBottomSheetItem.fromIcon({
    required String text,
    required IconData icon,
    VoidCallback? onSelected,
  }) {
    return CustomOptionsBottomSheetItem._(
      text: text,
      icon: Icon(icon, color: const Color(0xFF98A2B3), size: 24),
      onSelected: onSelected,
    );
  }

  const CustomOptionsBottomSheetItem._({
    required this.text,
    required this.icon,
    this.onSelected,
  });

  final String text;
  final Widget icon;
  final VoidCallback? onSelected;
}

class CustomOptionsBottomSheet extends StatelessWidget {
  const CustomOptionsBottomSheet({super.key, required this.items});

  final List<CustomOptionsBottomSheetItem> items;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: false,
      right: false,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 10),
            Container(
              width: 36.0,
              height: 5.0,
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
            const SizedBox(height: 16),
            for (final item in items)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  item.onSelected?.call();
                },
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.all<Color>(
                    const Color.fromRGBO(249, 250, 251, 1),
                  ),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 16,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 12,
                    children: [
                      item.icon,
                      Text(
                        item.text,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
