//
//  StatusMarkerComponent.h
//  TookTODO
//
//  Created by Chaban Nikolay on 8/26/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectsEnumerations.h"

@interface StatusMarkerComponent : UIView

- (void) setStatusString: (NSString*) status
                withType: (TaskType) type;

- (UILabel*) getStatusTextLabel;

@end
