import 'package:flutter/material.dart';
import './widgets/chart_n.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses',
      theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.blue[500],
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chossenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chossenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.insert(0, newTx);
    });
  }

  void _deleteTx(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  bool _switch = false;
  @override
  Widget build(BuildContext context) {
    final islandescape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text(
        'Personal Expenses',
      ),
      actions: <Widget>[
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Show Chart',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: Colors.white),
              ),
              Switch(
                  value: _switch,
                  activeColor: Colors.amberAccent,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onChanged: (val) {
                    setState(() {
                      _switch = val;
                    });
                  }),
            ],
          ),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: islandescape
            ? Row(

                children: _switch
                    ? [
                       Column(
                           children: [
                             Container(
                               height:450,
                                width: (MediaQuery.of(context).size.width -
                                  appBar.preferredSize.height) *
                              0.3,
                               
                                child: Chart_N(_recentTransactions),
                              ),
                           ],
                         ),
                       Container(
                          height: 450,
                         child: new Column(
                            children: [
                             Container(
                          width: (MediaQuery.of(context).size.width -
                                  appBar.preferredSize.height) *
                              0.7,
                            
                          child: TransactionList(_userTransactions, _deleteTx),
                        ),
                            ],
                          ),
                       ),
                      ]
                    : [
                        Container(
                          width: (MediaQuery.of(context).size.width -
                                  appBar.preferredSize.height ) *
                              0.7,
                          child: TransactionList(_userTransactions, _deleteTx),
                        ),
                      ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: _switch
                    ? [
                        Container(
                          height: (MediaQuery.of(context).size.height -
                                  appBar.preferredSize.height -
                                  MediaQuery.of(context).padding.top) *
                              0.3,
                          child: Chart(_recentTransactions),
                        ),
                        Container(
                          height: (MediaQuery.of(context).size.height -
                                  appBar.preferredSize.height -
                                  MediaQuery.of(context).padding.top) *
                              0.7,
                          child: TransactionList(_userTransactions, _deleteTx),
                        ),
                      ]
                    : [
                        Container(
                          height: (MediaQuery.of(context).size.height -
                                  appBar.preferredSize.height -
                                  MediaQuery.of(context).padding.top) *
                              0.7,
                          child: TransactionList(_userTransactions, _deleteTx),
                        ),
                      ],
              ),
      ),
      floatingActionButtonLocation: islandescape? FloatingActionButtonLocation.endFloat: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
