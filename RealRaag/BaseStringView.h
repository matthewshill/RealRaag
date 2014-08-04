//
//  BaseStringView.h
//  RealRaag
//
//  Created by Matthew S. Hill on 7/30/14.
//  Copyright (c) 2014 Matthew S. Hill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseStringView : UIView

@property (nonatomic, readonly) CGFloat stringOneStart;
@property (nonatomic, readonly) CGFloat stringOneEnd;
@property (nonatomic, readonly) CGFloat stringTwoStart;
@property (nonatomic, readonly) CGFloat stringTwoEnd;
@property (nonatomic, readonly) CGFloat stringThreeStart;
@property (nonatomic, readonly) CGFloat stringThreeEnd;
@property (nonatomic, readonly) CGFloat fretOneStart;
@property (nonatomic, readonly) CGFloat fretOneEnd;
@property (nonatomic, readonly) CGFloat fretTwoStart;
@property (nonatomic, readonly) CGFloat fretTwoEnd;
@property (nonatomic, readonly) CGFloat fretThreeStart;
@property (nonatomic, readonly) CGFloat fretThreeEnd;

typedef enum {
    FretOpen=-1,
    FretOne,
    FretTwo,
    FretThree,
    FretFour
} Fret;

typedef enum {
    StringOne=0,
    StringTwo,
    StringThree
} String;

@end

