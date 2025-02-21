import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/db/category/category_db.dart';
import 'package:money_manager/db/transactions/transaction_db.dart';
import 'package:money_manager/models/transaction/transcation_model.dart';
import 'package:money_manager/models/category/category_model.dart';

class ScreenAddTransaction extends StatefulWidget {
  static const routeName = 'add-transactions';
  const ScreenAddTransaction({super.key});

  @override
  State<ScreenAddTransaction> createState() => _ScreenAddTransactionState();
}

class _ScreenAddTransactionState extends State<ScreenAddTransaction> {
  DateTime? _selectedDate;
  CategoryType? _selectedCategorytype;
  CategoryModel? _selectedCategoryModel;
  String? _CategoryID;

  final _purposeTextEditingController = TextEditingController();
  final _amountTextEditingController = TextEditingController();

  @override
  void initState() {
    _selectedCategorytype = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back, color: Colors.black),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _purposeTextEditingController,
                decoration: InputDecoration(
                  hintText: 'Purpose',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _amountTextEditingController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Amount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextButton.icon(
                onPressed: () async {
                  final selectedDateTemp = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(const Duration(days: 60)),
                    lastDate: DateTime.now(),
                  );
                  if (selectedDateTemp == null) return;
                  setState(() {
                    _selectedDate = selectedDateTemp;
                  });
                },
                icon: const Icon(Icons.calendar_today, color: Colors.purple),
                label: Text(
                  _selectedDate == null
                      ? 'Select Date'
                      : DateFormat('yyyy-MM-dd').format(_selectedDate!),
                  style: const TextStyle(color: Colors.purple),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Radio(
                        value: CategoryType.income,
                        groupValue: _selectedCategorytype,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCategorytype = CategoryType.income;
                            _CategoryID = null;
                          });
                        },
                      ),
                      const Text('Income'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: CategoryType.expense,
                        groupValue: _selectedCategorytype,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCategorytype = CategoryType.expense;
                            _CategoryID = null;
                          });
                        },
                      ),
                      const Text('Expense'),
                    ],
                  ),
                ],
              ),
              DropdownButton<String>(
                hint: const Text('Select Category'),
                value: _CategoryID,
                items: (_selectedCategorytype == CategoryType.income
                        ? CategoryDB().incomeCategoryList
                        : CategoryDB().expenseCategoryList)
                    .value
                    .map((e) {
                  return DropdownMenuItem(
                    value: e.id,
                    child: Text(e.name),
                    onTap: () {
                      _selectedCategoryModel = e;
                    },
                  );
                }).toList(),
                onChanged: (selectedvalue) {
                  setState(() {
                    _CategoryID = selectedvalue;
                  });
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    addTransaction();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addTransaction() async {
    final purposeText = _purposeTextEditingController.text;
    final amounttext = _amountTextEditingController.text;
    if (purposeText.isEmpty || amounttext.isEmpty || _CategoryID == null || _selectedDate == null) {
      return;
    }

    final parsedAmount = double.tryParse(amounttext);
    if (parsedAmount == null || _selectedCategoryModel == null) {
      return;
    }

    final model = TransactionsModel(
      purpose: purposeText,
      amount: parsedAmount,
      date: _selectedDate!,
      type: _selectedCategorytype!,
      category: _selectedCategoryModel!,
    );

    await TransactionDB.instance.addTransaction(model);
    Navigator.of(context).pop();
    TransactionDB.instance.refresh();
  }
}
