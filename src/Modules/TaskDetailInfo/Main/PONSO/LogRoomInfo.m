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


#pragma mark - Public methods -

- (NSAttributedString*) getRoomInfoWithAttributesForLog
{
    NSMutableAttributedString* roomInfoWithAttribute = [[NSMutableAttributedString alloc] init];
    
    [roomInfoWithAttribute appendAttributedString: [self getRoomNumberStringForLog]];
    [roomInfoWithAttribute appendAttributedString: [[NSAttributedString alloc] initWithString: @" "]];
    [roomInfoWithAttribute appendAttributedString: [self getRoomTitleStringForLog]];
    
    return roomInfoWithAttribute.copy;
}


#pragma mark - Internal methods -

- (NSAttributedString*) getRoomNumberStringForLog
{
    UIFont* roomNumberFont = [UIFont fontWithName: @"SFUIText-Semibold"
                                             size: 13.f];
    
    NSAttributedString* numberString = [[NSAttributedString alloc] initWithString: ( self.roomNumber ) ? self.roomNumber : @""
                                                                       attributes: @{ NSFontAttributeName: roomNumberFont}];
    
    return numberString;
}

- (NSAttributedString*) getRoomTitleStringForLog
{
    UIFont* roomTitleFont = [UIFont fontWithName: @"SFUIText-Regular"
                                             size: 13.f];
    
    NSAttributedString* titleString = [[NSAttributedString alloc] initWithString: ( self.roomTitle ) ? self.roomTitle : @""
                                                                      attributes: @{ NSFontAttributeName: roomTitleFont}];
    
    return titleString;
}

@end
