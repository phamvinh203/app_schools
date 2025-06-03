import 'package:flutter/material.dart';

class StudentClassDetailScreen extends StatefulWidget {
  final Map<String, dynamic> subjectData;

  const StudentClassDetailScreen({
    super.key,
    required this.subjectData,
  });

  @override
  State<StudentClassDetailScreen> createState() => _StudentClassDetailScreenState();
}

class _StudentClassDetailScreenState extends State<StudentClassDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(widget.subjectData['name']),
        backgroundColor: widget.subjectData['color'],
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => _showSubjectMenu(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // Subject Info Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: widget.subjectData['color'],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        widget.subjectData['icon'],
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.subjectData['name'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Giáo viên: ${widget.subjectData['teacher']}',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: _buildQuickStat(
                        'Bài tập',
                        '${widget.subjectData['assignments']}',
                        Icons.assignment,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildQuickStat(
                        'Tài liệu',
                        '${_getDocuments().length}',
                        Icons.folder,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildQuickStat(
                        'Điểm TB',
                        '8.5',
                        Icons.star,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Tab Bar
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: widget.subjectData['color'],
              unselectedLabelColor: Colors.grey,
              indicatorColor: widget.subjectData['color'],
              tabs: const [
                Tab(text: 'Tài liệu'),
                Tab(text: 'Bài tập'),
                Tab(text: 'Điểm số'),
              ],
            ),
          ),

          // Tab Views
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildDocumentsTab(),
                _buildAssignmentsTab(),
                _buildGradesTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStat(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentsTab() {
    final documents = _getDocuments();
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue[50]!, Colors.blue[100]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue.withOpacity(0.3)),
          ),
          child: Column(
            children: [
              Icon(Icons.folder_open, size: 40, color: Colors.blue[600]),
              const SizedBox(height: 8),
              Text(
                'Tài liệu môn học',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Tải xuống và xem các tài liệu học tập',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.blue[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final document = documents[index];
              return _buildDocumentCard(document);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAssignmentsTab() {
    final assignments = _getAssignments();
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: assignments.length,
      itemBuilder: (context, index) {
        final assignment = assignments[index];
        return _buildAssignmentCard(assignment);
      },
    );
  }

  Widget _buildGradesTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Overall grade card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.analytics, 
                        color: widget.subjectData['color'], size: 30),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Điểm trung bình môn',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.subjectData['name'],
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: widget.subjectData['color'],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          '8.5',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildGradeStat('Điểm thường xuyên', '8.2'),
                      _buildGradeStat('Điểm giữa kỳ', '8.5'),
                      _buildGradeStat('Điểm cuối kỳ', '9.0'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Detailed grades list
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Chi tiết điểm số',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _getDetailedGrades().length,
                        itemBuilder: (context, index) {
                          final grade = _getDetailedGrades()[index];
                          return _buildGradeItem(grade);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradeStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: widget.subjectData['color'],
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildGradeItem(Map<String, dynamic> grade) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: _getGradeColor(grade['score']).withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              _getGradeIcon(grade['type']),
              color: _getGradeColor(grade['score']),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  grade['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  '${grade['type']} • ${grade['date']}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _getGradeColor(grade['score']),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              grade['score'].toString(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentCard(Map<String, dynamic> document) {
    final fileColor = _getFileColor(document['type']);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: fileColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            _getFileIcon(document['type']),
            color: fileColor,
            size: 24,
          ),
        ),
        title: Text(
          document['name'],
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(document['description']),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.access_time, size: 12, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  document['uploadDate'],
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(width: 16),
                Icon(Icons.file_download, size: 12, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  'Tải xuống',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.download, color: widget.subjectData['color']),
          onPressed: () => _downloadDocument(document),
        ),
      ),
    );
  }

  Widget _buildAssignmentCard(Map<String, dynamic> assignment) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: assignment['statusColor'].withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    assignment['status'],
                    style: TextStyle(
                      color: assignment['statusColor'],
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  'Hạn: ${assignment['deadline']}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              assignment['title'],
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              assignment['description'],
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                if (assignment['submitted'] == true) ...[
                  Icon(Icons.check_circle, 
                    size: 16, color: Colors.green[600]),
                  const SizedBox(width: 4),
                  Text(
                    'Đã nộp',
                    style: TextStyle(
                      color: Colors.green[600], 
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ] else ...[
                  Icon(Icons.pending, 
                    size: 16, color: Colors.orange[600]),
                  const SizedBox(width: 4),
                  Text(
                    'Chưa nộp',
                    style: TextStyle(
                      color: Colors.orange[600], 
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
                const Spacer(),
                ElevatedButton(
                  onPressed: () => _viewAssignmentDetail(assignment),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.subjectData['color'],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  ),
                  child: Text(
                    assignment['submitted'] == true ? 'Xem bài nộp' : 'Làm bài',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showSubjectMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Bật thông báo'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.schedule),
              title: const Text('Lịch học'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Hỗ trợ'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _downloadDocument(Map<String, dynamic> document) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đang tải xuống ${document['name']}...'),
        backgroundColor: widget.subjectData['color'],
      ),
    );
  }

  void _viewAssignmentDetail(Map<String, dynamic> assignment) {
    // Navigate to assignment detail screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Mở chi tiết bài tập: ${assignment['title']}'),
        backgroundColor: widget.subjectData['color'],
      ),
    );
  }

  Color _getGradeColor(double score) {
    if (score >= 9.0) return Colors.green;
    if (score >= 8.0) return Colors.blue;
    if (score >= 6.5) return Colors.orange;
    return Colors.red;
  }

  IconData _getGradeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'thường xuyên':
        return Icons.edit;
      case 'giữa kỳ':
        return Icons.quiz;
      case 'cuối kỳ':
        return Icons.school;
      default:
        return Icons.grade;
    }
  }

  IconData _getFileIcon(String type) {
    switch (type.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
      case 'docx':
        return Icons.description;
      case 'ppt':
      case 'pptx':
        return Icons.slideshow;
      case 'video':
        return Icons.play_circle_filled;
      default:
        return Icons.insert_drive_file;
    }
  }

  Color _getFileColor(String type) {
    switch (type.toLowerCase()) {
      case 'pdf':
        return Colors.red;
      case 'doc':
      case 'docx':
        return Colors.blue;
      case 'ppt':
      case 'pptx':
        return Colors.orange;
      case 'video':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  List<Map<String, dynamic>> _getDocuments() {
    return [
      {
        'name': 'Bài giảng Chương 1',
        'description': 'Slide bài giảng chương 1 ${widget.subjectData['name']}',
        'type': 'ppt',
        'uploadDate': '15/05/2025',
      },
      {
        'name': 'Tài liệu ôn tập',
        'description': 'Tổng hợp kiến thức ôn tập',
        'type': 'pdf',
        'uploadDate': '10/05/2025',
      },
      {
        'name': 'Video bài giảng',
        'description': 'Video hướng dẫn chi tiết',
        'type': 'video',
        'uploadDate': '08/05/2025',
      },
    ];
  }

  List<Map<String, dynamic>> _getAssignments() {
    return [
      {
        'title': 'Bài tập chương 1',
        'description': 'Giải các bài tập trong SGK trang 45-47',
        'deadline': '25/06/2025',
        'status': 'Đang diễn ra',
        'statusColor': Colors.blue,
        'submitted': false,
      },
      {
        'title': 'Kiểm tra 15 phút',
        'description': 'Kiểm tra kiến thức chương 1',
        'deadline': '20/06/2025',
        'status': 'Đã nộp',
        'statusColor': Colors.green,
        'submitted': true,
      },
    ];
  }

  List<Map<String, dynamic>> _getDetailedGrades() {
    return [
      {
        'name': 'Kiểm tra 15 phút - Chương 1',
        'type': 'Thường xuyên',
        'score': 8.5,
        'date': '15/05/2025',
      },
      {
        'name': 'Bài tập về nhà số 1',
        'type': 'Thường xuyên',
        'score': 9.0,
        'date': '10/05/2025',
      },
      {
        'name': 'Kiểm tra giữa kỳ',
        'type': 'Giữa kỳ',
        'score': 8.5,
        'date': '01/05/2025',
      },
      {
        'name': 'Thực hành bài 5',
        'type': 'Thường xuyên',
        'score': 7.5,
        'date': '25/04/2025',
      },
    ];
  }
}
