//
//  Subject.h
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 03.01.14.
//  Copyright (c) 2014 Yeldar Merkaziyev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Test;

@interface Subject : NSManagedObject

@property (nonatomic, retain) NSString * language;
@property (nonatomic, retain) NSString * subjectName;
@property (nonatomic, retain) NSSet *consistsOf;
@end

@interface Subject (CoreDataGeneratedAccessors)

- (void)addConsistsOfObject:(Test *)value;
- (void)removeConsistsOfObject:(Test *)value;
- (void)addConsistsOf:(NSSet *)values;
- (void)removeConsistsOf:(NSSet *)values;

@end
