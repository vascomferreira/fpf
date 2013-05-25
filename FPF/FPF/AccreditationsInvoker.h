//
//  AccreditationsInvoker.h
//  FPF
//
//  Created by Vasco Ferreira on 5/25/13.
//  Copyright (c) 2013 Armis. All rights reserved.
//

#import "BaseInvoker.h"
#import "AccreditationsListIn.h"
#import "AccreditationsListOut.h"

@interface AccreditationsInvoker : BaseInvoker

+(void) getAccreditationsList: (AccreditationsListIn*) input completed:(void (^)(AccreditationsListOut *))output;

@end
