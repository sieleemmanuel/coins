import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coins/net/firebase_methods.dart';
import 'package:coins/ui/add_coins.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  CollectionReference coinsRef = FirebaseFirestore.instance.collection("Users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Coins Prices"),
        leading: const Icon(Icons.home_rounded),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder(
            stream: coinsRef
                .doc(FirebaseAuth.instance.currentUser?.uid)
                .collection('Coins')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Unknown error occurred!"),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView(
                  padding: const EdgeInsets.only(bottom: 100.0),
                  children: snapshot.data!.docs.map((coin) {
                    var coinsValue =
                        (coin['amount'] * coin['price']).toStringAsFixed(2);
                    return Card(
                      margin:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      color: const Color.fromARGB(255, 232, 239, 245),
                      child: ListTile(
                        title: Text(coin.id.toUpperCase()),
                        subtitle: Row(
                          children: [
                            Text("Amount: ${coin['amount']} "),
                            const SizedBox(width: 20.0),
                            Text("Value: \$ $coinsValue"),
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: () async {
                            removeCoin(coin.id);
                          },
                          icon: const Icon(Icons.delete_outline),
                        ),
                      ),
                    );
                  }).toList());
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const AddCoins();
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
