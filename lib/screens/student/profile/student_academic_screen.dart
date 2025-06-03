import 'package:flutter/material.dart';

class StudentAcademicScreen extends StatefulWidget {
  const StudentAcademicScreen({super.key});

  @override
  State<StudentAcademicScreen> createState() => _StudentAcademicScreenState();
}

class _StudentAcademicScreenState extends State<StudentAcademicScreen> {
  String _selectedSemester = 'Học kỳ I (2023-2024)';

  final List<String> _semesters = [
    'Học kỳ I (2023-2024)',
    'Học kỳ II (2022-2023)',
    'Học kỳ I (2022-2023)',
    'Học kỳ II (2021-2022)',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Thông tin học tập'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Academic Overview
            _buildSectionCard(
              title: 'Tổng quan học tập',
              icon: Icons.school,
              children: [
                _buildStatCard('Điểm TB tích lũy', '8.5', '/10', Colors.green),
                const SizedBox(height: 12),
                _buildStatCard('Xếp loại', 'Giỏi', '', Colors.blue),
                const SizedBox(height: 12),
                _buildStatCard(
                  'Tín chỉ tích lũy',
                  '120',
                  '/150',
                  Colors.orange,
                ),
                const SizedBox(height: 12),
                _buildStatCard('Hạnh kiểm', 'Tốt', '', Colors.purple),
              ],
            ),

            const SizedBox(height: 16),

            // Semester Selection
            _buildSectionCard(
              title: 'Kết quả theo học kỳ',
              icon: Icons.calendar_today,
              children: [
                DropdownButtonFormField<String>(
                  value: _selectedSemester,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  items:
                      _semesters.map((semester) {
                        return DropdownMenuItem(
                          value: semester,
                          child: Text(semester),
                        );
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedSemester = value!;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Subject Grades
            _buildSectionCard(
              title: 'Điểm số các môn học',
              icon: Icons.grade,
              children: [
                _buildSubjectGrade('Toán học', 9.0, 'A'),
                const Divider(height: 20),
                _buildSubjectGrade('Vật lý', 8.5, 'B+'),
                const Divider(height: 20),
                _buildSubjectGrade('Hóa học', 8.8, 'A-'),
                const Divider(height: 20),
                _buildSubjectGrade('Sinh học', 8.2, 'B+'),
                const Divider(height: 20),
                _buildSubjectGrade('Ngữ văn', 8.0, 'B'),
                const Divider(height: 20),
                _buildSubjectGrade('Tiếng Anh', 9.2, 'A'),
                const Divider(height: 20),
                _buildSubjectGrade('Lịch sử', 8.3, 'B+'),
              ],
            ),

            const SizedBox(height: 16),

            // Attendance Record
            _buildSectionCard(
              title: 'Điểm danh',
              icon: Icons.fact_check,
              children: [
                _buildAttendanceItem('Tổng số buổi học', '120', Colors.blue),
                const Divider(height: 20),
                _buildAttendanceItem('Số buổi có mặt', '118', Colors.green),
                const Divider(height: 20),
                _buildAttendanceItem(
                  'Số buổi vắng có phép',
                  '2',
                  Colors.orange,
                ),
                const Divider(height: 20),
                _buildAttendanceItem(
                  'Số buổi vắng không phép',
                  '0',
                  Colors.red,
                ),
                const Divider(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Tỷ lệ tham dự',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '98.3%',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Assignments & Tests
            _buildSectionCard(
              title: 'Bài tập & Kiểm tra',
              icon: Icons.assignment,
              children: [
                _buildAssignmentStats(),
                const SizedBox(height: 16),
                _buildRecentAssignments(),
              ],
            ),

            const SizedBox(height: 16),

            // Academic Progress Chart
            _buildSectionCard(
              title: 'Tiến độ học tập',
              icon: Icons.trending_up,
              children: [_buildProgressChart()],
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

  Widget _buildStatCard(
    String label,
    String value,
    String suffix,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                TextSpan(
                  text: suffix,
                  style: TextStyle(fontSize: 14, color: color.withOpacity(0.7)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectGrade(String subject, double grade, String letterGrade) {
    Color gradeColor =
        grade >= 9.0
            ? Colors.green
            : grade >= 8.0
            ? Colors.blue
            : grade >= 7.0
            ? Colors.orange
            : Colors.red;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subject,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Điểm số: ${grade.toStringAsFixed(1)}',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: gradeColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: gradeColor.withOpacity(0.3)),
          ),
          child: Text(
            letterGrade,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: gradeColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAttendanceItem(String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildAssignmentStats() {
    return Row(
      children: [
        Expanded(
          child: _buildMiniStatCard('Hoàn thành', '15', '18', Colors.green),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildMiniStatCard('Chưa nộp', '2', '18', Colors.orange),
        ),
        const SizedBox(width: 12),
        Expanded(child: _buildMiniStatCard('Trễ hạn', '1', '18', Colors.red)),
      ],
    );
  }

  Widget _buildMiniStatCard(
    String label,
    String value,
    String total,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            '$value/$total',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildRecentAssignments() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Bài tập gần đây',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        _buildAssignmentItem(
          'Bài tập Toán - Chương 5',
          'Đã nộp',
          '9.5/10',
          Colors.green,
        ),
        const SizedBox(height: 8),
        _buildAssignmentItem(
          'Thí nghiệm Vật lý',
          'Chưa nộp',
          'Hạn: 25/05',
          Colors.orange,
        ),
        const SizedBox(height: 8),
        _buildAssignmentItem('Tiểu luận Văn', 'Đã nộp', '8.8/10', Colors.green),
      ],
    );
  }

  Widget _buildAssignmentItem(
    String title,
    String status,
    String score,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  score,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressChart() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bar_chart, size: 64, color: Colors.grey),
            SizedBox(height: 8),
            Text(
              'Biểu đồ tiến độ học tập',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Sẽ được triển khai trong phiên bản sau',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
