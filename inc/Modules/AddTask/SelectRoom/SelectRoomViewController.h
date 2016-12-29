//
//  SelectionPremisesController.h
//  TookTODO
//
//  Created by Chaban Nikolay on 9/16/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

// Classes
#import "ProjectTaskRoom+CoreDataClass.h"
#import "ProjectTaskRoomLevel+CoreDataClass.h"
#import "BaseMainViewController.h"
#import "SelectedRoomsInfo.h"

@protocol SelectRoomViewControllerDelegate;

@interface SelectRoomViewController : BaseMainViewController

// properties
@property (nonatomic, weak) id <SelectRoomViewControllerDelegate> delegate;

// methods
- (void) fillSelectedRoom: (SelectedRoomsInfo*) selectedRooms
             withDelegate: (id)                 delegate;

@end

@protocol SelectRoomViewControllerDelegate <NSObject>

- (void) returnSelectedInfo: (SelectedRoomsInfo*) info;

@end
