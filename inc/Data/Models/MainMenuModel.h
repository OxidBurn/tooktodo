//
//  MainMenuModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 8/15/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks
#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

// Classes
#import "ProjectInfo.h"

@interface MainMenuModel : NSObject

// properties


// methods


- (RACSignal*) sendReviewSignal;

- (NSString*) getFullUserName;

- (UIImage*) getUserAvatarImage;

- (NSArray*) getProjects;

- (RACSignal*) loadProjectsList;

- (NSURL*) getUserAvatarURL;

- (void) updateUserData;

- (void) setSelectedProject: (ProjectInfo*)            project
             withCompletion: (void(^)(BOOL isSuccess)) completion;

@end
