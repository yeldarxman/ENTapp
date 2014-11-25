//
//  TestChoiceCell.m
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 19.06.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import "TestChoiceCell.h"

@implementation TestChoiceCell

@synthesize choiceLetterButton;
@synthesize choiceTextLabel;
@synthesize choiceTextImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x += 10;
    frame.size.width -= 2 * 10;
    [super setFrame:frame];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder: aDecoder];
    if (self){
        self.choiceTextLabel.backgroundColor = [UIColor clearColor];
        self.choiceTextLabel.font = [UIFont systemFontOfSize:15];
        
        // for cell background color
        UIImageView *normalView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 300, self.backgroundView.frame.size.height)];
        normalView.image = [[UIImage imageNamed:@"choice_normal.png"] stretchableImageWithLeftCapWidth:100.0 topCapHeight:43.0];
        
        UIImageView *selectedView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 300, self.backgroundView.frame.size.height)];
        selectedView.image = [[UIImage imageNamed:@"choice_selected1.png"] stretchableImageWithLeftCapWidth:100.0 topCapHeight:43.0];
        
        self.backgroundView = normalView;
        self.selectedBackgroundView = selectedView;
    }
    return self;
}

-(void)setWrongBackground{
    self.backgroundView =[[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"choice_red.png"] stretchableImageWithLeftCapWidth:100.0 topCapHeight:43.0] ];
}

-(void)setCorrectBackground{
    self.backgroundView =[[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"choice_green.png"] stretchableImageWithLeftCapWidth:100.0 topCapHeight:43.0] ];
}

-(void)makeInvisible{
    [self.choiceTextLabel setText:@""];
    [self.choiceLetterButton setFrame:CGRectMake(0, 0, 0, 0)];
    [self.choiceTextImage setFrame:CGRectMake(0, 0, 0, 0)];
    self.backgroundView = self.backgroundView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
}

-(void)setWrongBackgroundScience{
    self.backgroundView =[[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"choice_red_science.png"] stretchableImageWithLeftCapWidth:100.0 topCapHeight:43.0] ];
}

-(void)setCorrectBackgroundScience{
    self.backgroundView =[[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"choice_green_science.png"] stretchableImageWithLeftCapWidth:100.0 topCapHeight:43.0] ];
}

-(void)setNormalBackgroundScience{
    self.backgroundView =[[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"choice_normal_science.png"] stretchableImageWithLeftCapWidth:100.0 topCapHeight:43.0] ];
    self.selectedBackgroundView =[[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"choice_selected_science.png"] stretchableImageWithLeftCapWidth:100.0 topCapHeight:43.0] ];
    
    self.backgroundView.frame = CGRectMake(10, 0, self.backgroundView.frame.size.width - 20, self.backgroundView.frame.size.height);
    
    choiceTextImage = [[UIImageView alloc] init];
    [choiceTextImage setFrame:CGRectMake(50, 12, 240, 32)];
    [self addSubview:choiceTextImage];
    [choiceTextLabel removeFromSuperview];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
