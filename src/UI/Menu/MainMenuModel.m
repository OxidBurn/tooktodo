//
//  MainMenuModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/15/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "MainMenuModel.h"

// Classes
#import "DataManager+UserInfo.h"
#import "UserInfo.h"
#import "Utils.h"

@interface MainMenuModel()

// properties

@property (strong, nonatomic) UserInfo* currentUserInfo;

// methods


@end

@implementation MainMenuModel


#pragma mark - Initialization -

- (instancetype) init
{
    if ( self = [super init] )
    {
        
    }
    
    return self;
}


#pragma mark - Properties -

- (UserInfo *)currentUserInfo
{
    if ( _currentUserInfo == nil )
    {
        _currentUserInfo = [DataManagerShared getCurrentUserInfo];
    }
    
    return _currentUserInfo;
}

#pragma mark - Public -

- (RACSignal*) sendReviewSignal
{
    @weakify(self)
    
    return [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
        
        @strongify(self)
        
        [SharedApplication openURL: [self getApplicationStoreURL]];
        
        [subscriber sendCompleted];
        
        return nil;
        
    }];
}

- (NSString*) getFullUserName
{
    return self.currentUserInfo.fullName;
}

- (UIImage*) getUserAvatarImage
{
    if ( self.currentUserInfo )
    {
        NSString* filePath   = [[Utils getAvatarsDirectoryPath] stringByAppendingString: self.currentUserInfo.photoImagePath];
        UIImage* avatarImage = [UIImage imageWithContentsOfFile: filePath];
        
        return avatarImage;
    }
    
    return nil;
}


#pragma mark - Internal methods -

- (NSURL*) getApplicationStoreURL
{
    return [NSURL URLWithString: @""];
}

@end
