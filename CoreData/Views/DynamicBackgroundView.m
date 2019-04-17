//
//  ActionUIView.m
//  CoreData
//
//  Created by mbp on 14/04/2019.
//  Copyright © 2019 mbp. All rights reserved.
//

#import "DynamicBackgroundView.h"

@interface DynamicBackgroundView ()
@end

@implementation DynamicBackgroundView

- (void)commonInit:(CGRect) frame{
    
    SKView* skView = [[SKView alloc] initWithFrame:frame];
    skView.backgroundColor = [UIColor redColor];
    [self addSubview:skView];
    
    SKScene* skScene = [[SKScene alloc] initWithSize:frame.size];
    
    SKEmitterNode* node =[NSKeyedUnarchiver unarchiveObjectWithFile:
                          [[NSBundle mainBundle] pathForResource:@"background" ofType:@"sks"]];
    node.position = CGPointMake(frame.size.width, frame.size.height);
    
    [skScene addChild:node];
    [skView presentScene:skScene];
}

- (id)initWithFrame:(CGRect)aRect
{
    if ((self = [super initWithFrame:aRect])) {
        [self commonInit:aRect];
    }
    return self;
}

@end
