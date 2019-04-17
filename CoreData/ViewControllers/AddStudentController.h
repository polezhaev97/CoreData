//
//  StudentInfoController.h
//  CoreData
//
//  Created by mbp on 21/03/2019.
//  Copyright © 2019 mbp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StudentInfoView.h"
#import "DataManager.h"
#import "DynamicBackgroundView.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddStudentController : UIViewController

@property(strong, nonatomic) StudentInfoView* studentInfo;
@property (strong, nonatomic) Course*  courses;

@end

NS_ASSUME_NONNULL_END
