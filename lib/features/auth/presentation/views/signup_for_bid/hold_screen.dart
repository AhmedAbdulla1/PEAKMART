import 'package:flutter/material.dart';
import 'package:peakmart/app/app.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/shared_widgets/buttons.dart';

class HoldScreen extends StatelessWidget {
  static const String routeName = '/hold-screen';

  const HoldScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFF4E5), // Background color of the page
      body: SafeArea(
        child: Column(
          children: [
            // Custom status bar

            // Main content
            Expanded(
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.38,
                  // Adjust width as needed
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3), // Shadow position
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Time for checking up!',
                        style: TextStyle(
                          fontSize: FontSize.s30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8B4513), // Brown color for the title
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'we are checking up your application for safety sir, we holding your auction account and soon we email you and you can bid for all products you want.\n It will be in 3 to 4 days',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: FontSize.s22,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomElevatedButtonWithoutStream(
                onPressed: () {
                  print('=== Navigation Stack (Bottom to Top) ===');
                  int index = 0;

                  // Get the Navigator's state
                  final navigator = Navigator.of(context);

                  // Use a temporary list to collect route names without popping
                  List<String> stack = [];
                  navigator.popUntil((route) {
                    stack.add(route.settings.name ?? 'Unnamed Route');
                    return true; // Keep the route in the stack, don't pop
                  });

                  // Reverse the list to show the stack from bottom to top
                  stack = stack.reversed.toList();

                  // Print the stack
                  for (var routeName in stack) {
                    print('[$index] Route: $routeName');
                    index++;
                  }
                  print('=====================');
                  Navigator.pop(context);
                },
                text: 'Back To Home',
              ),
            ),
          const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
