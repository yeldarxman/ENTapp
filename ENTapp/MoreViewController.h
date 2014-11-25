//
//  MoreViewController.h
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 22.06.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoreViewCell.h"
#import "LocalizationSystem.h"
#import <CoreData/CoreData.h>
#import "CoreData.h"
#import "Subject.h"
#import "Test.h"

@interface MoreViewController : UITableViewController<UIActionSheetDelegate>

@property (strong, nonatomic) NSString *selectedLanguage;

@end
