//
//  Person.h
//  FPF
//
//  Created by Vasco Ferreira on 5/23/13.
//  Copyright (c) 2013 Armis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Person : NSObject

@property(nonatomic,strong)NSString *name;
@property(assign)int age;
@property(nonatomic, retain) UIImage *pic;

@end
