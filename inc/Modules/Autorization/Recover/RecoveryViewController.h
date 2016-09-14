//
//  RecoveryViewController.h
//  TookTODO
//
//  Created by Nikolay Chaban on 09.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Classes
#import "BaseMainViewController.h"
#import "RecoveryViewModel.h"


@protocol RecoveryViewControllerDeledate;

@interface RecoveryViewController : BaseMainViewController

// properties

@property (nonatomic, weak) id<RecoveryViewControllerDeledate> delegate;

// methods

- (void) setRecoveryModel: (RecoveryViewModel*) model;


@end

@protocol RecoveryViewControllerDeledate <NSObject>

- (void) showSuccessRestoreAlert: (NSString*) text;

@end