import 'dart:math';

import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../config/theme_extension.dart';
import '../../data/audio_repository.dart';
import '../../data/image_repository.dart';
import '../inventory_items/card_flip.dart';
import '../inventory_items/confetti.dart';
import '../inventory_items/digital_rain.dart';
import '../inventory_items/fetch_image.dart';
import '../inventory_items/flash_effect.dart';
import '../inventory_items/frame_inventory_item.dart';
import '../inventory_items/interactive_plate.dart';
import '../inventory_items/shader_glitch.dart';
import '../inventory_items/shader_flashlight.dart';
import '../inventory_items/shader_magic.dart';
import '../inventory_items/shader_pixelation.dart';
import '../inventory_items/shader_plate.dart';
import '../inventory_items/shader_rain_window.dart';
import '../inventory_items/shader_ripple.dart';
import '../inventory_items/shader_night_vision.dart';
import '../inventory_items/shader_smoke.dart';
import '../inventory_items/shader_water.dart';
import '../inventory_items/shimmer_effect.dart';
import '../inventory_items/sitting_me.dart';
import '../inventory_items/sun_moon_switch.dart';
import '../inventory_items/target_plate.dart';
import 'app_bar/app_bar_home.dart';
import 'music_control/view_music_control.dart';
import 'page_contact.dart';
import 'page_menu.dart';
import 'scroll_indicator.dart';
import 'sliver_intro.dart';

class PageHome extends StatefulWidget {
  const PageHome({super.key});

  static PageHomeState of(BuildContext context) {
    return context.findAncestorStateOfType<PageHomeState>()!;
  }

  @override
  State<PageHome> createState() => PageHomeState();
}

