//
//  ViewController.m
//  RealRaag
//
//  Created by Matthew S. Hill on 7/22/14.
//  Copyright (c) 2014 Matthew S. Hill. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize audioController = _audioController;

- (void)viewDidLoad {
    [super viewDidLoad];

}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.audioController = [AudioController sharedInstance];    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playNoteOn:(UIButton *)b {
    UInt32 note = (UInt32)b.tag;
    UInt32 velocity = 127;
    [self.audioController playNoteOn:note withVelocity:velocity];
}

@end
