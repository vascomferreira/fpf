//
//  GetAccreditationsIn.h
//  FPF
//
//  Created by Vasco Ferreira on 5/24/13.
//  Copyright (c) 2013 Armis. All rights reserved.
//

#import "GenericIn.h"

@interface AccreditationsListIn : GenericIn

//json: eventID
@property(nonatomic, readwrite) int eventID;

//json: token
@property(nonatomic, readwrite) NSString *token;

@end
