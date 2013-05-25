//
//  AccreditationsInvoker.m
//  FPF
//
//  Created by Vasco Ferreira on 5/25/13.
//  Copyright (c) 2013 Armis. All rights reserved.
//

#import "AccreditationsInvoker.h"
#import "FPFServicesURLs.h"

@implementation AccreditationsInvoker

+(void) getAccreditationsList: (AccreditationsListIn*) input completed:(void (^)(AccreditationsListOut *))output {
    NSString *strURL = [FPFServicesURLs getUrlAccreditations];
    
    [BaseInvoker executeServiceAtUrlWithParameters:strURL serviceInput:input completed:^(GenericModel *rawOut) {
        
        AccreditationsListOut *opResult  =[[AccreditationsListOut alloc] initWithGenericModel:rawOut];
        output(opResult);
        
    }];
}

@end
