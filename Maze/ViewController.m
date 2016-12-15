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
    CGPoint target2 = CGPointMake(self.ghost2.center.x, self.ghost2.center.y-284);
    
    CABasicAnimation *bounce2 = [CABasicAnimation animationWithKeyPath:@"position.y"];
    bounce2.fromValue = [NSNumber numberWithInt:origin2.y];
    bounce2.toValue = [NSNumber numberWithInt:target2.y];
    bounce2.duration = 2;
    bounce2.autoreverses = YES;
    bounce2.repeatCount = HUGE_VALF;
    
    [self.ghost2.layer addAnimation:bounce2 forKey:@"position"];
    
    // define the start and end points of the animation for ghost3
    CGPoint origin3 = self.ghost3.center;
    CGPoint target3 = CGPointMake(self.ghost3.center.x, self.ghost3.center.y+284);
    
    CABasicAnimation *bounce3 = [CABasicAnimation animationWithKeyPath:@"position.y"];
    bounce3.fromValue = [NSNumber numberWithInt:origin3.y];
    bounce3.toValue = [NSNumber numberWithInt:target3.y];
    bounce3.duration = 2;
    bounce3.autoreverses = YES;
    bounce3.repeatCount = HUGE_VALF;
    
    [self.ghost3.layer addAnimation:bounce3 forKey:@"position"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
