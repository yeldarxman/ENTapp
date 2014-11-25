//
//  Test.h
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 03.01.14.
//  Copyright (c) 2014 Yeldar Merkaziyev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Subject.h"

@class Subject;

@interface Test : Subject

@property (nonatomic, retain) NSNumber * correctAnswers;
@property (nonatomic, retain) NSString * testId;
@property (nonatomic, retain) NSString * testName;
@property (nonatomic, retain) NSNumber * wrongAnswers;
@property (nonatomic, retain) NSString * variantName;
@property (nonatomic, retain) Subject *isInsideOf;

- (NSComparisonResult)compare:(Test *)test;
- (int) getTotalNumberOfQuestions;
- (CGFloat)getProgress;

@end
