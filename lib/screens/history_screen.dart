import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> mockData = [
      {
        'date': '2025-05-01',
        'checkIn': '09:00 AM',
        'checkOut': '05:00 PM',
        'location': 'Presidency University',
      },
      {
        'date': '2025-04-30',
        'checkIn': '09:10 AM',
        'checkOut': '04:55 PM',
        'location': 'Presidency University',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Check-In/Out History')),
      body: ListView.builder(
        itemCount: mockData.length,
        itemBuilder: (context, index) {
          final entry = mockData[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text('Date: ${entry['date']}'),
              subtitle: Text(
                'Check-In: ${entry['checkIn']}\nCheck-Out: ${entry['checkOut']}\nLocation: ${entry['location']}',
              ),
            ),
          );
        },
      ),
    );
  }
}
