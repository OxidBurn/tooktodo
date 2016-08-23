//
//  AllProjectsModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/22/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AllProjectsModel.h"

// Extensions
#import "DataManager+ProjectInfo.h"

@interface AllProjectsModel()

// properties


// methods


@end

@implementation AllProjectsModel

- (NSArray*) getProjectsContent
{
    return [DataManagerShared getAllProjects];
}



@end
