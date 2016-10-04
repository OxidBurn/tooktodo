//
//  OSAlertControllerProtocol.h
//  TookTODO
//
//  Created by Nikolay Chaban on 10/2/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#ifndef OSAlertControllerProtocol_h
#define OSAlertControllerProtocol_h
    
@protocol OSAlertControllerProtocol <NSObject>

- (void) didDoneAlertAction;

@optional

- (void) didDismissAlertAction;

@end

#endif /* OSAlertControllerProtocol_h */
