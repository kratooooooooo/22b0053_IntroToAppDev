import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: UserLogin(),
    ),
  );
}

class UserLogin extends StatefulWidget {
  const UserLogin({Key? key}) : super(key: key);

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  Map<String, double> expenseData = {
    'Salary': 50000,
    'Grocery': 3000,
    'Electricity Bill': 5000,
    // Add more expense categories here
  };

  double calculateTotalExpenses() {
    double total = 0;
    expenseData.forEach((key, value) {
      total += value;
    });
    return total;
  }

  bool isExpanded = false;
  bool isAddMenuOpen = false;
  TextEditingController categoryController = TextEditingController();
  TextEditingController valueController = TextEditingController();

  void toggleAddMenu() {
    setState(() {
      isAddMenuOpen = !isAddMenuOpen;
    });
  }

  void addExpenseCategory() {
    String category = categoryController.text;
    double value = double.tryParse(valueController.text) ?? 0;

    if (category.isNotEmpty && value > 0) {
      setState(() {
        expenseData[category] = value;
        categoryController.clear();
        valueController.clear();
        isAddMenuOpen = false;
      });
    }
  }

  void deleteExpenseCategory(String category) {
    setState(() {
      expenseData.remove(category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 172, 100, 255),
      appBar: AppBar(
        title: Text(
          'BUDGET TRACKER',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 35,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 203, 170, 250),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 25,
          ),
          Container(
              width: 200, // Specify the desired width
              height: 200, // Specify the desired height
              child: Image(
                  image: AssetImage(
                      'assets/user.png')) // Replace 'assets/image.png' with your image path
              ),
          SizedBox(height: 25),
          Text(
            'Welcome Back ',
            style: TextStyle(
              fontSize: 30,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Stack(
            alignment: Alignment.centerRight,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 50, 10),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Expenses: \$${calculateTotalExpenses().toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    if (isExpanded)
                      for (var entry in expenseData.entries)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${entry.key}: \$${entry.value.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              onPressed: () => deleteExpenseCategory(entry.key),
                              icon: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      icon: Icon(
                        isExpanded
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              if (!isAddMenuOpen)
                Positioned(
                  right: 10,
                  child: FloatingActionButton(
                    onPressed: toggleAddMenu,
                    child: Icon(Icons.add),
                  ),
                ),
            ],
          ),
          if (isAddMenuOpen)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                children: [
                  TextField(
                    controller: categoryController,
                    decoration: InputDecoration(labelText: 'Category Name'),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: valueController,
                    decoration: InputDecoration(labelText: 'Value'),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      addExpenseCategory();
                      toggleAddMenu();
                    },
                    child: Text('Add'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
