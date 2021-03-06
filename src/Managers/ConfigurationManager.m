//
//  ConfigurationManager.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/24/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ConfigurationManager.h"

@interface ConfigurationManager()

// properties

// methods


@end

@implementation ConfigurationManager

static ConfigurationManager *SINGLETON = nil;

static bool isFirstAccess = YES;

#pragma mark - Public Method

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone: NULL] init];
    });
    
    return SINGLETON;
}

#pragma mark - Life Cycle

+ (id) allocWithZone: (NSZone*) zone
{
    return [self sharedInstance];
}

+ (id) copyWithZone: (struct _NSZone *) zone
{
    return [self sharedInstance];
}

+ (id) mutableCopyWithZone: (struct _NSZone *) zone
{
    return [self sharedInstance];
}

- (id) copy
{
    return [[ConfigurationManager alloc] init];
}

- (id) mutableCopy
{
    return [[ConfigurationManager alloc] init];
}

- (id) init
{
    if(SINGLETON)
    {
        return SINGLETON;
    }
    
    if (isFirstAccess)
    {
        [self doesNotRecognizeSelector: _cmd];
    }
    
    self = [super init];
    
    return self;
}

#pragma mark - Coding protocol methods -




#pragma mark - Public mehtods -

- (void) saveSortingProjectsType: (AllProjectsSortingType)     type
                withAccedingType: (ContentAccedingSortingType) acceding
{
    [UserDefaults setInteger: type
                      forKey: @"AllProjectsSortingType"];
    [UserDefaults setInteger: acceding
                      forKey: @"AllProjectsSortingAccedingType"];
    
    [UserDefaults synchronize];
}

- (AllProjectsSortingType) getProjectsSortingType
{
    return [UserDefaults integerForKey: @"AllProjectsSortingType"];
}

- (ContentAccedingSortingType) getAccedingType
{
    return [UserDefaults integerForKey: @"AllProjectsSortingAccedingType"];
}

- (void) saveSortedTasks: (TasksSortingType)           tasksType
       withAscendingType: (ContentAccedingSortingType) ascending
{
    [UserDefaults setInteger: tasksType
                      forKey: @"TasksSortingType"];
    [UserDefaults setInteger: ascending
                      forKey: @"TasksSortingAscendingType"];
}

- (TasksSortingType) getTasksSortingType
{
    return [UserDefaults integerForKey: @"TasksSortingType"];
}

-(ContentAccedingSortingType) getAccedingTypeForTasks
{
    return [UserDefaults integerForKey: @"TasksSortingAscendingType"];
}

@end
