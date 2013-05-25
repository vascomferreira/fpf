//
//  ZonesMdl.h
//  FPF
//
//  Created by Vasco Ferreira on 5/24/13.
//  Copyright (c) 2013 Armis. All rights reserved.
//

#import "BasicModel.h"

@interface ZonesMdl : BasicModel


- (ZonesMdl*) initWithDictionary: (NSDictionary*) dictionary;
- (NSMutableDictionary *) toJSON;

//json: ID
@property(nonatomic, readwrite) int id;

//json: Description
@property(nonatomic, readwrite) NSString *description;

//json: ShortName
@property(nonatomic, readwrite) NSString *shortName;

@end
