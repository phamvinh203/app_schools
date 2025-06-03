import 'package:flutter/material.dart';
import 'class_detail_screen.dart';
import 'teacher_schedule_screen.dart';

class TeacherClassScreen extends StatefulWidget {
  const TeacherClassScreen({super.key});

  @override
  State<TeacherClassScreen> createState() => _TeacherClassScreenState();
}

class _TeacherClassScreenState extends State<TeacherClassScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header with Teacher Info
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lớp phụ trách',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Teacher info card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.green[400]!, Colors.green[600]!],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Giáo viên: Nguyễn Thị B',
                          style: Theme.of(
                            context,
                          ).textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Bộ môn: Toán học • Trường THPT ABC',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.white.withOpacity(0.9)),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            _buildInfoChip('5 lớp', Icons.school),
                            const SizedBox(width: 12),
                            _buildInfoChip('125 học sinh', Icons.people),
                            const SizedBox(width: 12),
                            _buildInfoChip('20 tiết/tuần', Icons.schedule),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Tab bar and schedule button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TabBar(
                          controller: _tabController,
                          labelColor: Colors.green[600],
                          unselectedLabelColor: Colors.grey[600],
                          indicatorColor: Colors.green[600],
                          indicatorWeight: 3,
                          tabs: const [
                            Tab(text: 'Lớp chủ nhiệm'),
                            Tab(text: 'Gia sư ngoài'),
                          ],
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => const TeacherScheduleScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.calendar_today, size: 16),
                        label: const Text('Lịch dạy'),
                      ),
                    ],
                  ),
                ],
              ),
            ), // Tab content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // School Classes Tab
                  _buildClassList(_getSchoolClasses()),
                  // Tutoring Classes Tab
                  _buildTutoringTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClassList(List<Map<String, dynamic>> classes) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: classes.length,
        itemBuilder: (context, index) {
          final classData = classes[index];
          return _buildClassCard(context, classData);
        },
      ),
    );
  }

  Widget _buildTutoringTab() {
    final tutoringClasses = _getTutoringClasses();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Create tutoring class button
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 16),
            child: ElevatedButton.icon(
              onPressed: () {
                _showCreateTutoringClassDialog();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.add, size: 20),
              label: const Text(
                'Tạo lớp gia sư mới',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // Existing tutoring classes list
          Expanded(
            child:
                tutoringClasses.isEmpty
                    ? _buildEmptyTutoringState()
                    : ListView.builder(
                      itemCount: tutoringClasses.length,
                      itemBuilder: (context, index) {
                        final classData = tutoringClasses[index];
                        return _buildClassCard(context, classData);
                      },
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyTutoringState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.school_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Chưa có lớp gia sư nào',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tạo lớp gia sư đầu tiên của bạn',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildClassCard(BuildContext context, Map<String, dynamic> classData) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: classData['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  classData['type'] == 'school' ? Icons.school : Icons.person,
                  color: classData['color'],
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          classData['name'],
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        if (classData['type'] == 'tutoring') ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orange[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Gia sư',
                              style: TextStyle(
                                color: Colors.orange[800],
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${classData['students']} học sinh • ${classData['schedule']}',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                    ),
                    if (classData['type'] == 'tutoring') ...[
                      const SizedBox(height: 4),
                      Text(
                        'Địa chỉ: ${classData['location']}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              PopupMenuButton(
                icon: const Icon(Icons.more_vert),
                itemBuilder:
                    (context) => [
                      if (classData['type'] == 'school') ...[
                        const PopupMenuItem(
                          value: 'attendance',
                          child: Row(
                            children: [
                              Icon(Icons.fact_check, size: 20),
                              SizedBox(width: 8),
                              Text('Điểm danh'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'grades',
                          child: Row(
                            children: [
                              Icon(Icons.grade, size: 20),
                              SizedBox(width: 8),
                              Text('Xem điểm'),
                            ],
                          ),
                        ),
                      ],
                      const PopupMenuItem(
                        value: 'students',
                        child: Row(
                          children: [
                            Icon(Icons.people, size: 20),
                            SizedBox(width: 8),
                            Text('Danh sách HS'),
                          ],
                        ),
                      ),
                      if (classData['type'] == 'tutoring') ...[
                        const PopupMenuItem(
                          value: 'schedule',
                          child: Row(
                            children: [
                              Icon(Icons.schedule, size: 20),
                              SizedBox(width: 8),
                              Text('Lịch dạy'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'payment',
                          child: Row(
                            children: [
                              Icon(Icons.payment, size: 20),
                              SizedBox(width: 8),
                              Text('Thanh toán'),
                            ],
                          ),
                        ),
                      ],
                    ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Stats row
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  classData['type'] == 'school'
                      ? 'Có mặt hôm nay'
                      : 'Buổi tuần này',
                  classData['type'] == 'school'
                      ? '${classData['present']}/${classData['students']}'
                      : '${classData['sessionsThisWeek']}',
                  Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatItem(
                  classData['type'] == 'school'
                      ? 'Bài tập chưa nộp'
                      : 'Tiến độ',
                  classData['type'] == 'school'
                      ? '${classData['pending']}'
                      : '${classData['progress']}%',
                  Colors.orange,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatItem(
                  classData['type'] == 'school'
                      ? 'Điểm TB lớp'
                      : 'Học phí/tháng',
                  classData['type'] == 'school'
                      ? '${classData['avgGrade']}'
                      : '${classData['monthlyFee']}k',
                  Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: classData['color'],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: Icon(
                    classData['type'] == 'school'
                        ? Icons.assignment
                        : Icons.edit_note,
                    size: 18,
                  ),
                  label: Text(
                    classData['type'] == 'school' ? 'Tạo bài tập' : 'Ghi chú',
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                ClassDetailScreen(classData: classData),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: classData['color'],
                    side: BorderSide(color: classData['color']),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(Icons.people, size: 18),
                  label: const Text('Xem lớp'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(color: Colors.grey[600], fontSize: 11),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  void _showCreateTutoringClassDialog() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController locationController = TextEditingController();
    final TextEditingController feeController = TextEditingController();
    String selectedSchedule = 'Thứ 2 - 14:00-16:00';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Tạo lớp gia sư mới',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Tên lớp gia sư',
                    hintText: 'VD: Toán nâng cao lớp 12',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: locationController,
                  decoration: const InputDecoration(
                    labelText: 'Địa chỉ dạy',
                    hintText: 'VD: 123 Nguyễn Huệ, Q1',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: selectedSchedule,
                  decoration: const InputDecoration(
                    labelText: 'Lịch dạy',
                    border: OutlineInputBorder(),
                  ),
                  items:
                      [
                        'Thứ 2 - 14:00-16:00',
                        'Thứ 3 - 14:00-16:00',
                        'Thứ 4 - 14:00-16:00',
                        'Thứ 5 - 14:00-16:00',
                        'Thứ 6 - 14:00-16:00',
                        'Thứ 7 - 9:00-11:00',
                        'Thứ 7 - 14:00-16:00',
                        'Thứ 7 - 19:00-21:00',
                        'Chủ nhật - 9:00-11:00',
                        'Chủ nhật - 14:00-16:00',
                        'Chủ nhật - 19:00-21:00',
                      ].map((String schedule) {
                        return DropdownMenuItem<String>(
                          value: schedule,
                          child: Text(schedule),
                        );
                      }).toList(),
                  onChanged: (String? newValue) {
                    selectedSchedule = newValue!;
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: feeController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Học phí/tháng (nghìn VNĐ)',
                    hintText: 'VD: 800',
                    border: OutlineInputBorder(),
                    suffixText: 'k VNĐ',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    locationController.text.isNotEmpty &&
                    feeController.text.isNotEmpty) {
                  // Here you would normally save the new tutoring class
                  // For now, we'll just show a success message
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Đã tạo lớp gia sư "${nameController.text}"',
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Vui lòng điền đầy đủ thông tin'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
              child: const Text('Tạo lớp'),
            ),
          ],
        );
      },
    );
  }

  List<Map<String, dynamic>> _getSchoolClasses() {
    return [
      {
        'name': 'Lớp 12A1',
        'students': 35,
        'schedule': 'Thứ 2,4,6 - Tiết 1,2',
        'color': Colors.blue,
        'present': 33,
        'pending': 5,
        'avgGrade': 8.2,
        'type': 'school',
      },
      {
        'name': 'Lớp 12A2',
        'students': 34,
        'schedule': 'Thứ 3,5,7 - Tiết 3,4',
        'color': Colors.green,
        'present': 32,
        'pending': 3,
        'avgGrade': 8.5,
        'type': 'school',
      },
      {
        'name': 'Lớp 12A3',
        'students': 36,
        'schedule': 'Thứ 2,4,6 - Tiết 5,6',
        'color': Colors.orange,
        'present': 34,
        'pending': 8,
        'avgGrade': 7.9,
        'type': 'school',
      },
    ];
  }

  List<Map<String, dynamic>> _getTutoringClasses() {
    return [
      {
        'name': 'Lớp gia sư 12A',
        'students': 3,
        'schedule': 'Thứ 7 - 19:00-21:00',
        'color': Colors.purple,
        'sessionsThisWeek': 1,
        'progress': 85,
        'monthlyFee': 1200,
        'type': 'tutoring',
        'location': '123 Trần Hưng Đạo, Q1',
      },
      {
        'name': 'Gia sư cá nhân',
        'students': 1,
        'schedule': 'Chủ nhật - 14:00-16:00',
        'color': Colors.teal,
        'sessionsThisWeek': 1,
        'progress': 92,
        'monthlyFee': 800,
        'type': 'tutoring',
        'location': '456 Nguyễn Văn Cừ, Q5',
      },
    ];
  }
}
