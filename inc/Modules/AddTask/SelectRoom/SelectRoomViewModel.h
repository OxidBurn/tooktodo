//
//  SelectRoomViewModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/16/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Framework
#import "ReactiveCocoa.h"

// Classes
#import "ProjectTaskRoomLevel+CoreDataClass.h"
#import "ProjectTaskRoom+CoreDataClass.h"
#import "SelectedRoomsInfo.h"

@interface SelectRoomViewModel : NSObject <UITableViewDelegate, UITableViewDataSource>

// methods

- (void) fillSelectedRoomsInfo: (SelectedRoomsInfo*) selectedRooms;

- (void) resetAllWithCompletion: (CompletionWithSuccess) completion;

- (SelectedRoomsInfo*) getSelectedInfo;

- (NSString*) getProjectName;

@end
