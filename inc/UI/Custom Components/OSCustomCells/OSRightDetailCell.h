//
//  RightDetailCell.h
//  TookTODO
//
//  Created by Chaban Nikolay on 9/15/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OSRightDetailCell : UITableViewCell

// methods

- (void) fillCellWithTitle: (NSString*) titleText
                withDetail: (NSString*) detailText;

@end
