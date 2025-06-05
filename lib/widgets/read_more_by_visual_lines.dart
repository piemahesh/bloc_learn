import 'package:flutter/material.dart';

class ReadMoreByVisualLines extends StatefulWidget {
  final String text;
  final int chunkSize;
  final TextStyle? style;

  const ReadMoreByVisualLines({
    super.key,
    required this.text,
    this.chunkSize = 10,
    this.style,
  });

  @override
  State<ReadMoreByVisualLines> createState() => _ReadMoreByVisualLinesState();
}

class _ReadMoreByVisualLinesState extends State<ReadMoreByVisualLines> {
  int _currentChunk = 1;
  List<String> _visibleLines = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _calculateLines();
  }

  void _calculateLines() {
    final TextSpan span = TextSpan(
      text: widget.text,
      style: widget.style ?? const TextStyle(fontSize: 15),
    );

    final TextPainter tp = TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
      maxLines: null,
    );

    tp.layout(maxWidth: MediaQuery.of(context).size.width);

    _visibleLines = [];
    for (TextBox box in tp.getBoxesForSelection(
      TextSelection(baseOffset: 0, extentOffset: widget.text.length),
    )) {
      _visibleLines.add(tp.text!.toPlainText());
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalLines = _visibleLines.length;
    final linesToShow = (_currentChunk * widget.chunkSize).clamp(0, totalLines);

    return LayoutBuilder(
      builder: (context, constraints) {
        final textStyle = widget.style ?? const TextStyle(fontSize: 15);
        final span = TextSpan(text: widget.text, style: textStyle);

        final tp = TextPainter(
          text: span,
          textDirection: TextDirection.ltr,
          maxLines: linesToShow,
        );
        tp.layout(maxWidth: constraints.maxWidth);

        final bool hasMore = tp.computeLineMetrics().length > linesToShow;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(span, maxLines: linesToShow, overflow: TextOverflow.clip),
            if (hasMore)
              TextButton(
                onPressed: () {
                  setState(() {
                    _currentChunk++;
                  });
                },
                child: const Text("Read more"),
              ),
          ],
        );
      },
    );
  }
}
