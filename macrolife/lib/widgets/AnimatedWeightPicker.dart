import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore_for_file: constant_identifier_names, camel_case_types

enum INTERVAL_TYPE {
  MAJOR,
  SUB,
  MINOR,
  NONE,
}

final RegExp _regex = RegExp(r"([.]*0+)(?!.*\d)");

extension Ex on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
  String trimTrallingZero() => toString().replaceAll(_regex, '');
}

class WheelModel {
  final String value;
  final INTERVAL_TYPE interval;
  WheelModel(this.value, this.interval);
}

class AnimatedWeightPicker extends StatefulWidget {
  final double min;
  final double max;
  final double division;
  final double squeeze;
  final double dialHeight;
  final double dialThickness;
  final Color dialColor;
  final int majorIntervalAt;
  final double majorIntervalHeight;
  final double majorIntervalThickness;
  final Color majorIntervalColor;
  final bool showMajorIntervalText;
  final double majorIntervalTextSize;
  final Color majorIntervalTextColor;
  final int subIntervalAt;
  final double subIntervalHeight;
  final double subIntervalThickness;
  final Color subIntervalColor;
  final bool showSubIntervalText;
  final double subIntervalTextSize;
  final Color subIntervalTextColor;
  final double minorIntervalHeight;
  final double minorIntervalThickness;
  final Color minorIntervalColor;
  final bool showMinorIntervalText;
  final double minorIntervalTextSize;
  final Color minorIntervalTextColor;
  final bool showSelectedValue;
  final Color selectedValueColor;
  final TextStyle? selectedValueStyle;
  final bool showSuffix;
  final String suffixText;
  final Color suffixTextColor;
  final Widget? suffix;
  final Function(String newValue)? onChange;
  final double? initialValue;
  const AnimatedWeightPicker({
    super.key,
    required this.min,
    required this.max,
    this.division = 0.5,
    this.squeeze = 2.5,
    this.dialHeight = 50,
    this.dialThickness = 1.5,
    this.dialColor = Colors.green,
    this.majorIntervalAt = 10,
    this.majorIntervalHeight = 18,
    this.majorIntervalThickness = 1,
    this.majorIntervalColor = Colors.grey,
    this.showMajorIntervalText = true,
    this.majorIntervalTextSize = 15,
    this.majorIntervalTextColor = Colors.grey,
    this.minorIntervalHeight = 10,
    this.minorIntervalThickness = 1,
    this.minorIntervalColor = Colors.grey,
    this.showMinorIntervalText = false,
    this.minorIntervalTextSize = 15,
    this.minorIntervalTextColor = Colors.grey,
    this.subIntervalAt = 5,
    this.subIntervalHeight = 15,
    this.subIntervalThickness = 1,
    this.subIntervalColor = Colors.grey,
    this.showSubIntervalText = false,
    this.subIntervalTextSize = 5,
    this.subIntervalTextColor = Colors.grey,
    this.showSelectedValue = true,
    this.selectedValueColor = Colors.green,
    this.selectedValueStyle,
    this.showSuffix = true,
    this.suffixText = 'Kg',
    this.suffixTextColor = Colors.green,
    this.suffix,
    this.onChange,
    this.initialValue,
  })  : assert(!(max < min)),
        assert(!(min == max)),
        assert(!(max < 1)),
        assert(!(min < 0)),
        assert(!(max > 1000)),
        assert(!(dialHeight > 110 || dialHeight < 3)),
        assert(!(dialThickness > 5 || dialThickness < 0.5)),
        assert(!(majorIntervalHeight > 110 || majorIntervalHeight < 3)),
        assert(!(majorIntervalAt > max || majorIntervalAt < 1)),
        assert(!(majorIntervalThickness > 5 || majorIntervalThickness < 0.5)),
        assert(!(minorIntervalHeight > 110 || minorIntervalHeight < 3)),
        assert(!(minorIntervalThickness > 5 || minorIntervalThickness < 0.5)),
        assert(!(subIntervalAt > max || subIntervalAt < 1)),
        assert(!(subIntervalHeight > 110 || subIntervalHeight < 3)),
        assert(!(subIntervalThickness > 5 || subIntervalThickness < 0.5)),
        assert(!(majorIntervalTextSize > 20 || majorIntervalTextSize < 1)),
        assert(!(minorIntervalTextSize > 20 || minorIntervalTextSize < 1)),
        assert(!(subIntervalTextSize > 20 || subIntervalTextSize < 1)),
        assert(!(division < 0.1 || division > 1)),
        assert(squeeze > 0),
        assert(!(initialValue != null &&
            (initialValue < min || initialValue > max)));

