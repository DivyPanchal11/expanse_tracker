import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'add_expense_screen.dart';
import '../../services/firestore_service.dart';

class ExpenseListScreen extends StatefulWidget {
  const ExpenseListScreen({super.key});

  @override
  State<ExpenseListScreen> createState() =>
      _ExpenseListScreenState();
}

class _ExpenseListScreenState
    extends State<ExpenseListScreen> {
  final FirestoreService firestoreService =
  FirestoreService();

  final TextEditingController searchController =
  TextEditingController();

  String searchText = '';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('expenses')
          .orderBy('date', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState ==
            ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData ||
            snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text(
              "No Expenses Found",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText:
                  "Search by title or category",
                  prefixIcon:
                  const Icon(Icons.search),
                  filled: true,
                  fillColor: Theme.of(context)
                      .brightness ==
                      Brightness.dark
                      ? Colors.grey.shade900
                      : Colors.white,
                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(15),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchText =
                        value.toLowerCase().trim();
                  });
                },
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount:
                snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final expense =
                  snapshot.data!.docs[index];

                  final title = expense['title']
                      .toString()
                      .toLowerCase();

                  final category =
                  expense['category']
                      .toString()
                      .toLowerCase();

                  if (searchText.isNotEmpty &&
                      !title.contains(
                          searchText) &&
                      !category.contains(
                          searchText)) {
                    return const SizedBox();
                  }

                  final DateTime date =
                  (expense['date']
                  as Timestamp)
                      .toDate();

                  return Card(
                    elevation: 6,
                    margin:
                    const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(
                          20),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .cardColor,
                        borderRadius:
                        BorderRadius.circular(
                            20),
                      ),
                      child: ListTile(
                        contentPadding:
                        const EdgeInsets
                            .symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),

                        title: Text(
                          expense['title'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                            FontWeight.bold,
                            color: Theme.of(
                                context)
                                .textTheme
                                .bodyLarge
                                ?.color,
                          ),
                        ),

                        subtitle: Text(
                          "${expense['category']} • ${date.day}/${date.month}/${date.year}",
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(
                                context)
                                .textTheme
                                .bodyMedium
                                ?.color,
                          ),
                        ),

                        trailing: Row(
                          mainAxisSize:
                          MainAxisSize.min,
                          children: [
                            Text(
                              "₹${expense['amount']}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight:
                                FontWeight.bold,
                                color: Theme.of(
                                    context)
                                    .textTheme
                                    .bodyLarge
                                    ?.color,
                              ),
                            ),

                            IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Theme.of(
                                    context)
                                    .iconTheme
                                    .color,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) =>
                                        AddExpenseScreen(
                                          docId:
                                          expense.id,
                                          title:
                                          expense[
                                          'title'],
                                          amount:
                                          (expense[
                                          'amount']
                                          as num)
                                              .toDouble(),
                                          category:
                                          expense[
                                          'category'],
                                          date: (expense[
                                          'date']
                                          as Timestamp)
                                              .toDate(),
                                        ),
                                  ),
                                );
                              },
                            ),

                            IconButton(
                              icon:
                              const Icon(
                                Icons.delete,
                                color:
                                Colors.red,
                              ),
                              onPressed:
                                  () async {
                                bool?
                                confirm =
                                await showDialog(
                                  context:
                                  context,
                                  builder:
                                      (context) =>
                                      AlertDialog(
                                        title:
                                        const Text(
                                          "Delete Expense",
                                        ),
                                        content:
                                        const Text(
                                          "Are you sure you want to delete this expense?",
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed:
                                                () {
                                              Navigator.pop(
                                                context,
                                                false,
                                              );
                                            },
                                            child:
                                            const Text(
                                              "Cancel",
                                            ),
                                          ),
                                          TextButton(
                                            onPressed:
                                                () {
                                              Navigator.pop(
                                                context,
                                                true,
                                              );
                                            },
                                            child:
                                            const Text(
                                              "Delete",
                                            ),
                                          ),
                                        ],
                                      ),
                                );

                                if (confirm ==
                                    true) {
                                  await firestoreService
                                      .deleteExpense(
                                    expense.id,
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}