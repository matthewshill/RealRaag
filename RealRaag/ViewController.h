//
//  ViewController.h
//  RealRaag
//
//  Created by Matthew S. Hill on 7/22/14.
//  Copyright (c) 2014 Matthew S. Hill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioController.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) AudioController *audioController;

- (IBAction)playNoteOn:(UIButton *)b;

@end

