//
//  ProjectSystem+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 9/4/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ProjectSystem.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProjectSystem (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *systemID;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *shortTitle;
@property (nullable, nonatomic, retain) NSNumber *hasTasks;
@property (nullable, nonatomic, retain) ProjectInfo *project;

@end

NS_ASSUME_NONNULL_END
