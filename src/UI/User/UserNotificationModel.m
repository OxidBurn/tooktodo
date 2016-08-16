//
//  UserNotificationModel.m
//  TookTODO
//
//  Created by Глеб on 16.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "UserNotificationModel.h"
#import "UserNotificationCell.h"

static NSString* CellID = @"CellID";
static NSString* LabelTextKey = @"LabelTextKey";
static NSString* SwitchTagKey = @"SwitchTagKey";

@interface UserNotificationModel()

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

- (NSInteger) numberOfSectionsInTableView: (UITableView*) tableView
{
    return 2;
}

- (NSInteger) tableView: (UITableView*) tableView
  numberOfRowsInSection: (NSInteger)    section
{
    return [self.tableRowsData[section] count];
}

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    UserNotificationCell* cell = [tableView dequeueReusableCellWithIdentifier: CellID];
    
    NSDictionary* info = self.tableRowsData[indexPath.section][indexPath.row];
    
    NSString* cellText = info[LabelTextKey];
    
    NSNumber* switchTag = info[SwitchTagKey];
    
    [cell fillCellWithText: cellText
             withSwitchTag: switchTag];
    
    return cell;
}

-   (CGFloat) tableView: (UITableView*) tableView
heightForRowAtIndexPath: (NSIndexPath*) indexPath
{
    
    return (indexPath.section == 0 && indexPath.row == 2) ? 60 : 40;
}

- (UIView*)  tableView: (UITableView*) tableView
viewForHeaderInSection: (NSInteger)    section
{
    if ( section == 1 )
    {
        UIView* headerView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, CGRectGetMaxX(tableView.frame), 10)];
        
        CGFloat red   = 230.0/256;
        CGFloat green = 232.0/256;
        CGFloat blue  = 234.0/256;
        
        headerView.backgroundColor = [UIColor colorWithRed: red
                                                     green: green
                                                      blue: blue
                                                     alpha: 1.0f];
        return headerView;
    }
    return nil;
}

#pragma mark - UITableViewDelegate methods -

- (CGFloat)     tableView: (UITableView*) tableView
 heightForHeaderInSection: (NSInteger)    section
{
    return section == 1 ? 10 : 0;
}

@end
