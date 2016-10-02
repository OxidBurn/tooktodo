//
//  OSDefaultAlertController.h
//  TookTODO
//
//  Created by Chaban Nikolay on 9/8/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSAlertViewController.h"

// Classes
#import "OSAlertControllerProtocol.h"

@interface OSDefaultAlertController : OSAlertViewController

//properties

@property (nonatomic, weak) id <OSAlertControllerProtocol> delegate;

// methods

- (void) setTitle: (NSString*) title
      withMessage: (NSString*) message
      withBtnText: (NSString*) btnText;

@end
