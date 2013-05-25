//
//  FPFUtils.h
//  FPF
//
//  Created by Vasco Ferreira on 5/24/13.
//  Copyright (c) 2013 Armis. All rights reserved.
//

#import <Foundation/Foundation.h>


#define SERVICE_DATE_FORMAT @"yyyy-MM-ddTHH:mm:ss.fff"
#define SERVICE_FPF_DATE_FORMAT @"yyyy-MM-dd'T'HH:mm:ss.SSS"
#define SERVICE_FPF_DATE_FORMAT_WITHOUT_MILI @"yyyy-MM-dd'T'HH:mm:ss"

@interface FPFUtils : NSObject {
    NSDateFormatter* dateFormatter;    
}

-(BOOL) getBool: (id)v;
-(BOOL) isNull: (NSObject*) obj;
-(int) getInt: (id)v;
-(NSDate*) getDate:(id)v;
-(NSDate*) getDateTime:(id)v;
-(NSString*) getTrimmedString: (id)v;
-(NSString*) getTrimmedString:(id)v capitalize: (BOOL)capitalize removeSpaces: (BOOL) removeSpaces;

@end
