import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../ui/styles/dimens.dart';

typedef BodyBuilder = Widget Function(
    BuildContext context, ScrollController childScrollController);

class BaseScaffoldBody extends HookWidget {
  final BodyBuilder builder;
  final bool fillScreen;
  final EdgeInsets? padding;

  const BaseScaffoldBody({
    Key? key,
    required this.builder,
    this.fillScreen = true,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = useScrollController();
    ScrollController childScrollController = useScrollController();

    childScrollController.addListener(() {
      if (childScrollController.offset >=
          childScrollController.position.maxScrollExtent * 0.8) {
        scrollController.animateTo(childScrollController.offset,
            duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
      }
      if (childScrollController.offset == 0) {
        scrollController.animateTo(childScrollController.offset,
            duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
      }
    });

    return Padding(
      padding: padding ?? Dimens.screenPadding,
      child: LayoutBuilder(builder: (context, constraint) {
        return ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraint.minHeight),
          child: SingleChildScrollView(
            controller: scrollController,
            child: IntrinsicHeight(
              child: Container(
                  constraints: fillScreen
                      ? BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height * 0.85)
                      : null,
                  child: builder(context, childScrollController)),
            ),
          ),
        );
      }),
    );
  }
}