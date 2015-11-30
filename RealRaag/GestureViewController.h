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
#import "RightPanelTableViewController.h"

@interface GestureViewController : UIViewController

@property (nonatomic) IBOutlet StrumView *strumView;
@property (nonatomic) IBOutlet FretView *fretView;

@property (nonatomic) NSInteger stringOnefret;
@property (nonatomic) NSInteger stringTwofret;
@property (nonatomic) NSInteger stringThreefret;
@property (nonatomic) NSInteger string;
@property (nonatomic) UIImageView *imageView;
@property (nonatomic, copy) NSMutableArray *imageArray;
@property (nonatomic) NSMutableArray *stringOneFretDown;
@property (nonatomic) NSMutableArray *stringTwoFretDown;
@property (nonatomic) NSMutableArray *stringThreeFretDown;
@property (nonatomic) UIImageView *stringOneFretPressedImage;
@property (nonatomic) UIImageView *stringTwoFretPressedImage;
@property (nonatomic) UIImageView *stringThreeFretPressedImage;
@property (nonatomic) UIImageView *stringOneImage;
@property (nonatomic) UIImageView *stringTwoImage;
@property (nonatomic) UIImageView *stringThreeImage;
@property (nonatomic) UIImageView *soundholeImage;

@end

