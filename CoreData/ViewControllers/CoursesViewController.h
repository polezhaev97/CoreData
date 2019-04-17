//
//  АacultyViewController.h
//  CoreData
//
//  Created by mbp on 30/03/2019.
//  Copyright © 2019 mbp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoursesViewController : UIViewController

@property(strong, nonatomic) NSMutableArray* coursesArray;
@property (strong, nonatomic) Student*  student;

-(void) reloadData;

@end

NS_ASSUME_NONNULL_END
