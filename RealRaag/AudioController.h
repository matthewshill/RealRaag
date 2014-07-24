//
//  AudioController.h
//  RealRaag
//
//  Created by Matthew S. Hill on 7/22/14.
//  Copyright (c) 2014 Matthew S. Hill. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <CoreAudio/CoreAudioTypes.h>

@interface AudioController : NSObject

- (void) playNoteOn:(UInt32) noteNum withVelocity:(UInt32) velocity;
+ (AudioController *)sharedInstance;
@end
