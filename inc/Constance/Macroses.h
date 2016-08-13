//
//  Macroses.h
//  TookTODO
//
//  Created by Nikolay Chaban on 8/12/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#ifndef Macroses_h
#define Macroses_h

// Color
#define RGB(r, g, b)     [UIColor colorWithRed: r/255.0 green: g/255.0 blue: b/255.0 alpha: 1.0]

// App
#define UserDefaults                        [NSUserDefaults standardUserDefaults]
#define SharedApplication                   [UIApplication sharedApplication]
#define DefaultNotifyCenter                 [NSNotificationCenter defaultCenter]
#define DefaultFileManager                  [NSFileManager defaultManager]
#define KeyChain                            [KeyChainManager sharedInstance]

#define MainBundle                          [NSBundle mainBundle]
#define MainScreen                          [UIScreen mainScreen]
#define ShowNetworkActivityIndicator()      [UIApplication sharedApplication].networkActivityIndicatorVisible = YES
#define HideNetworkActivityIndicator()      [UIApplication sharedApplication].networkActivityIndicatorVisible = NO
#define NetworkActivityIndicatorVisible(x)  [UIApplication sharedApplication].networkActivityIndicatorVisible = x
#define NavBar                              self.navigationController.navigationBar

#endif /* Macroses_h */
