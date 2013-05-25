//
//  GenericModel.h
//  FPF
//
//  Created by Vasco Ferreira on 5/25/13.
//  Copyright (c) 2013 Armis. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    GMSFailure,
    GMSSuccess,
    GMSLogin,
    GMSLogout,
    GMSChangePin,
    GMSActivation,
    GMSVersionNotSupported,
    GMSMatriz,
    GMSNIF,
    GMSSMSToken,
    GMSDup,
    GMSProxy,
    GMSDmif
} GenericModelState;

@interface GenericModel : NSObject

/*
 Possible data values:
 In Services:
 - NSDictionary: After successfully parsing json from service response
 - NSData: File data from service response
 In Views:
 - NSDictionary: After successfully parsing json from service response
 - NSString: Full file path if successfully saved
 */
@property (nonatomic,copy) id data;
@property (nonatomic,strong) NSString *msg;
@property GenericModelState state;

-(id) init;
-(id) initWithData:(NSDictionary*)_data withMsg:(NSString*)_msg withState:(GenericModelState) gms;

@end
