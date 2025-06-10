import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class ThemeSettingsScreen extends StatelessWidget {
  const ThemeSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Giao diện'),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode 
                ? Icons.light_mode 
                : Icons.dark_mode,
            ),
            onPressed: () => themeProvider.toggleTheme(),
            tooltip: 'Chuyển đổi nhanh',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Theme Mode Selection
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.palette,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Chọn giao diện',
                        style: theme.textTheme.headlineSmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildThemeOption(
                    context,
                    'Giao diện sáng',
                    'Luôn sử dụng giao diện sáng',
                    Icons.light_mode,
                    ThemeMode.light,
                    themeProvider,
                  ),
                  const SizedBox(height: 8),
                  _buildThemeOption(
                    context,
                    'Giao diện tối',
                    'Luôn sử dụng giao diện tối',
                    Icons.dark_mode,
                    ThemeMode.dark,
                    themeProvider,
                  ),
                  const SizedBox(height: 8),
                  _buildThemeOption(
                    context,
                    'Theo hệ thống',
                    'Tự động theo cài đặt thiết bị',
                    Icons.settings_system_daydream,
                    ThemeMode.system,
                    themeProvider,
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Theme Preview
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.preview,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Xem trước giao diện',
                        style: theme.textTheme.headlineSmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildThemePreview(context),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Current Theme Info
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Thông tin giao diện',
                        style: theme.textTheme.headlineSmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow('Chế độ hiện tại', themeProvider.themeModeString),
                  const SizedBox(height: 8),
                  _buildInfoRow(
                    'Độ sáng', 
                    themeProvider.isDarkMode ? 'Tối' : 'Sáng',
                  ),
                  const SizedBox(height: 8),
                  _buildInfoRow(
                    'Màu chủ đạo', 
                    '#${theme.colorScheme.primary.value.toRadixString(16).substring(2).toUpperCase()}',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    ThemeMode themeMode,
    ThemeProvider themeProvider,
  ) {
    final isSelected = themeProvider.themeMode == themeMode;
    final theme = Theme.of(context);
    
    return Card(
      elevation: isSelected ? 4 : 1,
      color: isSelected 
        ? theme.colorScheme.primaryContainer 
        : theme.colorScheme.surface,
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected 
            ? theme.colorScheme.primary 
            : theme.colorScheme.onSurface,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected 
              ? theme.colorScheme.onPrimaryContainer 
              : theme.colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: isSelected 
              ? theme.colorScheme.onPrimaryContainer 
              : theme.colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        trailing: isSelected 
          ? Icon(
              Icons.check_circle,
              color: theme.colorScheme.primary,
            ) 
          : null,
        onTap: () => themeProvider.setThemeMode(themeMode),
      ),
    );
  }

  Widget _buildThemePreview(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.5),
        ),
      ),
      child: Column(
        children: [
          // Preview AppBar
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Thanh điều hướng',
              style: TextStyle(
                color: theme.colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Preview Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Thẻ mẫu',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Đây là cách hiển thị thẻ trong giao diện hiện tại.',
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Chính'),
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        child: const Text('Phụ'),
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
  Widget _buildInfoRow(String label, String value) {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
    );
  }
}
