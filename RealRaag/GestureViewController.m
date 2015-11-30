//
//  GestureViewController.m
//  RealRaag
//
//  Created by Matthew S. Hill on 7/29/14.
//  Copyright (c) 2014 Matthew S. Hill. All rights reserved.
//

#import "GestureViewController.h"

@interface GestureViewController () <StrumDelegate, FretDelegate>
@property RightPanelTableViewController *rightPanelTable;
@property UIActionSheet *popUp;
@end

@implementation GestureViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.navigationItem.title = @"Free Play";
    
    NSInteger fret_height = (self.view.bounds.size.height + 10) / 5;
    NSInteger fret_width = (self.view.bounds.size.width / 3) + 1;
    
    
    _imageArray = [[NSMutableArray alloc] init];
    _stringOneFretDown = [[NSMutableArray alloc] init];
    _stringTwoFretDown = [[NSMutableArray alloc] init];
    _stringThreeFretDown = [[NSMutableArray alloc] init];
    
    //setup fretboard images
    
    for (int string = 0; string < 3; string++) {
        for(int fret = 0; fret < 5; fret++){
            CGRect rect = CGRectMake(string * fret_width, (fret_height * fret) + (fret + 5), fret_width, fret_height);
            _imageView = [[UIImageView alloc] initWithFrame:rect];
            [_imageView setImage:[self getFretFileName:(fret + (string * 10))]];
            [self.view addSubview:_imageView];
            _imageView.userInteractionEnabled = YES;
            [_imageArray addObject:_imageView];
        }
    }

    
    //setup string images
    _stringOneImage = [[UIImageView alloc] initWithFrame:[self frameForRestingStringAtIndex:0]];
    [_stringOneImage setImage:kStringImage];
    [self.view addSubview:_stringOneImage];
    
    _stringTwoImage = [[UIImageView alloc] initWithFrame:[self frameForRestingStringAtIndex:1]];
    [_stringTwoImage setImage:kStringImage];
    [self.view addSubview:_stringTwoImage];
    
    _stringThreeImage = [[UIImageView alloc] initWithFrame:[self frameForRestingStringAtIndex:2]];
    [_stringThreeImage setImage:kStringImage];
    [self.view addSubview:_stringThreeImage];

    //set up three hidden images
    _stringOneFretPressedImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, fret_width, fret_height)];
    [_stringOneFretPressedImage setImage:kImageFretHighlight];
    _stringOneFretPressedImage.hidden = YES;
    [self.view addSubview:_stringOneFretPressedImage];
    _stringTwoFretPressedImage = [[UIImageView alloc] initWithFrame:CGRectMake(fret_width, 44, fret_width, fret_height)];
    [_stringTwoFretPressedImage setImage:kImageFretHighlight];
    _stringTwoFretPressedImage.hidden = YES;
    [self.view addSubview:_stringTwoFretPressedImage];
    _stringThreeFretPressedImage = [[UIImageView alloc] initWithFrame:CGRectMake(2 * fret_width, 44, fret_width, fret_height)];
    [_stringThreeFretPressedImage setImage:kImageFretHighlight];
    _stringThreeFretPressedImage.hidden = YES;
    [self.view addSubview:_stringThreeFretPressedImage];
    
    //set up custom UIViews
    self.fretView = [FretView new];
    self.strumView = [StrumView new];
    [self.view addSubview:_fretView];
    [self.view addSubview:_strumView];
    NSDictionary *viewsDict = @{@"fret":_fretView, @"strum":_strumView};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-44-[fret]-0-[strum(110)]-0-|" options:0 metrics:nil views:viewsDict]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[fret]-0-|" options:0 metrics:nil views:viewsDict]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[strum]-0-|" options:0 metrics:nil views:viewsDict]];
    
    _strumView.translatesAutoresizingMaskIntoConstraints = NO;
    _fretView.translatesAutoresizingMaskIntoConstraints  = NO;
    _strumView.delegate = self;
    _fretView.delegate  = self;
    
    //add right panel navigation
    /*_rightPanelTable = [RightPanelTableViewController new];
    [self addChildViewController:_rightPanelTable];
    [self.view addSubview:_rightPanelTable.tableView];
    [_rightPanelTable.tableView setFrame:CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [UIView animateWithDuration:1 animations:^{
        [_rightPanelTable.tableView setFrame:self.view.bounds];
    }];*/
    

    //add navigation button
    UIButton *raagNavButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [raagNavButton setImage:[UIImage imageNamed:@"raagNavButton.jpg"] forState:UIControlStateNormal];
    [raagNavButton sizeToFit];
    [raagNavButton addTarget:self action:@selector(raagButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:raagNavButton];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    _popUp = [[UIActionSheet alloc] initWithTitle:@"Tutorial" delegate:_popUp.delegate cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"How To Play",@"Yeman",@"Kesturi",@"Asa", @"Bhairavi", @"Excercises", nil];
    _popUp.tag = 1;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]){
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}
-(UIImage *)getFretFileName:(int)i{
    NSString *fileName = [NSString stringWithFormat: @"%@%i", kFretFileName, i + 1];
    NSLog(@"%@", fileName);
    return [UIImage imageNamed:fileName];
}
-(void)raagButtonClicked{
    NSLog(@"CLICKED");
    /*[UIView animateWithDuration:0.05f animations:^{
        CGFloat x = self.view.bounds.size.width - _rightPanelTable.tableView.bounds.size.width;
        [_rightPanelTable.tableView setFrame:CGRectMake(x, 0, _rightPanelTable.tableView.bounds.size.width, _rightPanelTable.tableView.bounds.size.height)];
    }];*/
    [_popUp showInView:self.view];
}

