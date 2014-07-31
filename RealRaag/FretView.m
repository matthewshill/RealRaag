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
    //NSLog(@"touch count: %lu", (unsigned long)touchCount);
    //NSLog(@"tap count: %lu", (unsigned long)tapCount);
    CGPoint startPoint = [[touches anyObject] locationInView:self];
    //NSLog(@"(x,y) = %f %f", startPoint.x, startPoint.y);
    CGFloat height = self.bounds.size.height;
    //NSLog(@"screen height: %f", height);
    
    if (startPoint.y < [self fretOneStart] && startPoint.x < [self stringOneStart]) {
        NSLog(@"FRET ONE - STRING ONE");
    }
    if ((startPoint.y > [self fretOneEnd] && startPoint.y < [self fretTwoStart]) && startPoint.x < [self stringOneStart]) {
        NSLog(@"FRET TWO - STRING ONE");
    }
    if ((startPoint.y > [self fretTwoEnd] && startPoint.y < [self fretThreeStart]) && startPoint.x < [self stringOneStart]) {
        NSLog(@"FRET THREE - STRING ONE");
    }
    if((startPoint.y > [self fretThreeEnd]) && startPoint.x < [self stringOneStart]){
        NSLog(@"FRET FOUR - STRING ONE");
    }
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    NSUInteger touchCount = [touches count];
    //NSLog(@"touch moved count: %lu", (unsigned long)touchCount);
    CGPoint startPoint = [[touches anyObject] locationInView:self];
    //NSLog(@"(x,y) = %f %f", startPoint.x, startPoint.y);
    /*if (startPoint.y < [self fretOneStart]) {
        NSLog(@"FRET ONE");
    }
    if (startPoint.y > [self fretOneEnd] && startPoint.y < [self fretTwoStart]) {
        NSLog(@"FRET TWO");
    }
    if (startPoint.y > [self fretTwoEnd] && startPoint.y < [self fretThreeStart]) {
        NSLog(@"FRET THREE");
    }
    if(startPoint.y > [self fretThreeEnd]){
        NSLog(@"FRET FOUR");
    }*/
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
