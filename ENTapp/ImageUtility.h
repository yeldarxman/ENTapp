//
//  ImageUtility.h
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 01.07.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageUtility : NSObject

+ (UIImage*)imageByCropping:(UIImage *)imageToCrop toRect:(CGRect)aperture;
+ (UIImage*)imageByCropping:(UIImage *)imageToCrop toRect:(CGRect)aperture withOrientation:(UIImageOrientation)orientation;

@end
