//
//  TestNextQuestionCell.m
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 19.06.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import "TestNextQuestionCell.h"

@implementation TestNextQuestionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder: aDecoder];
    if (self){
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.font = [UIFont systemFontOfSize:15];
        
        // for cell background color
        self.backgroundView =[[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"pencil_unselected.png"] stretchableImageWithLeftCapWidth:63.0 topCapHeight:39.0] ];
        
        self.selectedBackgroundView =[[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"pencil_selected.png"] stretchableImageWithLeftCapWidth:63.0 topCapHeight:39.0] ];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
