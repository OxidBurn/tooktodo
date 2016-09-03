//
//  OfflineSettingsTypes.h
//  TookTODO
//
//  Created by Nikolay Chaban on 8/22/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#ifndef OfflineSettingsTypes_h
#define OfflineSettingsTypes_h

typedef NS_ENUM(NSUInteger, OfflineSettingsItemType)
{
    TasksFeedsPlansType,
    
    TasksType,
    CompletedTasksType,
    CanceledTasksType,
    
    FeedsType,
    
    PlansType,
    
    PhotoInTasksWhereIMemberType,
    PhotoInAllTasksType,
    
    AllDocumentsType,
    DocumentsWhereIResponderType,
    DocumentsWhereIMemberType,
    DocumentsInAllTasksType,
};

#endif /* OfflineSettingsTypes_h */
