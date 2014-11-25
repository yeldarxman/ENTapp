//
//  TestsTableViewCell.m
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 18.06.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import "TestsTableViewCell.h"

@implementation TestsTableViewCell

@synthesize titleLabel;
@synthesize progressView;
@synthesize percentageLabel;
@synthesize imageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Your code goes here!
    }
    
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder: aDecoder];
    if (self){
        // for cell background color
        //self.backgroundView =[[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"tests_cell_background.png"] stretchableImageWithLeftCapWidth:49.0 topCapHeight:24.0] ];
        //self.selectedBackgroundView =[[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"tests_cell_background_selected.png"] stretchableImageWithLeftCapWidth:49.0 topCapHeight:24.0] ];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x -= 10 ;
    frame.size.width += 2 * 10;
    [super setFrame:frame];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
