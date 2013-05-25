//
//  GenericBinaryOut.h
//  FPF
//
//  Created by Vasco Ferreira on 5/25/13.
//  Copyright (c) 2013 Armis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GenericOut.h"

@interface GenericBinaryOut : GenericOut

@property(nonatomic,strong) NSData *binPackage;

- (id)initWithData:(NSData *)data;

@end
