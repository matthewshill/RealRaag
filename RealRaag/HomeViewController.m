//
//  HomeViewController.m
//  RealRaag
//
//  Created by Matthew S. Hill on 8/6/14.
//  Copyright (c) 2014 Matthew S. Hill. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //hide nav bar
    self.navigationController.navigationBarHidden = YES;
    //buttons for navigation control

    self.view.backgroundColor = bgColor;
    
    UIImage *border = borderImage;
    UIImageView *borderView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    borderView.image = border;
    [self.view addSubview:borderView];

    //self.logo.font = [UIFont fontWithName:@"Linotype - Pide Nashi LT 1.tff" size:self.logo.font.pointSize];;

    [_historyButton setBackgroundImage:historyButtonImage forState:UIControlStateNormal];
    [_historyButton addTarget:self action:@selector(historyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_historyButton];
    
    [_playButton setBackgroundImage:[UIImage imageNamed:@"Images/playButton"] forState:UIControlStateNormal];
    [_playButton addTarget:self action:@selector(playButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_playButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

-(IBAction)playButtonClicked:(id)sender{
    [self performSegueWithIdentifier:@"gestureSegue" sender:sender];
}

-(IBAction)historyButtonClicked:(id)sender{
    [self performSegueWithIdentifier:@"historySegue" sender:sender];
}

-(IBAction)tutorialButtonClicked:(id)sender{
    [self performSegueWithIdentifier:@"tableView" sender:sender];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
