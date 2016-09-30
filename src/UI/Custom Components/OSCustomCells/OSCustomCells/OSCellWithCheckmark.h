//
//  OSCellWithCheckmark.h
//  TookTODO
//
//  Created by Lera on 30.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ProjectTaskStage+CoreDataClass.h"

@interface OSCellWithCheckmark : UITableViewCell

- (void) fillCellWithTitle: (NSString*) title;

- (void) changeCheckmarkState: (BOOL) state;

- (BOOL) currentCheckMarkState;

@end
