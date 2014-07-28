//
//  MIDIHelper.m
//  RealRaag
//
//  Created by Matthew S. Hill on 7/28/14.
//  Copyright (c) 2014 Matthew S. Hill. All rights reserved.
//

#import "MIDIHelper.h"

@implementation MIDIHelper

+(NSArray *)notesForScale:(MidiScale)scale register:(MidiRegister)reg{
    NSMutableArray *notesToPlay = [NSMutableArray new];
    
    switch (scale) {
        case MidiScaleCMaj:
        {
            /*if(reg==MidiRegisterFull || reg==MidiRegisterLow)
            {
                [notesToPlay addObject:@(C0)];
                [notesToPlay addObject:@(D0)];
                [notesToPlay addObject:@(E0)];
                [notesToPlay addObject:@(F0)];
                [notesToPlay addObject:@(G0)];
                [notesToPlay addObject:@(A0)];
                [notesToPlay addObject:@(B0)];
            }*/
            if(reg==MidiRegisterFull || reg==MidiRegisterLow)
            {
                [notesToPlay addObject:@(C0)];
                [notesToPlay addObject:@(D0)];
                [notesToPlay addObject:@(E0)];
                [notesToPlay addObject:@(F0)];
                [notesToPlay addObject:@(G0)];
                [notesToPlay addObject:@(A0)];
                [notesToPlay addObject:@(B0)];
                [notesToPlay addObject:@(C1)];
                [notesToPlay addObject:@(D1)];
                [notesToPlay addObject:@(E1)];
                [notesToPlay addObject:@(F1)];
                [notesToPlay addObject:@(G1)];
                [notesToPlay addObject:@(A1)];
                [notesToPlay addObject:@(B1)];
            }
            if(reg==MidiRegisterFull || reg==MidiRegisterLow || reg==MidiRegisterMed)
            {
                [notesToPlay addObject:@(C2)];
                [notesToPlay addObject:@(D2)];
                [notesToPlay addObject:@(E2)];
                [notesToPlay addObject:@(F2)];
                [notesToPlay addObject:@(G2)];
                [notesToPlay addObject:@(A2)];
                [notesToPlay addObject:@(B2)];
            }
            if(reg==MidiRegisterFull || reg==MidiRegisterMed)
            {
                [notesToPlay addObject:@(C3)];
                [notesToPlay addObject:@(D3)];
                [notesToPlay addObject:@(E3)];
                [notesToPlay addObject:@(F3)];
                [notesToPlay addObject:@(G3)];
                [notesToPlay addObject:@(A3)];
                [notesToPlay addObject:@(B3)];
                
            }
            if(reg==MidiRegisterMed || reg==MidiRegisterFull || reg==MidiRegisterHigh)
            {
                [notesToPlay addObject:@(C4)];
                [notesToPlay addObject:@(D4)];
                [notesToPlay addObject:@(E4)];
                [notesToPlay addObject:@(F4)];
                [notesToPlay addObject:@(G4)];
                [notesToPlay addObject:@(A4)];
                [notesToPlay addObject:@(B4)];
            }
            if(reg==MidiRegisterFull || reg==MidiRegisterHigh)
            {
                [notesToPlay addObject:@(C5)];
                [notesToPlay addObject:@(D5)];
                [notesToPlay addObject:@(E5)];
                [notesToPlay addObject:@(F5)];
                [notesToPlay addObject:@(G5)];
                [notesToPlay addObject:@(A5)];
                [notesToPlay addObject:@(B5)];
            }
            if (reg==MidiRegisterFull || reg==MidiRegisterHigh) {
                [notesToPlay addObject:@(C6)];
                [notesToPlay addObject:@(D6)];
                [notesToPlay addObject:@(E6)];
                [notesToPlay addObject:@(F6)];
                [notesToPlay addObject:@(G6)];
                [notesToPlay addObject:@(A6)];
                [notesToPlay addObject:@(B6)];
            }
            if(reg==MidiRegisterFull || reg== MidiRegisterHigh)
            {
                [notesToPlay addObject:@(C7)];
                [notesToPlay addObject:@(D7)];
                [notesToPlay addObject:@(E7)];
                [notesToPlay addObject:@(F7)];
                [notesToPlay addObject:@(G7)];
                [notesToPlay addObject:@(A7)];
                [notesToPlay addObject:@(B7)];
            }
            if(reg==MidiRegisterFull || reg==MidiRegisterHigh)
            {
                [notesToPlay addObject:@(C8)];
                [notesToPlay addObject:@(D8)];
                [notesToPlay addObject:@(E8)];
                [notesToPlay addObject:@(F8)];
                [notesToPlay addObject:@(G8)];
                [notesToPlay addObject:@(A8)];
                [notesToPlay addObject:@(B8)];
            }
        }
            break;
            
        default:
            break;
    }
    
    return notesToPlay;
}

@end
