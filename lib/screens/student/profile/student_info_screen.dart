import 'package:flutter/material.dart';

class StudentInfoScreen extends StatefulWidget {
  const StudentInfoScreen({super.key});

  @override
  State<StudentInfoScreen> createState() => _StudentInfoScreenState();
}

class _StudentInfoScreenState extends State<StudentInfoScreen> {
  bool _isEditing = false;
  final _nameController = TextEditingController(text: 'Nguyễn Văn An');
  final _studentIdController = TextEditingController(text: 'SV20240001');
  final _phoneController = TextEditingController(text: '0123456789');
  final _emailController = TextEditingController(
    text: 'nguyenvanan@school.edu.vn',
  );
  final _addressController = TextEditingController(
    text: '123 Đường ABC, Quận 1, TP.HCM',
  );
  final _parentNameController = TextEditingController(text: 'Nguyễn Văn Bình');
  final _parentPhoneController = TextEditingController(text: '0987654321');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Thông tin cá nhân'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
              if (!_isEditing) {
                _saveProfile();
              }
            },
          ),
        ],
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
                _buildInfoItem(
                  'Họ và tên',
                  _nameController,
                  Icons.person_outline,
                ),
                const Divider(height: 20),
                _buildInfoItem(
                  'Mã số sinh viên',
                  _studentIdController,
                  Icons.badge_outlined,
                  enabled: false,
                ),
                const Divider(height: 20),
                _buildInfoItem(
                  'Số điện thoại',
                  _phoneController,
                  Icons.phone_outlined,
                ),
                const Divider(height: 20),
                _buildInfoItem('Email', _emailController, Icons.email_outlined),
                const Divider(height: 20),
                _buildInfoItem(
                  'Địa chỉ',
                  _addressController,
                  Icons.location_on_outlined,
                  maxLines: 2,
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Academic Information
            _buildSectionCard(
              title: 'Thông tin học tập',
              icon: Icons.school,
              children: [
                _buildStaticInfoItem('Lớp', '12A1'),
                const Divider(height: 20),
                _buildStaticInfoItem('Khóa học', '2021-2024'),
                const Divider(height: 20),
                _buildStaticInfoItem('Chuyên ngành', 'Khoa học Tự nhiên'),
                const Divider(height: 20),
                _buildStaticInfoItem('Giáo viên chủ nhiệm', 'Nguyễn Thị Bình'),
                const Divider(height: 20),
                _buildStaticInfoItem('Điểm trung bình', '8.5/10'),
              ],
            ),

            const SizedBox(height: 16),

            // Parent Information
            _buildSectionCard(
              title: 'Thông tin phụ huynh',
              icon: Icons.family_restroom,
              children: [
                _buildInfoItem(
                  'Tên phụ huynh',
                  _parentNameController,
                  Icons.person_outline,
                ),
                const Divider(height: 20),
                _buildInfoItem(
                  'Số điện thoại',
                  _parentPhoneController,
                  Icons.phone_outlined,
                ),
                const Divider(height: 20),
                _buildStaticInfoItem('Quan hệ', 'Bố'),
                const Divider(height: 20),
                _buildStaticInfoItem('Nghề nghiệp', 'Kỹ sư'),
              ],
            ),

            const SizedBox(height: 16),

            // Academic Achievements
            _buildSectionCard(
              title: 'Thành tích học tập',
              icon: Icons.military_tech,
              children: [
                _buildAchievementItem(
                  'Học sinh giỏi',
                  'Học kỳ I năm học 2023-2024',
                  Colors.amber,
                  Icons.emoji_events,
                ),
                const Divider(height: 20),
                _buildAchievementItem(
                  'Giải Nhất Olympic Toán',
                  'Cấp trường năm 2023',
                  Colors.orange,
                  Icons.workspace_premium,
                ),
                const Divider(height: 20),
                _buildAchievementItem(
                  'Học sinh tích cực',
                  'Hoạt động đoàn thể',
                  Colors.green,
                  Icons.volunteer_activism,
                ),
              ],
            ),

            const SizedBox(height: 24),
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
                backgroundColor: Colors.blue[100],
                child: Icon(Icons.person, size: 80, color: Colors.blue[600]),
              ),
              if (_isEditing)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue[600],
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
          Text(
            'Nguyễn Văn An',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Học sinh lớp 12A1',
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
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: Colors.blue[600], size: 24),
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
      ),
    );
  }

  Widget _buildInfoItem(
    String label,
    TextEditingController controller,
    IconData icon, {
    bool enabled = true,
    int maxLines = 1,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.blue[600], size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              _isEditing && enabled
                  ? TextField(
                    controller: controller,
                    maxLines: maxLines,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                  )
                  : Text(
                    controller.text,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStaticInfoItem(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.info_outline, color: Colors.blue[600], size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementItem(
    String title,
    String description,
    Color color,
    IconData icon,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _saveProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Thông tin cá nhân đã được cập nhật!'),
        backgroundColor: Colors.green,
      ),
    );
  }
}
