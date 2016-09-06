//
//  TeamProfileInfoViewModel.h
//  TookTODO
//
//  Created by Lera on 05.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RolesViewController.h"

@protocol TeamProfileViewModelDelegate;

@interface TeamProfileInfoViewModel : NSObject <RolesViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id<TeamProfileViewModelDelegate> delegate;

- (RACSignal*) updateInfo;

- (void) performActionForIndex: (NSUInteger) index;

@end

@protocol TeamProfileViewModelDelegate <NSObject>

- (void) showControllerWithIdentifier: (NSString*) segueID;

- (void) showDesignationAlert: (NSString*) userName;

@end