import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SimpleRulerPicker extends StatefulWidget {
  final int minValue;
  final int maxValue;
  final int initialValue;
  final int? currentWeight;
  final double scaleLabelSize;
  final double scaleLabelWidth;
  final double scaleBottomPadding;
  final int scaleItemWidth;
  final ValueChanged<int>? onValueChanged;
  final double longLineHeight;
  final double shortLineHeight;
  final Color lineColor;
  final Color selectedColor;
  final Color labelColor;
  final double lineStroke;
  final double height;
  final Axis axis;
  final String unitString;
  final bool mostrar;
  final bool isLeft;

  const SimpleRulerPicker({
    super.key,
    this.minValue = 0,
    this.maxValue = 200,
    this.initialValue = 100,
    this.currentWeight, // Default: peso actual
    this.onValueChanged,
    this.scaleLabelSize = 14,
    this.scaleLabelWidth = 40,
    this.scaleBottomPadding = 6,
    this.scaleItemWidth = 10,
    this.longLineHeight = 4,
    this.shortLineHeight = 12,
    this.lineColor = Colors.grey,
    this.selectedColor = Colors.orange,
    this.labelColor = Colors.grey,
    this.lineStroke = 2,
    this.height = 100,
    this.axis = Axis.horizontal,
    this.mostrar = false,
    this.isLeft = true,
    required this.unitString,
  }) : assert(
          minValue <= initialValue &&
              initialValue <= maxValue &&
              minValue < maxValue,
        );

  @override
  _SimpleRulerPickerState createState() => _SimpleRulerPickerState();
}

class _SimpleRulerPickerState extends State<SimpleRulerPicker> {
  late ScrollController _scrollController;
  late int _selectedValue;
  bool _isPosFixed = false;

  bool get _isHorizontalAxis => widget.axis == Axis.horizontal;

  int getScrolledItemIndex(double scrolledPixels, int itemWidth) {
    return scrolledPixels ~/ itemWidth;
  }

  bool onNotification(ScrollNotification scrollNotification) {
    if (scrollNotification is ScrollEndNotification) {
      final scrollPixels = scrollNotification.metrics.pixels;
      if (!_isPosFixed) {
        final jumpIndex =
            getScrolledItemIndex(scrollPixels, widget.scaleItemWidth);

        final jumpPixels =
            (jumpIndex * widget.scaleItemWidth) + (widget.scaleItemWidth / 2);

        Future.delayed(const Duration(milliseconds: 100)).then((_) {
          _isPosFixed = true;
          _scrollController.jumpTo(
            jumpPixels,
          );
        });
      }
    }
    return true;
  }

