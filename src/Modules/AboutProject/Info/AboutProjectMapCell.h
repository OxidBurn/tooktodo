//
//  AboutProjectMapCell.h
//  TookTODO
//
//  Created by Глеб on 28.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutProjectMapCell : UITableViewCell

// mehtods
- (void) fillCellWithTitle: (NSString*) title
           withCoordinates: (NSString*) coordinates;

@end
