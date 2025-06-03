import 'package:flutter/material.dart';

class TeacherClassManagementScreen extends StatefulWidget {
  const TeacherClassManagementScreen({super.key});

  @override
  State<TeacherClassManagementScreen> createState() =>
      _TeacherClassManagementScreenState();
}

class _TeacherClassManagementScreenState
    extends State<TeacherClassManagementScreen> {
  String _selectedFilter = 'Tất cả';
  final List<String> _filters = [
    'Tất cả',
    'Đang dạy',
    'Chủ nhiệm',
    'Đã kết thúc',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Quản lý lớp học'),
        backgroundColor: Colors.green[600],
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => _showFilterDialog(),
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Statistics Cards
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Tổng lớp',
                    '5',
                    Icons.class_,
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    'Học sinh',
                    '152',
                    Icons.people,
                    Colors.green,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Chủ nhiệm',
                    '1',
                    Icons.star,
                    Colors.orange,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    'Bài tập',
                    '24',
                    Icons.assignment,
                    Colors.purple,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Quick Actions
            _buildQuickActionsSection(),

            const SizedBox(height: 24),

            // Classes List
            _buildClassesSection(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreateClassDialog(),
        backgroundColor: Colors.green[600],
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Tạo lớp mới'),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsSection() {
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
                child: Icon(Icons.flash_on, color: Colors.green[600], size: 24),
              ),
              const SizedBox(width: 12),
              const Text(
                'Thao tác nhanh',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 20),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 2.5,
            children: [
              _buildQuickActionButton(
                'Tạo bài tập',
                Icons.assignment_add,
                Colors.blue,
                () => _navigateToCreateAssignment(),
              ),
              _buildQuickActionButton(
                'Điểm danh',
                Icons.fact_check,
                Colors.green,
                () => _showAttendanceDialog(),
              ),
              _buildQuickActionButton(
                'Chấm điểm',
                Icons.grade,
                Colors.orange,
                () => _navigateToGrading(),
              ),
              _buildQuickActionButton(
                'Thống kê',
                Icons.analytics,
                Colors.purple,
                () => _showStatisticsDialog(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClassesSection() {
    final classes = _getFilteredClasses();

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
                child: Icon(Icons.class_, color: Colors.green[600], size: 24),
              ),
              const SizedBox(width: 12),
              const Text(
                'Danh sách lớp học',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _selectedFilter,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green[600],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: classes.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final classData = classes[index];
              return _buildClassCard(classData);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildClassCard(Map<String, dynamic> classData) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: classData['color'].withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: classData['color'].withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: classData['color'],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.class_, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      classData['name'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${classData['subject']} • ${classData['students']} học sinh',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(classData['status']).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  classData['status'],
                  style: TextStyle(
                    fontSize: 10,
                    color: _getStatusColor(classData['status']),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.schedule, size: 14, color: Colors.grey[500]),
              const SizedBox(width: 4),
              Text(
                classData['schedule'],
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => _navigateToClassDetail(classData),
                style: TextButton.styleFrom(
                  foregroundColor: classData['color'],
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                ),
                child: const Text('Chi tiết', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Đang dạy':
        return Colors.green;
      case 'Chủ nhiệm':
        return Colors.blue;
      case 'Đã kết thúc':
        return Colors.grey;
      default:
        return Colors.orange;
    }
  }

  List<Map<String, dynamic>> _getFilteredClasses() {
    final allClasses = [
      {
        'name': '12A1',
        'subject': 'Toán học',
        'students': 35,
        'status': 'Chủ nhiệm',
        'schedule': 'T2, T4, T6 - 7h00',
        'color': Colors.blue,
      },
      {
        'name': '12A2',
        'subject': 'Toán học',
        'students': 33,
        'status': 'Đang dạy',
        'schedule': 'T3, T5, T7 - 8h00',
        'color': Colors.green,
      },
      {
        'name': '11B1',
        'subject': 'Toán học',
        'students': 30,
        'status': 'Đang dạy',
        'schedule': 'T2, T4 - 9h00',
        'color': Colors.orange,
      },
      {
        'name': '11B2',
        'subject': 'Toán học',
        'students': 28,
        'status': 'Đang dạy',
        'schedule': 'T3, T6 - 10h00',
        'color': Colors.purple,
      },
      {
        'name': '10A1',
        'subject': 'Toán học',
        'students': 26,
        'status': 'Đã kết thúc',
        'schedule': 'Năm học trước',
        'color': Colors.grey,
      },
    ];

    if (_selectedFilter == 'Tất cả') {
      return allClasses;
    }
    return allClasses.where((cls) => cls['status'] == _selectedFilter).toList();
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Lọc lớp học'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children:
                  _filters.map((filter) {
                    return RadioListTile<String>(
                      title: Text(filter),
                      value: filter,
                      groupValue: _selectedFilter,
                      onChanged: (value) {
                        setState(() => _selectedFilter = value!);
                        Navigator.pop(context);
                      },
                    );
                  }).toList(),
            ),
          ),
    );
  }

  void _showCreateClassDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Tạo lớp mới'),
            content: const Text(
              'Chức năng tạo lớp mới sẽ được triển khai sau.',
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

  void _navigateToCreateAssignment() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Chuyển đến trang tạo bài tập...')),
    );
  }

  void _showAttendanceDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Điểm danh'),
            content: const Text('Chức năng điểm danh sẽ được triển khai sau.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Đóng'),
              ),
            ],
          ),
    );
  }

  void _navigateToGrading() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Chuyển đến trang chấm điểm...')),
    );
  }

  void _showStatisticsDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Thống kê lớp học'),
            content: const Text('Chức năng thống kê sẽ được triển khai sau.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Đóng'),
              ),
            ],
          ),
    );
  }

  void _navigateToClassDetail(Map<String, dynamic> classData) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Mở chi tiết lớp ${classData['name']}...')),
    );
  }
}
