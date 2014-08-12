//
//  RaagViewController.m
//  RealRaag
//
//  Created by Matthew S. Hill on 8/8/14.
//  Copyright (c) 2014 Matthew S. Hill. All rights reserved.
//

#import "RaagViewController.h"

@interface RaagViewController ()

@end

@implementation RaagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _yemanButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_yemanButton setTitle:@"Yeman" forState:UIControlStateNormal];
    _yemanButton.frame = CGRectMake(80.0, 155.0, 160, 40);
    [[_yemanButton layer] setBorderWidth:2.0];
    [[_yemanButton layer] setBorderColor:[UIColor blueColor].CGColor];
    [self.view addSubview:_yemanButton];
    
    _kesturiButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_kesturiButton setTitle:@"Kesturi" forState:UIControlStateNormal];
    _kesturiButton.frame = CGRectMake(80.0, 205.0, 160, 40);
    [[_kesturiButton layer] setBorderWidth:2.0];
    [[_kesturiButton layer] setBorderColor:[UIColor blueColor].CGColor];
    [self.view addSubview:_kesturiButton];
    
    _asaButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_asaButton setTitle:@"Asa" forState:UIControlStateNormal];
    _asaButton.frame = CGRectMake(80.0, 255.0, 160, 40);
    [[_asaButton layer] setBorderWidth:2.0];
    [[_asaButton layer] setBorderColor:[UIColor blueColor].CGColor];
    [self.view addSubview:_asaButton];
    
    _bhairaviButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_bhairaviButton setTitle:@"Bhairavi" forState:UIControlStateNormal];
    _bhairaviButton.frame = CGRectMake(80.0, 305.0, 160, 40);
    [[_bhairaviButton layer] setBorderWidth:2.0];
    [[_bhairaviButton layer] setBorderColor:[UIColor blueColor].CGColor];
    [self.view addSubview:_bhairaviButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden{
    return YES;
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
