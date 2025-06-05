import 'package:flutter/material.dart';

class ReadMoreLines extends StatefulWidget {
  final String text;
  final int chunkSize;
  final TextStyle? textStyle;

  const ReadMoreLines({
    super.key,
    required this.text,
    this.chunkSize = 10,
    this.textStyle,
  });

  @override
  State<ReadMoreLines> createState() => _ReadMoreLinesState();
}

class _ReadMoreLinesState extends State<ReadMoreLines> {
  int _visibleLineCount = 10;

  @override
  Widget build(BuildContext context) {
    final style = widget.textStyle ?? const TextStyle(fontSize: 16);

    return LayoutBuilder(
      builder: (context, constraints) {
        final span = TextSpan(text: widget.text, style: style);
        final tp = TextPainter(
          text: span,
          textDirection: TextDirection.ltr,
          maxLines: null,
        );
        tp.layout(maxWidth: constraints.maxWidth);

        final lines = tp.computeLineMetrics();
        final totalLines = lines.length;

        if (totalLines <= _visibleLineCount) {
          return Text(widget.text, style: style);
        }

        final linesToShow = _visibleLineCount.clamp(0, totalLines);
        final cutoffY = lines
            .take(linesToShow)
            .fold<double>(0, (prev, line) => prev + line.height);

        final cutoffOffset = tp.getPositionForOffset(Offset(0, cutoffY)).offset;

        // Fallback: if cutoffOffset is 0 or invalid, show entire text
        final visibleText =
            (cutoffOffset > 0)
                ? widget.text.substring(0, cutoffOffset)
                : widget.text;

        final hasMore = _visibleLineCount < totalLines;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(visibleText, style: style),
            if (hasMore)
              TextButton(
                onPressed: () {
                  setState(() {
                    _visibleLineCount += widget.chunkSize;
                  });
                },
                child: const Text('Read more'),
              ),
          ],
        );
      },
    );
  }
}
