//
//  AddMessageViewController.h
//  TookTODO
//
//  Created by Lera on 27.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddMessageViewControllerDelegate;

@interface AddMessageViewController : UIViewController

@property (nonatomic, strong) id<AddMessageViewControllerDelegate> delegate;

@end

@protocol AddMessageViewControllerDelegate <NSObject>

- (void) setTaskDescription: (NSString*) taskDescription;

@end
