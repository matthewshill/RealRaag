//
//  GestureViewController.m
//  RealRaag
//
//  Created by Matthew S. Hill on 7/29/14.
//  Copyright (c) 2014 Matthew S. Hill. All rights reserved.
//

#import "GestureViewController.h"

@interface GestureViewController () <StrumDelegate, FretDelegate>
@end

@implementation GestureViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    _strumView.delegate = self;
    _fretView.delegate  = self;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)stringHit:(NSInteger)stringIndex{
    /*if (stringIndex == 0) {
        [[AudioController sharedInstance] playNoteOn:3048];
    }
    if (stringIndex == 1) {
        [[AudioController sharedInstance] playNoteOn:2048];
    }
    if (stringIndex == 2) {
        [[AudioController sharedInstance] playNoteOn:1048];
    }
    if (stringIndex == 3) {
        [[AudioController sharedInstance] playNoteOn:4048];
    }
    if (stringIndex == 4) {
        [[AudioController sharedInstance] playNoteOn:5048];
    }
    if (stringIndex == 5) {
        [[AudioController sharedInstance] playNoteOn:6048];
    }*/
    NSInteger note = 0;
    switch (stringIndex) {
        case 0:
            if (self.string == 0) {
                note = (3048 + (2 * self.fret));
                if (self.fret == 3 || self.fret == 4) {
                    note--;
                }
                [[AudioController sharedInstance] playNoteOn:note];
            }
            else{
                [[AudioController sharedInstance] playNoteOn:3048];
            }
            break;
        case 1:
            if (self.string == 1) {
                note = (2048 + (2 * self.fret));
                if (self.fret == 3 || self.fret == 4) {
                    note--;
                }
                [[AudioController sharedInstance] playNoteOn:note];
            }
            else{
                [[AudioController sharedInstance] playNoteOn:2048];
            }
            break;
        case 2:
            if(self.string == 2){
                note = (1048 + (2 * self.fret));
                if (self.fret == 3 || self.fret ==4) {
                    note--;
                }
                [[AudioController sharedInstance] playNoteOn:note];
            }
            else{
                [[AudioController sharedInstance] playNoteOn:1048];
            }
            break;
        case 3:
            if (self.string == 0) {
                note = (4048 + (2 * self.fret));
                if (self.fret == 3 || self.fret == 4) {
                    note--;
                }
                [[AudioController sharedInstance] playNoteOn:note];
            }
            else{
                [[AudioController sharedInstance] playNoteOn:4048];
            }
            break;
        case 4:
            if (self.string == 1) {
                note = (5048 + (2 * self.fret));
                if (self.fret == 3 || self.fret == 4) {
                    note--;
                }
                [[AudioController sharedInstance] playNoteOn:note];
            }
            else{
                [[AudioController sharedInstance] playNoteOn:5048];
            }
            break;
        case 5:
            if (self.string == 2) {
                note = (6048 + (2 * self.fret));
                if(self.fret == 3 || self.fret == 4){
                    note--;
                }
                [[AudioController sharedInstance] playNoteOn:note];
            }
            else{
                [[AudioController sharedInstance] playNoteOn:6048];
            }
            break;
            
        default:
            break;
    }
    
    NSLog(@"(fret, string) %d %d", self.fret, self.string);
    NSLog(@"string index: %d", stringIndex);
}

-(void)fretsPressed:(Fret)fretIndex stringIndex:(NSInteger)stringIndex{
    [self setFret:fretIndex setString:stringIndex];
}

-(void)setFret:(NSInteger)fret setString:(NSInteger)string{
    self.fret =  fret;
    self.string = string;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
