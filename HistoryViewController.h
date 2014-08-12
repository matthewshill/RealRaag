//
//  HistoryViewController.h
//  RealRaag
//
//  Created by Matthew S. Hill on 8/6/14.
//  Copyright (c) 2014 Matthew S. Hill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoViewController.h"

@interface HistoryViewController : UIViewController

@property (strong, nonatomic) UIImageView *rubabImage;
@property (nonatomic) UITextView *historyText;
@property (nonatomic, strong) UIScrollView *scrollView;

@end
