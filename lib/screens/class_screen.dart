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

  Widget _buildTutoringTab() {
    final myTutoringClasses = _getTutoringClasses();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Find and join tutoring classes button
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    _showAvailableTutoringClasses();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.search, size: 18),
                  label: const Text(
                    'Tìm lớp gia sư',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    _showMyTutoringApplications();
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.orange,
                    side: const BorderSide(color: Colors.orange),
                    padding: const EdgeInsets.all(12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.pending_actions, size: 18),
                  label: const Text(
                    'Đơn đăng ký',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // My enrolled tutoring classes
          Expanded(
            child:
                myTutoringClasses.isEmpty
                    ? _buildEmptyTutoringState()
                    : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lớp gia sư đã tham gia',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: ListView.builder(
                            itemCount: myTutoringClasses.length,
                            itemBuilder: (context, index) {
                              final tutoring = myTutoringClasses[index];
                              return _buildTutoringCard(context, tutoring);
                            },
                          ),
                        ),
                      ],
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
            'Chưa tham gia lớp gia sư nào',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tìm và đăng ký lớp gia sư phù hợp',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
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

  void _showAvailableTutoringClasses() {
    final availableClasses = _getAvailableTutoringClasses();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            height: MediaQuery.of(context).size.height * 0.85,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Colors.blue),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Lớp gia sư có sẵn',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ),

                // Available classes list
                Expanded(
                  child:
                      availableClasses.isEmpty
                          ? const Center(
                            child: Text(
                              'Hiện tại chưa có lớp gia sư nào',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          )
                          : ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: availableClasses.length,
                            itemBuilder: (context, index) {
                              final tutoring = availableClasses[index];
                              return _buildAvailableTutoringCard(
                                context,
                                tutoring,
                              );
                            },
                          ),
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildAvailableTutoringCard(
    BuildContext context,
    Map<String, dynamic> tutoring,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
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
                    Text(
                      tutoring['name'],
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Giáo viên: ${tutoring['teacher']}',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                    ),
                    Text(
                      'Lịch: ${tutoring['schedule']}',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                    ),
                    Text(
                      'Địa chỉ: ${tutoring['location']}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    if (tutoring['description'] != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        tutoring['description'],
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[700],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Class info
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  'Học sinh hiện tại',
                  '${tutoring['currentStudents']}/${tutoring['maxStudents']}',
                  Colors.blue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatItem(
                  'Học phí/tháng',
                  '${tutoring['monthlyFee']}k',
                  Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatItem(
                  'Trạng thái',
                  tutoring['isOpen'] ? 'Đang mở' : 'Đã đầy',
                  tutoring['isOpen'] ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Register button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed:
                  tutoring['isOpen']
                      ? () => _showRegisterDialog(tutoring)
                      : null,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    tutoring['isOpen'] ? tutoring['color'] : Colors.grey,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: Icon(
                tutoring['isOpen'] ? Icons.app_registration : Icons.block,
                size: 18,
              ),
              label: Text(
                tutoring['isOpen'] ? 'Đăng ký tham gia' : 'Lớp đã đầy',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showRegisterDialog(Map<String, dynamic> tutoring) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Đăng ký lớp gia sư'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Bạn có muốn đăng ký vào lớp "${tutoring['name']}"?'),
                const SizedBox(height: 16),
                Text(
                  'Thông tin lớp:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 8),
                Text('• Giáo viên: ${tutoring['teacher']}'),
                Text('• Lịch học: ${tutoring['schedule']}'),
                Text('• Học phí: ${tutoring['monthlyFee']}k VNĐ/tháng'),
                Text('• Địa chỉ: ${tutoring['location']}'),
                if (tutoring['description'] != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    'Mô tả:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    tutoring['description'],
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Hủy'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context); // Close bottom sheet
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Đã gửi đơn đăng ký lớp "${tutoring['name']}"',
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: tutoring['color'],
                  foregroundColor: Colors.white,
                ),
                child: const Text('Đăng ký'),
              ),
            ],
          ),
    );
  }

  void _showMyTutoringApplications() {
    final applications = _getMyTutoringApplications();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.pending_actions, color: Colors.orange),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Đơn đăng ký của tôi',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ),

                // Applications list
                Expanded(
                  child:
                      applications.isEmpty
                          ? const Center(
                            child: Text(
                              'Chưa có đơn đăng ký nào',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          )
                          : ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: applications.length,
                            itemBuilder: (context, index) {
                              final application = applications[index];
                              return _buildApplicationCard(
                                context,
                                application,
                              );
                            },
                          ),
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildApplicationCard(
    BuildContext context,
    Map<String, dynamic> application,
  ) {
    Color statusColor =
        application['status'] == 'pending'
            ? Colors.orange
            : application['status'] == 'approved'
            ? Colors.green
            : Colors.red;

    String statusText =
        application['status'] == 'pending'
            ? 'Đang chờ duyệt'
            : application['status'] == 'approved'
            ? 'Đã duyệt'
            : 'Bị từ chối';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor.withOpacity(0.3)),
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
              Expanded(
                child: Text(
                  application['className'],
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  statusText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Giáo viên: ${application['teacher']}',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
          ),
          Text(
            'Ngày đăng ký: ${application['appliedDate']}',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
          ),
          if (application['status'] == 'rejected' &&
              application['reason'] != null) ...[
            const SizedBox(height: 8),
            Text(
              'Lý do từ chối: ${application['reason']}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.red,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
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

  List<Map<String, dynamic>> _getAvailableTutoringClasses() {
    // Mock data for available tutoring classes that students can register for
    return [
      {
        'name': 'Vật lý nâng cao',
        'teacher': 'Thầy Phạm Minh Tuấn',
        'schedule': 'Thứ 3, 6 - 19:00-21:00',
        'location': '789 Lê Văn Sỹ, Q3',
        'color': Colors.green,
        'currentStudents': 8,
        'maxStudents': 12,
        'monthlyFee': 900,
        'isOpen': true,
        'type': 'tutoring',
        'description': 'Lớp ôn thi đại học, tập trung vào các dạng bài khó',
      },
      {
        'name': 'Hóa học cơ bản',
        'teacher': 'Cô Nguyễn Thị Lan',
        'schedule': 'Thứ 5, 7 - 18:00-20:00',
        'location': '321 Hoàng Văn Thụ, Q10',
        'color': Colors.orange,
        'currentStudents': 6,
        'maxStudents': 10,
        'monthlyFee': 750,
        'isOpen': true,
        'type': 'tutoring',
        'description': 'Củng cố kiến thức cơ bản, phù hợp học sinh yếu môn',
      },
      {
        'name': 'Tiếng Anh IELTS',
        'teacher': 'Thầy Michael Brown',
        'schedule': 'Chủ nhật - 14:00-17:00',
        'location': '555 Nguyễn Đình Chiểu, Q1',
        'color': Colors.red,
        'currentStudents': 15,
        'maxStudents': 15,
        'monthlyFee': 1200,
        'isOpen': false, // Class is full
        'type': 'tutoring',
        'description': 'Luyện thi IELTS từ 5.0 lên 6.5+',
      },
      {
        'name': 'Toán học tư duy',
        'teacher': 'Cô Trần Thị Hương',
        'schedule': 'Thứ 2, 4 - 17:30-19:30',
        'location': '147 Pasteur, Q3',
        'color': Colors.purple,
        'currentStudents': 4,
        'maxStudents': 8,
        'monthlyFee': 850,
        'isOpen': true,
        'type': 'tutoring',
        'description': 'Phát triển tư duy logic và giải quyết vấn đề',
      },
      {
        'name': 'Lập trình cơ bản',
        'teacher': 'Thầy Lê Văn Đức',
        'schedule': 'Thứ 6 - 19:00-21:30',
        'location': '888 Cách Mạng Tháng 8, Q10',
        'color': Colors.indigo,
        'currentStudents': 7,
        'maxStudents': 12,
        'monthlyFee': 1000,
        'isOpen': true,
        'type': 'tutoring',
        'description': 'Học lập trình Python từ cơ bản đến nâng cao',
      },
    ];
  }

  List<Map<String, dynamic>> _getMyTutoringApplications() {
    // Mock data for student's tutoring applications
    return [
      {
        'className': 'Vật lý nâng cao',
        'teacher': 'Thầy Phạm Minh Tuấn',
        'appliedDate': '15/05/2025',
        'status': 'pending', // pending, approved, rejected
        'reason': null,
      },
      {
        'className': 'Hóa học cơ bản',
        'teacher': 'Cô Nguyễn Thị Lan',
        'appliedDate': '10/05/2025',
        'status': 'approved',
        'reason': null,
      },
      {
        'className': 'Tiếng Anh IELTS',
        'teacher': 'Thầy Michael Brown',
        'appliedDate': '08/05/2025',
        'status': 'rejected',
        'reason': 'Lớp đã đầy, có thể đăng ký lớp tiếp theo',
      },
      {
        'className': 'Toán học tư duy',
        'teacher': 'Cô Trần Thị Hương',
        'appliedDate': '20/05/2025',
        'status': 'pending',
        'reason': null,
      },
    ];
  }
}
