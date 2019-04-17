//
//  StudentInfoView.m
//  CoreData
//
//  Created by mbp on 22/03/2019.
//  Copyright © 2019 mbp. All rights reserved.
//

#import "StudentInfoView.h"

@interface StudentInfoView ()

@property(strong, nonatomic) UILabel* nameLabel;
@property(strong, nonatomic) UILabel* surnameLabel;
@property(strong, nonatomic) UILabel* numberLabel;

@end

@implementation StudentInfoView

- (void)commonInit{
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.text = @"Имя";
    self.nameLabel.font =[UIFont systemFontOfSize:25];
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.translatesAutoresizingMaskIntoConstraints = NO;

    self.surnameLabel = [[UILabel alloc] init];
    self.surnameLabel.text = @"Фамилия";
    self.surnameLabel.font =[UIFont systemFontOfSize:25];
    self.surnameLabel.textColor = [UIColor whiteColor];
    self.surnameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.numberLabel = [[UILabel alloc] init];
    self.numberLabel.text = @"Номер телефона";
    self.numberLabel.font =[UIFont systemFontOfSize:25];
    self.numberLabel.textColor = [UIColor whiteColor];
    self.numberLabel.translatesAutoresizingMaskIntoConstraints = NO;

    self.nameField = [[UITextField alloc] init];
    self.nameField.placeholder = @"Имя";
    self.nameField.textAlignment = NSTextAlignmentCenter;
    [self.nameField setBorderStyle:UITextBorderStyleRoundedRect];
    self.nameField.translatesAutoresizingMaskIntoConstraints = NO;

    
    self.surnameField = [[UITextField alloc] init];
    self.surnameField.placeholder = @"Фамилия";
    self.surnameField.textAlignment = NSTextAlignmentCenter;
    [self.surnameField setBorderStyle:UITextBorderStyleRoundedRect];
    self.surnameField.translatesAutoresizingMaskIntoConstraints = NO;

    self.numberField = [[UITextField alloc] init];
    self.numberField.placeholder = @"Номер телефона";
    self.numberField.textAlignment = NSTextAlignmentCenter;
    [self.numberField setBorderStyle:UITextBorderStyleRoundedRect];
    self.numberField.translatesAutoresizingMaskIntoConstraints = NO;
    self.numberField.keyboardType = UIKeyboardTypeNumberPad;

    [self addSubview:self.nameLabel];
    [self addSubview:self.surnameLabel];
    [self addSubview:self.numberLabel];
    
    [self addSubview:self.nameField];
    [self addSubview:self.surnameField];
    [self addSubview:self.numberField];
    
    [self applyConstraints];
    
}


-(void)applyConstraints {
    NSDictionary* views = @{
                            @"nameL" : self.nameLabel,
                            @"surnameL" : self.surnameLabel,
                            @"numberL":self.numberLabel,
                            @"nameF":self.nameField,
                            @"surnameF" : self.surnameField,
                            @"numberF" : self.numberField
                            };
    
    NSArray* constraints =[[NSArray alloc] initWithObjects:
                           @"H:|-[nameL]-[nameF(120)]-|",
                           @"H:|-[surnameL]-[surnameF(120)]-|",
                           @"H:|-[numberL]-[numberF(120)]-|",
                           @"V:|-[nameL(30)]-11-[surnameL(30)]-11-[numberL(30)]-|",
                           @"V:|-[nameF(30)]-11-[surnameF(30)]-11-[numberF(30)]-10-|"
                           ,nil];
    
    NSMutableArray* layoutConstraint = [[NSMutableArray alloc] init];
    
    for (NSString* constraint in constraints) {
        NSArray* c = [NSLayoutConstraint constraintsWithVisualFormat:constraint options:0 metrics:nil views:views];
        [layoutConstraint addObjectsFromArray:c];
    }
    [NSLayoutConstraint activateConstraints:layoutConstraint];
}

- (id)initWithFrame:(CGRect)aRect
{
    if ((self = [super initWithFrame:aRect])) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder*)coder
{
    if ((self = [super initWithCoder:coder])) {
        [self commonInit];
    }
    return self;
}

@end
