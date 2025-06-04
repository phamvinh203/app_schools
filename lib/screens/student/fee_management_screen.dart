import 'package:flutter/material.dart';

class StudentFeeManagementScreen extends StatefulWidget {
  const StudentFeeManagementScreen({super.key});

  @override
  State<StudentFeeManagementScreen> createState() =>
      _StudentFeeManagementScreenState();
}

class _StudentFeeManagementScreenState extends State<StudentFeeManagementScreen>
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
          'Quản lý học phí',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: _showNotifications,
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'history':
                  _showPaymentHistory();
                  break;
                case 'help':
                  _showHelp();
                  break;
                case 'settings':
                  _showSettings();
                  break;
              }
            },
            itemBuilder:
                (context) => [
                  const PopupMenuItem(
                    value: 'history',
                    child: Text('Lịch sử giao dịch'),
                  ),
                  const PopupMenuItem(
                    value: 'help',
                    child: Text('Hướng dẫn thanh toán'),
                  ),
                  const PopupMenuItem(
                    value: 'settings',
                    child: Text('Cài đặt'),
                  ),
                ],
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Tổng quan'),
            Tab(text: 'Chưa thanh toán'),
            Tab(text: 'Đã thanh toán'),
            Tab(text: 'Hóa đơn'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildUnpaidTab(),
          _buildPaidTab(),
          _buildInvoicesTab(),
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
          // Summary Cards
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  'Cần thanh toán',
                  '2.500.000 ₫',
                  Icons.payment,
                  Colors.red,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSummaryCard(
                  'Đã thanh toán tháng này',
                  '1.800.000 ₫',
                  Icons.check_circle,
                  Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildSummaryCard(
                  'Quá hạn',
                  '500.000 ₫',
                  Icons.warning,
                  Colors.orange,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSummaryCard(
                  'Tổng năm học',
                  '18.500.000 ₫',
                  Icons.account_balance_wallet,
                  Colors.blue,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Quick Actions
          const Text(
            'Thao tác nhanh',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildQuickActionCard(
                  'Thanh toán ngay',
                  Icons.payment,
                  Colors.green,
                  _showQuickPayment,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildQuickActionCard(
                  'Xem hóa đơn',
                  Icons.receipt,
                  Colors.blue,
                  () => _tabController.animateTo(3),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildQuickActionCard(
                  'Lịch sử',
                  Icons.history,
                  Colors.purple,
                  () => _tabController.animateTo(2),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildQuickActionCard(
                  'Hỗ trợ',
                  Icons.help,
                  Colors.orange,
                  _showHelp,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Recent Fees
          const Text(
            'Học phí gần đây',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ..._getRecentFees().map((fee) => _buildRecentFeeCard(fee)),

          const SizedBox(height: 24),

          // Payment Methods
          const Text(
            'Phương thức thanh toán',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildPaymentMethodsCard(),
        ],
      ),
    );
  }

  Widget _buildUnpaidTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Filter and Sort
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: DropdownButton<String>(
                    value: 'all',
                    underline: const SizedBox(),
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(value: 'all', child: Text('Tất cả')),
                      DropdownMenuItem(
                        value: 'overdue',
                        child: Text('Quá hạn'),
                      ),
                      DropdownMenuItem(
                        value: 'due_soon',
                        child: Text('Sắp đến hạn'),
                      ),
                      DropdownMenuItem(
                        value: 'tutoring',
                        child: Text('Gia sư'),
                      ),
                      DropdownMenuItem(
                        value: 'school',
                        child: Text('Học phí trường'),
                      ),
                    ],
                    onChanged: (value) {},
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: _showBulkPayment,
                icon: const Icon(Icons.payment, size: 18),
                label: const Text('Thanh toán hàng loạt'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Unpaid Fees List
          ..._getUnpaidFees().map((fee) => _buildUnpaidFeeCard(fee)),
        ],
      ),
    );
  }

  Widget _buildPaidTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Date Range Filter
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Từ ngày',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    readOnly: true,
                    onTap: () => _selectDate(context, true),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Đến ngày',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    readOnly: true,
                    onTap: () => _selectDate(context, false),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(onPressed: () {}, child: const Text('Lọc')),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Paid Fees List
          ..._getPaidFees().map((fee) => _buildPaidFeeCard(fee)),
        ],
      ),
    );
  }

  Widget _buildInvoicesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Invoice Actions
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _downloadAllInvoices,
                  icon: const Icon(Icons.download),
                  label: const Text('Tải tất cả hóa đơn'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _requestInvoice,
                  icon: const Icon(Icons.request_page),
                  label: const Text('Yêu cầu hóa đơn'),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Invoices List
          ..._getInvoices().map((invoice) => _buildInvoiceCard(invoice)),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(
    String title,
    String amount,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
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
              Icon(icon, color: color, size: 24),
              const Spacer(),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(title, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          const SizedBox(height: 4),
          Text(
            amount,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w600, color: color),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentFeeCard(Map<String, dynamic> fee) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color:
                  fee['isPaid']
                      ? Colors.green.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              fee['isPaid'] ? Icons.check_circle : Icons.payment,
              color: fee['isPaid'] ? Colors.green : Colors.red,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fee['title'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  fee['dueDate'],
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                fee['amount'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: fee['isPaid'] ? Colors.green : Colors.red,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                fee['isPaid'] ? 'Đã thanh toán' : 'Chưa thanh toán',
                style: TextStyle(
                  fontSize: 12,
                  color: fee['isPaid'] ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildPaymentMethodTile(
            'Ví điện tử MoMo',
            Icons.account_balance_wallet,
            true,
          ),
          const Divider(),
          _buildPaymentMethodTile('Thẻ ngân hàng', Icons.credit_card, true),
          const Divider(),
          _buildPaymentMethodTile(
            'Chuyển khoản ngân hàng',
            Icons.account_balance,
            false,
          ),
          const Divider(),
          _buildPaymentMethodTile('Thanh toán tại trường', Icons.school, false),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodTile(String method, IconData icon, bool isActive) {
    return ListTile(
      leading: Icon(icon, color: isActive ? Colors.blue : Colors.grey),
      title: Text(method),
      trailing:
          isActive
              ? const Icon(Icons.check_circle, color: Colors.green)
              : const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: isActive ? null : () => _activatePaymentMethod(method),
    );
  }

  Widget _buildUnpaidFeeCard(Map<String, dynamic> fee) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color:
              fee['isOverdue']
                  ? Colors.red.withOpacity(0.3)
                  : Colors.grey.withOpacity(0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
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
                  fee['title'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              if (fee['isOverdue'])
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Quá hạn',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.schedule, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                'Hạn: ${fee['dueDate']}',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
              const Spacer(),
              Text(
                fee['amount'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          if (fee['description'] != null) ...[
            const SizedBox(height: 8),
            Text(
              fee['description'],
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
          ],
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _showFeeDetails(fee),
                  child: const Text('Chi tiết'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _payFee(fee),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Thanh toán'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaidFeeCard(Map<String, dynamic> fee) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
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
                  fee['title'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Đã thanh toán',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.check_circle, size: 16, color: Colors.green),
              const SizedBox(width: 4),
              Text(
                'Thanh toán: ${fee['paidDate']}',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
              const Spacer(),
              Text(
                fee['amount'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                'Phương thức: ${fee['paymentMethod']}',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => _downloadReceipt(fee),
                child: const Text('Tải biên lai'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceCard(Map<String, dynamic> invoice) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
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
              Icon(Icons.receipt, color: Colors.blue),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  invoice['title'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Text(
                invoice['amount'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Số hóa đơn: ${invoice['invoiceNumber']}',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
          Text(
            'Ngày: ${invoice['date']}',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _viewInvoice(invoice),
                  icon: const Icon(Icons.visibility, size: 18),
                  label: const Text('Xem'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _downloadInvoice(invoice),
                  icon: const Icon(Icons.download, size: 18),
                  label: const Text('Tải xuống'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Data methods
  List<Map<String, dynamic>> _getRecentFees() {
    return [
      {
        'title': 'Học phí tháng 6/2025',
        'dueDate': 'Hạn: 15/06/2025',
        'amount': '1.500.000 ₫',
        'isPaid': false,
      },
      {
        'title': 'Gia sư Toán - Tháng 6',
        'dueDate': 'Hạn: 10/06/2025',
        'amount': '800.000 ₫',
        'isPaid': true,
      },
      {
        'title': 'Học phí tháng 5/2025',
        'dueDate': 'Đã thanh toán: 12/05/2025',
        'amount': '1.500.000 ₫',
        'isPaid': true,
      },
    ];
  }

  List<Map<String, dynamic>> _getUnpaidFees() {
    return [
      {
        'title': 'Học phí tháng 6/2025',
        'dueDate': '15/06/2025',
        'amount': '1.500.000 ₫',
        'isOverdue': false,
        'description': 'Học phí trường THPT ABC - Lớp 12A1',
      },
      {
        'title': 'Gia sư Vật lý - Tháng 6',
        'dueDate': '10/06/2025',
        'amount': '600.000 ₫',
        'isOverdue': false,
        'description': 'Lớp gia sư Vật lý 12 - Thầy Nguyễn Văn A',
      },
      {
        'title': 'Phí hoạt động ngoại khóa',
        'dueDate': '01/06/2025',
        'amount': '200.000 ₫',
        'isOverdue': true,
        'description': 'Tham gia câu lạc bộ Khoa học',
      },
    ];
  }

  List<Map<String, dynamic>> _getPaidFees() {
    return [
      {
        'title': 'Gia sư Toán - Tháng 6',
        'paidDate': '28/05/2025',
        'amount': '800.000 ₫',
        'paymentMethod': 'MoMo',
      },
      {
        'title': 'Học phí tháng 5/2025',
        'paidDate': '12/05/2025',
        'amount': '1.500.000 ₫',
        'paymentMethod': 'Chuyển khoản',
      },
      {
        'title': 'Gia sư Hóa - Tháng 5',
        'paidDate': '10/05/2025',
        'amount': '700.000 ₫',
        'paymentMethod': 'Thẻ ngân hàng',
      },
    ];
  }

  List<Map<String, dynamic>> _getInvoices() {
    return [
      {
        'title': 'Hóa đơn học phí tháng 5/2025',
        'invoiceNumber': 'HD202505001',
        'date': '15/05/2025',
        'amount': '1.500.000 ₫',
      },
      {
        'title': 'Hóa đơn gia sư tháng 5/2025',
        'invoiceNumber': 'GS202505001',
        'date': '10/05/2025',
        'amount': '1.500.000 ₫',
      },
    ];
  }

  // Action methods
  void _showNotifications() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Thông báo'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.warning, color: Colors.orange),
                  title: const Text('Học phí sắp đến hạn'),
                  subtitle: const Text('Học phí tháng 6 sẽ đến hạn vào 15/06'),
                ),
                ListTile(
                  leading: const Icon(Icons.check_circle, color: Colors.green),
                  title: const Text('Thanh toán thành công'),
                  subtitle: const Text(
                    'Gia sư Toán tháng 6 đã được thanh toán',
                  ),
                ),
              ],
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

  void _showPaymentHistory() {
    _tabController.animateTo(2);
  }

  void _showHelp() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Hướng dẫn thanh toán'),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('1. Chọn khoản phí cần thanh toán'),
                Text('2. Chọn phương thức thanh toán'),
                Text('3. Xác nhận thông tin và thanh toán'),
                Text('4. Lưu biên lai để đối chiếu'),
                SizedBox(height: 16),
                Text(
                  'Liên hệ hỗ trợ: 0123.456.789',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
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

  void _showSettings() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Cài đặt'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SwitchListTile(
                  title: const Text('Nhắc nhở thanh toán'),
                  subtitle: const Text('Thông báo trước 3 ngày'),
                  value: true,
                  onChanged: (value) {},
                ),
                SwitchListTile(
                  title: const Text('Email biên lai'),
                  subtitle: const Text('Gửi biên lai qua email'),
                  value: false,
                  onChanged: (value) {},
                ),
                ListTile(
                  title: const Text('Phương thức thanh toán mặc định'),
                  subtitle: const Text('MoMo'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {},
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Đóng'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Lưu'),
              ),
            ],
          ),
    );
  }

  void _showQuickPayment() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder:
          (context) => Container(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Thanh toán nhanh',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                ..._getUnpaidFees()
                    .take(3)
                    .map(
                      (fee) => CheckboxListTile(
                        title: Text(fee['title']),
                        subtitle: Text(fee['amount']),
                        value: false,
                        onChanged: (value) {},
                      ),
                    ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Hủy'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _processPayment();
                        },
                        child: const Text('Thanh toán'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }

  void _showBulkPayment() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Thanh toán hàng loạt'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Chọn các khoản phí muốn thanh toán:'),
                const SizedBox(height: 16),
                ..._getUnpaidFees().map(
                  (fee) => CheckboxListTile(
                    title: Text(fee['title']),
                    subtitle: Text(fee['amount']),
                    value: false,
                    onChanged: (value) {},
                  ),
                ),
                const SizedBox(height: 16),
                const Row(
                  children: [
                    Text('Tổng cộng: '),
                    Spacer(),
                    Text(
                      '2.300.000 ₫',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
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
                  _processPayment();
                },
                child: const Text('Thanh toán'),
              ),
            ],
          ),
    );
  }

  void _selectDate(BuildContext context, bool isFromDate) async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
    );
  }

  void _downloadAllInvoices() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đang tải tất cả hóa đơn...'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _requestInvoice() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Yêu cầu hóa đơn'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Chọn khoản phí',
                    border: OutlineInputBorder(),
                  ),
                  items:
                      _getPaidFees()
                          .map(
                            (fee) => DropdownMenuItem<String>(
                              value: fee['title'],
                              child: Text(fee['title']),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {},
                ),
                const SizedBox(height: 16),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Ghi chú (tùy chọn)',
                    border: OutlineInputBorder(),
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
                      content: Text('Đã gửi yêu cầu hóa đơn'),
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

  void _activatePaymentMethod(String method) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đang kích hoạt $method...'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _showFeeDetails(Map<String, dynamic> fee) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(fee['title']),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow('Số tiền:', fee['amount']),
                _buildDetailRow('Hạn thanh toán:', fee['dueDate']),
                if (fee['description'] != null)
                  _buildDetailRow('Mô tả:', fee['description']),
                _buildDetailRow(
                  'Trạng thái:',
                  fee['isOverdue'] ? 'Quá hạn' : 'Chưa thanh toán',
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Đóng'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _payFee(fee);
                },
                child: const Text('Thanh toán'),
              ),
            ],
          ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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

  void _payFee(Map<String, dynamic> fee) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder:
          (context) => Container(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Thanh toán ${fee['title']}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Text('Số tiền: ', style: TextStyle(fontSize: 16)),
                      const Spacer(),
                      Text(
                        fee['amount'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Chọn phương thức thanh toán:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                _buildPaymentOption('MoMo', Icons.account_balance_wallet, true),
                _buildPaymentOption('Thẻ ngân hàng', Icons.credit_card, false),
                _buildPaymentOption(
                  'Chuyển khoản',
                  Icons.account_balance,
                  false,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Hủy'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _processPayment();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Xác nhận thanh toán'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildPaymentOption(String method, IconData icon, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.grey[300]!,
          width: isSelected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(icon, color: isSelected ? Colors.blue : Colors.grey),
        title: Text(method),
        trailing:
            isSelected
                ? const Icon(Icons.check_circle, color: Colors.blue)
                : null,
        onTap: () {},
      ),
    );
  }

  void _processPayment() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => const AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Đang xử lý thanh toán...'),
              ],
            ),
          ),
    );

    // Simulate payment processing
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pop(context); // Close loading dialog
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: const Text('Thành công!'),
              content: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 64),
                  SizedBox(height: 16),
                  Text('Thanh toán thành công!'),
                  Text('Biên lai đã được gửi về email của bạn.'),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Đóng'),
                ),
              ],
            ),
      );
    });
  }

  void _downloadReceipt(Map<String, dynamic> fee) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đang tải biên lai ${fee['title']}...'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _viewInvoice(Map<String, dynamic> invoice) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đang mở ${invoice['title']}...'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _downloadInvoice(Map<String, dynamic> invoice) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đang tải ${invoice['title']}...'),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
