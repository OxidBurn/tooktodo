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
#import "LoginService.h"
#import "ProjectInfoData.h"

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

- (NSArray*) getProjects
{
    return [DataManagerShared getAllProjects];
}

- (RACSignal*) loadProjectsList
{
    NSDictionary* requestParameter = @{@"skip" : @(0),
                                       @"take" : @(100)};
    
    @weakify(self)
    
    RACSignal* loadingSignal = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[LoginService getProjectsList: requestParameter] subscribeNext: ^(RACTuple* tuple) {
            
            @strongify(self)
            
            [self parseGettingProjectsResponse: tuple[0]
                                withCompletion: ^{
                                   
                                    [subscriber sendNext: nil];
                                    [subscriber sendCompleted];
                                    
                                }];
            
        }
                                                                  error: ^(NSError *error) {
                                                                      
                                                                      [subscriber sendError: error];
                                                                      
                                                                  }];
        
        
        return nil;
    }];
    
    
    return loadingSignal;
}



#pragma mark - Internal methods -

- (NSURL*) getApplicationStoreURL
{
    return [NSURL URLWithString: @""];
}

- (void) parseGettingProjectsResponse: (NSDictionary*) response
                       withCompletion: (void(^)())     completion
{
    NSError* parseError       = nil;
    NSArray* responseProjects = response[@"list"];
    NSArray* projectsList     = [ProjectInfoData arrayOfModelsFromDictionaries: responseProjects
                                                                         error: &parseError];
    
    if ( parseError )
    {
        NSLog(@"Parse error %@", parseError.localizedDescription);
    }
    else
    {
        [DataManagerShared persistNewProjects: projectsList
                               withCompletion: ^{
                                   
                                   completion();
                                   
                               }];
    }
}

@end
