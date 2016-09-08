//
//  OSAlertDesignateAdminController.h
//  TookTODO
//
//  Created by Lera on 08.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSAlertViewController.h"

@protocol OSAlertDesignateAdminControllerDelegate;

@interface OSAlertDesignateAdminController : OSAlertViewController

@property (nonatomic, weak) id <OSAlertDesignateAdminControllerDelegate> delegate;

- (void) setImage: (UIImage*)  image
         withName: (NSString*) name;

@end

@protocol OSAlertDesignateAdminControllerDelegate <NSObject>

- (void) performActionForButtonTag: (NSUInteger) btnTag;

@end
