import 'package:flutter/material.dart';

class TeacherAdvancedScheduleManagementScreen extends StatefulWidget {
  const TeacherAdvancedScheduleManagementScreen({super.key});

  @override
  State<TeacherAdvancedScheduleManagementScreen> createState() =>
      _TeacherAdvancedScheduleManagementScreenState();
}

class _TeacherAdvancedScheduleManagementScreenState
    extends State<TeacherAdvancedScheduleManagementScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
        title: const Text(
          'Quản lý lịch nâng cao',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green[600],
        foregroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(icon: Icon(Icons.assignment), text: 'Yêu cầu'),
            Tab(icon: Icon(Icons.history), text: 'Lịch sử'),
            Tab(icon: Icon(Icons.analytics), text: 'Thống kê'),
            Tab(icon: Icon(Icons.settings), text: 'Cài đặt'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildRequestsTab(),
          _buildHistoryTab(),
          _buildStatisticsTab(),
          _buildSettingsTab(),
        ],
      ),
    );
  }

  // Requests Tab - Manage substitute and makeup requests
  Widget _buildRequestsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pending requests
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.pending_actions, color: Colors.orange[600]),
                      const SizedBox(width: 8),
                      const Text(
                        'Yêu cầu đang chờ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildRequestItem(
                    'Yêu cầu thay thế',
                    'Thứ 3, 16/01 - Tiết 3',
                    'Đang chờ phê duyệt',
                    Colors.orange,
                    Icons.swap_horiz,
                  ),
                  const Divider(),
                  _buildRequestItem(
                    'Xếp lịch bù',
                    'Thứ 7, 20/01 - Tiết 1-2',
                    'Đã phê duyệt',
                    Colors.green,
                    Icons.schedule,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Create new request
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tạo yêu cầu mới',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _showSubstituteRequestDialog,
                          icon: const Icon(Icons.swap_horiz),
                          label: const Text('Yêu cầu thay thế'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[600],
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _showMakeupScheduleDialog,
                          icon: const Icon(Icons.schedule),
                          label: const Text('Xếp lịch bù'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[600],
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // History Tab - View schedule change history
  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildHistoryItem(
            'Thay thế tiết học',
            'Thứ 2, 08/01 - Tiết 4',
            'GV Nguyễn Văn C thay thế',
            Icons.swap_horiz,
            Colors.blue,
          ),
          _buildHistoryItem(
            'Lịch bù',
            'Thứ 7, 13/01 - Tiết 1-2',
            'Bù tiết bị hủy ngày 10/01',
            Icons.schedule,
            Colors.green,
          ),
          _buildHistoryItem(
            'Hủy tiết học',
            'Thứ 4, 10/01 - Tiết 2',
            'Hủy do lý do cá nhân',
            Icons.cancel,
            Colors.red,
          ),
          _buildHistoryItem(
            'Đổi phòng học',
            'Thứ 5, 11/01 - Tiết 3',
            'Từ P301 → P205',
            Icons.room,
            Colors.orange,
          ),
        ],
      ),
    );
  }

  // Statistics Tab - Teaching statistics
  Widget _buildStatisticsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Teaching hours stats
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Thống kê giờ dạy',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildStatItem('Tổng tiết dạy tuần này', '15', Icons.schedule),
                  _buildStatItem('Tiết đã dạy', '12', Icons.check_circle),
                  _buildStatItem('Tiết còn lại', '3', Icons.pending),
                  _buildStatItem('Tiết thay thế', '2', Icons.swap_horiz),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Class performance stats
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hiệu suất lớp học',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildStatItem('Tỷ lệ tham gia', '95%', Icons.people),
                  _buildStatItem('Điểm trung bình', '8.2', Icons.grade),
                  _buildStatItem('Hoàn thành bài tập', '88%', Icons.assignment_turned_in),
                  _buildStatItem('Phản hồi tích cực', '92%', Icons.thumb_up),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Settings Tab - Preferences and notifications
  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Thông báo',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text('Nhắc nhở lịch dạy'),
                    subtitle: const Text('Thông báo trước 30 phút'),
                    value: true,
                    onChanged: (value) {},
                    activeColor: Colors.green[600],
                  ),
                  SwitchListTile(
                    title: const Text('Thông báo thay đổi lịch'),
                    subtitle: const Text('Cập nhật khi có thay đổi'),
                    value: true,
                    onChanged: (value) {},
                    activeColor: Colors.green[600],
                  ),
                  SwitchListTile(
                    title: const Text('Nhắc nhở chấm điểm'),
                    subtitle: const Text('Nhắc nhở cuối tuần'),
                    value: false,
                    onChanged: (value) {},
                    activeColor: Colors.green[600],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Đồng bộ hóa',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    leading: const Icon(Icons.sync, color: Colors.blue),
                    title: const Text('Google Calendar'),
                    subtitle: const Text('Đồng bộ lịch dạy'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: _syncWithGoogleCalendar,
                  ),
                  ListTile(
                    leading: const Icon(Icons.backup, color: Colors.orange),
                    title: const Text('Sao lưu dữ liệu'),
                    subtitle: const Text('Tự động sao lưu hàng tuần'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestItem(
    String title,
    String schedule,
    String status,
    Color statusColor,
    IconData icon,
  ) {
    return ListTile(
      leading: Icon(icon, color: statusColor),
      title: Text(title),
      subtitle: Text(schedule),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: statusColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          status,
          style: TextStyle(
            color: statusColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryItem(
    String title,
    String date,
    String description,
    IconData icon,
    Color color,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(date),
            Text(
              description,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.green[600]),
          const SizedBox(width: 12),
          Expanded(child: Text(label)),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  // Dialog methods
  void _showSubstituteRequestDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Yêu cầu thay thế'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Lý do yêu cầu thay thế',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Ngày cần thay thế',
                border: OutlineInputBorder(),
              ),
              items: _getUpcomingDates().map((date) {
                return DropdownMenuItem(value: date, child: Text(date));
              }).toList(),
              onChanged: (value) {},
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Tiết học',
                border: OutlineInputBorder(),
              ),
              items: List.generate(6, (index) => 'Tiết ${index + 1}').map((period) {
                return DropdownMenuItem(value: period, child: Text(period));
              }).toList(),
              onChanged: (value) {},
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
                  content: Text('Đã gửi yêu cầu thay thế thành công!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Gửi yêu cầu'),
          ),
        ],
      ),
    );
  }

  void _showMakeupScheduleDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xếp lịch bù'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Lý do cần bù',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Ngày bù',
                border: OutlineInputBorder(),
              ),
              items: _getAvailableMakeupDates().map((date) {
                return DropdownMenuItem(value: date, child: Text(date));
              }).toList(),
              onChanged: (value) {},
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Tiết học',
                border: OutlineInputBorder(),
              ),
              items: List.generate(6, (index) => 'Tiết ${index + 1}').map((period) {
                return DropdownMenuItem(value: period, child: Text(period));
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
                  content: Text('Đã xếp lịch bù thành công!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Xác nhận'),
          ),
        ],
      ),
    );
  }

  void _syncWithGoogleCalendar() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Đồng bộ Google Calendar'),
        content: const Text('Bạn có muốn đồng bộ lịch dạy với Google Calendar không?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Simulate sync process
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const AlertDialog(
                  content: Row(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(width: 16),
                      Text('Đang đồng bộ...'),
                    ],
                  ),
                ),
              );
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Đồng bộ Google Calendar thành công!'),
                    backgroundColor: Colors.green,
                  ),
                );
              });
            },
            child: const Text('Đồng bộ'),
          ),
        ],
      ),
    );
  }

  // Helper methods
  List<String> _getUpcomingDates() {
    return [
      'Thứ 2, 15/01/2024',
      'Thứ 3, 16/01/2024',
      'Thứ 4, 17/01/2024',
      'Thứ 5, 18/01/2024',
      'Thứ 6, 19/01/2024',
    ];
  }

  List<String> _getAvailableMakeupDates() {
    return [
      'Thứ 7, 20/01/2024',
      'Chủ nhật, 21/01/2024',
      'Thứ 7, 27/01/2024',
      'Chủ nhật, 28/01/2024',
    ];
  }
}
