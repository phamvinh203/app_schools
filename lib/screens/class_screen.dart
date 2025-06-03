import 'package:flutter/material.dart';
import 'student_class_detail_screen.dart';
import 'student/student_schedule_screen.dart';

class ClassScreen extends StatefulWidget {
  const ClassScreen({super.key});

  @override
  State<ClassScreen> createState() => _ClassScreenState();
}

class _ClassScreenState extends State<ClassScreen>
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
            // Header with student info
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lớp học',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Quick info card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue[400]!, Colors.blue[600]!],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lớp 12A1',
                          style: Theme.of(
                            context,
                          ).textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Trường THPT ABC • Sĩ số: 35 học sinh',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.white.withOpacity(0.9)),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            _buildInfoChip('6 môn học', Icons.book),
                            const SizedBox(width: 12),
                            _buildInfoChip('2 lớp gia sư', Icons.person),
                            const SizedBox(width: 12),
                            _buildInfoChip('12 bài tập', Icons.assignment),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Tab bar and schedule button
                  Row(
                    children: [
                      Expanded(
                        child: TabBar(
                          controller: _tabController,
                          labelColor: Colors.blue[600],
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: Colors.blue[600],
                          tabs: const [
                            Tab(
                              text: 'Môn học trường',
                              icon: Icon(Icons.school, size: 20),
                            ),
                            Tab(
                              text: 'Lớp gia sư',
                              icon: Icon(Icons.person, size: 20),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => const StudentScheduleScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.calendar_today, size: 16),
                        label: const Text('Lịch học'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Tab content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // School Subjects Tab
                  _buildSubjectGrid(_getSchoolSubjects()),
                  // Tutoring Classes Tab
                  _buildTutoringList(_getTutoringClasses()),
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

  Widget _buildSubjectGrid(List<Map<String, dynamic>> subjects) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.0,
        ),
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          final subject = subjects[index];
          return _buildSubjectCard(context, subject);
        },
      ),
    );
  }

  Widget _buildTutoringList(List<Map<String, dynamic>> tutoringClasses) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: tutoringClasses.length,
        itemBuilder: (context, index) {
          final tutoring = tutoringClasses[index];
          return _buildTutoringCard(context, tutoring);
        },
      ),
    );
  }

  Widget _buildTutoringCard(
    BuildContext context,
    Map<String, dynamic> tutoring,
  ) {
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
                  color: tutoring['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.person, color: tutoring['color'], size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          tutoring['name'],
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Gia sư',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Giáo viên: ${tutoring['teacher']}',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Lịch: ${tutoring['schedule']}',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Địa chỉ: ${tutoring['location']}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Stats row
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  'Buổi tuần này',
                  '${tutoring['sessionsThisWeek']}',
                  Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatItem(
                  'Tiến độ',
                  '${tutoring['progress']}%',
                  Colors.orange,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatItem(
                  'Học phí/tháng',
                  '${tutoring['monthlyFee']}k',
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
                    backgroundColor: tutoring['color'],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(Icons.assignment_turned_in, size: 18),
                  label: const Text('Bài tập'),
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
                                StudentClassDetailScreen(subjectData: tutoring),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: tutoring['color'],
                    side: BorderSide(color: tutoring['color']),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(Icons.info_outline, size: 18),
                  label: const Text('Chi tiết'),
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

  Widget _buildSubjectCard(BuildContext context, Map<String, dynamic> subject) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => StudentClassDetailScreen(subjectData: subject),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: subject['color'].withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(subject['icon'], color: subject['color'], size: 24),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: Text(
                subject['name'],
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 2),
            Flexible(
              child: Text(
                subject['teacher'],
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    '${subject['assignments']} bài tập',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: subject['color'],
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: Colors.grey[400],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getSchoolSubjects() {
    return [
      {
        'name': 'Toán học',
        'teacher': 'Cô Nguyễn Thị A',
        'assignments': 3,
        'icon': Icons.calculate,
        'color': Colors.blue,
        'type': 'school',
      },
      {
        'name': 'Vật lý',
        'teacher': 'Thầy Trần Văn B',
        'assignments': 2,
        'icon': Icons.science,
        'color': Colors.green,
        'type': 'school',
      },
      {
        'name': 'Hóa học',
        'teacher': 'Cô Lê Thị C',
        'assignments': 4,
        'icon': Icons.biotech,
        'color': Colors.orange,
        'type': 'school',
      },
      {
        'name': 'Ngữ văn',
        'teacher': 'Cô Phạm Thị D',
        'assignments': 2,
        'icon': Icons.menu_book,
        'color': Colors.purple,
        'type': 'school',
      },
      {
        'name': 'Tiếng Anh',
        'teacher': 'Cô Smith E',
        'assignments': 1,
        'icon': Icons.language,
        'color': Colors.red,
        'type': 'school',
      },
      {
        'name': 'Lịch sử',
        'teacher': 'Thầy Hoàng Văn F',
        'assignments': 0,
        'icon': Icons.history_edu,
        'color': Colors.brown,
        'type': 'school',
      },
    ];
  }

  List<Map<String, dynamic>> _getTutoringClasses() {
    return [
      {
        'name': 'Toán nâng cao',
        'teacher': 'Thầy Nguyễn Văn X',
        'schedule': 'Thứ 7 - 14:00-16:00',
        'location': '123 Trần Hưng Đạo, Q1',
        'color': Colors.indigo,
        'sessionsThisWeek': 1,
        'progress': 85,
        'monthlyFee': 800,
        'type': 'tutoring',
      },
      {
        'name': 'Tiếng Anh giao tiếp',
        'teacher': 'Cô Sarah Johnson',
        'schedule': 'Chủ nhật - 9:00-11:00',
        'location': '456 Nguyễn Văn Cừ, Q5',
        'color': Colors.teal,
        'sessionsThisWeek': 1,
        'progress': 92,
        'monthlyFee': 1000,
        'type': 'tutoring',
      },
    ];
  }
}
