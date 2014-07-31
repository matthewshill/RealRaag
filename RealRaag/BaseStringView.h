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

@end
