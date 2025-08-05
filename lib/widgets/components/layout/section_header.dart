import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? action;
  final VoidCallback? onActionPressed;
  final String? actionText;
  final IconData? actionIcon;

  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.action,
    this.onActionPressed,
    this.actionText,
    this.actionIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (action != null)
              action!
            else if (actionText != null)
              TextButton(
                onPressed: onActionPressed,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(actionText!),
                    if (actionIcon != null) ...[
                      const SizedBox(width: 4),
                      Icon(actionIcon, size: 16),
                    ],
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
} 