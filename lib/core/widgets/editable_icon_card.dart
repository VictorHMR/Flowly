import 'package:flutter/material.dart';
import 'package:flowly/core/utils/utils.dart';

class EditableIconCard<T> extends StatelessWidget {
  const EditableIconCard({
    super.key,
    required this.selectedIcon,
    required this.onChanged,
  });
  final IconData selectedIcon;
  final ValueChanged<IconData> onChanged;

  static const List<IconData> avaliableIcons = [
    Icons.task_alt,
    Icons.work_outline,
    Icons.school_outlined,
    Icons.fitness_center,
    Icons.book_outlined,
    Icons.shopping_cart_outlined,
    Icons.favorite_outline,
    Icons.home_outlined,
    Icons.attach_money,
    Icons.code,
    Icons.cleaning_services_outlined,
    Icons.restaurant_outlined,
    Icons.flight_takeoff,
    Icons.directions_run,
    Icons.music_note,
    Icons.movie_outlined,
    Icons.pets_outlined,
    Icons.medication_outlined,
    Icons.local_hospital_outlined,
    Icons.event_note_outlined,
    Icons.alarm,
    Icons.nightlight_round,
    Icons.self_improvement,
    Icons.water_drop_outlined,
    Icons.phone_android,
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    return GestureDetector(
      onTap: () {
        _showIconsModal(context);
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 120,
            height: 120,

            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colors.surfaceContainerHighest,
            ),

            child: Icon(selectedIcon, size: 48, color: colors.primary),
          ),

          Positioned(
            right: 5,
            bottom: 5,

            child: Container(
              width: 32,
              height: 32,

              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.primary,
                border: Border.all(
                  color: colors.surfaceContainerHighest,
                  width: 3,
                ),
              ),

              child: IconButton(
                onPressed: () {
                  _showIconsModal(context);
                },
                padding: EdgeInsets.zero,

                icon: Icon(
                  Icons.edit_outlined,
                  size: 20,
                  color: colors.onPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showIconsModal(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: colors.surface,

      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 42,
                  height: 5,
                  decoration: BoxDecoration(
                    color: colors.outlineVariant,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Text(
                'Selecionar Ícone',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: colors.onSurface,
                ),
              ),

              const SizedBox(height: 20),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: avaliableIcons.length,

                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                ),

                itemBuilder: (context, index) {
                  final icon = avaliableIcons[index];
                  final isSelected = icon == selectedIcon;

                  return GestureDetector(
                    onTap: () {
                      onChanged(icon);
                      Navigator.pop(context);
                    },

                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),

                        color: isSelected
                            ? colors.primary
                            : colors.surfaceContainerHighest,

                        border: Border.all(
                          color: isSelected
                              ? colors.primary
                              : colors.outlineVariant,
                        ),
                      ),

                      child: Icon(
                        icon,
                        size: 30,
                        color: isSelected
                            ? colors.onPrimary
                            : colors.onSurfaceVariant,
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
