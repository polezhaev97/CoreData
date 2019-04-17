//
//  EditStudentInfoViewController.h
//  CoreData
//
//  Created by mbp on 22/03/2019.
//  Copyright © 2019 mbp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StudentInfoView.h"
#import "DataManager.h"
#import "DynamicBackgroundView.h"

NS_ASSUME_NONNULL_BEGIN

@interface EditStudentInfoViewController : UIViewController

@property(strong, nonatomic) StudentInfoView* studentInfo;
@property (strong, nonatomic) Student*  student;
@property(strong, nonatomic) NSMutableSet* selectedCourses;
@property(strong, nonatomic) NSMutableArray* coursesArray;

@end

NS_ASSUME_NONNULL_END
