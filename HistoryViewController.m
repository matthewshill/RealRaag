//
//  HistoryViewController.m
//  RealRaag
//
//  Created by Matthew S. Hill on 8/6/14.
//  Copyright (c) 2014 Matthew S. Hill. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = bgColor;
    
    UIImage *border = borderImage;
    UIImageView *borderView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    borderView.image = border;
    [self.view addSubview:borderView];
    
    //self.navigationController.navigationBarHidden = YES;
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    _scrollView.contentSize = CGSizeMake(320, 900);
    [self.view addSubview:_scrollView];
    /*
    CGRect rect = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height/2);
    _rubabImage = [[UIImageView alloc] initWithFrame:rect];
    [_rubabImage setImage:[UIImage imageNamed:@"rubab1.jpg"]];
    [_rubabImage setUserInteractionEnabled:YES];
    //[self.view addSubview:_rubabImage];
    [_scrollView addSubview:_rubabImage];
    
    UIButton *b = [[UIButton alloc]
                   initWithFrame:CGRectMake(0, 0, _rubabImage.frame.size.width, _rubabImage.frame.size.height)];
    b.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [b addTarget:self action:@selector(imageTapped:) forControlEvents:UIControlEventTouchUpInside];
    [b setTag:_rubabImage.tag];
    [_rubabImage addSubview:b];
    */
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"rubabHistory" ofType:@"txt"];
    NSError *error;
    NSLog(@"file path: %@", filePath);
    NSString *fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSASCIIStringEncoding error:&error];
    NSAttributedString *text = [[NSAttributedString alloc] initWithString:fileContents
                                                               attributes:@{NSFontAttributeName:[UIFont fontWithName:@"HoeflerText-Italic" size:14]}];
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:text];
    NSLayoutManager *textLayout = [[NSLayoutManager alloc] init];
    //add layout manager to text storage object
    [textStorage addLayoutManager:textLayout];
    //CGSize textContainerSize = self.view.bounds.size;
    //textContainerSize.height = textContainerSize.height + 64;
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(320, 640)];
    //add text view container to layout
    [textLayout addTextContainer:textContainer];
    //UITextView object using text container
    _historyText = [[UITextView alloc] initWithFrame:CGRectMake(35, self.view.bounds.size.height/3, 230, 600) textContainer:textContainer];
    _historyText.backgroundColor = bgColor;
    [_historyText setScrollEnabled:NO];
    [_historyText setEditable:NO];
    [self.view addSubview:_historyText];
    //[_scrollView addSubview:_historyText];
    
    //self.navigationItem.title = @"RealRaag";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)imageTapped:(id)sender{
    PhotoViewController *pvc = [PhotoViewController new];
    [pvc setImageToDisplay:_rubabImage.image];
    [self presentViewController:pvc animated:YES completion:nil];
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
