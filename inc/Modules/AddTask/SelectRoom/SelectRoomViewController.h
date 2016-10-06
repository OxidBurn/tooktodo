//
//  SelectionPremisesController.h
//  TookTODO
//
//  Created by Chaban Nikolay on 9/16/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectRoomViewController;

@interface SelectRoomViewController : UIViewController

// properties
@property (nonatomic, weak) id<SelectRoomViewController> delegate;

// methods
- (void) fillSelectedRoom: (id) room
              atIndexPath: (NSIndexPath*) indexPath
             withDelegate: (id <SelectRoomViewController>) delegate;

@end

@protocol SelectRoomViewController <NSObject>

- (void) returnSelectedItem: (id) item;

@end
