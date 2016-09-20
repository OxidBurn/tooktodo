//
//  ViewController.h
//  TookTODO
//
//  Created by Nikolay Chaban on 8/8/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "BaseMainViewController.h"
#import "OSDefaultAlertController.h"

@interface LoginViewController : BaseMainViewController 

@property (nonatomic, copy) void(^dismissLoginView)();

@property (nonatomic, strong) NSString* alertEmailText;

//methods



@end

