import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final purposeController = TextEditingController();

  String selectedTone = "professional";
  String selectedEmailType = "Leave Request";

  String generatedEmail = "";

  bool loading = false;

  Future<void> generateEmail() async {
    setState(() {
      loading = true;
    });

    try {
      final result = await ApiService.generateEmail(
        purpose: purposeController.text,
        tone: selectedTone,
      );

      setState(() {
        generatedEmail = result;
      });
    } catch (e) {
      setState(() {
        generatedEmail = e.toString();
      });
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Email Generator"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: purposeController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: "Email Purpose",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedTone,
              isExpanded: true,
              items: const [
                DropdownMenuItem(
                  value: "professional",
                  child: Text("Professional"),
                ),
                DropdownMenuItem(
                  value: "friendly",
                  child: Text("Friendly"),
                ),
                DropdownMenuItem(
                  value: "formal",
                  child: Text("Formal"),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedTone = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: loading ? null : generateEmail,
              child: const Text("Generate Email"),
            ),
            const SizedBox(height: 20),
            if (loading) const CircularProgressIndicator(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(text: generatedEmail),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Copied to clipboard"),
                          ),
                        );
                      },
                    ),
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: SelectableText(generatedEmail),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


