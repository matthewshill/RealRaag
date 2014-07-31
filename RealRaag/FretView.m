//
//  FretView.m
//  RealRaag
//
//  Created by Matthew S. Hill on 7/29/14.
//  Copyright (c) 2014 Matthew S. Hill. All rights reserved.
//

#import "FretView.h"

@implementation FretView

NSUInteger *touchCount;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        // Initialization code
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    touchCount = [touches count];
    NSUInteger tapCount = [[touches anyObject] tapCount];
    NSLog(@"touch count: %lu", (unsigned long)touchCount);
    NSLog(@"tap count: %lu", (unsigned long)tapCount);
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    NSUInteger touchCount = [touches count];
    NSLog(@"touch moved count: %lu", (unsigned long)touchCount);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)r  ect
{
    // Drawing code
}
*/

@end
