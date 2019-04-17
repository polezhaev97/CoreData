//
//  DataManager.h
//  CoreData
//
//  Created by mbp on 20/03/2019.
//  Copyright © 2019 mbp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CoreData+CoreDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DataManager : NSObject

@property (readonly, strong) NSPersistentContainer *persistentContainer;

+ (id) sharedManager;

-(NSArray*) getAllCourses;
-(NSArray*) getAllStudents;

-(void) addCourses:(NSString*) name and:(NSString*) lesson and:(NSString*) teacher andStudents:(NSSet*)students;
-(void) addNewStudent:(NSString*) name and: (NSString*) surname and:(NSString*) number andCourses:(NSSet* )courses;

-(void) deleteAllStudents;
-(void) deleteAllCourses;

-(void) editStudent:(Student*) student;
-(void) editCourses:(Course*) courses;

-(void) deleteStudent:(Student*) student;
-(void) deleteCourses:(Course*) curses;

-(NSArray*) getCourses;
-(NSArray*) getStudents;

- (void)saveContext;

@end

NS_ASSUME_NONNULL_END
