import 'package:coins/model/coin.dart';
import 'package:coins/net/api_methods.dart';
import 'package:coins/net/firebase_methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddCoins extends StatefulWidget {
  const AddCoins({super.key});

  @override
  State<AddCoins> createState() => _AddCoinsState();
}

class _AddCoinsState extends State<AddCoins> {
  TextEditingController amountController = TextEditingController();
  List<String> coins = [
    "Bitcoin",
    "Ethereum",
    "Tether",
    "USD-Coin",
    "Cardano",
    "Dogecoin",
    "Solana",
    "Polkadot",
    "Binance-Coin",
    "Binance-Bitcoin",
    "Binance-USD"
  ];

  String dropdownValue = "Bitcoin";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Coins"),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  value: dropdownValue,
                  items: coins.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                ),
              ),
              const SizedBox(height: 30.0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextFormField(
                  controller: amountController,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "Enter Coin Amount",
                      fillColor: Colors.indigo.shade50,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              const SizedBox(height: 30.0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 40.0)),
                    onPressed: () async {
                      double price =
                          await getPrice(dropdownValue.toLowerCase());
                      double amount = double.parse(amountController.text);
                      Coin coin = Coin(
                          id: dropdownValue.toLowerCase(),
                          name: dropdownValue,
                          price: price,
                          amount: amount);
                      addCoin(coin);
                      if (!context.mounted) return;
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Add Amount",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
