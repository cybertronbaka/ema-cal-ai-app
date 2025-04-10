part of 'widgets.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 32, 20, 32),
            child: child,
          ),
          Positioned(
            right: 12,
            top: 12,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.close_rounded),
            ),
          ),
        ],
      ),
    );
  }
}
