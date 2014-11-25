//
//  PageChildViewController.h
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 27.06.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageChildViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UILabel *pageLabel;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) UIImage *image;
@property float navigationBarHeight;
@property float height;
@property float width;
@property int index;

@end
