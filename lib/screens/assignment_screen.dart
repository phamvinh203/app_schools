import 'package:flutter/material.dart';

class AssignmentScreen extends StatelessWidget {
  const AssignmentScreen({super.key});

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
                    'Bài tập',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.filter_list),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Filter tabs
              DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    TabBar(
                      labelColor: Colors.blue,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Colors.blue,
                      isScrollable: false,
                      labelStyle: const TextStyle(fontSize: 14),
                      tabs: const [
                        Tab(text: 'Tất cả'),
                        Tab(text: 'Chưa làm'),
                        Tab(text: 'Đã nộp'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.65,
                      child: TabBarView(
                        children: [
                          _buildAssignmentList(context, _getAllAssignments()),
                          _buildAssignmentList(
                            context,
                            _getPendingAssignments(),
                          ),
                          _buildAssignmentList(
                            context,
                            _getSubmittedAssignments(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
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
    final isSubmitted = assignment['status'] == 'Đã nộp';
    final isPending = assignment['status'] == 'Chưa làm';

    Color statusColor = Colors.grey;
    IconData statusIcon = Icons.help;

    if (isSubmitted) {
      statusColor = Colors.green;
      statusIcon = Icons.check_circle;
    } else if (isPending) {
      statusColor = Colors.red;
      statusIcon = Icons.pending;
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
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  assignment['subject'],
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              Icon(statusIcon, color: statusColor, size: 20),
              const SizedBox(width: 4),
              Text(
                assignment['status'],
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
              if (!isSubmitted)
                Flexible(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      isPending ? 'Làm bài' : 'Xem chi tiết',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
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
        'subject': 'Toán học',
        'title': 'Bài tập về phương trình bậc hai',
        'description':
            'Giải các bài tập trong SGK trang 45-47, bao gồm các dạng phương trình đặc biệt',
        'deadline': '25/06/2025',
        'status': 'Chưa làm',
      },
      {
        'subject': 'Vật lý',
        'title': 'Thí nghiệm về chuyển động',
        'description':
            'Thực hiện thí nghiệm và viết báo cáo về chuyển động thẳng đều',
        'deadline': '23/06/2025',
        'status': 'Đã nộp',
      },
      {
        'subject': 'Hóa học',
        'title': 'Bài kiểm tra 15 phút',
        'description':
            'Kiểm tra kiến thức về bảng tuần hoàn các nguyên tố hóa học',
        'deadline': '24/06/2025',
        'status': 'Chưa làm',
      },
      {
        'subject': 'Ngữ văn',
        'title': 'Phân tích tác phẩm',
        'description':
            'Viết bài phân tích tác phẩm "Tôi đi học" của Thanh Tịnh',
        'deadline': '26/06/2025',
        'status': 'Đã nộp',
      },
    ];
  }

  List<Map<String, dynamic>> _getPendingAssignments() {
    return _getAllAssignments()
        .where((assignment) => assignment['status'] == 'Chưa làm')
        .toList();
  }

  List<Map<String, dynamic>> _getSubmittedAssignments() {
    return _getAllAssignments()
        .where((assignment) => assignment['status'] == 'Đã nộp')
        .toList();
  }
}
