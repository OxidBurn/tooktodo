//
//  UserNotificationInfo.m
//  TookTODO
//
//  Created by Глеб on 16.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "UserNotificationInfo.h"
#import "UserNotificationModel.h"

@interface UserNotificationInfo()

// properties

@property (weak, nonatomic) IBOutlet UITableView* notificationInfoTableView;

@property (strong, nonatomic) UserNotificationModel* dataModel;

// methods
- (void) setUpDefaults;

@end

@implementation UserNotificationInfo

#pragma mark - Lyfe cycle -

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpDefaults];
}

#pragma mark - Properties -

- (UserNotificationModel*) dataModel
{
    if ( _dataModel == nil )
    {
        _dataModel = [UserNotificationModel new];
    }
    return _dataModel;
}

#pragma mark - Internal -

- (void) setUpDefaults
{
    self.notificationInfoTableView.dataSource = self.dataModel;
    self.notificationInfoTableView.delegate   = self.dataModel;
}
@end
