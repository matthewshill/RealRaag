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

-(CGFloat)fretOneStart{
    return (317 / 4) - (STRING_WIDTH / 2);
}

-(CGFloat)fretOneEnd{
    return (317 / 4) + (STRING_WIDTH / 2);
}

-(CGFloat)fretTwoStart{
    return ((317 / 4) * 2) - (STRING_WIDTH / 2);
}

-(CGFloat)fretTwoEnd{
    return ((317 / 4) * 2) + (STRING_WIDTH / 2);
}

-(CGFloat)fretThreeStart{
    return ((317 / 4) * 3) - (STRING_WIDTH / 2);
}

-(CGFloat)fretThreeEnd{
    return ((317 / 4) * 3) + (STRING_WIDTH / 2);
}


@end
