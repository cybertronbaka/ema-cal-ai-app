part of 'widgets.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      top: false,
      child: Column(
        children: [
          const Spacer(),
          Center(
            child: NodeConnectionAnimation(
              nodeCount: 15,
              size: Size(screenSize.width, screenSize.height / 2),
            ),
          ),
          const Spacer(),
          const DefaultTextStyle(
            style: TextStyle(fontFamily: 'Poppins'),
            child: Column(
              children: [
                Text(
                  'Processing...',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Please wait',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
