//
//  PageChildViewController.m
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 27.06.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import "PageChildViewController.h"

@interface PageChildViewController ()

@end

@implementation PageChildViewController

@synthesize label;
@synthesize text;
@synthesize pageLabel;
@synthesize index;
@synthesize image;
@synthesize navigationBarHeight;
@synthesize height;
@synthesize width;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [label setText:text];
    [pageLabel setText:[NSString stringWithFormat:@"%i", index + 1]];
    UIImageView *imageView = [[UIImageView alloc] init];
    CGRect frame = CGRectMake(0, 0, image.size.width/2, image.size.height/2);
    NSLog(@"Image size is %f, %f", image.size.width, image.size.height);
    [imageView setBounds:frame];
    [imageView setImage:image];
    imageView.center = [self calculateCenter];
    [self.view addSubview:imageView];
    [self.view bringSubviewToFront:pageLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGPoint) calculateCenter {
    float x1 = 0;
    float x2 = width; // self.view.frame.size.width;
    
    float y1 = 0;
    NSLog(@"NAVIGATION before is %f", navigationBarHeight);
    float y2 = height - navigationBarHeight - 7;
    
    NSLog(@"WIDTH is %f", x2);
    NSLog(@"HEIGHT is %f", y2);
    NSLog(@"NAVIGATION after is %f", navigationBarHeight);
    
    CGPoint center = CGPointMake((x2 - x1)/2 + 5, (y2 - y1)/2);
    
    NSLog(@"Center is %f, %f", center.x, center.y);
    return center;
}

@end
