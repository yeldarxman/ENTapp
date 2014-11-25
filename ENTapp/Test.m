//
//  Test.m
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 03.01.14.
//  Copyright (c) 2014 Yeldar Merkaziyev. All rights reserved.
//

#import "Test.h"
#import "Subject.h"


@implementation Test

@dynamic correctAnswers;
@dynamic testId;
@dynamic testName;
@dynamic wrongAnswers;
@dynamic variantName;
@dynamic isInsideOf;

- (NSComparisonResult) compare:(Test *)test {
    NSRange range1 = [test.testName rangeOfString:@" -" options:NSBackwardsSearch range:NSMakeRange(0, 6)];
    NSRange range2 = [self.testName rangeOfString:@" -" options:NSBackwardsSearch range:NSMakeRange(0, 6)];
    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSNumber *firstNumber = [f numberFromString:[test.testName substringToIndex:range1.location]];
    NSNumber *secondNumber = [f numberFromString:[self.testName substringToIndex:range2.location]];
    
    return [firstNumber compare:secondNumber];
}

- (int) getTotalNumberOfQuestions {
    return 25;
}

- (CGFloat) getProgress {
    
    int total = [self getTotalNumberOfQuestions];
    float result = total == 0 ? 0 : ([self.correctAnswers intValue] * 100)/total;
    
    return result;
}   

@end
