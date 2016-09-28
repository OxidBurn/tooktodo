//
//  SwitchTableCell.h
//  TookTODO
//
//  Created by Chaban Nikolay on 9/15/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OSSwitchTableCellDelegate;

@interface OSSwitchTableCell : UITableViewCell

// properties
@property (weak, nonatomic) id <OSSwitchTableCellDelegate> delegate;

// methods

- (void) fillCellWithTitle: (NSString*) titleText
           withSwitchState: (BOOL)      isSelected
              withDelegate: (id)        delegate;

@end

@protocol OSSwitchTableCellDelegate <NSObject>

- (void) updateTaskState: (BOOL) isHidden;

@end
