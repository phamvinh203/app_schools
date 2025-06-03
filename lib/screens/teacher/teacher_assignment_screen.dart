import 'package:flutter/material.dart';
import 'create_assignment_screen.dart';

class TeacherAssignmentScreen extends StatelessWidget {
  const TeacherAssignmentScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Quản lý bài tập',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.filter_list),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Summary Cards
              Row(
                children: [
                  Expanded(
                    child: _buildSummaryCard(
                      context,
                      'Tổng bài tập',
                      '24',
                      Icons.assignment,
                      Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildSummaryCard(
                      context,
                      'Chờ chấm',
                      '12',
                      Icons.pending_actions,
                      Colors.orange,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24), // Filter tabs
              Expanded(
                child: DefaultTabController(
                  length: 4,
                  child: Column(
                    children: [
                      TabBar(
                        labelColor: Colors.green,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: Colors.green,
                        isScrollable: true,
                        labelStyle: const TextStyle(fontSize: 14),
                        tabs: const [
                          Tab(text: 'Tất cả'),
                          Tab(text: 'Chờ chấm'),
                          Tab(text: 'Đã chấm'),
                          Tab(text: 'Quá hạn'),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: TabBarView(
                          children: [
                            _buildAssignmentList(context, _getAllAssignments()),
                            _buildAssignmentList(
                              context,
                              _getPendingAssignments(),
                            ),
                            _buildAssignmentList(
                              context,
                              _getGradedAssignments(),
                            ),
                            _buildAssignmentList(
                              context,
                              _getOverdueAssignments(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateAssignmentScreen(),
            ),
          );
        },
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Tạo bài tập'),
      ),
    );
  }

  Widget _buildSummaryCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
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
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssignmentList(
    BuildContext context,
    List<Map<String, dynamic>> assignments,
  ) {
    return ListView.builder(
      itemCount: assignments.length,
      itemBuilder: (context, index) {
        final assignment = assignments[index];
        return _buildAssignmentCard(context, assignment);
      },
    );
  }

  Widget _buildAssignmentCard(
    BuildContext context,
    Map<String, dynamic> assignment,
  ) {
    final status = assignment['status'];
    Color statusColor = Colors.grey;
    IconData statusIcon = Icons.help;

    switch (status) {
      case 'Chờ chấm':
        statusColor = Colors.orange;
        statusIcon = Icons.pending_actions;
        break;
      case 'Đã chấm':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case 'Quá hạn':
        statusColor = Colors.red;
        statusIcon = Icons.warning;
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  assignment['class'],
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              Icon(statusIcon, color: statusColor, size: 20),
              const SizedBox(width: 4),
              Text(
                status,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: statusColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            assignment['title'],
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            assignment['description'],
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.people, size: 16, color: Colors.grey[500]),
              const SizedBox(width: 4),
              Text(
                '${assignment['submitted']}/${assignment['total']} đã nộp',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey[500]),
              ),
              const SizedBox(width: 16),
              Icon(Icons.schedule, size: 16, color: Colors.grey[500]),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  'Hạn: ${assignment['deadline']}',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey[500]),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (status == 'Chờ chấm')
                    TextButton(
                      onPressed: () {},
                      child: const Text('Chấm điểm'),
                    ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_vert),
                    iconSize: 20,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getAllAssignments() {
    return [
      {
        'class': '12A1',
        'title': 'Bài tập về phương trình bậc hai',
        'description':
            'Giải các bài tập trong SGK trang 45-47, bao gồm các dạng phương trình đặc biệt',
        'deadline': '25/06/2025',
        'status': 'Chờ chấm',
        'submitted': 20,
        'total': 35,
      },
      {
        'class': '12A2',
        'title': 'Thí nghiệm về chuyển động',
        'description':
            'Thực hiện thí nghiệm và viết báo cáo về chuyển động thẳng đều',
        'deadline': '23/06/2025',
        'status': 'Đã chấm',
        'submitted': 33,
        'total': 34,
      },
      {
        'class': '12A3',
        'title': 'Bài kiểm tra 15 phút',
        'description':
            'Kiểm tra kiến thức về bảng tuần hoàn các nguyên tố hóa học',
        'deadline': '20/06/2025',
        'status': 'Quá hạn',
        'submitted': 28,
        'total': 36,
      },
    ];
  }

  List<Map<String, dynamic>> _getPendingAssignments() {
    return _getAllAssignments()
        .where((assignment) => assignment['status'] == 'Chờ chấm')
        .toList();
  }

  List<Map<String, dynamic>> _getGradedAssignments() {
    return _getAllAssignments()
        .where((assignment) => assignment['status'] == 'Đã chấm')
        .toList();
  }

  List<Map<String, dynamic>> _getOverdueAssignments() {
    return _getAllAssignments()
        .where((assignment) => assignment['status'] == 'Quá hạn')
        .toList();
  }
}
