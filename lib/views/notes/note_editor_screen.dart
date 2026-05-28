import 'package:flowly/models/models.dart';
import 'package:flowly/viewmodels/viewmodels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:provider/provider.dart';

class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({super.key, this.note});

  final Note? note;

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  late final QuillController controller;

  late final TextEditingController titleController;

  bool isSaving = false;

  @override
  void initState() {
    super.initState();

    final document = widget.note?.document != null
        ? Document.fromJson(widget.note!.document!['ops'])
        : Document();

    controller = QuillController(
      document: document,

      selection: const TextSelection.collapsed(offset: 0),
    );

    titleController = TextEditingController(text: widget.note?.title ?? '');
  }

  @override
  void dispose() {
    controller.dispose();
    titleController.dispose();
    super.dispose();
  }

  Future<void> _saveNote() async {
    if (isSaving) return;
    setState(() => isSaving = true);
    final noteVM = context.read<NoteViewModel>();
    await noteVM.saveNote(
      controller: controller,
      titleController: titleController,
      existingNote: widget.note,
    );
    if (mounted) {
      Navigator.pop(context);
    }
    setState(() => isSaving = false);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'Nova Nota' : 'Editar Nota'),
        actions: [
          IconButton(
            onPressed: isSaving ? null : _saveNote,
            icon: isSaving
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.save),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 16),
            height: 70,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              child: TextField(
                controller: titleController,
                maxLines: 1,
                maxLength: 50,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                decoration: const InputDecoration(
                  hintText: 'Título',
                  counterText: '',
                  fillColor: Colors.transparent,
                  border: UnderlineInputBorder(),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
              child: QuillEditor.basic(controller: controller),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: colors.surfaceContainer,
              border: Border(top: BorderSide(color: colors.outlineVariant)),
            ),
            child: QuillSimpleToolbar(
              controller: controller,
              config: const QuillSimpleToolbarConfig(
                
                multiRowsDisplay: false,
                showBoldButton: true,
                showItalicButton: true,
                showUnderLineButton: false,
                showStrikeThrough: false,
                showAlignmentButtons: false,
                showBackgroundColorButton: false,
                showCodeBlock: false,
                showColorButton: false,
                showDirection: false,
                showDividers: false,
                showFontFamily: false,
                showFontSize: true,
                showHeaderStyle: false,
                showIndent: false,
                showInlineCode: false,
                showLink: true,
                showListBullets: true,
                showListCheck: true,
                showListNumbers: true,
                showQuote: false,
                showRedo: false,
                showUndo: false,
                showSearchButton: false,
                showSmallButton: false,
                showSubscript: false,
                showSuperscript: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
