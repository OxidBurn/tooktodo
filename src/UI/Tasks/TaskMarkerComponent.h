//
//  TaskMarkComponent.h
//  TookTODO
//
//  Created by Chaban Nikolay on 8/25/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSUInteger, TaskMarkerComponentType)
{
    TaskMarkerSubtaskType,
    TaskMarkerAttachmentsType,
    TaskMarkerCommentsType,
};

@interface TaskMarkerComponent : UIView

- (void) setValue: (NSUInteger)              value
         withType: (TaskMarkerComponentType) type;

@end
