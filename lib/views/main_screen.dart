import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/course_viewmodel.dart';
import 'courses/courses_page.dart';
import 'home/home_page.dart';
import 'my_learning/my_learning_page.dart';
import 'profile/profile_page.dart';
import 'widgets/app_drawer.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  String _getAppBarTitle(int index) {
    switch (index) {
      case 0:
        return 'COURSE APP';
      case 1:
        return 'COURSES';
      case 2:
        return 'MY LEARNING';
      case 3:
        return 'PROFILE';
      default:
        return 'COURSE APP';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courseState = ref.watch(courseViewModelProvider);
    final notifier = ref.read(courseViewModelProvider.notifier);

    final pages = const [
      HomePage(),
      CoursesPage(),
      MyLearningPage(),
      ProfilePage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _getAppBarTitle(courseState.selectedTabIndex),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('No new notifications')),
              );
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: IndexedStack(
        index: courseState.selectedTabIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: courseState.selectedTabIndex,
        onTap: (index) {
          notifier.selectTab(index);
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            activeIcon: Icon(Icons.menu_book),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library_outlined),
            activeIcon: Icon(Icons.video_library),
            label: 'My Learning',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
