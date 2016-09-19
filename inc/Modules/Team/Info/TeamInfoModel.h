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
#import "ProjectRoleAssignments+CoreDataClass.h"

// Categories
#import "DataManager+Team.h"

typedef NS_ENUM(NSUInteger, FilteringMemebersState)
{
    TableNormalState,
    TableFilteringState,
};

@protocol TeamInfoModelDelegate;

@interface TeamInfoModel : NSObject

//properties
@property (weak, nonatomic) id <TeamInfoModelDelegate> delegate;

//methods
- (NSString*) getProjectName;

- (void) updateTeamInfoWithCompletion: (CompletionWithSuccess) completion;

- (NSUInteger) countOfItems;

- (ProjectRoleAssignments*) teamMemberByIndex: (NSUInteger) index;

- (void) handleCallForUserAtIndex: (NSUInteger) index;

- (NSString*) getEmailOfMemberAtIndex: (NSUInteger) index;

- (void) markItemAsSelectedAtIndex: (NSUInteger) index;

- (void) filteringWithKeyWord: (NSString*) keyWord;

- (BOOL) isEnableFiltering;

- (void) startFiltering;

- (void) stopFiltering;

@end

@protocol TeamInfoModelDelegate <NSObject>

- (void) returnPhoneNumbers: (NSString*) mainNumber
                       with: (NSString*) additionNumber;

@end
