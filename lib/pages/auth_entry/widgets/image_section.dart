part of '../auth_entry_page.dart';

class _ImageSection extends StatelessWidget {
  const _ImageSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(),
              Positioned.fill(
                child: Image.asset(
                  'assets/images/cuisine.jpg', // Todo: Need a better image
                  fit: BoxFit.cover,
                ),
              ),
              const Column(
                children: [
                  Expanded(flex: 1, child: SizedBox.expand()),
                  Expanded(flex: 5, child: ScannerOverlayBox()),
                  Expanded(flex: 2, child: SizedBox.expand()),
                ],
              ),
            ],
          ),
        ),
        const Expanded(child: SizedBox.expand()),
      ],
    );
  }
}
