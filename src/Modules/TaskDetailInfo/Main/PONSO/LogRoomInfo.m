//
//  LogRoomInfo.m
//  TookTODO
//
//  Created by Nikolay Chaban on 12/26/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "LogRoomInfo.h"

@interface LogRoomInfo()

// properties

@property (nonatomic, strong) NSString* roomNumber;

@property (strong, nonatomic) NSString* roomTitle;

// methods


@end

@implementation LogRoomInfo


#pragma mark - Initialization -

- (instancetype) initWithRoomNumber: (NSNumber*) number
                          withTitle: (NSString*) title
{
    if ( self = [super init] )
    {
        self.roomNumber = number.stringValue;
        self.roomTitle  = title;
    }
    
    return self;
}


#pragma mark - Public method -

- (NSAttributedString*) getRoomInfoWithAttributesForLog
{
    NSMutableAttributedString* roomInfoWithAttribute = [[NSMutableAttributedString alloc] init];
    
    [roomInfoWithAttribute appendAttributedString: [self getRoomNumberStringForLog]];
    [roomInfoWithAttribute appendAttributedString: [self getRoomTitleStringForLog]];
    
    return roomInfoWithAttribute.copy;
}


#pragma mark - Internal methods -

- (NSAttributedString*) getRoomNumberStringForLog
{
    NSAttributedString* numberString = [[NSAttributedString alloc] initWithString: self.roomNumber
                                                                       attributes: @{}];
    
    return numberString;
}

- (NSAttributedString*) getRoomTitleStringForLog
{
    NSAttributedString* titleString = [[NSAttributedString alloc] initWithString: self.roomTitle
                                                                      attributes: @{}];
    
    return titleString;
}

@end
