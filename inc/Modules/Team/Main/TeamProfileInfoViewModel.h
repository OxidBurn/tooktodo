//
//  TeamProfileInfoViewModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 06.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RolesViewController.h"
#import "OSAlertDesignateAdminController.h"

@protocol TeamProfileViewModelDelegate;

@interface TeamProfileInfoViewModel : NSObject <RolesViewControllerDelegate, UITableViewDataSource, UITableViewDelegate, OSAlertDesignateAdminControllerDelegate>

@property (nonatomic, weak) id<TeamProfileViewModelDelegate> delegate;

@property (nonatomic, copy) void(^reloadTableView)();

- (RACSignal*) updateInfo;

- (void) performActionForIndex: (NSUInteger) index;

- (NSString*) getProjectName;

@end

@protocol TeamProfileViewModelDelegate <NSObject>

- (void) showControllerWithIdentifier: (NSString*) segueID;

//- (void) showDesignationAlert: (NSString*) userName;

- (void) showDesignationAlert: (NSString*) userName
                   withAvatar: (UIImage*)  avatar
                  withMessage: (NSString*) message;

- (void) showEmailComposerForMail: (NSString*) email;

@end
