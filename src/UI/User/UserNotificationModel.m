//
//  UserNotificationModel.m
//  TookTODO
//
//  Created by Глеб on 16.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "UserNotificationModel.h"
@import UIKit;

static NSString* CellID = @"CellID";
static NSString* LabelTextKey = @"LabelTextKey";
static NSString* SwitchTagKey = @"SwitchTagKey";

@interface UserNotificationModel() <UITableViewDelegate, UITableViewDataSource>

// properties
@property (strong, nonatomic) NSArray* tableRowsData;

// methods


@end

@implementation UserNotificationModel

#pragma mark - Properties -

- (NSArray*) tableRowsData
{
    if ( _tableRowsData == nil )
    {
        _tableRowsData = @[@[@{LabelTextKey: @"Все сообщения",
                               SwitchTagKey: @1},
                             @{LabelTextKey: @"Где я учавствую",
                               SwitchTagKey: @2},
                             @{LabelTextKey: @"Где я ответственный или утверждающий",
                               SwitchTagKey: @3}],
                           
                           @[@{LabelTextKey: @"Сообщения в ленту",
                               SwitchTagKey: @4},
                             @{LabelTextKey: @"Задачи",
                               SwitchTagKey: @5},
                             @{LabelTextKey: @"Документы",
                               SwitchTagKey: @6},
                             @{LabelTextKey: @"Команды",
                               SwitchTagKey: @7},
                             @{LabelTextKey: @"Профиль проекта",
                               SwitchTagKey: @8},
                             @{LabelTextKey: @"Системные",
                               SwitchTagKey: @9}],
                           ];
    }
    return _tableRowsData;
}

#pragma mark - UITableViewDataSource methods -

#pragma mark - UITableViewDelegate methods -




@end
