//
//  MainMenuViewModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 8/15/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ReactiveCocoa.h"

@interface MainMenuViewModel : NSObject <UITableViewDataSource, UITableViewDelegate>

// properties

// Send email to support
// for now it's just stub
@property (strong, nonatomic) RACCommand* supportActionCommand;

// Open review page
// for now it's just stub, will be worked when application would be on AppStore
@property (strong, nonatomic) RACCommand* reviewActionCommand;

@property (copy, nonatomic) void(^hideMenu)();

// methods

- (void) updateUserData;

- (UIImage*) userAvatar;

- (NSString*) fullUserName;

- (RACSignal*) loadProjectsList;

- (void) updateProjectsContent;

- (NSURL*) getUserAvatarURL;

@end
