import 'package:flutter/material.dart';

void main() {
  runApp(const CampusDirectoryApp());
}

class CampusDirectoryApp extends StatelessWidget {
  const CampusDirectoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Campus Directory',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const DirectoryHome(),
    );
  }
}

// Sample Data updated with CSM & CSD departments
final Map<String, List<Map<String, String>>> facultyData = {
  'CSM': [
    {
      'name': 'Dr. Kavitha Soppari',
      'designation': 'HOD & Professor',
      'email': 'kavitha.csm@college.edu',
      'phone': '9876599901',
    },
    {
      'name': 'Mr. Ajay',
      'designation': 'Professor',
      'email': 'ajay.csm@college.edu',
      'phone': '9876599902',
    },
    {
      'name': 'Ms. Monika',
      'designation': 'Assistant Professor',
      'email': 'monika.csm@college.edu',
      'phone': '9876599903',
    },
  ],
  'CSE': [
    {
      'name': 'Dr. Ramesh Kumar',
      'designation': 'Professor',
      'email': 'ramesh@college.edu',
      'phone': '9876543210',
    },
    {
      'name': 'Ms. Anjali',
      'designation': 'Assistant Professor',
      'email': 'anjali@college.edu',
      'phone': '9876501234',
    },
  ],
  'CSD': [
    {
      'name': 'Dr. Vikram',
      'designation': 'Professor & Head',
      'email': 'vikram.csd@college.edu',
      'phone': '9876588801',
    },
    {
      'name': 'Ms. Sneha',
      'designation': 'Assistant Professor',
      'email': 'sneha.csd@college.edu',
      'phone': '9876588802',
    },
  ],
  'ECE': [
    {
      'name': 'Dr. Suresh',
      'designation': 'Professor',
      'email': 'suresh@college.edu',
      'phone': '9876512345',
    },
    {
      'name': 'Ms. Kavya',
      'designation': 'Assistant Professor',
      'email': 'kavya@college.edu',
      'phone': '9876523456',
    },
  ],
  'EEE': [
    {
      'name': 'Mr. Rajesh',
      'designation': 'Associate Professor',
      'email': 'rajesh@college.edu',
      'phone': '9876534567',
    },
  ],
  'Civil': [
    {
      'name': 'Dr. Priya',
      'designation': 'Professor',
      'email': 'priya@college.edu',
      'phone': '9876545678',
    },
  ],
};

// SCREEN 1 - Directory Home
class DirectoryHome extends StatelessWidget {
  const DirectoryHome({super.key});

  @override
  Widget build(BuildContext context) {
    final departments = facultyData.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Directory',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 2,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            color:
                Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
            child: Row(
              children: const [
                Icon(Icons.info_outline, color: Colors.indigo),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Select a department below to view faculty members and contact details.',
                    style: TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: departments.length,
              itemBuilder: (context, index) {
                final department = departments[index];
                final count = facultyData[department]?.length ?? 0;

                return Card(
                  elevation: 2,
                  margin:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: CircleAvatar(
                      backgroundColor: Colors.indigo.shade100,
                      child: const Icon(Icons.school, color: Colors.indigo),
                    ),
                    title: Text(
                      department,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Text('$count Faculty Member(s) available'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FacultyList(department: department),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// SCREEN 2 - Faculty List with Search
class FacultyList extends StatefulWidget {
  final String department;

  const FacultyList({super.key, required this.department});

  @override
  State<FacultyList> createState() => _FacultyListState();
}

class _FacultyListState extends State<FacultyList> {
  String search = '';

  @override
  Widget build(BuildContext context) {
    final faculty = facultyData[widget.department]!.where((member) {
      return member['name']!.toLowerCase().contains(search.toLowerCase()) ||
          member['designation']!.toLowerCase().contains(search.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.department} Faculty'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search by name or designation...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                setState(() {
                  search = value;
                });
              },
            ),
          ),
          Expanded(
            child: faculty.isEmpty
                ? const Center(
                    child: Text('No faculty members found.',
                        style: TextStyle(color: Colors.grey)),
                  )
                : ListView.builder(
                    itemCount: faculty.length,
                    itemBuilder: (context, index) {
                      final member = faculty[index];

                      return Card(
                        elevation: 1,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Colors.indigo,
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                          title: Text(
                            member['name']!,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(member['designation']!),
                          trailing:
                              const Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FacultyDetails(
                                  department: widget.department,
                                  faculty: member,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// SCREEN 3 - Faculty Details with Interactive Actions
class FacultyDetails extends StatelessWidget {
  final String department;
  final Map<String, String> faculty;

  const FacultyDetails({
    super.key,
    required this.department,
    required this.faculty,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Faculty Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.indigo,
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  faculty['name']!,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
                Chip(
                  label: Text(faculty['designation']!),
                  backgroundColor: Colors.indigo.shade50,
                  labelStyle: TextStyle(
                      color: Colors.indigo.shade800,
                      fontWeight: FontWeight.bold),
                ),
                const Divider(height: 30, thickness: 1),
                ListTile(
                  leading: const Icon(Icons.school, color: Colors.indigo),
                  title: const Text('Department'),
                  subtitle: Text(department,
                      style: const TextStyle(fontWeight: FontWeight.w500)),
                ),
                ListTile(
                  leading: const Icon(Icons.email, color: Colors.indigo),
                  title: const Text('Email'),
                  subtitle: Text(faculty['email']!,
                      style: const TextStyle(fontWeight: FontWeight.w500)),
                  trailing: IconButton(
                    icon: const Icon(Icons.copy, size: 20),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                'Copied ${faculty['email']} to clipboard')),
                      );
                    },
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.phone, color: Colors.indigo),
                  title: const Text('Phone'),
                  subtitle: Text(faculty['phone']!,
                      style: const TextStyle(fontWeight: FontWeight.w500)),
                  trailing: IconButton(
                    icon: const Icon(Icons.call, color: Colors.green),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Calling ${faculty['phone']}...')),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
