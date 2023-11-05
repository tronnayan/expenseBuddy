import 'package:flutter/material.dart';

// Helper function to get the payment method label (Assuming it's defined elsewhere)
String _getPaymentMethodLabel(String method) {
  switch (method) {
    case 'card':
      return 'Card';
    case 'cash':
      return 'Cash';
    case 'upi':
      return 'UPI';
    default:
      return 'Unknown';
  }
}

class AddExpenseScreen extends StatefulWidget {
  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _name; // Nullable field for expense name
  double? _amount; // Nullable field for expense amount
  DateTime _date = DateTime.now(); // Default to current date
  String? _method = 'cash'; // Default payment method, also nullable
  String? _category; // Nullable field for expense category

  // List of categories (assuming you have these categories in your app)
  final List<String> _categories = ['Groceries', 'Internet', 'Electricity', 'Dining', 'Travel'];
  // Theme colors (should match HomePage colors)
  final Color primaryColor = Color(0xFF6528F7); // A nice shade of blue
  final Color secondaryColor = Color(0xFFA076F9); // A complimentary purple
  final Color highlightColor = Color(0xFFEDE4FF); // White for highlights
  final LinearGradient formGradient = LinearGradient(
    colors: [Color(0xFFA076F9), Color(0xFF190482)],
    begin: Alignment.topRight,
    end: Alignment.bottomRight,
  );
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Expense'),
        backgroundColor: primaryColor,
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: ListView(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Expense Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the expense name';
                    }
                    return null;
                  },
                  onSaved: (value) => _name = value,
                ),
                SizedBox(height: 4.0),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty || double.tryParse(value) == null) {
                      return 'Please enter a valid amount';
                    }
                    return null;
                  },
                  onSaved: (value) => _amount = value == null ? null : double.tryParse(value),
                ),
                SizedBox(height: 4.0),
                DropdownButtonFormField<String>(
                  value: _category,
                  hint: Text('Select Category'),
                  items: _categories
                      .map((String category) => DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  ))
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _category = newValue;
                    });
                  },
                  validator: (value) => value == null ? 'Please select a category' : null,
                  onSaved: (value) => _category = value,
                ),
                SizedBox(height: 4.0),
                DropdownButtonFormField<String>(
                  value: _method,
                  items: ['cash', 'card', 'upi']
                      .map((String method) => DropdownMenuItem(
                    value: method,
                    child: Text(_getPaymentMethodLabel(method)),
                  ))
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _method = newValue;
                    });
                  },
                  onSaved: (value) => _method = value,
                ),
                SizedBox(height: 4.0),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Date'),
                  controller: TextEditingController(
                    text: "${_date.year}-${_date.month.toString().padLeft(2, '0')}-${_date.day.toString().padLeft(2, '0')}",
                  ),
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode()); // to prevent opening default keyboard
                    _selectDate(context);
                  },
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.only(left:110, right: 110),
                  child:ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                        primary: secondaryColor, // Button background
                      ),
                      child: Text('Add Expense'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          // Now you can use _name, _amount, _date, _method, and _category
                          // to add the expense to the list. Check for null values as needed.
                          Navigator.pop(context);
                        }
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

