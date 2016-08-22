//
//  UserNotificationInfo.m
//  TookTODO
//
//  Created by Nikolay Chaban on 16.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "UserNotificationInfoController.h"
#import "UserNotificationModel.h"

@interface UserNotificationInfoController()

// properties

@property (weak, nonatomic) IBOutlet UITableView* notificationInfoTableView;

@property (strong, nonatomic) UserNotificationModel* dataModel;

// methods
- (void) setUpDefaults;

@end

@implementation UserNotificationInfoController

#pragma mark - Lyfe cycle -

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpDefaults];
    
    [self titleLabel];
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

- (UILabel*) titleLabel
{
    UIFont* customFont = [UIFont fontWithName: @"SFUIText-Regular"
                                         size: 14.0f];
    
    UILabel *label        = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 480, 18)];
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines   = 1;
    label.font            = customFont;
    label.textAlignment   = NSTextAlignmentCenter;
    label.textColor       = [UIColor whiteColor];
    label.text            = @"ВАШ ПРОФИЛЬ";
    
    [label sizeToFit];
    
    
    
    self.navigationItem.titleView = label;
    
    return label;
}

@end
