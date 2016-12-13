//
//  SecureTextField.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/4/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OSSecureTextField : UITextField

- (void) updateSecureState: (BOOL) isSecure;

@end
