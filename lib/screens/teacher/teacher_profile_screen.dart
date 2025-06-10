import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import '../../screens/login_screen.dart';
import '../../screens/theme_settings_screen.dart';
import 'profile/teacher_info_screen.dart';
import 'profile/teacher_class_management_screen.dart';
import 'profile/teacher_settings_screen.dart';
import 'profile/teacher_support_screen.dart';
import 'fee_management_screen.dart';

class TeacherProfileScreen extends StatelessWidget {
  const TeacherProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [              // Profile Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.secondary,
                      Theme.of(context).colorScheme.secondary.withOpacity(0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Nguyễn Thị Bình',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Giáo viên Toán học • THPT ABC',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(child: _buildStatItem('3', 'Lớp\nphụ trách')),
                        Container(
                          width: 1,
                          height: 40,
                          color: Colors.white.withOpacity(0.3),
                        ),
                        Expanded(
                          child: _buildStatItem('105', 'Học sinh\ntổng cộng'),
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: Colors.white.withOpacity(0.3),
                        ),
                        Expanded(
                          child: _buildStatItem('15', 'Năm\nkinh nghiệm'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24), // Menu Items
              _buildMenuSection(context, 'Thông tin cá nhân', [
                _buildMenuItem(Icons.person_outline, 'Hồ sơ giáo viên', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TeacherInfoScreen(),
                    ),
                  );
                }),
                _buildMenuItem(
                  Icons.school_outlined,
                  'Thông tin giảng dạy',
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TeacherInfoScreen(),
                      ),
                    );
                  },
                ),
                _buildMenuItem(Icons.schedule_outlined, 'Lịch dạy', () {}),
                _buildMenuItem(
                  Icons.grade_outlined,
                  'Báo cáo thành tích',
                  () {},
                ),
              ]),

              const SizedBox(height: 16),

              _buildMenuSection(context, 'Quản lý lớp học', [
                _buildMenuItem(Icons.assignment_outlined, 'Tạo bài tập', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => const TeacherClassManagementScreen(),
                    ),
                  );
                }),
                _buildMenuItem(Icons.fact_check_outlined, 'Điểm danh', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => const TeacherClassManagementScreen(),
                    ),
                  );
                }),
                _buildMenuItem(Icons.assessment_outlined, 'Chấm điểm', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => const TeacherClassManagementScreen(),
                    ),
                  );
                }),
                _buildMenuItem(Icons.analytics_outlined, 'Thống kê lớp', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => const TeacherClassManagementScreen(),
                    ),
                  );
                }),
                _buildMenuItem(Icons.payment, 'Quản lý học phí', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FeeManagementScreen(),
                    ),
                  );
                }),
              ]),

              const SizedBox(height: 16),              _buildMenuSection(context, 'Cài đặt', [
                _buildMenuItem(Icons.settings_outlined, 'Cài đặt', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TeacherSettingsScreen(),
                    ),
                  );
                }),
                _buildMenuItem(Icons.palette_outlined, 'Giao diện', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ThemeSettingsScreen(),
                    ),
                  );
                }),
                _buildMenuItem(Icons.notifications_outlined, 'Thông báo', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TeacherSettingsScreen(),
                    ),
                  );
                }),
                _buildMenuItem(Icons.security_outlined, 'Bảo mật', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TeacherSettingsScreen(),
                    ),
                  );
                }),
                _buildMenuItem(Icons.language_outlined, 'Ngôn ngữ', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TeacherSettingsScreen(),
                    ),
                  );
                }),
                Consumer<ThemeProvider>(
                  builder: (context, themeProvider, child) {
                    return _buildMenuItem(
                      themeProvider.isDarkMode 
                        ? Icons.light_mode_outlined 
                        : Icons.dark_mode_outlined,
                      'Chế độ tối',
                      () {},
                      trailing: Switch(
                        value: themeProvider.isDarkMode,
                        onChanged: (value) => themeProvider.toggleTheme(),
                        activeColor: Theme.of(context).colorScheme.secondary,
                      ),
                    );
                  },
                ),
              ]),

              const SizedBox(height: 16),

              _buildMenuSection(context, 'Hỗ trợ', [
                _buildMenuItem(Icons.help_outline, 'Hướng dẫn sử dụng', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TeacherSupportScreen(),
                    ),
                  );
                }),
                _buildMenuItem(
                  Icons.contact_support_outlined,
                  'Liên hệ hỗ trợ',
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TeacherSupportScreen(),
                      ),
                    );
                  },
                ),
                _buildMenuItem(Icons.info_outline, 'Về ứng dụng', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TeacherSupportScreen(),
                    ),
                  );
                }),
                _buildMenuItem(Icons.feedback_outlined, 'Phản hồi', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TeacherSupportScreen(),
                    ),
                  );
                }),
              ]),

              const SizedBox(height: 24),
              // Logout Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[50],
                    foregroundColor: Colors.red,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.red.withOpacity(0.3)),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout, color: Colors.red[600]),
                      const SizedBox(width: 8),
                      Text(
                        'Đăng xuất',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.red[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FittedBox(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Flexible(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
  Widget _buildMenuSection(
    BuildContext context,
    String title,
    List<Widget> items,
  ) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onBackground.withOpacity(0.8),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.shadow.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(children: items),
        ),
      ],
    );
  }
  Widget _buildMenuItem(
    IconData icon,
    String title,
    VoidCallback onTap, {
    Widget? trailing,
  }) {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        return ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.colorScheme.secondary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: theme.colorScheme.secondary, size: 20),
          ),
          title: Text(
            title, 
            style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
          ),
          trailing: trailing ??
              Icon(
                Icons.arrow_forward_ios, 
                size: 16, 
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
          onTap: onTap,
        );
      },
    );
  }
}
