//
//  OSAlertDesignateAdminController.h
//  TookTODO
//
//  Created by Nikolay Chaban on 08.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSAlertViewController.h"

// Classes
#import "OSAlertControllerProtocol.h"

@interface OSAlertDesignateAdminController : OSAlertViewController

@property (nonatomic, weak) id <OSAlertControllerProtocol> delegate;

- (void) setImage: (NSString*) imagePath
         withName: (NSString*) name
      withMessage: (NSString*) message;

@end

