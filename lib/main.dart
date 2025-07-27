import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reminder App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red),
      home: const ReminderHome(),
    );
  }
}

class ReminderHome extends StatefulWidget {
  const ReminderHome({super.key});

  @override
  State<ReminderHome> createState() => _ReminderHomeState();
}

class _ReminderHomeState extends State<ReminderHome> {
  final List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  final List<String> activities = [
    'Wake up',
    'Go to gym',
    'Breakfast',
    'Meetings',
    'Lunch',
    'Quick nap',
    'Go to library',
    'Dinner',
    'Go to sleep',
  ];

  String selectedDay = 'Monday';
  String selectedActivity = 'Wake up';
  TimeOfDay? selectedTime;

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Your Day'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: selectedDay,
              onChanged: (String? newValue) {
                setState(() {
                  selectedDay = newValue!;
                });
              },
              items: days.map((String day) {
                return DropdownMenuItem<String>(
                  value: day,
                  child: Text(day),
                );
              }).toList(),
              isExpanded: true,
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedActivity,
              onChanged: (String? newValue) {
                setState(() {
                  selectedActivity = newValue!;
                });
              },
              items: activities.map((String activity) {
                return DropdownMenuItem<String>(
                  value: activity,
                  child: Text(activity),
                );
              }).toList(),
              isExpanded: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (!context.mounted) {
                  return;
                }

                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (!context.mounted) {
                  return;
                }

                if (picked != null) {

                  setState(() {
                    selectedTime = picked;
                  });


                  final formattedTime = picked.format(context);
                  final snackBar = SnackBar(
                    content: Text(
                      'Timer set for $selectedDay - $selectedActivity at $formattedTime',
                    ),
                    duration: const Duration(seconds: 3),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: const Text("Set Timer"),
            ),


            const SizedBox(height: 20),
Text(
  selectedTime != null
      ? "Timer set for $selectedDay\nActivity $selectedActivity at ${selectedTime!.format(context)}"
      : "No time selected yet",
  style: const TextStyle(fontSize: 20),
  textAlign: TextAlign.center,
),

          ],
        ),
      ),
    );
  }
}
