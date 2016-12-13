//
//  AddTaskTypeTableViewCell.h
//  TookTODO
//
//  Created by Nikolay Chaban on 10/7/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddTaskTypeTableViewCell : UITableViewCell

// methods

- (void) setTypeTitle: (NSString*) title
        withTypeColor: (UIColor*)  color;

- (void) markCellAsSelected: (BOOL) isSelected;

@end
