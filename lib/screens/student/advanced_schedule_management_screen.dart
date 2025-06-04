import 'package:flutter/material.dart';

class AdvancedScheduleManagementScreen extends StatefulWidget {
  const AdvancedScheduleManagementScreen({super.key});

  @override
  State<AdvancedScheduleManagementScreen> createState() =>
      _AdvancedScheduleManagementScreenState();
}

class _AdvancedScheduleManagementScreenState
    extends State<AdvancedScheduleManagementScreen>
    with SingleTickerProviderStateMixin {
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
      appBar: AppBar(
        title: const Text('Quản lý lịch học nâng cao'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Yêu cầu', icon: Icon(Icons.request_page, size: 20)),
            Tab(text: 'Lịch sử', icon: Icon(Icons.history, size: 20)),
            Tab(text: 'Thống kê', icon: Icon(Icons.analytics, size: 20)),
            Tab(text: 'Cài đặt', icon: Icon(Icons.settings, size: 20)),
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

  Widget _buildRequestsTab() {
    final requests = _getMyRequests();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _showNewMakeupRequest,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(12),
                  ),
                  icon: const Icon(Icons.schedule),
                  label: const Text('Yêu cầu học bù'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _showNewLeaveRequest,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(12),
                  ),
                  icon: const Icon(Icons.sick),
                  label: const Text('Xin nghỉ học'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Yêu cầu gần đây',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Expanded(
            child:
                requests.isEmpty
                    ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.request_page,
                            size: 80,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Chưa có yêu cầu nào',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                    : ListView.builder(
                      itemCount: requests.length,
                      itemBuilder: (context, index) {
                        final request = requests[index];
                        return _buildRequestCard(request);
                      },
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestCard(Map<String, dynamic> request) {
    Color statusColor =
        request['status'] == 'pending'
            ? Colors.orange
            : request['status'] == 'approved'
            ? Colors.green
            : Colors.red;

    String statusText =
        request['status'] == 'pending'
            ? 'Đang chờ duyệt'
            : request['status'] == 'approved'
            ? 'Đã duyệt'
            : 'Bị từ chối';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
              Icon(
                request['type'] == 'makeup' ? Icons.schedule : Icons.sick,
                color: statusColor,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  request['title'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
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
          Text('Môn học: ${request['subject']}'),
          Text('Ngày: ${request['date']}'),
          if (request['reason'] != null) Text('Lý do: ${request['reason']}'),
          const SizedBox(height: 8),
          Text(
            'Gửi lúc: ${request['submittedAt']}',
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Lịch sử thay đổi lịch học',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                _buildHistoryItem(
                  'Học bù môn Toán',
                  'Thứ 7, 15/05/2025 - 14:00',
                  'Đã hoàn thành',
                  Icons.check_circle,
                  Colors.green,
                ),
                _buildHistoryItem(
                  'Nghỉ môn Vật lý',
                  'Thứ 3, 10/05/2025 - 07:00',
                  'Đã xin phép',
                  Icons.sick,
                  Colors.orange,
                ),
                _buildHistoryItem(
                  'Học bù môn Hóa',
                  'Chủ nhật, 05/05/2025 - 09:00',
                  'Đã hoàn thành',
                  Icons.check_circle,
                  Colors.green,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(
    String title,
    String time,
    String status,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(time, style: TextStyle(color: Colors.grey[600])),
              ],
            ),
          ),
          Text(
            status,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Thống kê học tập',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatCard('Tổng tiết học', '156', Colors.blue),
              ),
              const SizedBox(width: 12),
              Expanded(child: _buildStatCard('Tiết nghỉ', '8', Colors.orange)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildStatCard('Tiết học bù', '5', Colors.green)),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard('Tỷ lệ chuyên cần', '95%', Colors.purple),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Thống kê theo môn',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
              children: [
                _buildSubjectStat('Toán học', 28, 1, 0),
                _buildSubjectStat('Vật lý', 24, 2, 1),
                _buildSubjectStat('Hóa học', 20, 1, 0),
                _buildSubjectStat('Ngữ văn', 16, 1, 0),
                _buildSubjectStat('Tiếng Anh', 18, 2, 1),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
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
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectStat(String subject, int total, int absent, int makeup) {
    double attendanceRate = ((total - absent) / total * 100);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              subject,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text('$total tiết')),
          Expanded(child: Text('Nghỉ: $absent')),
          Expanded(child: Text('Bù: $makeup')),
          Expanded(
            child: Text(
              '${attendanceRate.toStringAsFixed(1)}%',
              style: TextStyle(
                color: attendanceRate >= 80 ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Cài đặt lịch học',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            title: const Text('Tự động đồng bộ'),
            subtitle: const Text('Đồng bộ với Google Calendar'),
            value: true,
            onChanged: (value) {},
          ),
          SwitchListTile(
            title: const Text('Thông báo thay đổi lịch'),
            subtitle: const Text('Nhận thông báo khi có thay đổi'),
            value: true,
            onChanged: (value) {},
          ),
          SwitchListTile(
            title: const Text('Nhắc nhở học bù'),
            subtitle: const Text('Nhắc nhở các tiết cần học bù'),
            value: false,
            onChanged: (value) {},
          ),
          const SizedBox(height: 24),
          const Text(
            'Tùy chọn hiển thị',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ListTile(
            title: const Text('Chế độ xem mặc định'),
            subtitle: const Text('Tuần'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Múi giờ'),
            subtitle: const Text('GMT+7 (Giờ Việt Nam)'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _exportAllData,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 48),
            ),
            icon: const Icon(Icons.download),
            label: const Text('Xuất dữ liệu lịch học'),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getMyRequests() {
    return [
      {
        'type': 'makeup',
        'title': 'Yêu cầu học bù môn Toán',
        'subject': 'Toán học',
        'date': '20/05/2025',
        'reason': 'Nghỉ ốm ngày 18/05',
        'status': 'pending',
        'submittedAt': '19/05/2025 14:30',
      },
      {
        'type': 'leave',
        'title': 'Xin nghỉ môn Vật lý',
        'subject': 'Vật lý',
        'date': '22/05/2025',
        'reason': 'Đi khám bác sĩ',
        'status': 'approved',
        'submittedAt': '18/05/2025 09:15',
      },
      {
        'type': 'makeup',
        'title': 'Yêu cầu học bù môn Hóa',
        'subject': 'Hóa học',
        'date': '15/05/2025',
        'reason': null,
        'status': 'rejected',
        'submittedAt': '14/05/2025 16:45',
      },
    ];
  }

  void _showNewMakeupRequest() {
    // This will show the same dialog as in the main schedule screen
    Navigator.pop(context);
    // The parent screen will handle showing the makeup request dialog
  }

  void _showNewLeaveRequest() {
    // This will show the same dialog as in the main schedule screen
    Navigator.pop(context);
    // The parent screen will handle showing the leave request dialog
  }

  void _exportAllData() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đang xuất dữ liệu lịch học...'),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
