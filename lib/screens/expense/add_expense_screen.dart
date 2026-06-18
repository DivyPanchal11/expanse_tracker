import 'package:flutter/material.dart';
import '../../services/firestore_service.dart';

class AddExpenseScreen extends StatefulWidget {
  final String? docId;
  final String? title;
  final double? amount;
  final String? category;
  final DateTime? date;

  const AddExpenseScreen({
    super.key,
    this.docId,
    this.title,
    this.amount,
    this.category,
    this.date,
  });

  @override
  State<AddExpenseScreen> createState() =>
      _AddExpenseScreenState();
}

class _AddExpenseScreenState
    extends State<AddExpenseScreen> {
  bool isLoading = false;

  final FirestoreService firestoreService =
  FirestoreService();

  final TextEditingController titleController =
  TextEditingController();

  final TextEditingController amountController =
  TextEditingController();

  String selectedCategory = 'Food';

  DateTime selectedDate = DateTime.now();

  final List<String> categories = [
    'Food',
    'Travel',
    'Shopping',
    'Bills',
    'Others',
  ];

  @override
  void initState() {
    super.initState();

    if (widget.docId != null) {
      titleController.text = widget.title!;
      amountController.text =
          widget.amount.toString();
      selectedCategory = widget.category!;
      selectedDate = widget.date!;
    }
  }

  Future<void> pickDate() async {
    DateTime? pickedDate =
    await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2035),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> saveExpense() async {
    if (titleController.text.trim().isEmpty ||
        amountController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    double? amount = double.tryParse(
      amountController.text.trim(),
    );

    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Enter a valid amount"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      if (widget.docId == null) {
        await firestoreService.addExpense(
          title: titleController.text.trim(),
          amount: amount,
          category: selectedCategory,
          date: selectedDate,
        );
      } else {
        await firestoreService.updateExpense(
          docId: widget.docId!,
          title: titleController.text.trim(),
          amount: amount,
          category: selectedCategory,
          date: selectedDate,
        );
      }

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.docId == null
                ? "Expense Added Successfully"
                : "Expense Updated Successfully",
          ),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Failed to save expense",
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0014A8),
        foregroundColor: Colors.white,
        title: Text(
          widget.docId == null
              ? "Add Expense"
              : "Edit Expense",
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: "Expense Title",
                prefixIcon: const Icon(Icons.title),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Amount",
                prefixIcon:
                const Icon(Icons.currency_rupee),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: selectedCategory,
              decoration: InputDecoration(
                labelText: "Category",
                prefixIcon:
                const Icon(Icons.category),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              items: categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.calendar_month,
                  color: Color(0xFF0014A8),
                ),
                title: Text(
                  "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                ),
                trailing: const Text(
                  "Select Date",
                  style: TextStyle(
                    color: Color(0xFF0014A8),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: pickDate,
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  const Color(0xFF0014A8),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(15),
                  ),
                ),
                onPressed:
                isLoading ? null : saveExpense,
                child: isLoading
                    ? const CircularProgressIndicator(
                  color: Colors.white,
                )
                    : Text(
                  widget.docId == null
                      ? "Save Expense"
                      : "Update Expense",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}