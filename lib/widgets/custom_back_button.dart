part of 'widgets.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
    this.color = Colors.black,
    this.backgroundColor = Colors.white,
    this.onPressed,
  });

  const CustomBackButton.white({super.key, this.onPressed})
    : color = Colors.white,
      backgroundColor = const Color(0x639E9E9E);

  final Color color;
  final Color backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(backgroundColor),
      ),
      onPressed: () {
        if (onPressed != null) {
          onPressed!.call();
          return;
        }

        Navigator.of(context).pop();
      },
      icon: FaIcon(FontAwesomeIcons.arrowLeft, color: color, size: 20),
    );
  }
}
