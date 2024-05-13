import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_order_app/screen/widgets/navigation.dart';

class Profile extends StatelessWidget {
  final String email;

  const Profile(this.email);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'CANTEEN HUB PROFILE',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      drawer: Navigation(email),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .where('userEmail', isEqualTo: email)
            .limit(1)
            .get()
            .then((querySnapshot) => querySnapshot.docs.first),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No data found'));
          }

          final userData = snapshot.data!.data() as Map<String, dynamic>;
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                                'https://media.istockphoto.com/id/1130884625/vector/user-member-vector-icon-for-ui-user-interface-or-profile-face-avatar-app-in-circle-design.jpg?s=612x612&w=0&k=20&c=1ky-gNHiS2iyLsUPQkxAtPBWH1BZt0PKBB1WBtxQJRE='),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ListTile(
                        title: const Text('Username'),
                        subtitle: Text(userData['username']),
                      ),
                      const Divider(),
                      ListTile(
                        title: const Text('User Email'),
                        subtitle: Text(userData['userEmail']),
                      ),
                      const Divider(),
                      _buildEditableListTile(
                        context,
                        'Registration ID',
                        userData['regId'],
                        'regId',
                        userData,
                      ),
                      const Divider(),
                      ListTile(
                        title: const Text('Created At'),
                        subtitle: Text(
                          '${DateTime.fromMillisecondsSinceEpoch(userData['createdAt'].millisecondsSinceEpoch)}',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEditableListTile(BuildContext context, String title,
      String value, String field, Map<String, dynamic> userData) {
    return ListTile(
      title: Text(title),
      subtitle: Row(
        children: [
          Expanded(child: Text(value)),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              _editField(context, field, userData);
            },
          ),
        ],
      ),
    );
  }

  void _editField(
      BuildContext context, String field, Map<String, dynamic> userData) {
    String value = userData[field];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit $field'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: TextEditingController(text: value),
                onChanged: (newValue) {
                  value = newValue;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Color(0xFFFAB317),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              FirebaseFirestore.instance
                  .collection('users')
                  .where('userEmail', isEqualTo: email)
                  .limit(1)
                  .get()
                  .then((querySnapshot) {
                if (querySnapshot.docs.isNotEmpty) {
                  String docId = querySnapshot.docs.first.id;
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(docId)
                      .update({field: value});
                }
              });

              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(primary: const Color(0xFFFAB317)),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
