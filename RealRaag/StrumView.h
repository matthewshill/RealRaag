//
//  StrumView.h
//  RealRaag
//
//  Created by Matthew S. Hill on 7/29/14.
//  Copyright (c) 2014 Matthew S. Hill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioController.h"
#import "BaseStringView.h"

@protocol StrumDelegate <NSObject>

-(void)stringHit:(NSInteger)stringIndex;

@end

@interface StrumView : BaseStringView

@property CGPoint startPoint;
@property (nonatomic, weak) id <StrumDelegate> delegate;

@end
