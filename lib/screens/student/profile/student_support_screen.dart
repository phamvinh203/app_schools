import 'package:flutter/material.dart';

class StudentSupportScreen extends StatelessWidget {
  const StudentSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Hỗ trợ'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quick Help Section
            _buildSectionCard(
              title: 'Trợ giúp nhanh',
              icon: Icons.help_outline,
              children: [
                _buildHelpItem(
                  Icons.play_circle_outline,
                  'Hướng dẫn sử dụng',
                  'Video hướng dẫn các tính năng cơ bản cho học sinh',
                  Colors.blue,
                  () => _showTutorial(context),
                ),
                const Divider(height: 20),
                _buildHelpItem(
                  Icons.quiz_outlined,
                  'Câu hỏi thường gặp',
                  'Tìm câu trả lời cho các vấn đề phổ biến',
                  Colors.orange,
                  () => _showFAQ(context),
                ),
                const Divider(height: 20),
                _buildHelpItem(
                  Icons.school_outlined,
                  'Hướng dẫn học tập',
                  'Mẹo và kỹ thuật học tập hiệu quả',
                  Colors.green,
                  () => _showStudyGuide(context),
                ),
                const Divider(height: 20),
                _buildHelpItem(
                  Icons.description_outlined,
                  'Tài liệu hướng dẫn',
                  'Hướng dẫn chi tiết sử dụng ứng dụng',
                  Colors.purple,
                  () => _openUserManual(),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Academic Support
            _buildSectionCard(
              title: 'Hỗ trợ học tập',
              icon: Icons.school,
              children: [
                _buildSupportItem(
                  Icons.assignment_outlined,
                  'Hỗ trợ bài tập',
                  'Cần giúp đỡ về bài tập và dự án',
                  Colors.blue,
                  () => _showHomeworkHelp(context),
                ),
                const Divider(height: 20),
                _buildSupportItem(
                  Icons.group_outlined,
                  'Nhóm học tập',
                  'Tham gia nhóm học tập với bạn bè',
                  Colors.green,
                  () => _showStudyGroups(context),
                ),
                const Divider(height: 20),
                _buildSupportItem(
                  Icons.psychology_outlined,
                  'Tư vấn học tập',
                  'Lời khuyên từ giáo viên và chuyên gia',
                  Colors.purple,
                  () => _showAcademicCounseling(context),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Contact Support Section
            _buildSectionCard(
              title: 'Liên hệ hỗ trợ',
              icon: Icons.contact_support_outlined,
              children: [
                _buildContactItem(
                  Icons.phone_outlined,
                  'Hotline học sinh',
                  '1900-2468',
                  'Thời gian: 7:00 - 19:00 (T2-T6)',
                  Colors.green,
                  () => _makePhoneCall('19002468'),
                ),
                const Divider(height: 20),
                _buildContactItem(
                  Icons.email_outlined,
                  'Email hỗ trợ',
                  'student.support@schoolapp.edu.vn',
                  'Phản hồi trong vòng 12h',
                  Colors.blue,
                  () => _sendEmail('student.support@schoolapp.edu.vn'),
                ),
                const Divider(height: 20),
                _buildContactItem(
                  Icons.chat_outlined,
                  'Chat với giáo viên',
                  'Hỗ trợ trực tiếp từ giáo viên',
                  'Thời gian: 8:00 - 20:00 hàng ngày',
                  Colors.teal,
                  () => _openTeacherChat(),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Technical Support Section
            _buildSectionCard(
              title: 'Hỗ trợ kỹ thuật',
              icon: Icons.build_outlined,
              children: [
                _buildTechItem(
                  Icons.bug_report_outlined,
                  'Báo lỗi ứng dụng',
                  'Báo cáo lỗi hoặc sự cố kỹ thuật',
                  () => _showBugReportDialog(context),
                ),
                const Divider(height: 20),
                _buildTechItem(
                  Icons.lightbulb_outline,
                  'Đề xuất cải tiến',
                  'Ý tưởng cải thiện ứng dụng',
                  () => _showFeatureRequestDialog(context),
                ),
                const Divider(height: 20),
                _buildTechItem(
                  Icons.system_update_outlined,
                  'Kiểm tra cập nhật',
                  'Phiên bản hiện tại: v2.1.0',
                  () => _checkForUpdates(context),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Emergency Contact
            _buildSectionCard(
              title: 'Liên hệ khẩn cấp',
              icon: Icons.emergency,
              children: [
                _buildEmergencyItem(
                  Icons.local_hospital,
                  'Y tế trường học',
                  '0123-456-789',
                  'Liên hệ khi có vấn đề sức khỏe',
                ),
                const Divider(height: 20),
                _buildEmergencyItem(
                  Icons.security,
                  'An ninh trường',
                  '0123-456-790',
                  'Báo cáo sự cố an ninh',
                ),
                const Divider(height: 20),
                _buildEmergencyItem(
                  Icons.psychology,
                  'Tư vấn tâm lý',
                  '0123-456-791',
                  'Hỗ trợ tâm lý và tinh thần',
                ),
              ],
            ),

            const SizedBox(height: 16),

            // App Information Section
            _buildSectionCard(
              title: 'Thông tin ứng dụng',
              icon: Icons.info_outline,
              children: [
                _buildInfoRow('Phiên bản ứng dụng', 'v2.1.0'),
                const Divider(height: 20),
                _buildInfoRow('Ngày cập nhật', '15/05/2024'),
                const Divider(height: 20),
                _buildInfoRow('Hỗ trợ bởi', 'EduTech Solutions'),
                const Divider(height: 20),
                InkWell(
                  onTap: () => _showLicenseDialog(context),
                  child: Row(
                    children: [
                      Icon(
                        Icons.article_outlined,
                        color: Colors.blue[600],
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Điều khoản sử dụng',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Xem điều khoản và chính sách',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey,
                      ),
                    ],
                  ),
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
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blue[600], size: 24),
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

  Widget _buildHelpItem(
    IconData icon,
    String title,
    String subtitle,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
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
                    subtitle,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportItem(
    IconData icon,
    String title,
    String subtitle,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
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
                    subtitle,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem(
    IconData icon,
    String title,
    String contact,
    String subtitle,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
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
                    contact,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: color,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  Widget _buildTechItem(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue[600], size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyItem(
    IconData icon,
    String title,
    String phone,
    String description,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red[200]!),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.red[600], size: 24),
          const SizedBox(width: 16),
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
                  phone,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[700],
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _makePhoneCall(phone),
            icon: Icon(Icons.call, color: Colors.red[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Text(value, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
      ],
    );
  }

  // Helper methods for functionality
  void _showTutorial(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Hướng dẫn sử dụng'),
            content: const Text(
              'Chức năng này sẽ mở video hướng dẫn sử dụng ứng dụng dành cho học sinh. '
              'Bạn có muốn tiếp tục?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Hủy'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Open tutorial video
                },
                child: const Text('Xem ngay'),
              ),
            ],
          ),
    );
  }

  void _showFAQ(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const StudentFAQScreen()),
    );
  }

  void _showStudyGuide(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Hướng dẫn học tập'),
            content: const Text(
              'Tính năng hướng dẫn học tập sẽ được triển khai sau.',
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

  void _openUserManual() {
    // Open user manual PDF or web page
  }

  void _showHomeworkHelp(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Hỗ trợ bài tập'),
            content: const Text(
              'Tính năng hỗ trợ bài tập sẽ được triển khai sau.',
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

  void _showStudyGroups(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Nhóm học tập'),
            content: const Text(
              'Tính năng nhóm học tập sẽ được triển khai sau.',
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

  void _showAcademicCounseling(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Tư vấn học tập'),
            content: const Text(
              'Tính năng tư vấn học tập sẽ được triển khai sau.',
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

  void _makePhoneCall(String phoneNumber) {
    // In a real app, this would launch the phone dialer
  }

  void _sendEmail(String email) {
    // In a real app, this would open the email client
  }

  void _openTeacherChat() {
    // Open teacher chat functionality
  }

  void _showBugReportDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => const BugReportDialog());
  }

  void _showFeatureRequestDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const FeatureRequestDialog(),
    );
  }

  void _checkForUpdates(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Kiểm tra cập nhật'),
            content: const Text(
              'Bạn đang sử dụng phiên bản mới nhất của ứng dụng.',
            ),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  void _showLicenseDialog(BuildContext context) {
    showLicensePage(
      context: context,
      applicationName: 'School App',
      applicationVersion: 'v2.1.0',
    );
  }
}

// Student FAQ Screen
class StudentFAQScreen extends StatelessWidget {
  const StudentFAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> faqs = [
      {
        'question': 'Làm thế nào để xem bài tập đã được giao?',
        'answer':
            'Vào tab "Bài tập" trên màn hình chính để xem tất cả bài tập.',
      },
      {
        'question': 'Tôi quên mật khẩu, làm sao để đặt lại?',
        'answer':
            'Nhấn "Quên mật khẩu" tại màn hình đăng nhập và làm theo hướng dẫn.',
      },
      {
        'question': 'Làm thế nào để xem điểm số của mình?',
        'answer':
            'Vào "Thông tin cá nhân" > "Thông tin học tập" để xem điểm chi tiết.',
      },
      {
        'question': 'Làm sao để liên hệ với giáo viên?',
        'answer': 'Sử dụng tính năng "Chat với giáo viên" trong mục Hỗ trợ.',
      },
      {
        'question': 'Ứng dụng có thông báo khi có bài tập mới không?',
        'answer': 'Có, bạn có thể bật thông báo trong "Cài đặt" > "Thông báo".',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Câu hỏi thường gặp'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ExpansionTile(
              title: Text(
                faqs[index]['question']!,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    faqs[index]['answer']!,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Bug Report Dialog
class BugReportDialog extends StatefulWidget {
  const BugReportDialog({super.key});

  @override
  State<BugReportDialog> createState() => _BugReportDialogState();
}

class _BugReportDialogState extends State<BugReportDialog> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Báo cáo lỗi'),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Tiêu đề lỗi',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Mô tả chi tiết',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Hủy'),
        ),
        ElevatedButton(
          onPressed: () {
            // Submit bug report
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Báo cáo lỗi đã được gửi thành công'),
              ),
            );
          },
          child: const Text('Gửi'),
        ),
      ],
    );
  }
}

// Feature Request Dialog
class FeatureRequestDialog extends StatefulWidget {
  const FeatureRequestDialog({super.key});

  @override
  State<FeatureRequestDialog> createState() => _FeatureRequestDialogState();
}

class _FeatureRequestDialogState extends State<FeatureRequestDialog> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Đề xuất tính năng'),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Tên tính năng',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Mô tả chi tiết',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Hủy'),
        ),
        ElevatedButton(
          onPressed: () {
            // Submit feature request
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Đề xuất đã được gửi thành công')),
            );
          },
          child: const Text('Gửi'),
        ),
      ],
    );
  }
}
