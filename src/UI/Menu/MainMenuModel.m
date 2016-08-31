//
//  MainMenuModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/15/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "MainMenuModel.h"

// Classes
#import "UserInfo.h"
#import "Utils.h"
#import "ProjectsService.h"

// Frameworks
#import <JSONModel/JSONModel.h>

// Extensions
#import "DataManager+UserInfo.h"
#import "DataManager+ProjectInfo.h"

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

- (UserInfo*) currentUserInfo
{
    if ( _currentUserInfo == nil )
    {
        _currentUserInfo = [DataManagerShared getCurrentUserInfo];
    }
    
    return _currentUserInfo;
}

- (void) updateUserData
{
    self.currentUserInfo = [DataManagerShared getCurrentUserInfo];
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
    if ( self.currentUserInfo.photoImagePath )
    {
        NSString* filePath   = [[Utils getAvatarsDirectoryPath] stringByAppendingString: self.currentUserInfo.photoImagePath];
        UIImage* avatarImage = [UIImage imageWithContentsOfFile: filePath];
        
        return avatarImage;
    }
    
    return nil;
}

- (NSURL*) getUserAvatarURL
{
    return [NSURL URLWithString: self.currentUserInfo.avatarSrc];
}

- (NSArray*) getProjects
{
    return [DataManagerShared getAllProjects];
}

- (RACSignal*) loadProjectsList
{
    return [[ProjectsService sharedInstance] getAllProjectsList];
}


#pragma mark - Internal methods -

- (NSURL*) getApplicationStoreURL
{
    return [NSURL URLWithString: @""];
}

@end
