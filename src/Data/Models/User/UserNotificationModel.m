//
//  UserNotificationModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 16.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "UserNotificationModel.h"
#import "UserNotificationCell.h"

static NSString* CellID               = @"CellID";
static NSString* LabelTextKey         = @"LabelTextKey";
static NSString* SwitchTagKey         = @"SwitchTagKey";
static NSString* EnableStateKey       = @"EnableStateKey";
static NSString* StoreUserSettingsKey = @"UserNotificationSettingsKey";

@interface UserNotificationModel()

// properties
@property (strong, nonatomic) NSArray* tableRowsData;

// methods

- (void) setupDefaults;

@end

@implementation UserNotificationModel


#pragma mark - Initialization -

- (instancetype) init
{
    if ( self = [super init] )
    {
        [self setupDefaults];
    }
    
    return self;
}

- (void) setupDefaults
{
    if ( [UserDefaults valueForKey: StoreUserSettingsKey] == nil )
    {
        [UserDefaults setValue: @[@[@{LabelTextKey: @"Все сообщения",
                                      SwitchTagKey: @(AllMessageType),
                                      EnableStateKey : @(YES)},
                                    @{LabelTextKey: @"Где я участвую",
                                      SwitchTagKey: @(WhereIParticipateType),
                                      EnableStateKey : @(YES)},
                                    @{LabelTextKey: @"Где я ответственный\n или утверждающий",
                                      SwitchTagKey: @(WhereIResponsibleType),
                                      EnableStateKey : @(YES)}],
                                  
                                  @[@{LabelTextKey: @"Сообщения в ленту",
                                      SwitchTagKey: @(MessageInFeedsType),
                                      EnableStateKey : @(YES)},
                                    @{LabelTextKey: @"Задачи",
                                      SwitchTagKey: @(TasksType),
                                      EnableStateKey : @(YES)},
                                    @{LabelTextKey: @"Документы",
                                      SwitchTagKey: @(DocumentsType),
                                      EnableStateKey : @(YES)},
                                    @{LabelTextKey: @"Команды",
                                      SwitchTagKey: @(TeamsType),
                                      EnableStateKey : @(YES)},
                                    @{LabelTextKey: @"Профиль проекта",
                                      SwitchTagKey: @(ProjectProfileType),
                                      EnableStateKey : @(YES)},
                                    @{LabelTextKey: @"Системные",
                                      SwitchTagKey: @(SystemsType),
                                      EnableStateKey : @(YES)}],
                                  ]
                        forKey: StoreUserSettingsKey];
        
        [UserDefaults synchronize];
    }
}

#pragma mark - Properties -

- (NSArray*) tableRowsData
{
    if ( _tableRowsData == nil )
    {
        _tableRowsData = [UserDefaults valueForKey: StoreUserSettingsKey];
    }
    return _tableRowsData;
}


#pragma mark - Publi methods -

- (void) saveUserSettings
{
    [UserDefaults setValue: self.tableRowsData
                    forKey: StoreUserSettingsKey];
    
    [UserDefaults synchronize];
}


#pragma mark - Internal methods -

- (void) updateNotificationSetting: (NSUInteger) tag
                      withValueTag: (NSUInteger) valueTag
                         withValue: (BOOL)       value
{
    NSMutableArray* tmpArray    = self.tableRowsData.mutableCopy;
    NSMutableArray* tmpSubArray = [tmpArray[tag] mutableCopy];
    NSMutableDictionary* tmpDic = [tmpSubArray[valueTag] mutableCopy];
    
    tmpDic[EnableStateKey] = @(value);
    
    tmpSubArray[valueTag] = tmpDic;
    tmpArray[tag]         = tmpSubArray;
    
    self.tableRowsData = tmpArray.copy;
    
    tmpArray    = nil;
    tmpSubArray = nil;
    tmpDic      = nil;
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
    
    cell.tag = indexPath.section;
    
    NSDictionary* info = self.tableRowsData[indexPath.section][indexPath.row];
    
    NSString* cellText = info[LabelTextKey];
    
    NSNumber* switchTag = info[SwitchTagKey];
    
    BOOL switchValue = [info[EnableStateKey] boolValue];
    
    [cell fillCellWithText: cellText
             withSwitchTag: switchTag
           withSwitchValue: switchValue];
    
    __weak typeof(self) blockSelf = self;
    
    cell.didChangeValue = ^(NSUInteger cellTag, NSUInteger valueTag, BOOL value){
        
        [blockSelf updateNotificationSetting: cellTag
                                withValueTag: valueTag
                                   withValue: value];
        
    };
    
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
