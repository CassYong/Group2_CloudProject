import 'package:flutter/material.dart';

class DeviceInfo {
  final String userId;
  final String deviceId;
  final String deviceType;
  final String lastLogin;
  final String status;

  DeviceInfo({
    required this.userId,
    required this.deviceId,
    required this.deviceType,
    required this.lastLogin,
    required this.status,
  });
}

class HomePage extends StatefulWidget {
  final String userRole;
  final String userEmail;

  const HomePage({
    super.key,
    required this.userRole,
    required this.userEmail,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Static device tracking data for first admin
  final List<DeviceInfo> deviceList = [];

  // Static device tracking data for second admin
  final List<DeviceInfo> deviceList2 = [
    DeviceInfo(
      userId: 'user1@gmail.com',
      deviceId: 'DEV-001',
      deviceType: 'iPhone 13',
      lastLogin: '2024-03-20 14:30',
      status: 'Active',
    ),
  ];

  // Static device tracking data for third admin
  final List<DeviceInfo> deviceList3 = [
    DeviceInfo(
      userId: 'user1@gmail.com',
      deviceId: 'DEV-001',
      deviceType: 'iPhone 13',
      lastLogin: '2024-03-20 14:30',
      status: 'Active',
    ),
    DeviceInfo(
      userId: 'user2@gmail.com',
      deviceId: 'DEV-001',
      deviceType: 'iPhone 13',
      lastLogin: '2024-03-20 14:30',
      status: 'Active',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userRole == 'Admin' ||
                widget.userRole == 'Admin2' ||
                widget.userRole == 'Admin3'
            ? 'Admin Page'
            : '${widget.userRole} Page'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: _buildView(),
    );
  }

  Widget _buildView() {
    if (widget.userRole == 'Admin' ||
        widget.userRole == 'Admin2' ||
        widget.userRole == 'Admin3') {
      List<DeviceInfo> devices;
      if (widget.userRole == 'Admin') {
        devices = deviceList;
      } else if (widget.userRole == 'Admin2') {
        devices = deviceList2;
      } else {
        devices = deviceList3;
      }
      return _buildAdminView(devices);
    } else {
      return _buildUserView();
    }
  }

  Widget _buildAdminView(List<DeviceInfo> devices) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Admin Page',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text('Logout'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                child: DataTable(
                  headingRowColor:
                      MaterialStateProperty.all(Colors.blue.shade100),
                  columns: const [
                    DataColumn(label: Text('User ID')),
                    DataColumn(label: Text('Device ID')),
                  ],
                  rows: devices.map((device) {
                    return DataRow(
                      cells: [
                        DataCell(Text(device.userId)),
                        DataCell(Text(device.deviceId)),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome ${widget.userEmail}!',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'You are logged in as ${widget.userRole}',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
