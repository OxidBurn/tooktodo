//
//  UserNotificationModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 16.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

typedef NS_ENUM(NSUInteger, UserNotificaitonType)
{
    AllMessageType,
    WhereIParticipateType,
    WhereIResponsibleType,
};

typedef NS_ENUM(NSUInteger, ProjectUserNotificationType)
{
    MessageInFeedsType,
    TasksType,
    DocumentsType,
    TeamsType,
    ProjectProfileType,
    SystemsType,
};

@interface UserNotificationModel : NSObject <UITableViewDelegate, UITableViewDataSource>

- (void) saveUserSettings;

@end
