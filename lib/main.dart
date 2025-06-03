import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'blocs/navigation_bloc.dart';
import 'screens/home_screen.dart';
import 'screens/assignment_screen.dart';
import 'screens/class_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationBloc(),
      child: MaterialApp(
        title: 'School App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.grey[50],
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        home: const MainScreen(),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  final List<Widget> _screens = const [
    HomeScreen(),
    AssignmentScreen(),
    ClassScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        int selectedIndex = 0;
        if (state is NavigationInitial) {
          selectedIndex = state.selectedIndex;
        }

        return Scaffold(
          body: _screens[selectedIndex],
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1)),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 8,
                ),
                child: GNav(
                  rippleColor: Colors.blue[300]!,
                  hoverColor: Colors.blue[100]!,
                  gap: 6,
                  activeColor: Colors.white,
                  iconSize: 22,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  duration: const Duration(milliseconds: 400),
                  tabBackgroundColor: Colors.blue[600]!,
                  color: Colors.grey[600],
                  tabs: const [
                    GButton(icon: Icons.home, text: 'Trang chủ'),
                    GButton(icon: Icons.assignment, text: 'Bài tập'),
                    GButton(icon: Icons.school, text: 'Lớp'),
                    GButton(icon: Icons.person, text: 'Cá nhân'),
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
        );
      },
    );
  }
}
