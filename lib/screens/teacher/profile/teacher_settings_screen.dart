import 'package:flutter/material.dart';

class TeacherSettingsScreen extends StatefulWidget {
  const TeacherSettingsScreen({super.key});

  @override
  State<TeacherSettingsScreen> createState() => _TeacherSettingsScreenState();
}

class _TeacherSettingsScreenState extends State<TeacherSettingsScreen> {
  bool _pushNotifications = true;
  bool _emailNotifications = true;
  bool _assignmentReminders = true;
  bool _classReminders = false;
  bool _darkMode = false;
  bool _biometricAuth = false;
  String _selectedLanguage = 'Tiếng Việt';
  String _selectedTheme = 'Xanh lá';

  final List<String> _languages = ['Tiếng Việt', 'English', '中文'];
  final List<String> _themes = ['Xanh lá', 'Xanh dương', 'Tím', 'Cam'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Cài đặt'),
        backgroundColor: Colors.green[600],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Notification Settings
            _buildSectionCard(
              title: 'Thông báo',
              icon: Icons.notifications,
              children: [
                _buildSwitchTile(
                  'Thông báo đẩy',
                  'Nhận thông báo trên thiết bị',
                  _pushNotifications,
                  (value) => setState(() => _pushNotifications = value),
                ),
                _buildSwitchTile(
                  'Thông báo email',
                  'Nhận thông báo qua email',
                  _emailNotifications,
                  (value) => setState(() => _emailNotifications = value),
                ),
                _buildSwitchTile(
                  'Nhắc nhở bài tập',
                  'Thông báo khi có bài tập mới cần chấm',
                  _assignmentReminders,
                  (value) => setState(() => _assignmentReminders = value),
                ),
                _buildSwitchTile(
                  'Nhắc nhở lớp học',
                  'Thông báo trước giờ học 15 phút',
                  _classReminders,
                  (value) => setState(() => _classReminders = value),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Display Settings
            _buildSectionCard(
              title: 'Hiển thị',
              icon: Icons.display_settings,
              children: [
                _buildSwitchTile(
                  'Chế độ tối',
                  'Sử dụng giao diện tối',
                  _darkMode,
                  (value) => setState(() => _darkMode = value),
                ),
                _buildDropdownTile(
                  'Ngôn ngữ',
                  'Chọn ngôn ngữ hiển thị',
                  _selectedLanguage,
                  _languages,
                  (value) => setState(() => _selectedLanguage = value!),
                ),
                _buildDropdownTile(
                  'Màu chủ đề',
                  'Tùy chỉnh màu sắc ứng dụng',
                  _selectedTheme,
                  _themes,
                  (value) => setState(() => _selectedTheme = value!),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Security Settings
            _buildSectionCard(
              title: 'Bảo mật',
              icon: Icons.security,
              children: [
                _buildSwitchTile(
                  'Xác thực sinh trắc học',
                  'Sử dụng vân tay hoặc FaceID',
                  _biometricAuth,
                  (value) => setState(() => _biometricAuth = value),
                ),
                _buildActionTile(
                  'Đổi mật khẩu',
                  'Thay đổi mật khẩu đăng nhập',
                  Icons.lock_outline,
                  () => _showChangePasswordDialog(),
                ),
                _buildActionTile(
                  'Xóa dữ liệu cache',
                  'Xóa dữ liệu tạm thời để giải phóng bộ nhớ',
                  Icons.cached,
                  () => _showClearCacheDialog(),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Data & Storage
            _buildSectionCard(
              title: 'Dữ liệu & Lưu trữ',
              icon: Icons.storage,
              children: [
                _buildActionTile(
                  'Sao lưu dữ liệu',
                  'Tạo bản sao lưu cho dữ liệu quan trọng',
                  Icons.backup,
                  () => _showBackupDialog(),
                ),
                _buildActionTile(
                  'Khôi phục dữ liệu',
                  'Khôi phục từ bản sao lưu trước đó',
                  Icons.restore,
                  () => _showRestoreDialog(),
                ),
                _buildInfoTile(
                  'Dung lượng sử dụng',
                  '45.2 MB',
                  Icons.folder_outlined,
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Privacy Settings
            _buildSectionCard(
              title: 'Quyền riêng tư',
              icon: Icons.privacy_tip,
              children: [
                _buildActionTile(
                  'Chính sách bảo mật',
                  'Xem chính sách bảo mật của ứng dụng',
                  Icons.policy,
                  () => _showPrivacyPolicy(),
                ),
                _buildActionTile(
                  'Điều khoản sử dụng',
                  'Xem điều khoản và điều kiện',
                  Icons.description,
                  () => _showTermsOfService(),
                ),
                _buildActionTile(
                  'Quyền ứng dụng',
                  'Quản lý quyền truy cập của ứng dụng',
                  Icons.admin_panel_settings,
                  () => _showAppPermissions(),
                ),
              ],
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: Colors.green[600], size: 24),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    void Function(bool) onChanged,
  ) {
    return SwitchListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.grey[600], fontSize: 12),
      ),
      value: value,
      activeColor: Colors.green[600],
      onChanged: onChanged,
    );
  }

  Widget _buildDropdownTile(
    String title,
    String subtitle,
    String value,
    List<String> items,
    void Function(String?) onChanged,
  ) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.grey[600], fontSize: 12),
      ),
      trailing: DropdownButton<String>(
        value: value,
        underline: Container(),
        items:
            items.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item, style: const TextStyle(fontSize: 14)),
              );
            }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildActionTile(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: Colors.green[600]),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.grey[600], fontSize: 12),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.grey[400],
      ),
      onTap: onTap,
    );
  }

  Widget _buildInfoTile(String title, String value, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.green[600]),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: Text(
        value,
        style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w600),
      ),
    );
  }

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Đổi mật khẩu'),
            content: const Text(
              'Chức năng đổi mật khẩu sẽ được triển khai sau.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Đóng'),
              ),
            ],
          ),
    );
  }

  void _showClearCacheDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Xóa cache'),
            content: const Text('Bạn có chắc chắn muốn xóa dữ liệu cache?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Hủy'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Đã xóa cache thành công!')),
                  );
                },
                child: const Text('Xóa'),
              ),
            ],
          ),
    );
  }

  void _showBackupDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Sao lưu dữ liệu'),
            content: const Text('Tạo bản sao lưu dữ liệu lên cloud?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Hủy'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Đang sao lưu dữ liệu...')),
                  );
                },
                child: const Text('Sao lưu'),
              ),
            ],
          ),
    );
  }

  void _showRestoreDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Khôi phục dữ liệu'),
            content: const Text('Khôi phục dữ liệu từ bản sao lưu gần nhất?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Hủy'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Đang khôi phục dữ liệu...')),
                  );
                },
                child: const Text('Khôi phục'),
              ),
            ],
          ),
    );
  }

  void _showPrivacyPolicy() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => Scaffold(
              appBar: AppBar(
                title: const Text('Chính sách bảo mật'),
                backgroundColor: Colors.green[600],
                foregroundColor: Colors.white,
              ),
              body: const Padding(
                padding: EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Text(
                    'Chính sách bảo mật của ứng dụng School App...\n\n'
                    'Thông tin này sẽ được cập nhật chi tiết trong phiên bản chính thức.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
      ),
    );
  }

  void _showTermsOfService() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => Scaffold(
              appBar: AppBar(
                title: const Text('Điều khoản sử dụng'),
                backgroundColor: Colors.green[600],
                foregroundColor: Colors.white,
              ),
              body: const Padding(
                padding: EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Text(
                    'Điều khoản và điều kiện sử dụng ứng dụng School App...\n\n'
                    'Thông tin này sẽ được cập nhật chi tiết trong phiên bản chính thức.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
      ),
    );
  }

  void _showAppPermissions() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Quyền ứng dụng'),
            content: const Text(
              'Chức năng quản lý quyền ứng dụng sẽ được triển khai sau.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Đóng'),
              ),
            ],
          ),
    );
  }
}
