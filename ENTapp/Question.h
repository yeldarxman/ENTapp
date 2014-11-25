//
//  Question.h
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 18.06.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Question : NSObject

@property int questionNumber;
@property (strong, nonatomic) NSString *question;
@property (strong, nonatomic) NSString *choiceA;
@property (strong, nonatomic) NSString *choiceB;
@property (strong, nonatomic) NSString *choiceC;
@property (strong, nonatomic) NSString *choiceD;
@property (strong, nonatomic) NSString *choiceE;
@property (strong, nonatomic) NSString *rightAnswer;

@property BOOL scienceQuestion;
@property int rightAnswerIndex;
@property (strong, nonatomic) UIImage *questionImage;
@property (strong, nonatomic) UIImage *choiceAImage;
@property (strong, nonatomic) UIImage *choiceBImage;
@property (strong, nonatomic) UIImage *choiceCImage;
@property (strong, nonatomic) UIImage *choiceDImage;
@property (strong, nonatomic) UIImage *choiceEImage;

@end
