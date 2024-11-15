import 'package:flutter/material.dart';


class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildSectionTitle("Preferences"),
          _buildThemeOption(),
          _buildLanguageOption(),
          SizedBox(height: 20),
          _buildSectionTitle("Notifications"),
          _buildNotificationOption("Receive Notifications", true),
          _buildNotificationOption("Email Alerts", false),
          _buildNotificationOption("Push Notifications", true),
          SizedBox(height: 20),
          _buildSectionTitle("Support"),
          _buildSupportOption("Help Center"),
          _buildSupportOption("Feedback"),
          _buildSupportOption("Contact Us"),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.teal,
        ),
      ),
    );
  }

  Widget _buildThemeOption() {
    return ListTile(
      leading: Icon(Icons.color_lens, color: Colors.teal),
      title: Text("Theme"),
      subtitle: Text("Light / Dark"),
      trailing: DropdownButton<String>(
        value: "Light",
        items: ["Light", "Dark"].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          // Handle theme change
        },
      ),
    );
  }

  Widget _buildLanguageOption() {
    return ListTile(
      leading: Icon(Icons.language, color: Colors.teal),
      title: Text("Language"),
      subtitle: Text("Select your preferred language"),
      trailing: DropdownButton<String>(
        value: "English",
        items: ["English", "Vietnamese", "Spanish"].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          // Handle language change
        },
      ),
    );
  }

  Widget _buildNotificationOption(String title, bool value) {
    return SwitchListTile(
      activeColor: Colors.teal,
      title: Text(title),
      value: value,
      onChanged: (bool newValue) {
        // Handle notification preference change
      },
    );
  }

  Widget _buildSupportOption(String title) {
    return ListTile(
      leading: Icon(Icons.help_outline, color: Colors.teal),
      title: Text(title),
      onTap: () {
        // Navigate to support section
      },
    );
  }
}
