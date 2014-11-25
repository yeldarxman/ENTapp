//
//  LanguageSelectionViewController.h
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 22.06.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocalizationSystem.h"

@interface LanguageSelectionViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *kazakhButton;
@property (strong, nonatomic) IBOutlet UIButton *russianButton;
@property (strong, nonatomic) IBOutlet UIImageView *imageBackground;

- (IBAction)kazakhButtonPressed:(id)sender;
- (IBAction)russianButtonPressed:(id)sender;

@end
