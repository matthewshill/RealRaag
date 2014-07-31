//
//  GestureViewController.m
//  RealRaag
//
//  Created by Matthew S. Hill on 7/29/14.
//  Copyright (c) 2014 Matthew S. Hill. All rights reserved.
//

#import "GestureViewController.h"

@interface GestureViewController () <StrumDelegate>

@end

@implementation GestureViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    _strumView.delegate = self;
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
    if (stringIndex == 0) {
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
    }
}

-(void)fretsPressed:(NSInteger)fretIndex{
    
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
