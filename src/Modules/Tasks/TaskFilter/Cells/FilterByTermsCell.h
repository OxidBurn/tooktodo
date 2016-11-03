//
//  FilterByTermsCell.h
//  TookTODO
//
//  Created by Nikolay Chaban on 01.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterByTermsCell : UITableViewCell

// methods

- (void) fillCellWithTitle: (NSString*) titleText
                withDetail: (NSString*) detailText;

@end
