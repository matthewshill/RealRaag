//
//  BaseStringView.m
//  RealRaag
//
//  Created by Matthew S. Hill on 7/30/14.
//  Copyright (c) 2014 Matthew S. Hill. All rights reserved.
//

#import "BaseStringView.h"

@implementation BaseStringView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
 @property (nonatomic, readonly) CGFloat *stringOneStart;
 @property (nonatomic, readonly) CGFloat *stringOneEnd;
 @property (nonatomic, readonly) CGFloat *stringTwoStart;
 @property (nonatomic, readonly) CGFloat *stringTwoEnd;
 @property (nonatomic, readonly) CGFloat *stringThreeStart;
 @property (nonatomic, readonly) CGFloat *stringThreeEnd;

}
*/

-(CGFloat)stringOneStart{
    return (SCREEN_WIDTH / 4) - (STRING_WIDTH / 2);
}

-(CGFloat)stringOneEnd{
    return (SCREEN_WIDTH / 4) + (STRING_WIDTH / 2);
}

-(CGFloat)stringTwoStart{
    return ((SCREEN_WIDTH / 4) * 2) - (STRING_WIDTH / 2);
}

-(CGFloat)stringTwoEnd{
    return ((SCREEN_WIDTH / 4) * 2) + (STRING_WIDTH / 2);
}

-(CGFloat)stringThreeStart{
    return ((SCREEN_WIDTH / 4) * 3) - (STRING_WIDTH / 2);
}

-(CGFloat)stringThreeEnd{
    return ((SCREEN_WIDTH / 4) * 3) + (STRING_WIDTH / 2);
}

@end
