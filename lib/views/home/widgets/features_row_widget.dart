import 'package:flutter/material.dart';

class FeaturesRowWidget extends StatelessWidget {
  const FeaturesRowWidget({super.key});

  Widget _buildFeatureItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.15)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildFeatureItem(
          context,
          icon: Icons.auto_stories,
          title: '50+',
          subtitle: 'Courses',
          iconColor: Colors.blue,
        ),
        const SizedBox(width: 8),
        _buildFeatureItem(
          context,
          icon: Icons.military_tech_rounded,
          title: 'Expert',
          subtitle: 'Instructors',
          iconColor: Colors.amber[800] ?? Colors.amber,
        ),
        const SizedBox(width: 8),
        _buildFeatureItem(
          context,
          icon: Icons.play_circle_fill_rounded,
          title: 'Flexible',
          subtitle: 'Learning',
          iconColor: Colors.teal,
        ),
      ],
    );
  }
}
