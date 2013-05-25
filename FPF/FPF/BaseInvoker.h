//
//  BaseInvoker.h
//  FPF
//
//  Created by Vasco Ferreira on 5/24/13.
//  Copyright (c) 2013 Armis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GenericModel.h"
#import "GenericIn.h"

@interface BaseInvoker : NSObject

+(void) executeServiceAtUrlWithParameters:(NSString *)url  serviceInput:(GenericIn *)input completed:(void (^)(GenericModel *))completed;
+(void) handleError:(NSError*)error andReturn:(void (^)(GenericModel *))completed;

@end
