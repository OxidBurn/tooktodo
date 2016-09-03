//
//  TeamInfoModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/3/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks
#import "ReactiveCocoa.h"

// Classes
#import "TeamMember.h"

// Categories
#import "DataManager+Team.h"

@protocol TeamInfoModelDelegate;

@interface TeamInfoModel : NSObject

//properties
@property (weak, nonatomic) id <TeamInfoModelDelegate> delegate;

//methods
- (void) updateTeamInfoWithCompletion: (CompletionWithSuccess) completion;

- (NSUInteger) countOfItems;

- (TeamMember*) teamMemberByIndex: (NSUInteger) index;

- (void) handleCallForUserAtIndex: (NSUInteger) index;

- (void) markItemAsSelectedAtIndex: (NSUInteger) index;

@end

@protocol TeamInfoModelDelegate <NSObject>

- (void) returnPhoneNumbers: (NSString*) mainNumber
                       with: (NSString*) additionNumber;

@end
