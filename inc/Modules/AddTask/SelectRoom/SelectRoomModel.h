//
//  SelectRoomModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/16/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"
#import "ProjectTaskStage+CoreDataClass.h"

@interface SelectRoomModel : NSObject

- (void) markLevelAsExpandedAtIndexPath: (NSInteger) section;

- (RACSignal*) updateContent;

- (ProjectTaskStage*) getStageForSection: (NSUInteger) section;

@end
