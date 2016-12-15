//
//  ViewController.m
//  Maze
//
//  Created by Jonathan Deguzman on 12/14/16.
//  Copyright © 2016 Jonathan Deguzman. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *pacman;
@property (strong, nonatomic) IBOutlet UIImageView *ghost1;
@property (strong, nonatomic) IBOutlet UIImageView *ghost2;
@property (strong, nonatomic) IBOutlet UIImageView *ghost3;
@property (strong, nonatomic) IBOutlet UIImageView *exit;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *wall;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // define the start and end points of the animation for ghost1
    CGPoint origin1 = self.ghost1.center;
    CGPoint target1 = CGPointMake(self.ghost1.center.x, self.ghost1.center.y-124);
    
    // create a CABasicAnimation object by specifying that we want to move along the y axis from origin to target point. Use autoreverse to send it back and then make it repeat forever
    CABasicAnimation *bounce1 = [CABasicAnimation animationWithKeyPath:@"position.y"];
    bounce1.fromValue = [NSNumber numberWithInt:origin1.y];
    bounce1.toValue = [NSNumber numberWithInt:target1.y];
    bounce1.duration = 2;
    bounce1.autoreverses = YES;
    bounce1.repeatCount = HUGE_VALF;
    
    [self.ghost1.layer addAnimation:bounce1 forKey:@"position"];
    
    // define the start and end points of the animation for ghost2
    CGPoint origin2 = self.ghost2.center;
    CGPoint target2 = CGPointMake(self.ghost2.center.x, self.ghost2.center.y+284);
    
    CABasicAnimation *bounce2 = [CABasicAnimation animationWithKeyPath:@"position.y"];
    bounce2.fromValue = [NSNumber numberWithInt:origin2.y];
    bounce2.toValue = [NSNumber numberWithInt:target2.y];
    bounce2.duration = 2;
    bounce2.autoreverses = YES;
    bounce2.repeatCount = HUGE_VALF;
    
    [self.ghost2.layer addAnimation:bounce2 forKey:@"position"];
    
    // define the start and end points of the animation for ghost3
    CGPoint origin3 = self.ghost3.center;
    CGPoint target3 = CGPointMake(self.ghost3.center.x, self.ghost3.center.y-284);
    
    CABasicAnimation *bounce3 = [CABasicAnimation animationWithKeyPath:@"position.y"];
    bounce3.fromValue = [NSNumber numberWithInt:origin3.y];
    bounce3.toValue = [NSNumber numberWithInt:target3.y];
    bounce3.duration = 2;
    bounce3.autoreverses = YES;
    bounce3.repeatCount = HUGE_VALF;
    
    [self.ghost3.layer addAnimation:bounce3 forKey:@"position"];
    
    
    // movement of pacman
    self.lastUpdateTime = [[NSDate alloc] init];
    
    self.currentPoint = CGPointMake(0, 144);
    self.motionManager = [[CMMotionManager alloc] init];
    self.queue = [[NSOperationQueue alloc] init];
    
    self.motionManager.accelerometerUpdateInterval = kUpdateInterval;
    
    // start accelerometer updates using block to save acceleration data and then call the update method
    [self.motionManager startAccelerometerUpdatesToQueue:self.queue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
        [(id) self setAcceleration:accelerometerData.acceleration];
        [self performSelectorOnMainThread:@selector(update) withObject:nil waitUntilDone:NO];
    }];
    
}

// compute the new position of pacman
- (void)update {
    
    NSTimeInterval secondsSinceLastDraw = -([self.lastUpdateTime timeIntervalSinceNow]);
    
    // pacman's new velocity vector depends on the previous velocity vector, the current accelerator vector (from the accelerometer) and the time elapsed since the last calculation
    self.pacmanYVelocity = self.pacmanYVelocity - (self.acceleration.x * secondsSinceLastDraw);
    self.pacmanXVelocity = self.pacmanXVelocity - (self.acceleration.y * secondsSinceLastDraw);
    
    // compute a delta vector with the change to be applied to pacman's current position, based on the time elapsed, the recalculated velocity, and a scaling factor of 500
    CGFloat xDelta = secondsSinceLastDraw * self.pacmanXVelocity * 500;
    CGFloat yDelta = secondsSinceLastDraw * self.pacmanYVelocity * 500;
    
    self.currentPoint = CGPointMake(self.currentPoint.x + xDelta, self.currentPoint.y + yDelta);
    
    // tell pacman to move to his new position by invoking the movePacman method
    [self movePacman];
    
    self.lastUpdateTime = [NSDate date];
}

// change the frame where pacman draws to its new position
- (void)movePacman {
    self.previousPoint = self.currentPoint;
    
    CGRect frame = self.pacman.frame;
    frame.origin.x = self.currentPoint.x;
    frame.origin.y = self.currentPoint.y;
    
    self.pacman.frame = frame;
    
    // rotate the sprite by applying the old angle to the new one
    CGFloat newAngle = (self.pacmanXVelocity + self.pacmanYVelocity) * M_PI * 4;
    self.angle += newAngle * kUpdateInterval;
    
    // create a CABasicAnimation object which will be applied to the rotation of pacman
    CABasicAnimation *rotate;
    rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotate.fromValue = [NSNumber numberWithFloat:0];
    rotate.toValue = [NSNumber numberWithFloat:self.angle];
    rotate.duration = kUpdateInterval;
    rotate.repeatCount = 1;
    rotate.removedOnCompletion = NO;
    rotate.fillMode = kCAFillModeForwards;
    [self.pacman.layer addAnimation:rotate forKey:@"10"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
