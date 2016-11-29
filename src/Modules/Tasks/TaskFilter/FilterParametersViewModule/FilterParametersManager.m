//
//  FilterParametersManager.m
//  TookTODO
//
//  Created by Nikolay Chaban on 11/28/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterParametersManager.h"

// Classes
#import "FilterParametersManager+ProjectTasksFilterParser.h"
#import "FilterParametersManager+UpdatingProjectTaskFilter.h"
#import "FilterParametersManager+AllProjectsTasksParser.h"

@interface FilterParametersManager()

// properties

@property (nonatomic, assign) ScreenTypeForFiltering screenType;

@property (strong, nonatomic) NSArray* filterParametersContent;

// methods


@end


@implementation FilterParametersManager


#pragma mark - Public methods -

- (void) updateFilterContentForScreen: (ScreenTypeForFiltering) type
                       withCompletion: (FilterUpdateCompletion) completion
{
    self.screenType = type;
    
    [self parsingFilterParametersContent];
    
    if ( completion )
        completion(self.filterParametersContent.count);
}

- (NSUInteger) countOfFilterParameters
{
    return self.filterParametersContent.count;
}


#pragma mark - Internal methods -

- (void) parsingFilterParametersContent
{
    switch (self.screenType)
    {
        case ProjectTaskScreenType:
        {
            self.filterParametersContent = [self parseContentForProjectTasks];
        }
            break;
            
        case AllProjectTasksScreenType:
        {
            self.filterParametersContent = [self parseContentForAllProjectsTasks];
        }
            break;
    }
}

- (void) udateIndexes
{
    [self.filterParametersContent enumerateObjectsUsingBlock: ^(FilterTagParameterInfo*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        [obj updatedTagIndex: idx];
        
    }];
}

#pragma mark - Filter parameter view data source methods -

- (NSArray*) getFilterParameterContent
{
    return self.filterParametersContent;
}

#pragma mark - Filter parameter view delegate methods -

- (void) didDeleteFilterParameterWithTag: (NSUInteger) tag
{
    __block NSMutableArray* tmpFilterParametersContent = self.filterParametersContent.mutableCopy;
    
    FilterTagParameterInfo* parameterInfo = tmpFilterParametersContent[tag];
    
    __weak typeof(self) blockSelf = self;
    
    if ( self.screenType == ProjectTaskScreenType )
    {
        [self deleteFilterParameterWithInfo: parameterInfo
                             withCompletion: ^(BOOL isSuccess) {
                                 
                                 if ( blockSelf.didUpdateFilter )
                                     blockSelf.didUpdateFilter(blockSelf.filterParametersContent.count);
                                 
                             }];
    }
    else
    {
        [self deleteAllProjectsFilterParameterWithInfo: parameterInfo
                                        withCompletion: ^(BOOL isSuccess) {
                                           
                                            if ( blockSelf.didUpdateFilter )
                                                blockSelf.didUpdateFilter(blockSelf.filterParametersContent.count);
                                            
                                        }];
    }
    
    [tmpFilterParametersContent removeObjectAtIndex: tag];
    
    self.filterParametersContent = tmpFilterParametersContent.copy;
    
    tmpFilterParametersContent = nil;
    
    [self udateIndexes];
}


@end
