//
//  TopicSelectionTableViewController.h
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 24.06.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageViewController.h"
#import "JsonParser.h"

@interface TopicSelectionTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *topics;
@property (strong, nonatomic) NSString *subject;
@property (strong, nonatomic) NSString *selectedTopic;

@end
