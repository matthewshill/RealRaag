//
//  StrumView.m
//  RealRaag
//
//  Created by Matthew S. Hill on 7/29/14.
//  Copyright (c) 2014 Matthew S. Hill. All rights reserved.
//

#import "StrumView.h"

@implementation StrumView

@synthesize startPoint = _startPoint;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *theTouch = [touches anyObject];
    self.startPoint = [theTouch locationInView:self];
    NSLog(@"(x,y) = %f %f", self.startPoint.x, self.startPoint.y);
    NSInteger stringIndex = -1;

    if (self.startPoint.x > [self stringOneStart] && self.startPoint.x < [self stringOneEnd]) {
        stringIndex = 0;
    }
    
    if (self.startPoint.x > [self stringTwoStart] && self.startPoint.x < [self stringTwoEnd]) {
        stringIndex = 1;
    }
    
    if (self.startPoint.x > [self stringThreeStart] && self.startPoint.x < [self stringThreeEnd]) {
        stringIndex = 2;
    }
    
    if (self.delegate) {
        [self.delegate stringHit:stringIndex];
    }
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    NSInteger stringIndex = -1;
    CGPoint location = [[touches anyObject] locationInView:self];
    CGPoint prevLocation = [[touches anyObject] previousLocationInView:self];
    
    //1st String Up Stroke
    if(prevLocation.x > [self stringOneEnd] && location.x < [self stringOneStart]){
        stringIndex = 3;
    }
    //1st String Down Stroke
    if(prevLocation.x < [self stringOneStart] && location.x > [self stringOneEnd]){
        stringIndex = 0;
    }
    //2nd String Up Stroke
    if(prevLocation.x > [self stringTwoEnd] && location.x < [self stringTwoStart]){
        stringIndex = 4;
    }
    //2nd String Down Stroke
    if(prevLocation.x < [self stringTwoStart] && location.x > [self stringTwoEnd]){
        stringIndex = 1;
    }
    //3rd String Up Stroke
    if(prevLocation.x > [self stringThreeEnd] && location.x < [self stringThreeStart]){
        stringIndex = 5;
    }
    //3rd String Down Stroke
    if(prevLocation.x < [self stringThreeStart] && location.x > [self stringThreeEnd]){
        stringIndex = 2;
    }
    
    if (self.delegate) {
        [self.delegate stringHit:stringIndex];
    }
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
