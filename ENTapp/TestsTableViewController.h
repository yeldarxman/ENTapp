//
//  TestsTableViewController.h
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 18.06.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestsTableViewCell.h"
#import "LocalizationSystem.h"
#import "Subject.h"
#import "Test.h"
#import "TestsTestSelectionViewController.h"

@interface TestsTableViewController : UITableViewController

@property (strong, nonatomic) NSString *selectedLanguage;
@property (strong, nonatomic) NSMutableArray *subjects;
@property (strong, nonatomic) Subject *selectedSubject;
@property (strong, nonatomic) NSMutableArray *progresses;

@end
