//
//  FilterForResponsibleViewController.h
//  TookTODO
//
//  Created by Chaban Nikolay on 9/16/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ControllerMarkOption) {
    
    SingleMarkEnabled,
    MultipleMarksEnabled,

};

@interface SelectResponsibleViewController : UIViewController

// methods
- (instancetype) initWithMarkOption: (ControllerMarkOption) markOption;

- (void) setOption: (ControllerMarkOption) option;

@end
