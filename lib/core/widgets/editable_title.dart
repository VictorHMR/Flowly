import 'package:flutter/material.dart';

class EditableTitle extends StatefulWidget {
  const EditableTitle({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  final String initialValue;
  final ValueChanged<String> onChanged;

  @override
  State<EditableTitle> createState() => _EditableTitleState();
}

class _EditableTitleState extends State<EditableTitle> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  bool isEditing = false;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(text: widget.initialValue);

    _focusNode = FocusNode();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() {
          isEditing = false;
        });

        widget.onChanged(_controller.text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    if (!isEditing) {
      return GestureDetector(
        onTap: () {
          setState(() {
            isEditing = true;
          });

          Future.delayed(Duration.zero, () => _focusNode.requestFocus());
        },

        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _controller.text,
              textAlign: TextAlign.center,

              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: colors.onSurface,
              ),
            ),

            const SizedBox(width: 8),

            Icon(Icons.edit_outlined, size: 18, color: colors.onSurfaceVariant),
          ],
        ),
      );
    }

    return SizedBox(
      width: 220,

      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        textAlign: TextAlign.center,
        maxLines: 1,
        autofocus: true,

        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: colors.onSurface,
        ),

        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.only(bottom: 6),

          border: UnderlineInputBorder(
            borderSide: BorderSide(color: colors.primary),
          ),

          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: colors.primary, width: 2),
          ),
        ),
      ),
    );
  }
}
