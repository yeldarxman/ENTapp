//
//  ReadTableViewController.h
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 24.06.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReadTableViewCell.h"
#import "TopicSelectionTableViewController.h"

@interface ReadTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *subjects;
@property (strong, nonatomic) NSString *selectedSubject;
@property (strong, nonatomic) NSString *selectedLanguage;

@end
