//
//  AddCoursesViewController.h
//  CoreData
//
//  Created by mbp on 31/03/2019.
//  Copyright © 2019 mbp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoursesInfoView.h"
#import "DataManager.h"
#import "DynamicBackgroundView.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddCoursesViewController : UIViewController

@property(strong, nonatomic) CoursesInfoView* coursesInfo;
@property(strong, nonatomic) Student* student;

@end

NS_ASSUME_NONNULL_END
