//
//  TeamProfileInfoViewModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 06.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Classes
#import "RolesViewController.h"
#import "OSAlertControllerProtocol.h"
#import "FilledTeamInfo.h"

@protocol TeamProfileViewModelDelegate;

@interface TeamProfileInfoViewModel : NSObject <RolesViewControllerDelegate, UITableViewDataSource, UITableViewDelegate, OSAlertControllerProtocol>

@property (nonatomic, weak) id<TeamProfileViewModelDelegate> delegate;

@property (nonatomic, copy) void(^reloadTableView)();

- (RACSignal*) updateInfo;

- (void) performActionForIndex: (NSUInteger) index;

- (NSString*) getProjectName;

- (void) fillSelectedTeamMember: (FilledTeamInfo*) teamMember;

@end

@protocol TeamProfileViewModelDelegate <NSObject>

- (void) showControllerWithIdentifier: (NSString*) segueID;

- (void) showDesignationAlert: (NSString*) userName
                   withAvatar: (NSString*) avatarPath
                  withMessage: (NSString*) message;

- (void) showEmailComposerForMail: (NSString*) email;

@end
