//
//  PhotoViewController.m
//  RealRaag
//
//  Created by Matthew S. Hill on 8/7/14.
//  Copyright (c) 2014 Matthew S. Hill. All rights reserved.
//

#import "PhotoViewController.h"

@interface PhotoViewController ()

@property (nonatomic) UIImageView *imageView;

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"X" forState:UIControlStateNormal];
    [cancelButton setFrame:CGRectMake(self.view.bounds.size.width-40.f, 0.0f, 56.0f, 44.0f)];
    [cancelButton setAutoresizingMask:(UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleBottomMargin)];
    [cancelButton addTarget:self action:@selector(cancelPhotoView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    
}

-(void)setImageToDisplay:(UIImage *)imageToDisplay{
    _imageToDisplay = imageToDisplay;
    if(!_imageView){
        CGRect rect = CGRectMake(0, 30, self.view.bounds.size.width, self.view.bounds.size.height-40);
        _imageView = [[UIImageView alloc] initWithFrame:rect];
        // Alternative to verbose autolayout
        [_imageView setAutoresizingMask:(UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth)];
        [_imageView setContentMode:UIViewContentModeScaleToFill];
        [self.view addSubview:_imageView];
    }
    [_imageView setImage:_imageToDisplay];
}

-(void)cancelPhotoView{
    NSLog(@"TOUCHED");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden{
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