class PageHomeState extends State<PageHome> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  static const _pictureRatio = 3 / 4;
  final List<Widget> _inventoryItems = [];

  bool _openMenu = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    ImageRepository().preCacheImages(context);
    AudioRepository().preCacheAudios();

    _inventoryItems
      ..clear()
      ..add(
        FrameInventoryItem(
          title: S.of(context).sunMoonSwitchTitle,
          child: SunMoonSwitch(onChanged: (onChanged) {}),
        ),
      )
      ..add(
        FrameInventoryItem(
          title: S.of(context).shimmerEffectTitle,
          child: const WidgetSampleShimmer(),
        ),
      )
      ..add(
        FrameInventoryItem(
          title: S.of(context).confettiTitle,
          child: const Confetti(),
        ),
      )
      ..add(
        FrameInventoryItem(
          title: S.of(context).digitalRainTitle,
          child: const DigitalRain(),
        ),
      )
      ..add(
        FrameInventoryItem(
          title: S.of(context).shaderMagicTitle,
          child: const ShaderMagic(),
        ),
      )
      ..add(
        FrameInventoryItem(
          title: S.of(context).shaderWaterTitle,
          child: const ShaderWater(),
        ),
      )
      ..add(
        FrameInventoryItem(
          title: S.of(context).shaderGlitchTitle,
          child: const ShaderGlitch(),
        ),
      )
      ..add(
        FrameInventoryItem(
          title: S.of(context).shaderPixelationTitle,
          child: const ShaderPixelation(),
        ),
      )
      ..add(
        FrameInventoryItem(
          title: S.of(context).shaderFlashlightTitle,
          child: const ShaderFlashlight(),
        ),
      )
      ..add(
        FrameInventoryItem(
          title: S.of(context).shaderRippleTitle,
          child: const ShaderRipple(),
        ),
      )
      ..add(
        FrameInventoryItem(
          title: S.of(context).shaderSmokeTitle,
          child: const ShaderSmoke(),
        ),
      )
      ..add(
        FrameInventoryItem(
          title: S.of(context).shaderNightVisionTitle,
          child: const ShaderNightVision(),
        ),
      )
      ..add(
        FrameInventoryItem(
          title: S.of(context).shaderRainWindowTitle,
          child: const ShaderRainWindow(),
        ),
      )
      ..add(
        FrameInventoryItem(
          title: S.of(context).interactivePlateTitle,
          child: const InteractivePlate(),
        ),
      )
      ..add(
        FrameInventoryItem(
          title: S.of(context).circleCollisionTitle,
          child: const TargetPlate(),
        ),
      )
      ..add(
        FrameInventoryItem(
          title: S.of(context).flashEffectTitle,
          child: const FlashEffect(),
        ),
      )
      ..add(
        FrameInventoryItem(
          title: S.of(context).cardFlipTitle,
          child: const CardFlip(),
        ),
      )
      ..add(
        FrameInventoryItem(
          title: S.of(context).shaderMaskTitle,
          child: const ShaderPlate(),
        ),
      )
      ..add(
        FrameInventoryItem(
          title: S.of(context).fetchImageTitle,
          child: const FetchImage(),
        ),
      );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          PageMenu(animateTo: animateTo, toggleMenu: toggleMenu),
          _menuTransitionAnimation(
            transitionBody: Stack(
              children: [
                CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverIntro(
                      child: SizedBox(
                        height: MediaQuery.sizeOf(context).height,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        color: Theme.of(context)
                            .extension<ExtensionColors>()
                            ?.backgroundColor,
                        height: MediaQuery.sizeOf(context).height,
                        alignment: Alignment.center,
                        child: ListenableBuilder(
                          listenable: _scrollController,
                          builder: (context, child) {
                            double screenRatio =
                                MediaQuery.sizeOf(context).width /
                                    MediaQuery.sizeOf(context).height;

                            return SizedBox(
                              height: MediaQuery.sizeOf(context).height,
                              child: ClipRect(
                                child: AnimatedContainer(
                                  width: screenRatio < _pictureRatio
                                      ? MediaQuery.sizeOf(context).width *
                                          (1.0 -
                                              (0.2 *
                                                  (min(
                                                          _scrollController
                                                              .offset,
                                                          MediaQuery.sizeOf(context)
                                                              .height) /
                                                      (MediaQuery.sizeOf(context)
                                                          .height))))
                                      : MediaQuery.sizeOf(context).width *
                                              (1 -
                                                  (min(
                                                          _scrollController
                                                              .offset,
                                                          MediaQuery.sizeOf(context)
                                                              .height) /
                                                      (MediaQuery.sizeOf(context)
                                                          .height))) +
                                          (MediaQuery.sizeOf(context).height *
                                              (min(_scrollController.offset,
                                                      MediaQuery.sizeOf(context).height) /
                                                  (MediaQuery.sizeOf(context).height)) *
                                              _pictureRatio),
                                  height: screenRatio < _pictureRatio
                                      ? MediaQuery.sizeOf(context).height *
                                              (1 -
                                                  (min(
                                                          _scrollController
                                                              .offset,
                                                          MediaQuery.sizeOf(context)
                                                              .height) /
                                                      (MediaQuery.sizeOf(context)
                                                          .height))) +
                                          (MediaQuery.sizeOf(context).width *
                                              (min(
                                                      _scrollController.offset,
                                                      MediaQuery.sizeOf(context)
                                                          .height) /
                                                  (MediaQuery.sizeOf(context)
                                                      .height)) /
                                              _pictureRatio)
                                      : MediaQuery.sizeOf(context).height *
                                          (1.0 -
                                              (0.2 *
                                                  (min(_scrollController.offset,
                                                          MediaQuery.sizeOf(context).height) /
                                                      (MediaQuery.sizeOf(context).height)))),
                                  duration: const Duration(milliseconds: 200),
                                  child: OverflowBox(
                                    maxWidth: MediaQuery.sizeOf(context).width,
                                    maxHeight:
                                        MediaQuery.sizeOf(context).height,
                                    child: SizedBox(
                                      width: MediaQuery.sizeOf(context).width,
                                      height: MediaQuery.sizeOf(context).height,
                                      child: AnimatedScale(
                                        scale: 1.0 -
                                            ((screenRatio < _pictureRatio
                                                    ? 1 -
                                                        (MediaQuery.sizeOf(
                                                                    context)
                                                                .width *
                                                            0.9 *
                                                            1 /
                                                            _pictureRatio /
                                                            MediaQuery.sizeOf(
                                                                    context)
                                                                .height)
                                                    : 1 -
                                                        (MediaQuery.sizeOf(
                                                                    context)
                                                                .height *
                                                            0.9 *
                                                            _pictureRatio /
                                                            MediaQuery.sizeOf(
                                                                    context)
                                                                .width)) *
                                                (min(
                                                        _scrollController
                                                            .offset,
                                                        MediaQuery.sizeOf(
                                                                context)
                                                            .height) /
                                                    (MediaQuery.sizeOf(context)
                                                        .height))),
                                        duration:
                                            const Duration(milliseconds: 200),
                                        child: child,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: Image.asset(
                              'assets/images/me.jpeg',
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverMainAxisGroup(slivers: [
                      SliverAppBar(
                        backgroundColor: Theme.of(context)
                            .extension<ExtensionColors>()!
                            .backgroundColor,
                        title: Text(S.of(context).inventory),
                        centerTitle: true,
                        pinned: true,
                        surfaceTintColor: Colors.transparent,
                      ),
                      SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 500,
                          mainAxisSpacing: 50.0,
                          crossAxisSpacing: 50.0,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext _, int index) {
                            return _inventoryItems[index];
                          },
                          childCount: _inventoryItems.length,
                        ),
                      ),
                    ]),
                    SliverToBoxAdapter(
                      child: Stack(
                        children: [
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height,
                            child: const PageContact(),
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height,
                            child: const SittingMe(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const ViewMusicControl(),
                Positioned(
                  left: 0,
                  right: 0,
                  height: 40,
                  bottom: 16,
                  child: Center(
                    child: ListenableBuilder(
                        listenable: _scrollController,
                        builder: (context, child) {
                          if (_scrollController.offset < 500) {
                            return AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.fastOutSlowIn,
                              opacity:
                                  _scrollController.offset == 0 ? 1.0 : 0.0,
                              child: child,
                            );
                          }
                          return const SizedBox.shrink();
                        },
                        child: const ScrollIndicator()),
                  ),
                ),
              ],
            ),
          ),
          const AppBarHome(),
        ],
      ),
    );
  }

  Widget _menuTransitionAnimation({required Widget transitionBody}) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: _openMenu ? 20 * pi / 180 : 0),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Transform(
          alignment: Alignment.centerRight,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(value),
          child: AnimatedContainer(
            transformAlignment: Alignment.centerRight,
            transform: Matrix4.identity()
              ..translateByDouble(_openMenu ? -20.0 : 0, 1, 1, 1)
              ..scaleByDouble(_openMenu ? 0.7 : 1, 1, 1, 1),
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 300),
            child: child,
          ),
        );
      },
      child: ClipRect(
        clipBehavior: Clip.antiAlias,
        child: ColoredBox(
          color:
              Theme.of(context).extension<ExtensionColors>()!.backgroundColor!,
          child: transitionBody,
        ),
      ),
    );
  }

  void toggleMenu() {
    setState(() {
      _openMenu = !_openMenu;
    });
  }

  void animateTo(double targetOffset) async {
    toggleMenu();
    if (_scrollController.hasClients) {
      if (targetOffset == 9999) {
        targetOffset = _scrollController.position.maxScrollExtent;
        await _scrollController.animateTo(targetOffset,
            duration: const Duration(milliseconds: 500),
            curve: Curves.decelerate);
        return;
      }

      await _scrollController.animateTo(targetOffset,
          duration: const Duration(milliseconds: 500),
          curve: Curves.decelerate);
    }
  }
}
