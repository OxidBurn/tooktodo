//
//  OSDatePickerCell.h
//  TookTODO
//
//  Created by Nikolay Chaban on 19.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OSDatePickerCellDelegate;

@interface OSDatePickerCell : UITableViewCell

// properties
@property (weak, nonatomic) id <OSDatePickerCellDelegate> delegate;

// methods
- (void) setTagToDatePicker: (NSUInteger)    tag
               withDelegate: (id <NSObject>) delegate;
@end

@protocol OSDatePickerCellDelegate <NSObject>

- (void) updateDateLabelWithDate: (NSDate*)    date
                forPickerWithTag: (NSUInteger) pickerTag;

@end
