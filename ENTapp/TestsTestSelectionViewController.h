//
//  TestsTestSelectionViewController.h
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 18.06.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Subject.h"
#import "Test.h"
#import "TestsMainViewController.h"

@interface TestsTestSelectionViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *tests;
@property (strong, nonatomic) Subject *subject;
@property (strong, nonatomic) Test *selectedTest;
@property (strong, nonatomic) NSString *purchased;

@end
