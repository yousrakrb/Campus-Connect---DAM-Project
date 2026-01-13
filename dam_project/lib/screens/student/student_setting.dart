import 'package:flutter/material.dart';

class StudentSettingsScreen extends StatefulWidget {
  const StudentSettingsScreen({Key? key}) : super(key: key);

  @override
  _StudentSettingsScreenState createState() => _StudentSettingsScreenState();
}

class _StudentSettingsScreenState extends State<StudentSettingsScreen> {
  final Color primaryColor = Color(0xFF4361EE);
  final Color backgroundColor = Color(0xFFF5F7FB);
  
  // Settings states
  bool notificationsEnabled = true;
  bool emailNotifications = true;
  bool pushNotifications = true;
  bool darkMode = false;
  bool biometricLogin = false;
  String language = 'English';
  bool autoSync = true;
  
  List<String> languages = ['English', 'Spanish', 'French', 'German', 'Chinese'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Section
            _buildSectionHeader('Account Settings'),
            _buildProfileCard(),
            
            // Notifications
            _buildSectionHeader('Notifications'),
            _buildNotificationSettings(),
            
            // App Preferences
            _buildSectionHeader('App Preferences'),
            _buildAppPreferences(),
            
            // Privacy & Security
            _buildSectionHeader('Privacy & Security'),
            _buildPrivacySettings(),
            
            // Support
            _buildSectionHeader('Support'),
            _buildSupportOptions(),
            
            // Danger Zone
            _buildSectionHeader('Danger Zone'),
            _buildDangerZone(),
            
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey[600],
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: primaryColor.withOpacity(0.1),
              child: Icon(
                Icons.person,
                size: 32,
                color: primaryColor,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Yousra',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'yousra@university.dz',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Student ID: 12345678',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.edit_outlined),
              onPressed: () {
                // Navigate to edit profile
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationSettings() {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          _buildSettingSwitch(
            'Enable Notifications',
            'Receive app notifications',
            notificationsEnabled,
            (value) => setState(() => notificationsEnabled = value),
          ),
          if (notificationsEnabled) ...[
            Divider(height: 1),
            _buildSettingSwitch(
              'Email Notifications',
              'Receive notifications via email',
              emailNotifications,
              (value) => setState(() => emailNotifications = value),
            ),
            Divider(height: 1),
            _buildSettingSwitch(
              'Push Notifications',
              'Receive push notifications on device',
              pushNotifications,
              (value) => setState(() => pushNotifications = value),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAppPreferences() {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          _buildSettingSwitch(
            'Dark Mode',
            'Use dark theme throughout the app',
            darkMode,
            (value) => setState(() => darkMode = value),
          ),
          Divider(height: 1),
          _buildSettingDropdown(
            'Language',
            'Select app language',
            language,
            languages,
            (value) => setState(() => language = value!),
          ),
          Divider(height: 1),
          _buildSettingSwitch(
            'Auto-sync Data',
            'Automatically sync data when online',
            autoSync,
            (value) => setState(() => autoSync = value),
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacySettings() {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          _buildSettingSwitch(
            'Biometric Login',
            'Use fingerprint or face recognition',
            biometricLogin,
            (value) => setState(() => biometricLogin = value),
          ),
          Divider(height: 1),
          _buildSettingButton(
            'Change Password',
            Icons.lock_outline,
            _showChangePasswordDialog,
          ),
          Divider(height: 1),
          _buildSettingButton(
            'Privacy Policy',
            Icons.privacy_tip_outlined,
            _openPrivacyPolicy,
          ),
          Divider(height: 1),
          _buildSettingButton(
            'Terms of Service',
            Icons.description_outlined,
            _openTermsOfService,
          ),
        ],
      ),
    );
  }

  Widget _buildSupportOptions() {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          _buildSettingButton(
            'Help Center',
            Icons.help_outline,
            _openHelpCenter,
          ),
          Divider(height: 1),
          _buildSettingButton(
            'Contact Support',
            Icons.support_agent_outlined,
            _contactSupport,
          ),
          Divider(height: 1),
          _buildSettingButton(
            'Report a Problem',
            Icons.bug_report_outlined,
            _reportProblem,
          ),
          Divider(height: 1),
          _buildSettingButton(
            'App Version',
            Icons.info_outline,
            _showAppInfo,
            trailing: Text('v1.2.3'),
          ),
        ],
      ),
    );
  }

  Widget _buildDangerZone() {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.red.withOpacity(0.05),
      child: Column(
        children: [
          _buildSettingButton(
            'Clear Cache',
            Icons.delete_outline,
            _clearCache,
            color: Colors.orange,
          ),
          Divider(height: 1),
          _buildSettingButton(
            'Delete Account',
            Icons.delete_forever_outlined,
            _deleteAccount,
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingSwitch(String title, String subtitle, bool value, Function(bool) onChanged) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(Icons.notifications_outlined, size: 20, color: primaryColor),
      ),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: primaryColor,
      ),
    );
  }

  Widget _buildSettingDropdown(String title, String subtitle, String value, List<String> items, Function(String?) onChanged) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(Icons.language_outlined, size: 20, color: primaryColor),
      ),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      trailing: DropdownButton<String>(
        value: value,
        onChanged: onChanged,
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSettingButton(String title, IconData icon, VoidCallback onTap, {Widget? trailing, Color? color}) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: (color ?? primaryColor).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 20, color: color ?? primaryColor),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: color ?? Colors.black,
        ),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Change Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Current Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'New Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Confirm New Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Password changed successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text('Change Password'),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  void _openPrivacyPolicy() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Privacy Policy'),
        content: SingleChildScrollView(
          child: Text(
            'Your privacy is important to us. This privacy policy explains what personal data we collect from you and how we use it.\n\n'
            '1. Information We Collect:\n'
            '   - Account information\n'
            '   - Usage data\n'
            '   - Device information\n\n'
            '2. How We Use Your Information:\n'
            '   - To provide services\n'
            '   - To improve our app\n'
            '   - To communicate with you\n\n'
            '3. Data Security:\n'
            '   We implement appropriate security measures to protect your data.\n\n'
            'For more details, please visit our website.',
            style: TextStyle(height: 1.5),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _openTermsOfService() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Terms of Service'),
        content: SingleChildScrollView(
          child: Text(
            'By using this application, you agree to the following terms:\n\n'
            '1. Acceptable Use:\n'
            '   You agree to use this app for educational purposes only.\n\n'
            '2. Account Responsibility:\n'
            '   You are responsible for maintaining the confidentiality of your account.\n\n'
            '3. Prohibited Activities:\n'
            '   - Violating any laws\n'
            '   - Harassing other users\n'
            '   - Uploading malicious content\n\n'
            '4. Termination:\n'
            '   We reserve the right to terminate accounts that violate these terms.\n\n'
            'These terms may be updated periodically.',
            style: TextStyle(height: 1.5),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _openHelpCenter() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Help Center'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Need help? Here are some resources:\n',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              ListTile(
                leading: Icon(Icons.book_outlined),
                title: Text('User Guide'),
                subtitle: Text('Complete app documentation'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Opening user guide...'),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.video_library_outlined),
                title: Text('Video Tutorials'),
                subtitle: Text('Step-by-step video guides'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Opening video tutorials...'),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.question_answer_outlined),
                title: Text('FAQs'),
                subtitle: Text('Frequently asked questions'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Opening FAQs...'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _contactSupport() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Contact Support'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select a contact method:'),
            SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.email_outlined, color: primaryColor),
              title: Text('Email Support'),
              subtitle: Text('support@university.edu'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Opening email app...'),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.phone_outlined, color: primaryColor),
              title: Text('Phone Support'),
              subtitle: Text('+1 (555) 123-4567'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Opening phone app...'),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.chat_outlined, color: primaryColor),
              title: Text('Live Chat'),
              subtitle: Text('Available 9AM-5PM Mon-Fri'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Opening live chat...'),
                  ),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _reportProblem() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Report a Problem'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Subject',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
                hintText: 'Describe the problem in detail...',
              ),
              maxLines: 4,
            ),
            SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email (optional)',
                border: OutlineInputBorder(),
                hintText: 'For follow-up',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Problem report submitted successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text('Submit Report'),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  void _showAppInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('App Information'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('Version'),
              subtitle: Text('1.2.3 (Build 456)'),
            ),
            ListTile(
              leading: Icon(Icons.update_outlined),
              title: Text('Last Updated'),
              subtitle: Text('March 15, 2024'),
            ),
            ListTile(
              leading: Icon(Icons.developer_mode_outlined),
              title: Text('Developer'),
              subtitle: Text('University IT Department'),
            ),
            ListTile(
              leading: Icon(Icons.copyright_outlined),
              title: Text('Copyright'),
              subtitle: Text('© 2024 University Name'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _clearCache() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Clear Cache'),
        content: Text('This will remove temporary files and free up storage space. Your personal data will not be affected.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Cache cleared successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text('Clear Cache'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }

  void _deleteAccount() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Account'),
        content: Text('This action cannot be undone. All your data will be permanently deleted. Are you sure you want to proceed?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Account deletion requested. Admin will process within 48 hours.'),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 5),
                ),
              );
            },
            child: Text('Delete Account'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}