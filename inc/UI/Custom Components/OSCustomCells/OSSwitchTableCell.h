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

- (void) fillCellWithTitle: (NSString*)  titleText
                   withTag: (NSUInteger) tag
           withSwitchState: (BOOL)       isSelected
              withDelegate: (id)         delegate
          withEnabledState: (BOOL)       isEnabled;

- (void) resetValue;

@end

@protocol OSSwitchTableCellDelegate <NSObject>

@optional

- (void) updateTaskHiddenProperty: (BOOL) isHidden;

- (void) updateTermsOption: (BOOL)       isOn
                    forTag: (NSUInteger) tag;


@end
