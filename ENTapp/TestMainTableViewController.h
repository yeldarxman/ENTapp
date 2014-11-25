//
//  TestMainTableViewController.m
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 19.06.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"
#import "TestChoiceCell.h"
#import "TestsMainTableDelegate.h"

@interface TestMainTableViewController : UITableViewController

@property (strong, nonatomic) Question *question;
@property id<TestsMainTableDelegate> delegate;
@property (strong, nonatomic) NSString *answer;

@property BOOL answered;
@property int rightAnswerIndex;
@property int answerIndex;

@property BOOL scienseTest;

-(void) updateRightAnswerIndex;
-(void) setScienceIndication;

@end
