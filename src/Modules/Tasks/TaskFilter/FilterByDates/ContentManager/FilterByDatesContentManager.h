//
//  FilterByDatesContentManager.h
//  TookTODO
//
//  Created by Nikolay Chaban on 04.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Classes
#import "TermsData.h"

@interface FilterByDatesContentManager : NSObject

// methods
- (NSArray*) getFilterByDatesContentForTerms: (TermsData*) terms;

- (NSArray*) updateDateLabelContentWithDate: (NSDate*)    date
                           forPickerWithTag: (NSUInteger) pickerTag;

- (TermsData*) getTermsData;

- (NSString*) getStringFromDate: (NSDate*) date;

- (void) fillTerms: (TermsData*) terms;

@end
