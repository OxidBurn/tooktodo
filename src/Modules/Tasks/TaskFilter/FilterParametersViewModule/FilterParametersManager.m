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
            [self parseContentForAllProjectsTasks];
        }
            break;
    }
}



- (void) parseContentForAllProjectsTasks
{
    
}




@end
