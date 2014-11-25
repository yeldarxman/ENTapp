//
//  TestChoiceCell.h
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 19.06.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestChoiceCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *choiceLetterButton;
@property (strong, nonatomic) IBOutlet UILabel *choiceTextLabel;
@property (strong, nonatomic) UIImageView *choiceTextImage;


-(void)setWrongBackground;
-(void)setCorrectBackground;
-(void)makeInvisible;
-(void)setNormalBackgroundScience;
-(void)setWrongBackgroundScience;
-(void)setCorrectBackgroundScience;
@end
