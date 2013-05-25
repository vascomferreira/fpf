//
//  AccreditationMdl.m
//  FPF
//
//  Created by Vasco Ferreira on 5/24/13.
//  Copyright (c) 2013 Armis. All rights reserved.
//

#import "AccreditationMdl.h"
#import "ZonesMdl.h"

@implementation AccreditationMdl
@synthesize id, entityName, organizationDescription, categoryDescription, entityTypeDescription, zonesList,  code, numberOfPrints, lastPrintDate, deliveryDate, isValid, photoUrl;

- (AccreditationMdl*) initWithDictionary: (NSDictionary*) dictionary
{
    self.id = [UTILS getInt:[dictionary objectForKey:@"ID"]];
    self.entityName = [dictionary objectForKey:@"EntityName"];
    self.organizationDescription = [dictionary objectForKey:@"OrganizationDescription"];
    self.categoryDescription = [dictionary objectForKey:@"CategoryDescription"];
    self.entityTypeDescription = [dictionary objectForKey:@"EntityTypeDescription"];
    self.zonesList = [NSMutableArray new];
    for(NSDictionary *innerDic in [dic objectForKey:@"ZonesList"]){
        [self.zonesList addObject: [[ZonesMdl alloc] initWithDictionary:innerDic]];
    }
    self.code = [UTILS getInt:[dictionary objectForKey:@"Code"]];
    self.numberOfPrints = [UTILS getInt:[dictionary objectForKey:@"numberOfPrints"]];
    self.lastPrintDate = [UTILS getDate:[dictionary objectForKey:@"LastPrintDate"]];
    self.deliveryDate = [UTILS getDate:[dictionary objectForKey:@"DeliveryDate"]];
    self.isValid = [UTILS getBool:[dictionary objectForKey:@"IsValid"]];
    self.photoUrl = [dictionary objectForKey:@"PhotoUrl"];
    
    return self;
}

-(NSMutableDictionary *) toJSON {
    
    NSMutableDictionary *rawData = [NSMutableDictionary new];
    
    
    return rawData;
}
@end
