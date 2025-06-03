import 'package:flutter/material.dart';

class TeacherScheduleScreen extends StatefulWidget {
  const TeacherScheduleScreen({super.key});

  @override
  State<TeacherScheduleScreen> createState() => _TeacherScheduleScreenState();
}

class _TeacherScheduleScreenState extends State<TeacherScheduleScreen> {
  int selectedWeek = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Lịch dạy',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green[600],
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
                    value: 'print',
                    child: Row(
                      children: [
                        Icon(Icons.print, size: 20),
                        SizedBox(width: 8),
                        Text('In lịch'),
                      ],
                    ),
                  ),
                ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Header with week navigation
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green[600],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                // Teacher info
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        color: Colors.green[600],
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Nguyễn Thị B',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Giáo viên Toán • 15 tiết/tuần',
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
                    '3 tiết',
                    Icons.today,
                    Colors.blue,
                  ),
                ),
                Container(width: 1, height: 40, color: Colors.grey[300]),
                Expanded(
                  child: _buildQuickStat(
                    'Tuần này',
                    '15 tiết',
                    Icons.calendar_view_week,
                    Colors.green,
                  ),
                ),
                Container(width: 1, height: 40, color: Colors.grey[300]),
                Expanded(
                  child: _buildQuickStat(
                    'Nghỉ dạy',
                    '0 tiết',
                    Icons.free_breakfast,
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddClassDialog(context),
        backgroundColor: Colors.green[600],
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Thêm lịch', style: TextStyle(color: Colors.white)),
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
              classInfo['className'],
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
          {'className': '12A1', 'room': 'A101', 'color': Colors.blue},
          null,
          {'className': '12A2', 'room': 'A102', 'color': Colors.green},
          null,
          {'className': '12A1', 'room': 'A101', 'color': Colors.blue},
          null,
        ],
      },
      {
        'period': 2,
        'time': '7:45\n8:30',
        'classes': [
          {'className': '12A1', 'room': 'A101', 'color': Colors.blue},
          null,
          {'className': '12A2', 'room': 'A102', 'color': Colors.green},
          null,
          {'className': '12A1', 'room': 'A101', 'color': Colors.blue},
          null,
        ],
      },
      {
        'period': 3,
        'time': '8:45\n9:30',
        'classes': [
          null,
          {'className': '12A2', 'room': 'A102', 'color': Colors.green},
          null,
          {'className': '12A3', 'room': 'A103', 'color': Colors.orange},
          null,
          {'className': '12A2', 'room': 'A102', 'color': Colors.green},
        ],
      },
      {
        'period': 4,
        'time': '9:30\n10:15',
        'classes': [
          null,
          {'className': '12A2', 'room': 'A102', 'color': Colors.green},
          null,
          {'className': '12A3', 'room': 'A103', 'color': Colors.orange},
          null,
          {'className': '12A2', 'room': 'A102', 'color': Colors.green},
        ],
      },
      {
        'period': 5,
        'time': '10:30\n11:15',
        'classes': [
          {'className': '12A3', 'room': 'A103', 'color': Colors.orange},
          null,
          null,
          null,
          {'className': '12A3', 'room': 'A103', 'color': Colors.orange},
          null,
        ],
      },
      {
        'period': 6,
        'time': '11:15\n12:00',
        'classes': [
          {'className': '12A3', 'room': 'A103', 'color': Colors.orange},
          null,
          null,
          null,
          {'className': '12A3', 'room': 'A103', 'color': Colors.orange},
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
                        Icons.school,
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
                            'Lớp ${classInfo['className']}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Phòng ${classInfo['room']} • Môn Toán',
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
                _buildDetailRow('Sĩ số', '35 học sinh', Icons.people),
                _buildDetailRow('Chủ đề', 'Hàm số bậc nhất', Icons.book),

                const SizedBox(height: 24),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.fact_check),
                        label: const Text('Điểm danh'),
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
                        icon: const Icon(Icons.edit),
                        label: const Text('Chỉnh sửa'),
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

  void _showAddClassDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Thêm lịch dạy'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Lớp học',
                    border: OutlineInputBorder(),
                  ),
                  items:
                      ['12A1', '12A2', '12A3'].map((className) {
                        return DropdownMenuItem(
                          value: className,
                          child: Text(className),
                        );
                      }).toList(),
                  onChanged: (value) {},
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Thứ',
                    border: OutlineInputBorder(),
                  ),
                  items:
                      _getDaysOfWeek().map((day) {
                        return DropdownMenuItem(value: day, child: Text(day));
                      }).toList(),
                  onChanged: (value) {},
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Tiết học',
                    border: OutlineInputBorder(),
                  ),
                  items:
                      List.generate(6, (index) => 'Tiết ${index + 1}').map((
                        period,
                      ) {
                        return DropdownMenuItem(
                          value: period,
                          child: Text(period),
                        );
                      }).toList(),
                  onChanged: (value) {},
                ),
                const SizedBox(height: 16),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Phòng học',
                    border: OutlineInputBorder(),
                  ),
                ),
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Đã thêm lịch dạy thành công!'),
                    ),
                  );
                },
                child: const Text('Thêm'),
              ),
            ],
          ),
    );
  }
}
