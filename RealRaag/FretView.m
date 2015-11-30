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
    self.multipleTouchEnabled = YES;
    _stringOneTouches = [[NSMutableArray alloc] init];
    _stringTwoTouches = [[NSMutableArray alloc] init];
    _stringThreeTouches = [[NSMutableArray alloc] init];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSUInteger tapCount = [[touches anyObject] tapCount];
    CGPoint startPoint = [[touches anyObject] locationInView:self];
    
    NSInteger fretLength = (self.bounds.size.height / 4);
    NSInteger fret = (startPoint.y / fretLength) + 1;
    
    NSInteger stringLength = (self.bounds.size.width / 3);
    NSInteger string = (startPoint.x / stringLength);

    Fret fretIndex = fret;
    
    //check which fret is touched
    switch (string) {
        case 0:
            [_stringOneTouches addObject:touches];
            break;
        case 1:
            [_stringTwoTouches addObject:touches];
            break;
        case 2:
            [_stringThreeTouches addObject:touches];
            break;
        default:
            break;
    }
    
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
    
    if ([_stringOneTouches containsObject:touches] && string != 0) {
        
        if (string == 1) {
            [_stringTwoTouches addObject:touches];
        }
        if (string == 2){
            [_stringThreeTouches addObject:touches];
        }
        [_stringOneTouches removeObject:touches];
    }

    if([_stringTwoTouches containsObject:touches] && string != 1) {
        if (string == 0) {
            [_stringOneTouches addObject:touches];
        }
        if (string == 2) {
            [_stringThreeTouches addObject:touches];
        }
        [_stringTwoTouches removeObject:touches];
    }
    
    if([_stringThreeTouches containsObject:touches] && string != 2){
        if(string == 0){
            [_stringOneTouches addObject:touches];
        }
        if(string == 1){
            [_stringTwoTouches addObject:touches];
        }
        [_stringThreeTouches removeObject:touches];
    }
    
    if(self.delegate && fretIndex < 5){
        [self.delegate fretsPressed:fretIndex stringIndex:string];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    int string = -1;
    
    if([_stringOneTouches containsObject:touches]){
        [_stringOneTouches removeObject:touches];
        string = 0;
    }
    if([_stringTwoTouches containsObject:touches]){
        [_stringTwoTouches removeObject:touches];
        string = 1;
    }
    if([_stringThreeTouches containsObject:touches]){
        [_stringThreeTouches removeObject:touches];
        string = 2;
    }
    
    if(self.delegate){
        [self.delegate fretsPressed:FretOpen stringIndex:string];
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
