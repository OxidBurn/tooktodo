//
//  SelectRoomViewModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/16/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"
#import "ProjectTaskRoomLevel+CoreDataClass.h"
#import "ProjectTaskRoom+CoreDataClass.h"

@interface SelectRoomViewModel : NSObject <UITableViewDelegate, UITableViewDataSource>

- (RACSignal*) updateContent;

- (void) resetAllWithCompletion: (CompletionWithSuccess) completion;

- (void) fillSelectedRoom: (id) selectedRoom;

- (ProjectTaskRoom*) getSelectedRoom;

- (ProjectTaskRoomLevel*) getSelectedLevel;

- (id) getSelectedInfo;

@end
