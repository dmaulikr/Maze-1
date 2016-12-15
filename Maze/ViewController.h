//
//  ViewController.h
//  Maze
//
//  Created by Jonathan Deguzman on 12/14/16.
//  Copyright © 2016 Jonathan Deguzman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/CAAnimation.h>
#import <CoreMotion/CoreMotion.h>

// poll for data 60 times per second
#define kUpdateInterval (1.0f / 60.0f)

@interface ViewController : UIViewController

// holds the current position of pacman
@property (assign, nonatomic) CGPoint currentPoint;

// holds the position from where pacman has been moved
@property (assign, nonatomic) CGPoint previousPoint;

// contains the x component of the velocity
@property (assign, nonatomic) CGFloat pacmanXVelocity;

// contains the y component of the velocity
@property (assign, nonatomic) CGFloat pacmanYVelocity;

// current angle of pacman
@property (assign, nonatomic) CGFloat angle;

// current acceleration as measured by the accelerometer
@property (assign, nonatomic) CMAcceleration acceleration;

// the queue that helps us receive and process the data send by the accelerometer
@property (strong, nonatomic) CMMotionManager  *motionManager;
@property (strong, nonatomic) NSOperationQueue *queue;

// allows us to control how long it has been since the last call from the acceleromter
@property (strong, nonatomic) NSDate *lastUpdateTime;

@end

