import 'package:flowly/core/widgets/widgets.dart';
import 'package:flowly/models/models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditableDetailCard<T> extends StatelessWidget {
  const EditableDetailCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.type,
    required this.onChanged,

    this.enumValues,
    this.getLabel,
  });

  final IconData icon;
  final String title;

  final T value;

  final FieldType type;

  final ValueChanged<T> onChanged;

  /// usado para enumSelection
  final List<T>? enumValues;

  /// usado para exibir labels amigáveis
  final String Function(T value)? getLabel;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _handleTap(context),

        child: Ink(
          padding: const EdgeInsets.all(15),

          decoration: BoxDecoration(
            color: colors.surfaceBright,
            borderRadius: BorderRadius.circular(16),
          ),

          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors.inversePrimary,
                ),
                child: Icon(icon, color: colors.primary),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: colors.onSurface,
                      ),
                    ),
                    if (type == FieldType.multilineText ||
                        type == FieldType.text)
                      Text(
                        getLabel?.call(value) ?? value.toString(),
                        maxLines: 5,
                        style: TextStyle(
                          fontSize: 14,
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
              ),
              if (type == FieldType.weekDaysSelection)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 3, vertical: 0),
                  child: DisplayTinyWeekDays(
                    activeWeekDays: value as List<WeekDay>?,
                  ),
                )
              else if (type != FieldType.multilineText)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 3, vertical: 0),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: colors.surfaceContainer,
                    borderRadius: BorderRadius.all(Radius.elliptical(12, 12)),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(6),
                    child: Text(
                      _getValueText(),
                      style: TextStyle(
                        color: colors.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleTap(BuildContext context) async {
    switch (type) {
      case FieldType.enumSelection:
        _showEnumModal(context);
        break;
      case FieldType.multilineText:
        _showTextModal(context);
      case FieldType.weekDaysSelection:
        _showWeekDaysModal(context);
      case FieldType.date:
      case FieldType.day:
        _showDateModal(context);
      default:
        break;
    }
  }

  void _showEnumModal(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    showModalBottomSheet(
      context: context,
      backgroundColor: colors.surface,
      builder: (_) {
        return AppBottomSheet(
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: enumValues!.map((item) {
              return ListTile(
                title: Text(getLabel?.call(item) ?? item.toString()),
                onTap: () {
                  Navigator.pop(context);
                  onChanged(item);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _showTextModal(BuildContext context) {
    final controller = TextEditingController(text: value?.toString() ?? '');
    final colors = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: colors.surface,
      builder: (_) {
        return AppBottomSheet(
          title: title,
          child: Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controller,
                  maxLines: type == FieldType.multilineText ? 5 : 1,
                  minLines: type == FieldType.multilineText ? 4 : 1,
                  maxLength: type == FieldType.multilineText ? 190 : 50,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Digite aqui...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                      onChanged(controller.text as T);
                    },
                    child: const Text('Salvar'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showWeekDaysModal(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final selectedDays = List<WeekDay>.from(value as List<WeekDay>? ?? []);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: colors.surface,
      builder: (_) {
        return AppBottomSheet(
          title: 'Dias Da Semana',
          child: StatefulBuilder(
            builder: (context, setModalState) {
              return Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ...WeekDay.values.asMap().entries.map((entry) {
                          final index = entry.key;
                          final day = entry.value;
                          final isSelected = selectedDays.contains(day);
                          return GestureDetector(
                            onTap: () {
                              setModalState(() {
                                if (isSelected) {
                                  selectedDays.remove(day);
                                } else {
                                  selectedDays.add(day);
                                }
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 42,
                              height: 42,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected
                                    ? colors.primary
                                    : colors.surfaceContainer,
                              ),
                              child: Text(
                                day.tinyLabel,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: index == 0
                                      ? colors.error
                                      : isSelected
                                      ? colors.onPrimary
                                      : colors.onSurfaceVariant,
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          Navigator.pop(context);
                          onChanged(selectedDays as T);
                        },
                        child: const Text('Salvar'),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _showDateModal(BuildContext context) async {
    final dateNow = DateTime.now();
    final initialDate = value is DateTime
        ? (value as DateTime? ?? dateNow)
        : DateTime(dateNow.year, dateNow.month, value as int);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,

      firstDate: DateTime(initialDate.year, initialDate.month, 1),
      lastDate: DateTime(initialDate.year + 5, initialDate.month, 1),
    );

    if (pickedDate == null) return;

    onChanged(pickedDate as T);
  }

  dynamic _getValueText() => switch (type) {
    FieldType.date => DateFormat(
      'dd/MM/yyyy',
    ).format(value as DateTime? ?? DateTime.now()),
    FieldType.number => (value ?? '').toString(),
    FieldType.day => 'Dias ${(value ?? 1).toString().padLeft(2, '0')}',
    FieldType.text => (value ?? '').toString(),
    FieldType.multilineText => (value ?? '').toString(),
    FieldType.enumSelection => getLabel?.call(value) ?? value.toString(),
    FieldType.none => '',
    FieldType.weekDaysSelection => '',
  };
}
