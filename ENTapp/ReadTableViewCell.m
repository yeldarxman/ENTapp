//
//  ReadTableViewCell.m
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 24.06.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import "ReadTableViewCell.h"

@implementation ReadTableViewCell

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
        
        // for cell background color
        //self.backgroundView =[[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"tests_cell_background.png"] stretchableImageWithLeftCapWidth:40.0 topCapHeight:20.0] ];
        //self.selectedBackgroundView =[[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"tests_cell_background_selected.png"] stretchableImageWithLeftCapWidth:49.0 topCapHeight:24.0] ];
        [self.textLabel setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

/*- (void)setFrame:(CGRect)frame {
    frame.origin.x -= 10 ;
    frame.size.width += 2 * 10;
    [super setFrame:frame];
}*/

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
