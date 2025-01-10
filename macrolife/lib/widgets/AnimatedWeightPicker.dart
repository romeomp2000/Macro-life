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
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -30,
          left: 0,
          right: 0,
          child: Image.asset(
            'assets/icons/fondo_circular_bascula_2800x1400_ (1) (1).png',
            width: double.infinity,
            // opacity: const AlwaysStoppedAnimation(.5),
          ),
        ),
        SizedBox(
          height: 120,
          width: double.infinity,
          child: RotatedBox(
            quarterTurns: -45,
            child: ListWheelScrollView.useDelegate(
              physics: const FixedExtentScrollPhysics(),
              controller: _scrollController,
              offAxisFraction: 3.5,
              perspective: 0.003,
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
                        (_selectedIndex != 0 || _valueList.length - 1 != index);
                    bool isSubInterval = !isSelected &&
                        !isMajorInterval &&
                        _valueList[index].interval == INTERVAL_TYPE.SUB &&
                        index != _valueList.length - 1;
                    bool isMinorInterval = !isSelected &&
                        !isMajorInterval &&
                        !isSubInterval &&
                        (_valueList[index].interval == INTERVAL_TYPE.MINOR ||
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
                                                ? widget.minorIntervalThickness
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
                                (widget.showSubIntervalText && isSubInterval))
                              Text(
                                _valueList[index].value,
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  fontSize: _valueList[index].value.length >= 4
                                      ? 12
                                      : isMajorInterval
                                          ? widget.majorIntervalTextSize
                                          : isSubInterval
                                              ? widget.subIntervalTextSize
                                              : widget.minorIntervalTextSize,
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
        if (widget.showSelectedValue)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _valueList[_selectedIndex].value,
                style: widget.selectedValueStyle ??
                    TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                      height: 1,
                      color: widget.selectedValueColor,
                    ),
              ),
              if (widget.showSuffix && widget.suffix == null)
                Text(widget.suffixText,
                    style: TextStyle(color: widget.suffixTextColor))
              else if (widget.showSuffix && widget.suffix != null)
                widget.suffix!
            ],
          ),
      ],
    );
  }
}
