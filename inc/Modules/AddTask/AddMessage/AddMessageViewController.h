//
//  AddMessageViewController.h
//  TookTODO
//
// Created by Nikolay Chaban on 27.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddMessageViewControllerDelegate;

@interface AddMessageViewController : UIViewController

// properties
@property (nonatomic, strong) id<AddMessageViewControllerDelegate> delegate;

// methods
- (void) updateDescription: (NSString*) descriptionText
          andReturnToModel: (id)        model;

@end

@protocol AddMessageViewControllerDelegate <NSObject>

- (void) setTaskDescription: (NSString*) taskDescription;

@end
