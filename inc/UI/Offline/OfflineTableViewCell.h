//
//  OfflineTableViewCell.h
//  TookTODO
//
//  Created by Nikolay Chaban on 8/22/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OfflineTableViewCell : UITableViewCell

// properties

@property (copy, nonatomic) void(^didToggleEnableState)(BOOL isEnable);

// methods



@end
