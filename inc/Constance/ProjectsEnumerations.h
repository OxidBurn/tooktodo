//
//  ProjectsEnumerations.h
//  TookTODO
//
//  Created by Nikolay Chaban on 8/24/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#ifndef ProjectsEnumerations_h
#define ProjectsEnumerations_h

typedef NS_ENUM(NSUInteger, AllProjectsSortingType)
{
    SortingByLastVisitingType,
    SortingByNameType,
    SortingByAdressType,
    SortingByCreationDateType,
};

typedef NS_ENUM(NSUInteger, ContentAccedingSortingType)
{
    GrowsSortingType      = 1,
    DiminutionSortingType = 0,
};

typedef NS_ENUM(NSUInteger, AllTasksCellType)
{
    AllTasksStageCellType,
    AllTasksTaskCellType,
};


#endif /* ProjectsEnumerations_h */
