import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myproject/add_note.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget noteBox({
    required Color color,
    String? title,
    String? date,
    bool completed = false,
  }) {
    return Container(
      height: 100,
      width: 150,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (completed)
            const Align(
              alignment: Alignment.topRight,
              child: Icon(Icons.check_circle, color: Colors.green, size: 20),
            )
          else
            Text(
              title ?? '',
              style: const TextStyle(fontSize: 10, color: Colors.white),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          if (completed)
            Text(
              title ?? '',
              style: const TextStyle(
                fontSize: 10,
                color: Color.fromARGB(255, 158, 193, 209),
              ),
            ),
          if (date != null)
            Text(date, style: const TextStyle(fontSize: 8, color: Colors.grey)),
        ],
      ),
    );
  }

  Future<void> getuser(int id) async {
    final url = 'https://dummyjson.com/users/$id';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Map<String, dynamic> user =
          jsonDecode(response.body) as Map<String, dynamic>;
      print(user['firstName']);
    }
  }

  Widget horizontalBoxes(List<Widget> boxes) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const SizedBox(width: 6),
          ...boxes.expand((box) => [box, const SizedBox(width: 20)]),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 20, 17, 17),

      appBar: AppBar(
        title: const Text(
          'Notes Diary',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(235, 241, 243, 245),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 19, 2, 78),
        foregroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 224, 221, 221),
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.person, color: Colors.black),
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hello, Prem Sagar',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Text(
                'Add your Notes here.',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),

              // PINNED NOTES
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Pinned Notes',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add, color: Colors.white),
                  ),
                ],
              ),

              horizontalBoxes([
                noteBox(
                  color: Colors.white10,
                  title: 'Shopping List\nMilk, Bread, Eggs\nTomatoes, Potatoes,\nOnions',
                  date: '01-OCT-2023',
                ),
                noteBox(color: const Color.fromARGB(26, 148, 248, 190)),
                noteBox(color: const Color.fromARGB(26, 76, 65, 223)),
              ]),

              const SizedBox(height: 20),

              horizontalBoxes([
                noteBox(color: const Color.fromARGB(26, 222, 238, 79)),
                noteBox(color: const Color.fromARGB(26, 221, 95, 183)),
                noteBox(color: const Color.fromARGB(26, 85, 217, 235)),
              ]),

              // TODAY'S TASK
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Today's Task",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 213, 81, 240),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add, color: Colors.white),
                  ),
                ],
              ),

              // FIRST ROW: THREE TASK CONTAINERS
              horizontalBoxes([
                noteBox(
                  color: const Color.fromARGB(26, 238, 222, 79),
                  title: 'Maths Homework',
                  date: '01-OCT-2023',
                  completed: true,
                ),
                noteBox(
                  color: const Color.fromARGB(26, 238, 38, 88),
                  title: 'Maths Homework',
                  date: '01-OCT-2023',
                ),
                noteBox(
                  color: const Color.fromARGB(26, 80, 150, 220),
                  title: 'English Homework',
                  date: '01-OCT-2023',
                ),
              ]),

              const SizedBox(height: 20),

              horizontalBoxes([
                noteBox(color: Colors.white10),
                noteBox(color: const Color.fromARGB(26, 109, 145, 124)),
                noteBox(color: const Color.fromARGB(26, 247, 108, 108)),
              ]),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFE6D5FF),
        foregroundColor: const Color(0xFF503399),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNoteStutes()),
          );
        },
        child: const Icon(Icons.add, size: 30),
      ),
    );
  }
}
