//
//  UserInfoViewModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/15/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "UserInfoViewModel.h"
#import "UserInfoModel.h"

@interface UserInfoViewModel()

// properties

@property (strong, nonatomic) UserInfoModel* model;

// methods


@end

@implementation UserInfoViewModel


#pragma mark - Properties -

- (UserInfoModel*) model
{
    if ( _model == nil )
    {
        _model = [UserInfoModel new];
    }
    
    return _model;
}


#pragma mark - Public -

- (UIImage*) userAvatar
{
    return [self.model getUserAvatarImage];
}

- (NSString*) fullUserName
{
    return [self.model getFullUserName];
}

@end
