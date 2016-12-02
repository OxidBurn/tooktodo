//
//  OSFlexibleTextFieldCell.h
//  TookTODO
//
//  Created by Nikolay Chaban on 21.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddTaskViewModel.h"

@protocol OSFlexibleTextFieldCellDelegate;

@interface OSFlexibleTextFieldCell : UITableViewCell

// properties
@property (weak, nonatomic) id <OSFlexibleTextFieldCellDelegate> delegate;

// methods
- (void) fillCellWithText: (NSString*) textContent
             withDelegate: (id)        delegate;

- (void) resetCellContent;

@end

@protocol OSFlexibleTextFieldCellDelegate <NSObject>

- (void) updateFlexibleTextFieldCellWithText: (NSString*) newTaskNameString;

- (void) updateFlexibleTextFieldCellFrame;

- (AddTaskViewModel*) getViewModel;

@end
