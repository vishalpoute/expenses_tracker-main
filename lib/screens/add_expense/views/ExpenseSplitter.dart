import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ExpenseSplitterApp());
}

class ExpenseSplitterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Splitter',
      home: ExpenseSplitterHome(),
    );
  }
}

class ExpenseSplitterHome extends StatefulWidget {
  @override
  _ExpenseSplitterHomeState createState() => _ExpenseSplitterHomeState();
}

class _ExpenseSplitterHomeState extends State<ExpenseSplitterHome> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController _expenseController = TextEditingController();
  List<Map<String, TextEditingController>> _peopleControllers = [];

  void addPersonRow() {
    setState(() {
      _peopleControllers.add({
        'name': TextEditingController(),
        'email': TextEditingController(),
      });
    });
  }

  Future<void> addExpense() async {
    double amount = double.parse(_expenseController.text);
    List<Map<String, String>> people = _peopleControllers.map((controllers) {
      return {
        'name': controllers['name']!.text,
        'email': controllers['email']!.text,
      };
    }).toList();

    double splitAmount = amount / people.length;

    DocumentReference expenseRef = await _firestore.collection('expenses').add({
      'amount': amount,
      'people': people,
      'splitAmount': splitAmount,
      'paid': {},
    });

    for (var person in people) {
      await sendEmail(person['email']!, person['name']!, splitAmount);
    }

    _expenseController.clear();
    setState(() {
      _peopleControllers.clear();
    });
  }

  Future<void> sendEmail(String email, String name, double amount) async {
    final smtpServer = gmail('your_email@gmail.com', 'your_password');
    final message = Message()
      ..from = const Address('your_email@gmail.com', 'Expense Splitter')
      ..recipients.add(email)
      ..subject = 'Your share of the expense'
      ..text = 'Hello $name,\n\nYou owe \$$amount for the recent expense.';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent. ${e.message}');
    }
  }

  Future<void> markAsPaid(String expenseId, Map<String, String> person) async {
    DocumentSnapshot expenseDoc = await _firestore.collection('expenses').doc(expenseId).get();
    Map<String, dynamic> data = expenseDoc.data() as Map<String, dynamic>;

    Map<String, bool> paid = Map<String, bool>.from(data['paid'] ?? {});
    paid[person['email']!] = true;

    List<Map<String, String>> people = List<Map<String, String>>.from(data['people']);
    people.removeWhere((p) => p['email'] == person['email']);

    await _firestore.collection('expenses').doc(expenseId).update({
      'paid': paid,
      'people': people,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expense Splitter')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _expenseController,
              decoration: const InputDecoration(labelText: 'Expense Amount'),
              keyboardType: TextInputType.number,
            ),
            ..._peopleControllers.map((controllers) => Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controllers['name']!,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: controllers['email']!,
                    decoration: const InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
              ],
            )).toList(),
            ElevatedButton(
              onPressed: addPersonRow,
              child: const Text('Add Person'),
            ),
            ElevatedButton(
              onPressed: addExpense,
              child: const Text('Add Expense and Notify'),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('expenses').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();

                return Column(
                  children: snapshot.data!.docs.map((doc) {
                    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                    return ListTile(
                      title: Text('Amount: \$${data['amount']}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: (data['people'] as List<dynamic>).map((person) =>
                            Text('${person['name']} (${person['email']})'),
                        ).toList(),
                      ),
                      trailing: ElevatedButton(
                        onPressed: () => markAsPaid(doc.id, data['people'][0]),
                        child: const Text('Mark Paid'),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}