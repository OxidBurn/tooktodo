//
//  ViewController.h
//  TookTODO
//
//  Created by Nikolay Chaban on 8/8/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "BaseMainViewController.h"

@interface LoginViewController : BaseMainViewController

@property (nonatomic, copy) void(^dismissLoginView)();

@end

