//
//  EditCoursesViewController.h
//  CoreData
//
//  Created by mbp on 04/04/2019.
//  Copyright © 2019 mbp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoursesInfoView.h"
#import "DataManager.h"
#import "DynamicBackgroundView.h"

NS_ASSUME_NONNULL_BEGIN

@interface EditCoursesViewController : UIViewController

@property(strong, nonatomic) CoursesInfoView* coursesInfo;
@property(strong, nonatomic) Course* courses;
@property (strong, nonatomic) Student*  student;


@end

NS_ASSUME_NONNULL_END
