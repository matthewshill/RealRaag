//
//  ViewController.m
//  RealRaag
//
//  Created by Matthew S. Hill on 7/22/14.
//  Copyright (c) 2014 Matthew S. Hill. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
       
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playNoteOn:(UIButton *)b {
    [[AudioController sharedInstance] playNoteOn:b.tag];
}


@end
