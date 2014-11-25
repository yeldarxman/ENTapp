//
//  TestsTopicCell.m
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 02.07.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import "TestsVariantCell.h"

@implementation TestsVariantCell

@synthesize lockImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setLocked{
    lockImage = [[UIImageView alloc] init];
    [lockImage setFrame:CGRectMake(self.frame.size.width - 50, 6, 30, 30)];
    [lockImage setImage:[UIImage imageNamed:@"padlock.png"]];
    [self addSubview:lockImage];
    [self.detailTextLabel setText:@""];
}

@end
