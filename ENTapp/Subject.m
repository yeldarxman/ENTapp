//
//  Subject.m
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 03.01.14.
//  Copyright (c) 2014 Yeldar Merkaziyev. All rights reserved.
//

#import "Subject.h"
#import "Test.h"


@implementation Subject

@dynamic language;
@dynamic subjectName;
@dynamic consistsOf;

-(CGFloat) getProgress {
    int totalQuestions = 0;
    int totalCorrectAnswers = 0;
    
    for(int i=0; i<[[[self consistsOf] allObjects] count]; i++){
        totalCorrectAnswers = totalCorrectAnswers +
                [[[[[self consistsOf] allObjects] objectAtIndex:i] correctAnswers] intValue];
    }
    
    for(int i=0; i<[[[self consistsOf] allObjects] count]; i++){
        totalQuestions = totalQuestions +
                [[[[self consistsOf] allObjects] objectAtIndex:i] getTotalNumberOfQuestions];
    }
            
    float result = totalQuestions > 0 ?
                    (100 * totalCorrectAnswers) / totalQuestions : 0;
    
    return result;
}

@end
