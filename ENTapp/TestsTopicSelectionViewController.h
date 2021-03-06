//
//  TestsTopicSelectionViewController.h
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 18.06.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Subject.h"
#import "CoreData.h"
#import "TestsTestSelectionViewController.h"

@interface TestsTopicSelectionViewController : UITableViewController

@property (strong, nonatomic) Subject *subject;
@property (strong, nonatomic) NSMutableArray *topics;

@end
