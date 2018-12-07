import 'package:flutter/material.dart';
import '../widgets/cat.dart';

// For use of pi
import 'dart:math';

// Record current state of the animation

class Home extends StatefulWidget {
  // Create new instance of HomeState
  HomeState createState() => HomeState();
}

// Extends state of Home
// TickerProviderStateMixin gives the world a widget and tells animation controller to progress the animation to the next frame
class HomeState extends State<Home> with TickerProviderStateMixin {
  // Declare instance variables
  // Generic class, can specify type
  // Double is there because of angle parameter that takes in type double
  Animation<double> catAnimation;
  AnimationController catController;
  Animation<double> boxAnimation;
  AnimationController boxController;

  //Initialization, lifecycle method, automatically invokes, only extends State
  initState() {
    // Call original implementation of base class of state
    super.initState();

    boxController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    boxAnimation = Tween(
      // about 60% rototation
      begin: pi * 0.6,
      end: pi * 0.65,
    ).animate(
      CurvedAnimation(
        parent: boxController,
        // Constant rate instead of easing in.
        curve: Curves.easeInOut,
      ),
    );
    // If the status changes, i.e. completed, we can restart the animation by using an event listener
    boxController.addStatusListener((status) {
      // Check status of animation
      if (boxController.status == AnimationStatus.completed) {
        boxController.reverse();
        // Check if animation has ever played
      } else if (boxController.status == AnimationStatus.dismissed) {
        // Will play animation on tap
        boxController.forward();
      }
    });
    // Init animation
    boxController.forward();

    // Init catController, can start, stop, control
    catController = AnimationController(
      // Animation duration
      duration: Duration(milliseconds: 500),
      // Just mixed in TickerProvider, passing 'this' is mixedin
      vsync: this,
    );

    // Init cat
    // Moving range 0 to 100px up or down
    catAnimation = Tween(begin: -35.0, end: -80.0).animate(
      // The rate of which the animation will change.
      CurvedAnimation(
        parent: catController,
        curve: Curves.easeIn,
      ),
    );
  }

  // Helper method
  onTap() {
    // Check status of animation
    if (catController.status == AnimationStatus.completed) {
      boxController.forward();
      catController.reverse();
      // Check if animation has ever played
    } else if (catController.status == AnimationStatus.dismissed) {
      // Will play animation on tap
      catController.forward();
      boxController.stop();
    }
  }

  // Build tree
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Animation'),
        ),
        // Helper methods
        // Any tap will bubble up until it gets to GestureDetector
        body: GestureDetector(
          // Centers only single child within itself
          child: Center(
            // Use Stack layout widget, which allows to overlay widgets by layer
            child: Stack(
              overflow: Overflow.visible,
              // Array is order dependant. The first is at the bottom and the end is at the top
              children: [
                buildCatAnimation(),
                buildBox(),
                buildLeftFlap(),
                buildRightFlap()
              ],
            ),
          ),
          onTap: onTap,
        ));
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {
        // Controls where a child of the stack is Positioned
        return Positioned(
          child: child,
          // Offset by bottom of stack without changing dimensions
          top: catAnimation.value,
          // Offset right and left, this will make the cat constrained to the Positioned widget
          right: 0.0,
          left: 0.0,
        );
      },
      // Cat gets reused, saves on performance, created only 1 time
      child: Cat(),
    );
  }

  Widget buildBox() {
    return Container(
      height: 200.0,
      width: 200.0,
      color: Colors.brown,
    );
  }

  Widget buildLeftFlap() {
    // Move the rotated flap to blend in with the box
    return Positioned(
      left: 3.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          height: 10.0,
          width: 125.0,
          color: Colors.brown,
        ),
        builder: (context, child) {
          return Transform.rotate(
            // The child above
            child: child,
            // Default Alignment is center, need it top left of the flap.
            alignment: Alignment.topLeft,
            // Angle of flap
            angle: boxAnimation.value,
          );
        },
      ),
    );
  }

  Widget buildRightFlap() {
    // Move the rotated flap to blend in with the box
    return Positioned(
      right: 3.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          height: 10.0,
          width: 125.0,
          color: Colors.brown,
        ),
        builder: (context, child) {
          return Transform.rotate(
            // The child above
            child: child,
            // Default Alignment is center, need it top left of the flap.
            alignment: Alignment.topRight,
            // Angle of flap, you can use negative '-'
            angle: -boxAnimation.value,
          );
        },
      ),
    );
  }
}
