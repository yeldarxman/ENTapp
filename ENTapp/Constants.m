//
//  Constants.m
//  ENTapp
//
//  Created by Yeldar Merkaziyev on 07.09.13.
//  Copyright (c) 2013 Yeldar Merkaziyev. All rights reserved.
//

#import "Constants.h"

@implementation Constants

static NSMutableDictionary *ruSubjects;
static NSMutableDictionary *kkSubjects;

+ (NSString *) getEnglishSubjectName:(NSString *) language subject:(NSString *) subject{
    
    if([language isEqualToString:@"kk"]){
        return [[self kkSubjects] objectForKey:subject];
    } else {
        return [[self ruSubjects] objectForKey:subject];
    }
    
    return @"";
}

+ (NSMutableDictionary *) ruSubjects{
    if(ruSubjects){
        return ruSubjects;
    }
    
    ruSubjects = [[NSMutableDictionary alloc]  init];
    
    [ruSubjects setObject:@"Math" forKey: @"Математика"];
    [ruSubjects setObject:@"Kazakhstan history" forKey: @"История Казахстана"];
    [ruSubjects setObject:@"Kazakh language" forKey: @"Казахский язык"];
    [ruSubjects setObject:@"Russian language" forKey: @"Русский язык"];
    [ruSubjects setObject:@"English language" forKey: @"Английский язык"];
    [ruSubjects setObject:@"World history" forKey: @"Всемирная история"];
    [ruSubjects setObject:@"Physics" forKey: @"Физика"];
    [ruSubjects setObject:@"Chemistry" forKey: @"Химия"];
    [ruSubjects setObject:@"Biology" forKey: @"Биология"];
    [ruSubjects setObject:@"Geography" forKey: @"География"];
    
    return ruSubjects;
}

+ (NSMutableDictionary *) kkSubjects{
    if(kkSubjects){
        return kkSubjects;
    }
    
    kkSubjects = [[NSMutableDictionary alloc]  init];
    
    [kkSubjects setObject:@"Math" forKey: @"Математика"];
    [kkSubjects setObject:@"Kazakhstan history" forKey: @"Қазақстан тарихы"];
    [kkSubjects setObject:@"Kazakh language" forKey: @"Қазақ тiлi"];
    [kkSubjects setObject:@"Russian language" forKey: @"Орыс тiлi"];
    [kkSubjects setObject:@"English language" forKey: @"Ағылшын тiлi"];
    [kkSubjects setObject:@"World history" forKey: @"Дүниежүзi тарихы"];
    [kkSubjects setObject:@"Physics" forKey: @"Физика"];
    [kkSubjects setObject:@"Chemistry" forKey: @"Химия"];
    [kkSubjects setObject:@"Biology" forKey: @"Биология"];
    [kkSubjects setObject:@"Geography" forKey: @"География"];
    
    return kkSubjects;
}

@end
