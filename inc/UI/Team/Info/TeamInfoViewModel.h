//
//  TeamInfoViewModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/3/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks
@import UIKit;

@protocol TeamInfoViewModelDelegate;

@interface TeamInfoViewModel : NSObject <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

// properties
@property (weak, nonatomic) id <TeamInfoViewModelDelegate> delegate;

// methods

- (void) updateInfoWithCompletion: (CompletionWithSuccess) completion;


@end

@protocol TeamInfoViewModelDelegate <NSObject>

- (void) createActionSheetWithMainNumber: (NSString*) mainNumber
                       andAdditionNumber: (NSString*) additionNumber;

- (void) showEmailComposerForMail: (NSString*) email;

@end