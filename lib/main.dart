import 'package:expensebuddy/screens/add_expense.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
void main() {
  runApp(ExpenseBuddyApp());
}

class ExpenseBuddyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Sans',
        textTheme: TextTheme(
          headline6: TextStyle(fontSize: 18.0, fontStyle: FontStyle.italic),
        ),
      ),
      home: HomePage(),
    );
  }
}

String _greeting() {
  var hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Good Morning, Nayan!';
  }
  if (hour < 17) {
    return 'Good Afternoon, Nayan!';
  }
  return 'Good Evening, Nayan!';
}

String _getPaymentMethodLabel(String method) {
  switch (method) {
    case 'card':
      return 'Card';
    case 'cash':
      return 'Cash';
    case 'upi':
      return 'UPI';
    default:
      return 'Unknown'; // Unknown method
  }
}

// Define a map of category names to icons
final Map<String, IconData> categoryIcons = {
  'groceries': Icons.shopping_cart,
  'internet': Icons.wifi,
  'electricity': Icons.flash_on,
  'dining': Icons.restaurant,
  'travel': Icons.directions_car,
};

// Function to get the appropriate icon for a category
Icon getCategoryIcon(String category) {
  IconData iconData = categoryIcons[category.toLowerCase()] ?? Icons.error;
  return Icon(iconData, size: 30.0, color: Colors.blueGrey[600]);
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Example list of expenses with an added 'method' field for payment method
  final List<Map<String, dynamic>> expenses = [
    {
      'name': 'Groceries',
      'amount': 150.00,
      'date': '2023-11-01',
      'method': 'card'
    },
    {
      'name': 'Internet',
      'amount': 60.00,
      'date': '2023-11-03',
      'method': 'upi'
    },
    {
      'name': 'Electricity',
      'amount': 75.00,
      'date': '2023-11-05',
      'method': 'cash'
    },
    {
      'name': 'Groceries',
      'amount': 150.00,
      'date': '2023-11-01',
      'method': 'card'
    },
    {
      'name': 'Internet',
      'amount': 60.00,
      'date': '2023-11-03',
      'method': 'upi'
    },
    {
      'name': 'Electricity',
      'amount': 75.00,
      'date': '2023-11-05',
      'method': 'cash'
    },
    {
      'name': 'Groceries',
      'amount': 150.00,
      'date': '2023-11-01',
      'method': 'card'
    },
    {
      'name': 'Internet',
      'amount': 60.00,
      'date': '2023-11-03',
      'method': 'upi'
    },
    {
      'name': 'Electricity',
      'amount': 75.00,
      'date': '2023-11-05',
      'method': 'cash'
    },
    {
      'name': 'Groceries',
      'amount': 150.00,
      'date': '2023-11-01',
      'method': 'card'
    },
    {
      'name': 'Internet',
      'amount': 60.00,
      'date': '2023-11-03',
      'method': 'upi'
    },
    {
      'name': 'Electricity',
      'amount': 75.00,
      'date': '2023-11-05',
      'method': 'cash'
    },
    {
      'name': 'Groceries',
      'amount': 150.00,
      'date': '2023-11-01',
      'method': 'card'
    },
    {
      'name': 'Internet',
      'amount': 60.00,
      'date': '2023-11-03',
      'method': 'upi'
    },
    {
      'name': 'Electricity',
      'amount': 75.00,
      'date': '2023-11-05',
      'method': 'cash'
    },
    // Add more expenses here
  ];

  // Function to get the appropriate icon for the payment method
  Icon getPaymentMethodIcon(String method) {
    switch (method) {
      case 'card':
        return Icon(Icons.credit_card, color: Colors.blue, size: 16.0);
      case 'cash':
        return Icon(Icons.money, color: Colors.green, size: 16.0);
      case 'upi':
        return Icon(Icons.phone_android, color: Colors.orange, size: 16.0);
      default:
        return Icon(Icons.error_outline,
            color: Colors.red, size: 16.0); // Unknown method
    }
  }
  // Add state for sorting and filtering
  String _paymentMethodFilter = 'all'; // 'all', 'cash', 'card', 'upi'
  bool _sortAscending = true;

  List<Map<String, dynamic>> get sortedAndFilteredExpenses {
    // Filter the expenses first
    List<Map<String, dynamic>> filteredList = _paymentMethodFilter == 'all'
        ? expenses
        : expenses.where((expense) => expense['method'] == _paymentMethodFilter).toList();

    // Sort the filtered list
    filteredList.sort((a, b) {
      double amountA = a['amount'];
      double amountB = b['amount'];
      return _sortAscending ? amountA.compareTo(amountB) : amountB.compareTo(amountA);
    });

    return filteredList;
  }

  void _changeSorting() {
    setState(() {
      _sortAscending = !_sortAscending;
    });
  }

  void _setPaymentMethodFilter(String method) {
    setState(() {
      _paymentMethodFilter = method;
    });
  }
  @override
  Widget build(BuildContext context) {
    // Calculate the total expenses
    final double totalExpenses =
        expenses.fold(0.0, (sum, item) => sum + item['amount']);

    // Example income and balance calculation
    final double income = 5000.00;
    final double balance = income - totalExpenses;
    // Updated color palette

    // Updated color palette
    const Color primaryColor = Color(0xFF6528F7); // A nice shade of blue
    const Color secondaryColor = Color(0xFFA076F9); // A complimentary purple
    const Color highlightColor = Color(0xFFEDE4FF); // White for highlights
    const LinearGradient cardGradient = LinearGradient(
                                          colors: [Color(0xFFA076F9),Color(0xFF190482)],
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomRight,
                                        ); // A different shade of blue for cards
    Widget _buildFilterChip(String label, String filter) {
      final bool isActive = _paymentMethodFilter == filter;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ChoiceChip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                getPaymentMethodIcon(filter).icon,
                color: isActive ? Colors.white : null,
                size: 20.0,
              ),
              SizedBox(width: 4.0),
              Text(label),
            ],
          ),
          selected: isActive,
          onSelected: (selected) {
            if (selected) _setPaymentMethodFilter(filter);
          },
          backgroundColor: Colors.grey.shade200,
          selectedColor: secondaryColor,
          labelStyle: TextStyle(
            color: isActive ? Colors.white : Colors.black,
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Row(
          children: <Widget>[
            Icon(
              Icons.wallet,
              size: 30,
              color: highlightColor,
            ),
            SizedBox(width: 8),
            Text(
              _greeting(),
              style: TextStyle(color: highlightColor),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [primaryColor, secondaryColor],
                    begin: Alignment.topRight,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Text(
                  'Available Balance\n₹${balance.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 24, color: highlightColor),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              bottom: 8.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: cardGradient
                      ),
                      child: Text(
                        'Total Income\n₹${income.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 20, color: highlightColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: cardGradient
                      ),
                      child: Text(
                        'Total Expenses\n₹${totalExpenses.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 20, color: highlightColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded( // This ensures the SingleChildScrollView takes all available width
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip('All Methods', 'all'),
                      _buildFilterChip('Cash', 'cash'),
                      _buildFilterChip('Card', 'card'),
                      _buildFilterChip('UPI', 'upi'),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: Icon(_sortAscending ? Icons.arrow_upward : Icons.arrow_downward),
                onPressed: _changeSorting,
              ),
            ],
          ),

          Expanded(
            child: ListView.builder(
              itemCount: sortedAndFilteredExpenses.length,
              itemBuilder: (context, index) {
                final expense = sortedAndFilteredExpenses[index];
                return Card(
                  child: ListTile(
                    leading: getCategoryIcon(expense['name']),
                    title: Text(expense['name']),
                    subtitle: Row(
                      children: <Widget>[
                        Text(expense['date']),
                        SizedBox(width: 6),
                        getPaymentMethodIcon(expense['method']),
                      ],
                    ),
                    trailing: Text('₹${expense['amount'].toStringAsFixed(2)}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: primaryColor,
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Container(
          height: 60,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the AddExpenseScreen when the button is pressed
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddExpenseScreen()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: secondaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