-(CGFloat)xForStringAtIndex:(NSInteger)stringIndex{
    return self.view.bounds.size.width/6.f + 2.f*stringIndex*self.view.bounds.size.width/6.f - STRING_WIDTH/2.f;
}

-(CGRect)frameForRestingStringAtIndex:(NSInteger)stringIndex{
    return CGRectMake([self xForStringAtIndex:stringIndex], 0.f, STRING_WIDTH, self.view.bounds.size.height);
}

-(void)animateString:(NSInteger)stringIndex downStroke:(BOOL)downStroke{
    UIView *viewToAnimate;
    CGRect finalView = [self frameForRestingStringAtIndex:stringIndex];
    switch (stringIndex) {
        case 0:
            viewToAnimate = _stringOneImage;
            break;
        case 1:
            viewToAnimate = _stringTwoImage;
            break;
        case 2:
            viewToAnimate = _stringThreeImage;
            break;
        default:
            break;
    }
    
    //animation
    [UIView animateWithDuration:0.05f animations:^{
        [viewToAnimate setFrame:CGRectOffset(finalView, downStroke ? 5.f : -5.f, 0)];
    }];
    [UIView animateWithDuration:1.f delay:0.05f usingSpringWithDamping:.08f initialSpringVelocity:30.0f options:UIViewAnimationOptionTransitionNone animations:^{
        [viewToAnimate setFrame:finalView];
    } completion:nil];
}

