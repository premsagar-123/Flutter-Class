import 'package:flutter/material.dart';

class AddNoteStutes extends StatelessWidget {
  const AddNoteStutes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 1, 12),
      appBar: AppBar(
        title: Text(
          "Add Note",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(235, 12, 0, 19),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 2, 243, 63),
        foregroundColor: const Color.fromARGB(255, 29, 26, 26),
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Save button clicked!"),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text(
              "Save",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 8, 6, 17),
              ),
            ),
          ),
        ],
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(20),
        color: const Color.fromARGB(255, 4, 1, 7),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Write your notes here",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 236, 241, 237),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: TextField(
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,

                decoration: InputDecoration(
                  hintText: "Start typing your notes...",
                  hintStyle: const TextStyle(
                    color: Color.fromARGB(255, 233, 230, 238),
                  ),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 216, 5, 86),

                  contentPadding: const EdgeInsets.all(18),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 230, 219, 222),
                      width: 2,
                    ),
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
