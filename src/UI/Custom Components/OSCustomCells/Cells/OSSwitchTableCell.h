//
//  SwitchTableCell.h
//  TookTODO
//
//  Created by Chaban Nikolay on 9/15/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OSSwitchTableCell : UITableViewCell

// methods

- (void) fillCellWithTitle: (NSString*) titleText
           withSwitchState: (BOOL)      isSelected;

@end
