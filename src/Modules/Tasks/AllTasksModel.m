//
//  AllTasksModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/13/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AllTasksModel.h"

// Categories
#import "DataManager+ProjectInfo.h"

@interface AllTasksModel()

// properties

@property (strong, nonatomic) NSArray* projectsInfo;

// methods


@end

@implementation AllTasksModel


#pragma mark - Public methods -

- (RACSignal*) updateContent
{
    RACSignal* updateInfoSignal = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
        
        self.projectsInfo = [DataManagerShared getAllProjects];
        
        [subscriber sendCompleted];
        
        return nil;
    }];
    
    return updateInfoSignal;
}

- (NSUInteger) countOfSections
{
    return self.projectsInfo.count;
}

- (NSUInteger) countOfRowsInSection: (NSUInteger) section
{
    ProjectInfo* project = self.projectsInfo[section];
    
    return project.stage.count;
}

- (ProjectInfo*) getProjectInfoForSection: (NSUInteger) section
{
    return self.projectsInfo[section];
}



@end