  void calculateNewValue(double scrollPixels) {
    final scrollPixels = _scrollController.position.pixels;
    final jumpIndex = getScrolledItemIndex(scrollPixels, widget.scaleItemWidth);
    final jumpValue = jumpIndex + widget.minValue;
    final newValue = jumpValue.clamp(widget.minValue, widget.maxValue);
    if (newValue != _selectedValue) {
      setState(() {
        _selectedValue = newValue.toInt();
      });
      if (Platform.isIOS) {
        HapticFeedback.lightImpact();
      }
      widget.onValueChanged?.call(_selectedValue);
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
    final rangeFromMinValue = widget.initialValue - widget.minValue;

    final initialItemMiddlePixels =
        (rangeFromMinValue * widget.scaleItemWidth) +
            (widget.scaleItemWidth / 2);

    _scrollController = ScrollController(
      initialScrollOffset: initialItemMiddlePixels,
    );

    _scrollController.addListener(() {
      calculateNewValue(_scrollController.position.pixels);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Listener(
            onPointerDown: (event) {
              FocusScope.of(context).requestFocus(FocusNode());
              _isPosFixed = false;
            },
            child: NotificationListener(
              onNotification: onNotification,
              child: LayoutBuilder(
                builder: (context, constraints) => ListView.builder(
                  padding: _isHorizontalAxis
                      ? EdgeInsets.only(
                          left: constraints.maxWidth / 2,
                          right: constraints.maxWidth / 2,
                        )
                      : EdgeInsets.only(
                          top: constraints.maxHeight / 2,
                          bottom: constraints.maxHeight / 2,
                        ),
                  controller: _scrollController,
                  scrollDirection: widget.axis,
                  itemCount: (widget.maxValue - widget.minValue) + 1,
                  itemBuilder: (context, index) {
                    final int value = widget.minValue + index;
                    return SizedBox(
                      width: _isHorizontalAxis
                          ? widget.scaleItemWidth.toDouble()
                          : null,
                      height: _isHorizontalAxis
                          ? null
                          : widget.scaleItemWidth.toDouble(),
                      child: CustomPaint(
                        painter: _RulerPainter(
                          value: value,
                          isLeft: widget.isLeft,
                          selectedValue: _selectedValue,
                          currentWeight: widget.currentWeight,
                          scaleLabelSize: widget.scaleLabelSize,
                          scaleBottomPadding: widget.scaleBottomPadding,
                          longLineHeight: widget.longLineHeight,
                          shortLineHeight: widget.shortLineHeight,
                          lineColor: widget.lineColor,
                          selectedColor: widget.selectedColor,
                          labelColor: widget.labelColor,
                          lineStroke: widget.lineStroke,
                          axis: widget.axis,
                          maxScaleLabelWidth: widget.scaleLabelWidth,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          _isHorizontalAxis
              ? _VerticalPointer(
                  mostrar: widget.mostrar,
                  isLeft: widget.isLeft,
                  selectedValue: _selectedValue,
                  selectedColor: widget.selectedColor,
                  longLineHeight: widget.longLineHeight,
                  scaleLabelSize: widget.scaleLabelSize,
                  scaleBottomPadding: widget.scaleBottomPadding,
                  unitString: widget.unitString,
                  // alignLeft: true,
                )
              : _HorizontalPointer(
                  selectedValue: _selectedValue,
                  selectedColor: widget.selectedColor,
                  longLineHeight: widget.longLineHeight,
                  scaleLabelWidth: widget.scaleLabelWidth,
                  scaleBottomPadding: widget.scaleBottomPadding,
                  unitString: widget.unitString,
                  isLeft: widget.isLeft,
                  // alignLeft: true,
                ),
        ],
      ),
    );
  }
}

// Modifica el `_RulerPainter` para sombrear entre las líneas aquí

class _RulerPainter extends CustomPainter {
  final int value;
  final int selectedValue;
  final int? currentWeight; // Nueva propiedad
  final double scaleLabelSize;
  final double scaleBottomPadding;
  final double longLineHeight;
  final double shortLineHeight;
  final Color lineColor;
  final Color selectedColor;
  final Color labelColor;
  final double lineStroke;
  final Axis axis;
  final double maxScaleLabelWidth;
  final bool isLeft;

  _RulerPainter({
    required this.value,
    required this.selectedValue,
    this.currentWeight,
    required this.scaleLabelSize,
    required this.scaleBottomPadding,
    required this.longLineHeight,
    required this.shortLineHeight,
    required this.lineColor,
    required this.selectedColor,
    required this.labelColor,
    required this.lineStroke,
    required this.axis,
    required this.isLeft,
    required this.maxScaleLabelWidth,
  });

  bool get _isHorizontalAxis => axis == Axis.horizontal;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = lineColor
      ..strokeWidth = lineStroke
      ..style = PaintingStyle.stroke;

    // final Paint selectedPaint = Paint()
    //   ..color = selectedColor
    //   ..strokeWidth = lineStroke
    //   ..style = PaintingStyle.stroke;

    final Paint shadowPaint = Paint()
      ..color = Colors.grey.withOpacity(0.2) // Sombra gris
      ..style = PaintingStyle.fill;

    final double position = _isHorizontalAxis
        ? size.width / 10
        : isLeft
            ? (size.height / 2)
            : ((size.height / 2));

    // Dibujar las líneas principales y secundarias
    if (value % 10 == 0) {
      // Línea larga con etiqueta
      final Offset start = _isHorizontalAxis
          ? Offset(position, 0)
          : Offset(isLeft ? 0 : (500), position);
      // : Offset(0, position);
      final Offset end = _isHorizontalAxis
          ? Offset(position, longLineHeight)
          // : Offset(longLineHeight, position);
          : Offset(isLeft ? longLineHeight : (longLineHeight + 325), position);
      canvas.drawLine(start, end, linePaint);

      // Dibujar la etiqueta de la escala
      final TextSpan textSpan = TextSpan(
        text: value.toString(),
        style: TextStyle(
          color: labelColor,
          fontSize: scaleLabelSize,
        ),
      );
      final TextPainter textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        maxWidth: maxScaleLabelWidth,
      );

      final Offset textOffset = _isHorizontalAxis
          ? Offset(position - (textPainter.width / 2),
              longLineHeight + scaleBottomPadding)
          : Offset(
              isLeft
                  ? longLineHeight
                  : (longLineHeight + 280) + scaleBottomPadding,
              position - (textPainter.height / 2));

// if(!_isHorizontalAxis)
      textPainter.paint(canvas, textOffset);
    } else {
      // Línea corta sin etiqueta
      final Offset start = _isHorizontalAxis
          ? Offset(position, longLineHeight)
          : Offset(isLeft ? 0 : (500), position);

      final Offset end = _isHorizontalAxis
          ? Offset(position, longLineHeight - (shortLineHeight + 8))
          : Offset(
              isLeft ? shortLineHeight : (shortLineHeight + 370), position);
      canvas.drawLine(start, end, linePaint);
    }

    // Dibujar la sombra entre los dos indicadores
    if (currentWeight != null &&
        (value == selectedValue || value == currentWeight)) {
      final double selectedPos =
          (selectedValue - value).toDouble() * size.width;
      final double currentPos =
          (currentWeight! - value).toDouble() * size.width;

      final Rect shadowRect = _isHorizontalAxis
          ? Rect.fromLTRB(selectedPos, 0, currentPos, size.height - 130)
          : Rect.fromLTRB(0, selectedPos, size.width, currentPos);

      canvas.drawRect(shadowRect, shadowPaint);
    }

    // Dibujar la línea del indicador del peso actual
    if (value == currentWeight) {
      final Offset currentStart =
          _isHorizontalAxis ? Offset(position, 0) : Offset(0, position);
      final Offset currentEnd = _isHorizontalAxis
          ? Offset(position, longLineHeight * 1.5)
          : Offset(longLineHeight * 1.5, position);
      final Paint currentPaint = Paint()
        ..color = Colors.black // Línea azul para el peso actual
        ..strokeWidth = lineStroke
        ..style = PaintingStyle.stroke;
      canvas.drawLine(currentStart, currentEnd, currentPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class _HorizontalPointer extends StatelessWidget {
  const _HorizontalPointer({
    required this.selectedValue,
    required this.selectedColor,
    required this.longLineHeight,
    required this.scaleLabelWidth,
    required this.scaleBottomPadding,
    required this.unitString,
    required this.isLeft,
  });

  final int selectedValue;
  final Color selectedColor;
  final double longLineHeight;
  final double scaleLabelWidth;
  final double scaleBottomPadding;
  final String unitString;
  final bool isLeft;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: isLeft ? 150 : 80,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            selectedValue.toString(),
            style: TextStyle(
              fontSize: 55,
              letterSpacing: 3.5,
              color: selectedColor,
            ),
          ),
          Text(
            ' $unitString',
            style: TextStyle(
              fontSize: 35,
              letterSpacing: 3.5,
              color: selectedColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _VerticalPointer extends StatelessWidget {
  const _VerticalPointer({
    required this.selectedValue,
    required this.selectedColor,
    required this.longLineHeight,
    required this.scaleLabelSize,
    required this.scaleBottomPadding,
    required this.unitString,
    this.mostrar = false,
    required this.isLeft,
  });

  final int selectedValue;
  final Color selectedColor;
  final double longLineHeight;
  final double scaleLabelSize;
  final double scaleBottomPadding;
  final String unitString;
  final bool mostrar;
  final bool isLeft;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 9,
      left: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: longLineHeight,
            width: 3,
            color: selectedColor,
          ),
          SizedBox(
            height: scaleLabelSize + scaleBottomPadding,
          ),
          Icon(
            Icons.arrow_drop_up,
            color: selectedColor,
            size: 24,
          ),
          SizedBox(
            height: scaleLabelSize,
          ),
          if (!mostrar)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  selectedValue.toString(),
                  style: TextStyle(
                    fontSize: 55,
                    letterSpacing: 3.5,
                    color: selectedColor,
                  ),
                ),
                Text(
                  ' $unitString',
                  style: TextStyle(
                    fontSize: 35,
                    letterSpacing: 3.5,
                    color: selectedColor,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
