//
//  SystemDetailModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 24.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "SystemDetailModel.h"

//CLasses
#import "DataManager+Systems.h"
#import "ProjectTask+CoreDataClass.h"
#import "DataManager+Tasks.h"
#import "ProjectTaskWorkArea+CoreDataClass.h"

@implementation SystemDetailModel

- (NSString*) getProjectSystemDetailTitle
{
    ProjectTask* currTask = [DataManagerShared getSelectedTask];
    
    ProjectTaskWorkArea* workArea = currTask.workArea;

    return workArea.title;
}

@end