-(void)stringHit:(NSInteger)stringIndex{
    NSInteger note = 0;
    switch (stringIndex) {
        case 0:
            if (self.stringOnefret > 0) {
                note = (3048 + (2 * self.stringOnefret));
                if (self.stringOnefret == 3 || self.stringOnefret == 4) {
                    note--;
                }
                [[AudioController sharedInstance] playNoteOn:note];
            }
            else{
                [[AudioController sharedInstance] playNoteOn:3048];
            }
            break;
        case 1:
            if (self.stringTwofret > 0) {
                note = (2048 + (2 * self.stringTwofret));
                if (self.stringTwofret == 3 || self.stringTwofret == 4) {
                    note--;
                }
                [[AudioController sharedInstance] playNoteOn:note];
            }
            else{
                [[AudioController sharedInstance] playNoteOn:2048];
            }
            break;
        case 2:
            if(self.stringThreefret > 0){
                note = (1048 + (2 * self.stringThreefret));
                if (self.stringThreefret == 3 || self.stringThreefret ==4) {
                    note--;
                }
                [[AudioController sharedInstance] playNoteOn:note];
            }
            else{
                [[AudioController sharedInstance] playNoteOn:1048];
            }
            break;
        case 3:
            if (self.stringOnefret > 0) {
                note = (4048 + (2 * self.stringOnefret));
                if (self.stringOnefret == 3 || self.stringOnefret == 4) {
                    note--;
                }
                [[AudioController sharedInstance] playNoteOn:note];
            }
            else{
                [[AudioController sharedInstance] playNoteOn:4048];
            }
            break;
        case 4:
            if (self.stringTwofret > 0) {
                note = (5048 + (2 * self.stringTwofret));
                if (self.stringTwofret == 3 || self.stringTwofret == 4) {
                    note--;
                }
                [[AudioController sharedInstance] playNoteOn:note];
            }
            else{
                [[AudioController sharedInstance] playNoteOn:5048];
            }
            break;
        case 5:
            if (self.stringThreefret > 0) {
                note = (6048 + (2 * self.stringThreefret));
                if(self.stringThreefret == 3 || self.stringThreefret == 4){
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
    
    if(stringIndex > -1){
        [self animateString:stringIndex%3 downStroke: stringIndex<3];
    }
    //NSLog(@"(fret, string) %ld %ld", (long)self.fret, (long)self.string);
    //NSLog(@"string index: %ld", (long)stringIndex);
}

-(void)fretsPressed:(Fret)fretIndex stringIndex:(NSInteger)stringIndex{
    self.string = stringIndex;
    NSLog(@"TOUCHEDD");
    
    NSLog(@"fret touched: %d %ld", fretIndex, (long)stringIndex);
    NSInteger fret_height = (self.view.bounds.size.height - (STRUM_HEIGHT) - 44) / 4;
    
    //determine which frets are down on each string
    switch (stringIndex) {
        case -1:
            _stringOneFretPressedImage.hidden = YES;
            _stringTwoFretPressedImage.hidden = YES;
            _stringThreeFretPressedImage.hidden = YES;
            self.stringThreefret = fretIndex;
            self.stringTwofret = fretIndex;
            self.stringOnefret = fretIndex;
            [_stringOneFretDown removeLastObject];
            [_stringTwoFretDown removeLastObject];
            [_stringThreeFretDown removeLastObject];
        case 0:
            if ([_stringOneFretDown containsObject:@(fretIndex)]) {
                if (fretIndex > self.stringOnefret) {
                    self.stringOnefret = fretIndex;
                    _stringOneFretPressedImage.center = CGPointMake(52, fretIndex * fret_height);
                    _stringOneFretPressedImage.hidden = NO;
                }
                //self.stringOnefret = fretIndex;
                //_stringOneFretPressedImage.center = CGPointMake(52, fretIndex * fret_height);
                //_stringOneFretPressedImage.hidden = NO;
                return;
            }
            else if(fretIndex == -1){
                [_stringOneFretDown removeLastObject];
                self.stringOnefret = 0;
                _stringOneFretPressedImage.hidden = YES;
            }
            else{
                [_stringOneFretDown addObject:@(fretIndex)];
                self.stringOnefret = fretIndex;
                _stringOneFretPressedImage.center = CGPointMake(52, fretIndex * fret_height);
                _stringOneFretPressedImage.hidden = NO;
            }
            break;
        case 1:
            if ([_stringTwoFretDown containsObject:@(fretIndex)]) {
                self.stringTwofret = fretIndex;
                _stringTwoFretPressedImage.center = CGPointMake(160, fretIndex * fret_height);
                _stringTwoFretPressedImage.hidden = NO;
                return;
            }
            else if(fretIndex == -1){
                [_stringTwoFretDown removeLastObject];
                self.stringTwofret = 0;
                _stringTwoFretPressedImage.hidden = YES;
            }
            else{
                [_stringTwoFretDown addObject:@(fretIndex)];
                self.stringTwofret = fretIndex;
                _stringTwoFretPressedImage.center = CGPointMake(160, fretIndex * fret_height);
                _stringTwoFretPressedImage.hidden = NO;
            }
            break;
        case 2:
            if ([_stringThreeFretDown containsObject:@(fretIndex)]) {
                self.stringThreefret = fretIndex;
                _stringThreeFretPressedImage.center = CGPointMake(268, fretIndex * fret_height);
                _stringThreeFretPressedImage.hidden = NO;
                return;
            }
            else if(fretIndex == -1){
                [_stringThreeFretDown removeLastObject];
                self.stringThreefret = 0;
                _stringThreeFretPressedImage.hidden = YES;
            }
            else{
                [_stringThreeFretDown addObject:@(fretIndex)];
                self.stringThreefret = fretIndex;
                _stringThreeFretPressedImage.center = CGPointMake(268, fretIndex * fret_height);
                _stringThreeFretPressedImage.hidden = NO;
            }
            break;
        default:
            break;
    }
    
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
