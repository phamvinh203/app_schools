import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../blocs/navigation_bloc.dart';
import '../blocs/user_bloc.dart';
import 'home_screen.dart';
import 'assignment_screen.dart';
import 'class_screen.dart';
import 'profile_screen.dart';
import 'teacher/teacher_home_screen.dart';
import 'teacher/teacher_assignment_screen.dart';
import 'teacher/teacher_class_screen.dart';
import 'teacher/teacher_profile_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        final isTeacher =
            userState is UserInitial && userState.userType == UserType.teacher;

        return BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, navigationState) {
            int selectedIndex = 0;
            if (navigationState is NavigationInitial) {
              selectedIndex = navigationState.selectedIndex;
            }

            final studentScreens = const [
              HomeScreen(),
              AssignmentScreen(),
              ClassScreen(),
              ProfileScreen(),
            ];

            final teacherScreens = const [
              TeacherHomeScreen(),
              TeacherAssignmentScreen(),
              TeacherClassScreen(),
              TeacherProfileScreen(),
            ];

            final screens = isTeacher ? teacherScreens : studentScreens;
            final primaryColor = isTeacher ? Colors.green : Colors.blue;

            return Scaffold(
              body: screens[selectedIndex],
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      color: Colors.black.withOpacity(.1),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 8,
                    ),
                    child: GNav(
                      rippleColor: primaryColor[300]!,
                      hoverColor: primaryColor[100]!,
                      gap: 6,
                      activeColor: Colors.white,
                      iconSize: 22,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      duration: const Duration(milliseconds: 400),
                      tabBackgroundColor: primaryColor[600]!,
                      color: Colors.grey[600],
                      tabs: [
                        const GButton(icon: Icons.home, text: 'Trang chủ'),
                        GButton(
                          icon: isTeacher ? Icons.grading : Icons.assignment,
                          text: isTeacher ? 'Chấm bài' : 'Bài tập',
                        ),
                        GButton(
                          icon: isTeacher ? Icons.school : Icons.class_,
                          text: 'Lớp',
                        ),
                        const GButton(icon: Icons.person, text: 'Cá nhân'),
                      ],
                      selectedIndex: selectedIndex,
                      onTabChange: (index) {
                        context.read<NavigationBloc>().add(
                          NavigationTabChanged(index),
                        );
                      },
                    ),
                  ),
                ),
              ),
              // Add floating action button for user type switching (for demo purposes)
              floatingActionButton: FloatingActionButton(
                backgroundColor: primaryColor,
                onPressed: () {
                  final newUserType =
                      isTeacher ? UserType.student : UserType.teacher;
                  context.read<UserBloc>().add(UserTypeChanged(newUserType));
                  // Reset navigation to home when switching user types
                  context.read<NavigationBloc>().add(
                    const NavigationTabChanged(0),
                  );
                },
                child: Icon(
                  isTeacher ? Icons.person : Icons.school,
                  color: Colors.white,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
