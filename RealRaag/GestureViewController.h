//
//  GestureViewController.h
//  RealRaag
//
//  Created by Matthew S. Hill on 7/29/14.
//  Copyright (c) 2014 Matthew S. Hill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioController.h"
#import "StrumView.h"
#import "FretView.h"

@interface GestureViewController : UIViewController

@property (nonatomic) IBOutlet StrumView *strumView;
@property (nonatomic) IBOutlet FretView *fretView;
@property (nonatomic) int fret;
@property (nonatomic) NSInteger string;
@property (nonatomic) UIImageView *imageView;

@end

