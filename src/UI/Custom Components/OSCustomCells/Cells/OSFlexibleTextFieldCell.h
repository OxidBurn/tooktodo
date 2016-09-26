//
//  OSFlexibleTextFieldCell.h
//  TookTODO
//
//  Created by Глеб on 21.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddTaskViewModel.h"

@protocol OSFlexibleTextFieldCellDelegate;

@interface OSFlexibleTextFieldCell : UITableViewCell

// properties
@property (weak, nonatomic) id <OSFlexibleTextFieldCellDelegate> delegate;

// methods
- (void) fillCellWithText: (NSString*) textContent;

- (void) editTextLabel;

@end

@protocol OSFlexibleTextFieldCellDelegate <NSObject>

- (void) updateFlexibleTextFieldCellWithText: (NSString*) newTaskNameString;

- (AddTaskViewModel*) getViewModel;

@end
