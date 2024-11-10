import 'package:flutter/material.dart';

class DietaryPlan extends StatefulWidget {
  const DietaryPlan({super.key});

  @override
  State<DietaryPlan> createState() => _DietaryPlanState();
}

class _DietaryPlanState extends State<DietaryPlan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Shopping List'),
      ),
    );
  }
}
