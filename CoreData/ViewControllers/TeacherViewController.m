//
//  SettingsViewController.m
//  CoreData
//
//  Created by mbp on 31/03/2019.
//  Copyright © 2019 mbp. All rights reserved.
//

#import "TeacherViewController.h"

@implementation TeacherViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    DynamicBackgroundView * view = [[DynamicBackgroundView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:view];

    UILabel* noTeachersInfo = [[UILabel alloc] initWithFrame:self.view.frame];
    noTeachersInfo.text = @"Преподаватели все ушли";
    noTeachersInfo.font = [UIFont systemFontOfSize:25];
    noTeachersInfo.textColor = [UIColor orangeColor];
    noTeachersInfo.textAlignment = NSTextAlignmentCenter;
    
    [view addSubview:noTeachersInfo];
}

@end
