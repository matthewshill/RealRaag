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
@synthesize imageView;
@synthesize imageArray;
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSInteger fret_height = (self.view.bounds.size.height - (STRUM_HEIGHT + 64)) / 4;
    NSInteger fret_width = self.view.bounds.size.width / 3;
    imageArray = [[NSMutableArray alloc] init];
    
    for (int string = 0; string < 3; string++) {
        for(int fret = 0; fret < 4; fret++){
            CGRect rect = CGRectMake(string * fret_width, fret_height * fret + 64, fret_width, fret_height);
            imageView = [[UIImageView alloc] initWithFrame:rect];
            [imageView setImage:[UIImage imageNamed:@"fret.jpg"]];
            [self.view addSubview:imageView];
            imageView.userInteractionEnabled = YES;
            [imageArray addObject:imageView];
        }
    }
    
    self.fretView = [FretView new];
    self.strumView = [StrumView new];
    [self.view addSubview:_fretView];
    [self.view addSubview:_strumView];
    NSDictionary *viewsDict = @{@"fret":_fretView, @"strum":_strumView};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-64-[fret]-0-[strum(108)]-0-|" options:0 metrics:nil views:viewsDict]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[fret]-0-|" options:0 metrics:nil views:viewsDict]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[strum]-0-|" options:0 metrics:nil views:viewsDict]];
    
    _strumView.translatesAutoresizingMaskIntoConstraints = NO;
    _fretView.translatesAutoresizingMaskIntoConstraints  =NO;
    _strumView.delegate = self;
    _fretView.delegate  = self;
    //[_fretView setBackgroundColor:[UIColor clearColor]];
    
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
    
    NSLog(@"(fret, string) %d %ld", self.fret, (long)self.string);
    NSLog(@"string index: %ld", (long)stringIndex);
}

-(void)fretsPressed:(Fret)fretIndex stringIndex:(NSInteger)stringIndex{
    [self setFret:fretIndex setString:stringIndex];
    NSLog(@"TOUCHEDD");
    
    NSLog(@"fret touched: %d %d", fretIndex, stringIndex);

    for(UIImageView *image in imageArray){
        CGFloat f = floor(image.frame.origin.y / image.bounds.size.height) + 1;
        CGFloat s = floor(image.frame.origin.x / 100);
        if (f==fretIndex && s==stringIndex) {
            [image setImage:[UIImage imageNamed:@"fretPressed.jpg"]];
        }
        else{
            [image setImage:[UIImage imageNamed:@"fret.jpg"]];
        }
    }

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
