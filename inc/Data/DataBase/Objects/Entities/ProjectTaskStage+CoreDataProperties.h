//
//  ProjectTaskStage+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 9/11/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ProjectTaskStage.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProjectTaskStage (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *stageID;
@property (nullable, nonatomic, retain) NSNumber *isCommon;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSManagedObject *task;

@end

NS_ASSUME_NONNULL_END
