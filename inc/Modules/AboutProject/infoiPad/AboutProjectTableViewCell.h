//
//  AboutProjectTableViewCell.h
//  TookTODO
//
//  Created by Chaban Nikolay on 10/28/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutProjectTableViewCell : UITableViewCell

// methods
- (void) fillCellWithTitle: (NSString*) title;

- (void) selectCell;

- (void) deselectCell;

@end
