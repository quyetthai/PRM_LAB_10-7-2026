import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/course_type.dart';
import '../../viewmodels/course_viewmodel.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  IconData _getCategoryIcon(String id) {
    switch (id) {
      case 'all':
        return Icons.apps;
      case 'mobile':
        return Icons.phone_android;
      case 'web':
        return Icons.language;
      case 'ai':
        return Icons.psychology;
      case 'ui_ux':
        return Icons.design_services;
      default:
        return Icons.folder_outlined;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courseState = ref.watch(courseViewModelProvider);
    final notifier = ref.read(courseViewModelProvider.notifier);

    return Drawer(
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            // User Header
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 44,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              accountName: const Text(
                'Nguyễn Văn A',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              accountEmail: const Text(
                'nguyenvana@gmail.com',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ),

            // Course Types List from ViewModel
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      'CATEGORIES',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),

                  // Categories dynamically loaded from ViewModel
                  for (final CourseType type in courseState.courseTypes)
                    ListTile(
                      leading: Icon(
                        _getCategoryIcon(type.id),
                        color: courseState.selectedTypeId == type.id
                            ? Theme.of(context).colorScheme.primary
                            : Colors.black87,
                      ),
                      title: Text(
                        type.name,
                        style: TextStyle(
                          fontWeight: courseState.selectedTypeId == type.id
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: courseState.selectedTypeId == type.id
                              ? Theme.of(context).colorScheme.primary
                              : Colors.black87,
                        ),
                      ),
                      selected: courseState.selectedTypeId == type.id,
                      selectedTileColor: Theme.of(context)
                          .colorScheme
                          .primary
                          .withValues(alpha: 0.08),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onTap: () {
                        // Close drawer
                        Navigator.pop(context);
                        // Switch to Courses page and filter by selected type
                        notifier.selectCourseType(type.id);
                      },
                    ),

                  const Divider(height: 24, thickness: 1),

                  // Other sections: My Learning, Settings, About, Logout
                  ListTile(
                    leading: const Icon(Icons.play_lesson_outlined),
                    title: const Text('My Learning'),
                    onTap: () {
                      Navigator.pop(context);
                      notifier.selectTab(2);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings_outlined),
                    title: const Text('Settings'),
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Settings tapped')),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('About'),
                    onTap: () {
                      Navigator.pop(context);
                      showAboutDialog(
                        context: context,
                        applicationName: 'Course App',
                        applicationVersion: '1.0.0',
                        children: const [
                          Text('PRM393 - Flutter MVVM with Riverpod'),
                        ],
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.red),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Logged out')),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
