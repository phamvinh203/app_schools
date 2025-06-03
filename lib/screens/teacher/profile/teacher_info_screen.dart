import 'package:flutter/material.dart';

class TeacherInfoScreen extends StatelessWidget {
  const TeacherInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Hồ sơ giáo viên'),
        backgroundColor: Colors.green[600],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Photo Section
            _buildProfilePhotoSection(),
            const SizedBox(height: 24),

            // Personal Information
            _buildSectionCard(
              title: 'Thông tin cá nhân',
              icon: Icons.person,
              children: [
                _buildInfoItem('Họ và tên', 'Nguyễn Thị Bình'),
                _buildInfoItem('Mã giáo viên', 'GV001234'),
                _buildInfoItem('Ngày sinh', '15/08/1985'),
                _buildInfoItem('Giới tính', 'Nữ'),
                _buildInfoItem('Số điện thoại', '0123 456 789'),
                _buildInfoItem('Email', 'binh.nguyen@school.edu.vn'),
                _buildInfoItem('Địa chỉ', '123 Đường ABC, Quận 1, TP.HCM'),
              ],
            ),

            const SizedBox(height: 16),

            // Teaching Information
            _buildSectionCard(
              title: 'Thông tin giảng dạy',
              icon: Icons.school,
              children: [
                _buildInfoItem('Môn giảng dạy', 'Toán học'),
                _buildInfoItem('Trình độ', 'Thạc sĩ Toán học'),
                _buildInfoItem('Trường tốt nghiệp', 'Đại học Sư phạm TP.HCM'),
                _buildInfoItem('Năm kinh nghiệm', '15 năm'),
                _buildInfoItem('Chức vụ', 'Giáo viên chính'),
                _buildInfoItem('Lớp chủ nhiệm', '12A1'),
              ],
            ),

            const SizedBox(height: 16),

            // Academic Achievements
            _buildSectionCard(
              title: 'Thành tích học thuật',
              icon: Icons.emoji_events,
              children: [
                _buildAchievementItem(
                  'Giáo viên xuất sắc',
                  'Năm học 2023-2024',
                  Icons.star,
                  Colors.amber,
                ),
                _buildAchievementItem(
                  'Hướng dẫn HSG quốc gia',
                  'Giải nhì toán quốc gia 2023',
                  Icons.military_tech,
                  Colors.orange,
                ),
                _buildAchievementItem(
                  'Giải thưởng sáng tạo',
                  'Phương pháp giảng dạy sáng tạo',
                  Icons.lightbulb,
                  Colors.blue,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Edit Profile Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _showEditDialog(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[600],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.edit),
                label: const Text(
                  'Chỉnh sửa thông tin',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfilePhotoSection() {
    return Container(
      padding: const EdgeInsets.all(24),
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
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.green[100],
                child: Icon(Icons.person, size: 80, color: Colors.green[600]),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green[600],
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Nguyễn Thị Bình',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            'Giáo viên Toán học',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
        ],
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
      padding: const EdgeInsets.all(20),
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
          Row(
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
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementItem(
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Chỉnh sửa thông tin'),
            content: const Text(
              'Chức năng chỉnh sửa thông tin sẽ được triển khai sau.',
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
