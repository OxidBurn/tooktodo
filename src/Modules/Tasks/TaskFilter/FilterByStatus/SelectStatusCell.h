//
//  SelectStatusCell.h
//  TookTODO
//
//  Created by Nikolay Chaban on 25.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectStatusCell : UITableViewCell

// methods
- (void) fillCellForIndexPath: (NSIndexPath*) indexPath
            withSelectedState: (BOOL)         isSelected;

- (void) changeCheckmarkState: (BOOL) state;

- (BOOL) currentCheckMarkState;

@end
