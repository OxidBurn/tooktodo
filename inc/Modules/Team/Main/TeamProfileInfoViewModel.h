//
//  TeamProfileInfoViewModel.h
//  TookTODO
//
//  Created by Глеб on 06.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RolesViewController.h"

@protocol TeamProfileViewModelDelegate;

@interface TeamProfileInfoViewModel : NSObject <RolesViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id<TeamProfileViewModelDelegate> delegate;

- (RACSignal*) updateInfo;

- (void) performActionForIndex: (NSUInteger) index;

- (NSString*) getProjectName;

@end

@protocol TeamProfileViewModelDelegate <NSObject>

- (void) showControllerWithIdentifier: (NSString*) segueID;

- (void) showDesignationAlert: (NSString*) userName;

- (void) showEmailComposerForMail: (NSString*) email;

@end