  @override
  State<AnimatedWeightPicker> createState() => _AnimatedWeightPickerState();
}

class _AnimatedWeightPickerState extends State<AnimatedWeightPicker> {
  final int _divisionPrecision = 1;
  final int _valuePrecision = 1;

  final List<WheelModel> _valueList = [];
  int _selectedIndex = 0;

  final _scrollController = FixedExtentScrollController();

  @override
  void initState() {
    super.initState();
    createWeightList(onInit: true);
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      scrollToInitialValue();
    });
  }

  void scrollToInitialValue() {
    if (widget.initialValue != null) {
      final initialIndex = _valueList.indexWhere(
        (element) => double.parse(element.value) == widget.initialValue,
      );
      if (initialIndex == -1) return;
      _scrollController.jumpToItem(initialIndex);
    }
  }

  void createWeightList({required bool onInit}) {
    _valueList.clear();
    double current = widget.min;
    double interval = widget.division.toPrecision(_divisionPrecision);

    int mjInterval = 0;
    int subInterval = widget.subIntervalAt;
    int mnInterval = 1;
    int currentIndex = 0;

    do {
      _valueList.add(
        WheelModel(
          current.toPrecision(_valuePrecision).trimTrallingZero(),
          currentIndex == 0
              ? INTERVAL_TYPE.MINOR
              : mjInterval == currentIndex
                  ? INTERVAL_TYPE.MAJOR
                  : subInterval == currentIndex
                      ? INTERVAL_TYPE.SUB
                      : mnInterval == currentIndex
                          ? INTERVAL_TYPE.MINOR
                          : INTERVAL_TYPE.NONE,
        ),
      );
      if (currentIndex == mjInterval) mjInterval += widget.majorIntervalAt;
      if (currentIndex == subInterval) subInterval += widget.subIntervalAt * 2;
      if (currentIndex == mnInterval) mnInterval += 1;

      currentIndex++;
      current += interval;
    } while (current.toPrecision(2) <= widget.max);
    if (!onInit) setState(() {});
  }

  @override
  void didUpdateWidget(covariant AnimatedWeightPicker old) {
    super.didUpdateWidget(old);
    if (old.max == widget.max &&
        old.min == widget.min &&
        old.division.toPrecision(_divisionPrecision) ==
            widget.division.toPrecision(_divisionPrecision)) return;
    createWeightList(onInit: false);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      // alignment: AlignmentDirectional.bottomEnd,
      // mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ClipPath(
          clipper: ClipPathCustom(),
          child: Container(
            width: double.infinity,
            height: 290,
            padding: const EdgeInsets.only(top: 100, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: SizedBox(
              width: double.infinity,
              child: RotatedBox(
                quarterTurns: -45,
                child: ListWheelScrollView.useDelegate(
                  physics: const FixedExtentScrollPhysics(),
                  controller: _scrollController,
                  offAxisFraction: 2.8,
                  perspective: 0.002,
                  itemExtent: 20,
                  squeeze: widget.squeeze,
                  overAndUnderCenterOpacity: 1,
                  clipBehavior: Clip.none,
                  onSelectedItemChanged: (index) {
                    setState(() => _selectedIndex = index);
                    if (Platform.isIOS) {
                      HapticFeedback.mediumImpact();
                    }
                    if (widget.onChange == null) return;
                    widget.onChange!(_valueList[index].value);
                  },
                  renderChildrenOutsideViewport: true,
                  childDelegate: ListWheelChildLoopingListDelegate(
                    children: List<Widget>.generate(
                      _valueList.length,
                      growable: false,
                      (index) {
                        bool isSelected = _selectedIndex == index;
                        bool isMajorInterval = !isSelected &&
                            _valueList[index].interval == INTERVAL_TYPE.MAJOR &&
                            (_selectedIndex != 0 ||
                                _valueList.length - 1 != index);
                        bool isSubInterval = !isSelected &&
                            !isMajorInterval &&
                            _valueList[index].interval == INTERVAL_TYPE.SUB &&
                            index != _valueList.length - 1;
                        bool isMinorInterval = !isSelected &&
                            !isMajorInterval &&
                            !isSubInterval &&
                            (_valueList[index].interval ==
                                    INTERVAL_TYPE.MINOR ||
                                index == _valueList.length - 1);

                        return RotatedBox(
                          quarterTurns: 45,
                          child: Container(
                            height: double.infinity - 10,
                            alignment: Alignment.topCenter,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: isSelected
                                      ? widget.dialHeight
                                      : isMajorInterval
                                          ? widget.majorIntervalHeight
                                          : isSubInterval
                                              ? widget.subIntervalHeight
                                              : isMinorInterval
                                                  ? widget.minorIntervalHeight
                                                  : null,
                                  child: VerticalDivider(
                                    thickness: isSelected
                                        ? widget.dialThickness
                                        : isMajorInterval
                                            ? widget.majorIntervalThickness
                                            : isSubInterval
                                                ? widget.subIntervalThickness
                                                : isMinorInterval
                                                    ? widget
                                                        .minorIntervalThickness
                                                    : null,
                                    color: isSelected
                                        ? widget.dialColor
                                        : isMajorInterval
                                            ? widget.majorIntervalColor
                                            : isSubInterval
                                                ? widget.subIntervalColor
                                                : isMinorInterval
                                                    ? widget.minorIntervalColor
                                                    : null,
                                    endIndent: 0,
                                    indent: 0,
                                  ),
                                ),
                                if ((widget.showMajorIntervalText && isMajorInterval) ||
                                    (widget.showMinorIntervalText &&
                                        isMinorInterval) ||
                                    (widget.showSubIntervalText &&
                                        isSubInterval))
                                  Text(
                                    _valueList[index].value,
                                    maxLines: 1,
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                      fontSize: _valueList[index]
                                                  .value
                                                  .length >=
                                              4
                                          ? 12
                                          : isMajorInterval
                                              ? widget.majorIntervalTextSize
                                              : isSubInterval
                                                  ? widget.subIntervalTextSize
                                                  : widget
                                                      .minorIntervalTextSize,
                                      color: isMajorInterval
                                          ? widget.majorIntervalTextColor
                                          : isSubInterval
                                              ? widget.subIntervalTextColor
                                              : widget.minorIntervalTextColor,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -210,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 290,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(200),
                    topRight: Radius.circular(200))),
          ),
        ),
      ],
    );
  }
}

class ClipPathCustom extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.0021000, size.height * 0.4089000);
    path_0.lineTo(size.width * -0.0035000, size.height * 1);
    path_0.quadraticBezierTo(size.width * 0.5, size.height * 0.3548000,
        size.width * 1, size.height * 0.9870000);
    path_0.cubicTo(size.width * 1, size.height * 0.7378750, size.width * 1,
        size.height * 0.5748000, size.width * 1, size.height * 0.4374000);
    path_0.quadraticBezierTo(size.width * 0.5, size.height * -0.0580000,
        size.width * 0.0021000, size.height * 0.4089000);
    path_0.close();

    return path_0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

// class ClipPathCustom2 extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     // Layer 1

//     Path path_0 = Path();
//     path_0.moveTo(size.width * 0.0021000, size.height * 0.4089000);
//     path_0.lineTo(size.width * -0.0035000, size.height * 0.9877000);
//     path_0.quadraticBezierTo(size.width * 0.5110000, size.height * 0.9721000,
//         size.width * 0.9951000, size.height * 0.9870000);
//     path_0.cubicTo(
//         size.width * 0.9981250,
//         size.height * 0.7378750,
//         size.width * 1.0015500,
//         size.height * 0.5748000,
//         size.width * 1.0037000,
//         size.height * 0.4374000);
//     path_0.quadraticBezierTo(size.width * 0.5, size.height * -10.100001,
//         size.width * 0.0021000, size.height * 0.4089000);
//     path_0.close();

//     return path_0;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }
class ClipPathCustom2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * -0.0025000, size.height * 0.3270700);
    path_0.lineTo(size.width * -0.0004667, size.height * 0.3509500);
    path_0.lineTo(size.width * 1, size.height * 0.3502200);
    path_0.quadraticBezierTo(size.width * 0.9989667, size.height * 0.3334600,
        size.width * 0.9986667, size.height * 0.3304000);
    path_0.quadraticBezierTo(size.width * 0.5227667, size.height * 0.1644800,
        size.width * -0.0025000, size.height * 0.3270700);
    path_0.close();

    // Layer 1

    return path_0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}




// if (widget.showSelectedValue)
        //   Column(
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       Text(
        //         _valueList[_selectedIndex].value,
        //         style: widget.selectedValueStyle ??
        //             TextStyle(
        //               fontWeight: FontWeight.w700,
        //               fontSize: 30,
        //               height: 1,
        //               color: widget.selectedValueColor,
        //             ),
        //       ),
        //       if (widget.showSuffix && widget.suffix == null)
        //         Text(widget.suffixText,
        //             style: TextStyle(color: widget.suffixTextColor))
        //       else if (widget.showSuffix && widget.suffix != null)
        //         widget.suffix!
        //     ],
        //   ),