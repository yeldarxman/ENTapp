//
//  PageVIewController.h
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 27.06.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageChildViewController.h"
#import "LocalizationSystem.h"

@interface PageViewController : UIViewController<UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *pageController;
@property (strong, nonatomic) NSMutableArray *pageContent;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) NSString *topic;
@property (strong, nonatomic) UIImage *image;
@property float containerHeight;
@property float containerWidth;

-(IBAction)donePressed:(id)sender;

@end
