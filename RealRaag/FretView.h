//
//  FretView.h
//  RealRaag
//
//  Created by Matthew S. Hill on 7/29/14.
//  Copyright (c) 2014 Matthew S. Hill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "BaseStringView.h"

@protocol FretDelegate <NSObject>

-(void)fretsPressed:(Fret)fretIndex stringIndex:(NSInteger)stringIndex;

@end

@interface FretView : BaseStringView
@property (nonatomic, weak) id <FretDelegate> delegate;
@end
