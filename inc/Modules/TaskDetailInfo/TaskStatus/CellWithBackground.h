//
//  CellWithBackground.h
//  TookTODO
//
//  Created by Lera on 11.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellWithBackground : UITableViewCell

- (void) fillCellWithStatusName: (NSString*) name
                          image: (UIImage*)  image
                     background: (UIColor*)  background
                     arrowState: (BOOL)      isHiddenArrow;

@end
