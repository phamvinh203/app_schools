import 'package:flutter/material.dart';

class FeeManagementScreen extends StatefulWidget {
  const FeeManagementScreen({super.key});

  @override
  State<FeeManagementScreen> createState() => _FeeManagementScreenState();
}

class _FeeManagementScreenState extends State<FeeManagementScreen>
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
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Quản lý học phí',
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
            Tab(text: 'Tổng quan', icon: Icon(Icons.dashboard)),
            Tab(text: 'Công nợ', icon: Icon(Icons.payment)),
            Tab(text: 'Đã thu', icon: Icon(Icons.check_circle)),
            Tab(text: 'Báo cáo', icon: Icon(Icons.bar_chart)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _showCreateInvoiceDialog,
            icon: const Icon(Icons.add),
            tooltip: 'Tạo hóa đơn',
          ),
          PopupMenuButton<String>(
            onSelected: _handleMenuAction,
            itemBuilder:
                (context) => [
                  const PopupMenuItem(
                    value: 'export',
                    child: Row(
                      children: [
                        Icon(Icons.download, size: 20),
                        SizedBox(width: 8),
                        Text('Xuất báo cáo'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'settings',
                    child: Row(
                      children: [
                        Icon(Icons.settings, size: 20),
                        SizedBox(width: 8),
                        Text('Cài đặt'),
                      ],
                    ),
                  ),
                ],
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildOutstandingTab(),
          _buildPaidTab(),
          _buildReportsTab(),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary cards
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  'Tháng này',
                  '15.500.000đ',
                  'Đã thu: 12.000.000đ',
                  Colors.green,
                  Icons.trending_up,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSummaryCard(
                  'Chưa thu',
                  '3.500.000đ',
                  '5 học sinh',
                  Colors.orange,
                  Icons.schedule,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  'Quá hạn',
                  '800.000đ',
                  '2 học sinh',
                  Colors.red,
                  Icons.warning,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSummaryCard(
                  'Năm nay',
                  '180.000.000đ',
                  'Tổng doanh thu',
                  Colors.blue,
                  Icons.account_balance,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Recent activities
          const Text(
            'Hoạt động gần đây',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          ..._getRecentActivities().map(
            (activity) => _buildActivityItem(activity),
          ),

          const SizedBox(height: 24),

          // Quick actions
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Thao tác nhanh',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _showCreateInvoiceDialog,
                          icon: const Icon(Icons.add),
                          label: const Text('Tạo hóa đơn'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[600],
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _sendReminders,
                          icon: const Icon(Icons.notifications),
                          label: const Text('Gửi nhắc nhở'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange[600],
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

  Widget _buildOutstandingTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Filter buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text('Tất cả'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text('Sắp đến hạn'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text('Quá hạn'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Outstanding fees list
          ..._getOutstandingFees().map((fee) => _buildFeeCard(fee, false)),
        ],
      ),
    );
  }

  Widget _buildPaidTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Date filter
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _selectDateRange(),
                  icon: const Icon(Icons.date_range),
                  label: const Text('Tháng 6/2025'),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () => _showFilterDialog(),
                icon: const Icon(Icons.filter_list),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Paid fees list
          ..._getPaidFees().map((fee) => _buildFeeCard(fee, true)),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Monthly chart placeholder
          Container(
            height: 200,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 4,
                ),
              ],
            ),
            child: Column(
              children: [
                const Text(
                  'Doanh thu theo tháng',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.bar_chart, size: 48, color: Colors.green),
                          SizedBox(height: 8),
                          Text('Biểu đồ doanh thu sẽ hiển thị ở đây'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Statistics
          const Text(
            'Thống kê chi tiết',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildStatRow('Tổng số học sinh:', '15'),
                  _buildStatRow('Học sinh đang học:', '12'),
                  _buildStatRow('Tỷ lệ thanh toán đúng hạn:', '80%'),
                  _buildStatRow('Doanh thu trung bình/tháng:', '14.500.000đ'),
                  _buildStatRow(
                    'Lớp có doanh thu cao nhất:',
                    'Toán 12 Nâng cao',
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Export options
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Xuất báo cáo',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    leading: const Icon(
                      Icons.picture_as_pdf,
                      color: Colors.red,
                    ),
                    title: const Text('Báo cáo PDF'),
                    subtitle: const Text('Báo cáo tổng quan doanh thu'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _exportReport('pdf'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.table_chart, color: Colors.green),
                    title: const Text('Bảng tính Excel'),
                    subtitle: const Text('Chi tiết từng khoản thu'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _exportReport('excel'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(
    String title,
    String amount,
    String subtitle,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            amount,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildFeeCard(Map<String, dynamic> fee, bool isPaid) {
    final isOverdue = fee['isOverdue'] ?? false;
    final cardColor =
        isPaid ? Colors.green : (isOverdue ? Colors.red : Colors.orange);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: cardColor.withOpacity(0.1),
          child: Icon(
            isPaid ? Icons.check_circle : Icons.schedule,
            color: cardColor,
          ),
        ),
        title: Text(
          fee['studentName'],
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(fee['className']),
            Text(
              isPaid
                  ? 'Đã thanh toán: ${fee['paidDate']}'
                  : 'Hạn: ${fee['dueDate']}',
              style: TextStyle(
                color: isOverdue ? Colors.red : Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              fee['amount'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: cardColor,
                fontSize: 16,
              ),
            ),
            if (!isPaid)
              TextButton(
                onPressed: () => _markAsPaid(fee),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 0),
                ),
                child: Text(
                  'Đánh dấu đã thu',
                  style: TextStyle(fontSize: 10, color: Colors.blue[600]),
                ),
              ),
          ],
        ),
        onTap: () => _showFeeDetails(fee),
      ),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: activity['color'].withOpacity(0.1),
          child: Icon(activity['icon'], color: activity['color'], size: 20),
        ),
        title: Text(activity['title'], style: const TextStyle(fontSize: 14)),
        subtitle: Text(activity['time'], style: const TextStyle(fontSize: 12)),
        trailing: Text(
          activity['amount'],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: activity['color'],
          ),
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // Data methods
  List<Map<String, dynamic>> _getRecentActivities() {
    return [
      {
        'title': 'Nguyễn Văn A - Toán 12',
        'time': '2 giờ trước',
        'amount': '+1.200.000đ',
        'icon': Icons.check_circle,
        'color': Colors.green,
      },
      {
        'title': 'Trần Thị B - Vật lý 11',
        'time': '1 ngày trước',
        'amount': '+800.000đ',
        'icon': Icons.check_circle,
        'color': Colors.green,
      },
      {
        'title': 'Lê Văn C - Hóa 12',
        'time': '2 ngày trước',
        'amount': 'Quá hạn',
        'icon': Icons.warning,
        'color': Colors.red,
      },
    ];
  }

  List<Map<String, dynamic>> _getOutstandingFees() {
    return [
      {
        'studentName': 'Nguyễn Thị D',
        'className': 'Toán 12 Nâng cao',
        'amount': '1.200.000đ',
        'dueDate': '25/06/2025',
        'isOverdue': false,
      },
      {
        'studentName': 'Trần Văn E',
        'className': 'Vật lý 11',
        'amount': '800.000đ',
        'dueDate': '20/06/2025',
        'isOverdue': true,
      },
      {
        'studentName': 'Lê Thị F',
        'className': 'Hóa 12',
        'amount': '1.000.000đ',
        'dueDate': '30/06/2025',
        'isOverdue': false,
      },
      {
        'studentName': 'Phạm Văn G',
        'className': 'Toán 12 Nâng cao',
        'amount': '1.200.000đ',
        'dueDate': '15/06/2025',
        'isOverdue': true,
      },
      {
        'studentName': 'Hoàng Thị H',
        'className': 'Lý 12',
        'amount': '900.000đ',
        'dueDate': '28/06/2025',
        'isOverdue': false,
      },
    ];
  }

  List<Map<String, dynamic>> _getPaidFees() {
    return [
      {
        'studentName': 'Nguyễn Văn A',
        'className': 'Toán 12',
        'amount': '1.200.000đ',
        'paidDate': '15/05/2025',
      },
      {
        'studentName': 'Trần Thị B',
        'className': 'Vật lý 11',
        'amount': '800.000đ',
        'paidDate': '14/05/2025',
      },
      {
        'studentName': 'Lê Văn I',
        'className': 'Hóa 12',
        'amount': '1.000.000đ',
        'paidDate': '10/05/2025',
      },
      {
        'studentName': 'Nguyễn Thị J',
        'className': 'Toán 12 Nâng cao',
        'amount': '1.200.000đ',
        'paidDate': '08/05/2025',
      },
    ];
  }

  // Action methods
  void _handleMenuAction(String value) {
    switch (value) {
      case 'export':
        _showExportDialog();
        break;
      case 'settings':
        _showSettingsDialog();
        break;
    }
  }

  void _showCreateInvoiceDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Tạo hóa đơn học phí'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Học sinh',
                      border: OutlineInputBorder(),
                    ),
                    items:
                        ['Nguyễn Thị D', 'Trần Văn E', 'Lê Thị F', 'Phạm Văn G']
                            .map(
                              (name) => DropdownMenuItem(
                                value: name,
                                child: Text(name),
                              ),
                            )
                            .toList(),
                    onChanged: (value) {},
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Lớp gia sư',
                      border: OutlineInputBorder(),
                    ),
                    items:
                        ['Toán 12 Nâng cao', 'Vật lý 11', 'Hóa 12']
                            .map(
                              (className) => DropdownMenuItem(
                                value: className,
                                child: Text(className),
                              ),
                            )
                            .toList(),
                    onChanged: (value) {},
                  ),
                  const SizedBox(height: 16),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Số tiền',
                      border: OutlineInputBorder(),
                      suffix: Text('đ'),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Hạn thanh toán',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    readOnly: true,
                    onTap: () async {
                      await showDatePicker(
                        context: context,
                        initialDate: DateTime.now().add(
                          const Duration(days: 30),
                        ),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Ghi chú',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 2,
                  ),
                ],
              ),
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
                      content: Text('Đã tạo hóa đơn thành công!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                child: const Text('Tạo'),
              ),
            ],
          ),
    );
  }

  void _markAsPaid(Map<String, dynamic> fee) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Xác nhận thanh toán'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Xác nhận ${fee['studentName']} đã thanh toán ${fee['amount']}?',
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Phương thức thanh toán',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'cash', child: Text('Tiền mặt')),
                    DropdownMenuItem(
                      value: 'bank',
                      child: Text('Chuyển khoản'),
                    ),
                    DropdownMenuItem(value: 'card', child: Text('Thẻ')),
                    DropdownMenuItem(
                      value: 'ewallet',
                      child: Text('Ví điện tử'),
                    ),
                  ],
                  onChanged: (value) {},
                ),
                const SizedBox(height: 16),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Ghi chú (tùy chọn)',
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
                  setState(() {
                    // Update fee status to paid
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Đã cập nhật trạng thái thanh toán!'),
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

  void _showFeeDetails(Map<String, dynamic> fee) {
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
                    Icon(Icons.receipt, size: 32, color: Colors.green[600]),
                    const SizedBox(width: 12),
                    const Text(
                      'Chi tiết học phí',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildDetailRow('Học sinh:', fee['studentName']),
                _buildDetailRow('Lớp học:', fee['className']),
                _buildDetailRow('Số tiền:', fee['amount']),
                if (fee['dueDate'] != null)
                  _buildDetailRow('Hạn thanh toán:', fee['dueDate']),
                if (fee['paidDate'] != null)
                  _buildDetailRow('Ngày thanh toán:', fee['paidDate']),
                if (fee['paymentMethod'] != null)
                  _buildDetailRow('Phương thức:', fee['paymentMethod']),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          _printInvoice(fee);
                        },
                        icon: const Icon(Icons.print),
                        label: const Text('In hóa đơn'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          _sendInvoiceEmail(fee);
                        },
                        icon: const Icon(Icons.email),
                        label: const Text('Gửi email'),
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
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  void _selectDateRange() async {
    final dateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2026),
      initialDateRange: DateTimeRange(
        start: DateTime.now().subtract(const Duration(days: 30)),
        end: DateTime.now(),
      ),
    );
    if (dateRange != null) {
      // Filter data by date range
      setState(() {
        // Update filtered data
      });
    }
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Bộ lọc'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Lớp học',
                    border: OutlineInputBorder(),
                  ),
                  items:
                      ['Tất cả', 'Toán 12 Nâng cao', 'Vật lý 11', 'Hóa 12']
                          .map(
                            (item) => DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {},
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Phương thức thanh toán',
                    border: OutlineInputBorder(),
                  ),
                  items:
                      [
                            'Tất cả',
                            'Tiền mặt',
                            'Chuyển khoản',
                            'Thẻ',
                            'Ví điện tử',
                          ]
                          .map(
                            (item) => DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            ),
                          )
                          .toList(),
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
                  // Apply filters
                },
                child: const Text('Áp dụng'),
              ),
            ],
          ),
    );
  }

  void _sendReminders() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Gửi nhắc nhở'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Chọn đối tượng gửi nhắc nhở:'),
                const SizedBox(height: 16),
                CheckboxListTile(
                  title: const Text('Học sinh sắp đến hạn'),
                  subtitle: const Text('3 học sinh'),
                  value: true,
                  onChanged: (value) {},
                ),
                CheckboxListTile(
                  title: const Text('Học sinh quá hạn'),
                  subtitle: const Text('2 học sinh'),
                  value: true,
                  onChanged: (value) {},
                ),
                const SizedBox(height: 16),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Tin nhắn tùy chỉnh',
                    border: OutlineInputBorder(),
                    hintText: 'Nhập tin nhắn hoặc để trống sử dụng mẫu có sẵn',
                  ),
                  maxLines: 3,
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
                      content: Text('Đã gửi nhắc nhở đến 5 học sinh!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                child: const Text('Gửi'),
              ),
            ],
          ),
    );
  }

  void _showExportDialog() {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Xuất báo cáo học phí',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
                  title: const Text('Báo cáo PDF'),
                  subtitle: const Text('Tổng quan doanh thu và công nợ'),
                  onTap: () {
                    Navigator.pop(context);
                    _exportReport('pdf');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.table_chart, color: Colors.green),
                  title: const Text('Bảng tính Excel'),
                  subtitle: const Text('Chi tiết từng khoản thu và học sinh'),
                  onTap: () {
                    Navigator.pop(context);
                    _exportReport('excel');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.email, color: Colors.blue),
                  title: const Text('Gửi email báo cáo'),
                  subtitle: const Text('Gửi báo cáo qua email'),
                  onTap: () {
                    Navigator.pop(context);
                    _sendReportEmail();
                  },
                ),
              ],
            ),
          ),
    );
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Cài đặt học phí'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SwitchListTile(
                    title: const Text('Nhắc nhở tự động'),
                    subtitle: const Text('Gửi nhắc nhở trước hạn 3 ngày'),
                    value: true,
                    onChanged: (value) {},
                  ),
                  SwitchListTile(
                    title: const Text('Thông báo thanh toán'),
                    subtitle: const Text(
                      'Nhận thông báo khi có thanh toán mới',
                    ),
                    value: true,
                    onChanged: (value) {},
                  ),
                  const SizedBox(height: 16),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Ngày tạo hóa đơn hàng tháng',
                      border: OutlineInputBorder(),
                      suffix: Text('của tháng'),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Số ngày nhắc nhở trước hạn',
                      border: OutlineInputBorder(),
                      suffix: Text('ngày'),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
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
                    const SnackBar(content: Text('Đã lưu cài đặt!')),
                  );
                },
                child: const Text('Lưu'),
              ),
            ],
          ),
    );
  }

  void _exportReport(String format) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đang xuất báo cáo ${format.toUpperCase()}...'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _printInvoice(Map<String, dynamic> fee) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đang chuẩn bị in hóa đơn...'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _sendInvoiceEmail(Map<String, dynamic> fee) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đã gửi hóa đơn qua email!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _sendReportEmail() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đã gửi báo cáo qua email!'),
        backgroundColor: Colors.green,
      ),
    );
  }
}
