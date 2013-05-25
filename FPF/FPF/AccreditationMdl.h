//
//  AccreditationMdl.h
//  FPF
//
//  Created by Vasco Ferreira on 5/24/13.
//  Copyright (c) 2013 Armis. All rights reserved.
//

#import "BasicModel.h"

@interface AccreditationMdl : BasicModel

- (AccreditationMdl*) initWithDictionary: (NSDictionary*) dictionary;
- (NSMutableDictionary *) toJSON;

//json: id
@property(nonatomic, readwrite) int id;

//json: EntityName
@property(nonatomic, readwrite) NSString *entityName;

//json:OrganizationDescription
@property(nonatomic, readwrite) NSString *organizationDescription;

//json:CategoryDescription
@property(nonatomic, readwrite) NSString *categoryDescription;

//json:EntityTypeDescription
@property(nonatomic, readwrite) NSString *entityTypeDescription;

//json:Zones
@property(nonatomic,readwrite) NSMutableArray *zonesList;

//json:Code
@property(nonatomic, readwrite) int code;

//json:NumberOfPrints
@property(nonatomic, readwrite) int numberOfPrints;

//json:LastPrintDate
@property(nonatomic, readwrite) NSDate *lastPrintDate;

//json:DeliveryDate
@property(nonatomic, readwrite) NSDate *deliveryDate;

//json:"IsValid": true,
@property(nonatomic, readwrite) BOOL isValid;

//json:PhotoUrl
@property(nonatomic, readwrite) NSString *photoUrl;


@end
