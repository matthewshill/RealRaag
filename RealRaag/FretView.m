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
        [self setup];
        // Initialization code
    }
    return self;
}
-(id)init{
    self = [super init];
    if (self) {
        [self setup];
        // Initialization code
    }
    return self;
}
-(void)setup{
    self.userInteractionEnabled = YES;
    self.layer.borderColor = [UIColor purpleColor].CGColor;
    self.layer.borderWidth = 2;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    touchCount = [touches count];
    NSUInteger tapCount = [[touches anyObject] tapCount];
    //NSLog(@"touch count: %lu", (unsigned long)touchCount);
    //NSLog(@"tap count: %lu", (unsigned long)tapCount);
    CGPoint startPoint = [[touches anyObject] locationInView:self];
    //NSLog(@"(x,y) = %f %f", startPoint.x, startPoint.y);
    CGFloat height = self.bounds.size.height;
    
    //Fret fretIndex = FretOpen;
    
    NSInteger fretLength = (self.bounds.size.height / 4);
    NSInteger fret = (startPoint.y / fretLength) + 1;
    
    NSInteger stringLength = (self.bounds.size.width / 3);
    NSInteger string = (startPoint.x / stringLength);

    Fret fretIndex = fret;
    
    if(self.delegate){
        [self.delegate fretsPressed:fretIndex stringIndex:string];
    }
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    NSUInteger touchCount = [touches count];
    //NSLog(@"touch moved count: %lu", (unsigned long)touchCount);
    CGPoint startPoint = [[touches anyObject] locationInView:self];

    //Fret fretIndex = FretOpen;
    NSInteger fretLength = (self.bounds.size.height / 4);
    NSInteger fret = (startPoint.y / fretLength) + 1;
    
    NSInteger stringLength = (self.bounds.size.width / 3);
    NSInteger string = (startPoint.x / stringLength);
    
    Fret fretIndex = fret;
    
    if(self.delegate){
        [self.delegate fretsPressed:fretIndex stringIndex:string];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if(self.delegate){
        [self.delegate fretsPressed:FretOpen stringIndex:-1];
    }
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
