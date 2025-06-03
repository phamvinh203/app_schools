import 'package:flutter/material.dart';

class StudentScheduleScreen extends StatefulWidget {
  const StudentScheduleScreen({super.key});

  @override
  State<StudentScheduleScreen> createState() => _StudentScheduleScreenState();
}

class _StudentScheduleScreenState extends State<StudentScheduleScreen> {
  int selectedWeek = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Lịch học',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => _showCalendarView(context),
            icon: const Icon(Icons.calendar_month),
          ),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder:
                (context) => [
                  const PopupMenuItem(
                    value: 'export',
                    child: Row(
                      children: [
                        Icon(Icons.download, size: 20),
                        SizedBox(width: 8),
                        Text('Xuất lịch'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'reminder',
                    child: Row(
                      children: [
                        Icon(Icons.notifications, size: 20),
                        SizedBox(width: 8),
                        Text('Nhắc nhở'),
                      ],
                    ),
                  ),
                ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Header with student info and week navigation
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[600],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                // Student info
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        color: Colors.blue[600],
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Nguyễn Văn An',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Lớp 12A1 • 35 tiết/tuần',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Text(
                        'Tuần 12',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Week navigation
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (selectedWeek > 0) {
                          setState(() {
                            selectedWeek--;
                          });
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      icon: const Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          _getWeekRange(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Tháng ${DateTime.now().month}/2025',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          selectedWeek++;
                        });
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      icon: const Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Quick stats
          Container(
            margin: const EdgeInsets.all(16),
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
            child: Row(
              children: [
                Expanded(
                  child: _buildQuickStat(
                    'Hôm nay',
                    '6 tiết',
                    Icons.today,
                    Colors.blue,
                  ),
                ),
                Container(width: 1, height: 40, color: Colors.grey[300]),
                Expanded(
                  child: _buildQuickStat(
                    'Tuần này',
                    '35 tiết',
                    Icons.calendar_view_week,
                    Colors.green,
                  ),
                ),
                Container(width: 1, height: 40, color: Colors.grey[300]),
                Expanded(
                  child: _buildQuickStat(
                    'Bài tập',
                    '5 pending',
                    Icons.assignment,
                    Colors.orange,
                  ),
                ),
              ],
            ),
          ),

          // Schedule content
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  selectedWeek = index;
                });
              },
              itemBuilder: (context, index) {
                return _buildWeekSchedule();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStat(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildWeekSchedule() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Days of week header
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                const SizedBox(width: 60), // Space for time column
                ..._getDaysOfWeek().map(
                  (day) => Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        day,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Time slots
          ..._getTimeSlots().map((timeSlot) => _buildTimeSlotRow(timeSlot)),
        ],
      ),
    );
  }

  Widget _buildTimeSlotRow(Map<String, dynamic> timeSlot) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          // Time column
          Container(
            width: 60,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                Text(
                  'Tiết ${timeSlot['period']}',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  timeSlot['time'],
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          ),

          // Classes for each day
          ...List.generate(6, (dayIndex) {
            final classInfo = timeSlot['classes'][dayIndex];
            return Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                height: 60,
                child:
                    classInfo != null
                        ? _buildClassCard(classInfo)
                        : Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                        ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildClassCard(Map<String, dynamic> classInfo) {
    return GestureDetector(
      onTap: () => _showClassDetails(context, classInfo),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: classInfo['color'].withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: classInfo['color'], width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              classInfo['subject'],
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: classInfo['color'],
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              classInfo['room'],
              style: TextStyle(
                fontSize: 9,
                color: classInfo['color'].withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  String _getWeekRange() {
    final now = DateTime.now();
    final startOfWeek = now
        .subtract(Duration(days: now.weekday - 1))
        .add(Duration(days: selectedWeek * 7));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));

    return '${startOfWeek.day}/${startOfWeek.month} - ${endOfWeek.day}/${endOfWeek.month}';
  }

  List<String> _getDaysOfWeek() {
    return ['Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7'];
  }

  List<Map<String, dynamic>> _getTimeSlots() {
    return [
      {
        'period': 1,
        'time': '7:00\n7:45',
        'classes': [
          {
            'subject': 'Toán',
            'room': 'A101',
            'color': Colors.blue,
            'teacher': 'Cô Nguyễn Thị A',
          },
          null,
          {
            'subject': 'Vật lý',
            'room': 'B201',
            'color': Colors.green,
            'teacher': 'Thầy Trần Văn B',
          },
          null,
          {
            'subject': 'Toán',
            'room': 'A101',
            'color': Colors.blue,
            'teacher': 'Cô Nguyễn Thị A',
          },
          null,
        ],
      },
      {
        'period': 2,
        'time': '7:45\n8:30',
        'classes': [
          {
            'subject': 'Toán',
            'room': 'A101',
            'color': Colors.blue,
            'teacher': 'Cô Nguyễn Thị A',
          },
          null,
          {
            'subject': 'Vật lý',
            'room': 'B201',
            'color': Colors.green,
            'teacher': 'Thầy Trần Văn B',
          },
          null,
          {
            'subject': 'Toán',
            'room': 'A101',
            'color': Colors.blue,
            'teacher': 'Cô Nguyễn Thị A',
          },
          null,
        ],
      },
      {
        'period': 3,
        'time': '8:45\n9:30',
        'classes': [
          null,
          {
            'subject': 'Hóa học',
            'room': 'C301',
            'color': Colors.orange,
            'teacher': 'Cô Lê Thị C',
          },
          null,
          {
            'subject': 'Ngữ văn',
            'room': 'D401',
            'color': Colors.purple,
            'teacher': 'Cô Phạm Thị D',
          },
          null,
          {
            'subject': 'Hóa học',
            'room': 'C301',
            'color': Colors.orange,
            'teacher': 'Cô Lê Thị C',
          },
        ],
      },
      {
        'period': 4,
        'time': '9:30\n10:15',
        'classes': [
          null,
          {
            'subject': 'Hóa học',
            'room': 'C301',
            'color': Colors.orange,
            'teacher': 'Cô Lê Thị C',
          },
          null,
          {
            'subject': 'Ngữ văn',
            'room': 'D401',
            'color': Colors.purple,
            'teacher': 'Cô Phạm Thị D',
          },
          null,
          {
            'subject': 'Hóa học',
            'room': 'C301',
            'color': Colors.orange,
            'teacher': 'Cô Lê Thị C',
          },
        ],
      },
      {
        'period': 5,
        'time': '10:30\n11:15',
        'classes': [
          {
            'subject': 'Tiếng Anh',
            'room': 'E501',
            'color': Colors.red,
            'teacher': 'Cô Smith E',
          },
          null,
          null,
          null,
          {
            'subject': 'Lịch sử',
            'room': 'F601',
            'color': Colors.brown,
            'teacher': 'Thầy Hoàng Văn F',
          },
          null,
        ],
      },
      {
        'period': 6,
        'time': '11:15\n12:00',
        'classes': [
          {
            'subject': 'Tiếng Anh',
            'room': 'E501',
            'color': Colors.red,
            'teacher': 'Cô Smith E',
          },
          null,
          null,
          null,
          {
            'subject': 'Lịch sử',
            'room': 'F601',
            'color': Colors.brown,
            'teacher': 'Thầy Hoàng Văn F',
          },
          null,
        ],
      },
    ];
  }

  void _showClassDetails(BuildContext context, Map<String, dynamic> classInfo) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: classInfo['color'].withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.book,
                        color: classInfo['color'],
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            classInfo['subject'],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Phòng ${classInfo['room']} • ${classInfo['teacher']}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                _buildDetailRow(
                  'Thời gian',
                  '7:00 - 7:45 (Tiết 1)',
                  Icons.access_time,
                ),
                _buildDetailRow('Phòng học', classInfo['room'], Icons.room),
                _buildDetailRow(
                  'Giáo viên',
                  classInfo['teacher'],
                  Icons.person,
                ),
                _buildDetailRow(
                  'Chủ đề hôm nay',
                  'Hàm số bậc nhất',
                  Icons.topic,
                ),

                const SizedBox(height: 24),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.assignment),
                        label: const Text('Bài tập'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: classInfo['color'],
                          foregroundColor: Colors.white,
                        ),
                        icon: const Icon(Icons.notifications),
                        label: const Text('Nhắc nhở'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.grey[700], fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  void _showCalendarView(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Xem theo tháng'),
            content: SizedBox(
              width: 300,
              height: 300,
              child: CalendarDatePicker(
                initialDate: DateTime.now(),
                firstDate: DateTime(2025),
                lastDate: DateTime(2026),
                onDateChanged: (date) {
                  Navigator.pop(context);
                  // TODO: Navigate to specific week
                },
              ),
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
}
