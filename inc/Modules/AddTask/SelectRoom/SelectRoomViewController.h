//
//  SelectionPremisesController.h
//  TookTODO
//
//  Created by Chaban Nikolay on 9/16/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectTaskRoom+CoreDataClass.h"
#import "ProjectTaskRoomLevel+CoreDataClass.h"

#import "BaseMainViewController.h"

@protocol SelectRoomViewController;

@interface SelectRoomViewController : BaseMainViewController

// properties
@property (nonatomic, weak) id<SelectRoomViewController> delegate;

// methods
- (void) fillSelectedRoom: (id) room
             withDelegate: (id <SelectRoomViewController>) delegate;

@end

@protocol SelectRoomViewController <NSObject>

- (void) returnSelectedInfo: (id) info;

@end
