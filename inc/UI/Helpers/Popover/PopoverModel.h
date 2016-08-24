//
//  PopoverModel.h
//  TookTODO
//
//  Created by Глеб on 24.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PopoverModelDelegate;

@interface PopoverModel : NSObject <UITableViewDataSource, UITableViewDelegate>

//properties
@property (weak, nonatomic) id <PopoverModelDelegate> delegate;


//methods
- (instancetype) initWithType: (NSUInteger)                popoverType
                 withDelegate: (id <PopoverModelDelegate>) delegate;

- (CGSize) getPopoverSizeForType: (NSUInteger) typeIndex;

@end


@protocol PopoverModelDelegate <NSObject>

// methods
@optional
- (void) didSelectItemAtIndex: (NSUInteger) index;

- (void) dismissPopover;

@end
