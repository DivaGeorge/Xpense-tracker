import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/db/transactions/transaction_db.dart';
import 'package:money_manager/models/transaction/transcation_model.dart';
import 'package:money_manager/models/category/category_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ScreenTransactions extends StatelessWidget {
  const ScreenTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();

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
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: TransactionDB.instance.transactionListNotifier,
                  builder: (BuildContext ctx, List<TransactionsModel> newList, Widget? _) {
                    return ListView.separated(
                      padding: const EdgeInsets.all(10),
                      itemBuilder: (ctx, index) {
                        final value = newList[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Slidable(
                            key: Key(value.id ?? ''),
                            startActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (ctx) {
                                    TransactionDB.instance.deleteTransaction(value.id!);
                                    TransactionDB.instance.refresh();
                                  },
                                  icon: Icons.delete,
                                  label: 'Delete',
                                  backgroundColor: Colors.redAccent,
                                ),
                              ],
                            ),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                leading: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: value.type == CategoryType.income ? Colors.green : Colors.red,
                                  child: Text(
                                    DateFormat('dd MMM').format(value.date),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 12, color: Colors.white),
                                  ),
                                ),
                                title: Text(
                                  '₹ ${value.amount}',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                subtitle: Text(value.category.name),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (ctx, index) => const SizedBox(height: 10),
                      itemCount: newList.length,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () {
          Navigator.of(context).pushNamed('add-transactions');
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
