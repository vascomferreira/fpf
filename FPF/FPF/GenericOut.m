//
//  GenericOut.m
//  FPF
//
//  Created by Vasco Ferreira on 5/25/13.
//  Copyright (c) 2013 Armis. All rights reserved.
//

#import "GenericOut.h"

@implementation GenericOut

- (id)initWithJSON:(NSDictionary *)jsonInfo
{
    self = [super init];
    
    if (self) {
        
        
    }
    
    return self;
}

// este construtor, analisa a resposta do server e decide se é um retorno valido , se for entao manda fazer o parsing dele
- (id)initWithGenericModel:(GenericModel *)serverResponse {
    
    if ( serverResponse.state != GMSSuccess) {
        
        self = [super init];
        
        if ( self) {
            
            self.responseState = serverResponse.state;
            self.serverErrorMessage = serverResponse.msg;
            
            if ( [serverResponse.data isKindOfClass:[NSDictionary class]]) self.credentialData =(NSDictionary *)serverResponse.data;
        }
        return self;
    }
    
    self.responseState = GMSSuccess;
    
    
    
    if ( [serverResponse.data isKindOfClass:[NSDictionary class]]   ) {
        // resposta normal de json
        self = [self initWithJSON:(NSDictionary *)serverResponse.data];
        
    }
    else {
        // raw binary
        self = [self initWithData:serverResponse.data];
        
    }
    
    
    if ( self ) {
        
        self.responseState =serverResponse.state;
        
    }
    return self;
    
}
-(BOOL) isValidServerResponse {
    
    return self.responseState == GMSSuccess;
    
}

@end
