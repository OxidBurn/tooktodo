//
//  SelectResponsibleModel.h
//  TookTODO
//
//  Created by Глеб on 22.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Classes
#import "FilledTeamInfo.h"


typedef NS_ENUM(NSUInteger, MarkOption) {
    
    SingleMark,
    MultipleMarks,
    
};

@interface SelectResponsibleModel : NSObject

// methods

- (void) updateTeamInfoWithCompletion: (CompletionWithSuccess) completion;

- (NSUInteger) getNumberOfRows;

- (FilledTeamInfo*) returnFilledUserInfoForIndex: (NSUInteger) index;

- (void) handleCheckmarkForIndexPath: (NSIndexPath*) indexPath;

- (BOOL) getStateForMemberAtIndex: (NSUInteger) index;

- (void) fillContollerMarkOption: (MarkOption) controllerMarkOption;

@end
