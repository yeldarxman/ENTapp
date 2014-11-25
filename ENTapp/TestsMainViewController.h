//
//  TestsMainViewController.h
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 18.06.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"
#import "Subject.h"
#import "Test.h"
#import "TestsMainTableDelegate.h"
#import "TestMainTableViewController.h"
#import "CoreData.h"
#import "PDFUtility.h"

@interface TestsMainViewController : UIViewController <TestsMainTableDelegate, UIActionSheetDelegate>
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIScrollView *pageControl;
@property (strong, nonatomic) IBOutlet UIView *mainContent;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@property (strong, nonatomic) Subject *subject;
@property (strong, nonatomic) Test *test;

//data
@property (strong, nonatomic) NSMutableArray *pageButtons;
@property (strong, nonatomic) NSMutableArray *pages;

@property int pageCounter;
@property int currentPage;
@property int correctAnswersNumber;
@property int incorrectAnswersNumber;

-(IBAction)showActionSheet:(id)sender;

@end
