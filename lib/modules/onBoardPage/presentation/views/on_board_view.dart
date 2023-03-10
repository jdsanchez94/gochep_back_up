import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gochep/generated/l10n.dart';
import 'package:gochep/modules/onBoardPage/bloc/onboard_bloc.dart';
import 'package:gochep/modules/splash/presentation/views/splash_view.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingView extends HookWidget {
  final _introKey = GlobalKey<IntroductionScreenState>();

  OnBoardingView({super.key});

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return Scaffold(
      body: BlocProvider(
          create: (context) => OnboardBloc(),
          child: BlocConsumer<OnboardBloc, OnboardState>(
              builder: (context, state) {
            return IntroductionScreen(
              key: _introKey,
              globalBackgroundColor: Colors.white,
              allowImplicitScrolling: true,
              globalHeader: Align(
                alignment: Alignment.topRight,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16, right: 16),
                    child: _buildImage('flutter.png', 100),
                  ),
                ),
              ),
              globalFooter: SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                    child: Text(
                      S.current.onBoardingViewLetDone,
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      context.read<OnboardBloc>().add(OnboardDoneEvent());
                    }),
              ),
              pages: [
                PageViewModel(
                  title: 'Fractional shares',
                  body:
                      'Instead of having to buy an entire share, invest any amount you want.',
                  image: _buildImage('img1.jpg'),
                  decoration: pageDecoration,
                ),
                PageViewModel(
                  title: 'Learn as you go',
                  body:
                      'Download the Stockpile app and master the market with our mini-lesson.',
                  image: _buildImage('img2.jpg'),
                  decoration: pageDecoration,
                ),
                PageViewModel(
                  title: 'Kids and teens',
                  body:
                      'Kids and teens can track their stocks 24/7 and place trades that you approve.',
                  image: _buildImage('img3.jpg'),
                  decoration: pageDecoration,
                ),
                PageViewModel(
                  title: 'Title of last page - reversed',
                  bodyWidget: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Click on ', style: bodyStyle),
                      Icon(Icons.edit),
                      Text(' to edit a post', style: bodyStyle),
                    ],
                  ),
                  decoration: pageDecoration.copyWith(
                    bodyFlex: 2,
                    imageFlex: 4,
                    bodyAlignment: Alignment.bottomCenter,
                    imageAlignment: Alignment.topCenter,
                  ),
                  image: _buildImage('img1.jpg'),
                  reverse: false,
                ),
              ],
              onDone: () => context.read<OnboardBloc>().add(OnboardDoneEvent()),
              showSkipButton: false,
              skipOrBackFlex: 0,
              nextFlex: 0,
              showBackButton: true,
              back: const Icon(Icons.arrow_back),
              next: const Icon(Icons.arrow_forward),
              done: Text(S.current.done,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              curve: Curves.fastLinearToSlowEaseIn,
              controlsMargin: const EdgeInsets.all(16),
              controlsPadding: kIsWeb
                  ? const EdgeInsets.all(12.0)
                  : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
              dotsDecorator: const DotsDecorator(
                size: Size(10.0, 10.0),
                color: Color(0xFFBDBDBD),
                activeSize: Size(22.0, 10.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
              dotsContainerDecorator: const ShapeDecoration(
                color: Colors.black87,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
            );
          }, listener: (context, state) {
            if (state is OnBoardStateIsInAuthView) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: ((context) => const SplashView())),
                  (route) => false);
            }
          })),
    );
  }
}
