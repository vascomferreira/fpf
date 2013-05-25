//
//  FPFUtils.m
//  FPF
//
//  Created by Vasco Ferreira on 5/24/13.
//  Copyright (c) 2013 Armis. All rights reserved.
//

#import "FPFUtils.h"

@implementation FPFUtils

-(id) init{
    if((self = [super init])){
        dateFormatter = [NSDateFormatter new];
        [self setObjectLocale:dateFormatter];        
    }
    
    return self;
}

-(void) setObjectLocale:(id)obj{
    if([obj respondsToSelector:@selector(setLocale:)])
        [obj performSelector:@selector(setLocale:) withObject:[[NSLocale alloc] initWithLocaleIdentifier:@"pt_PT"]];
}

-(BOOL)getBool:(id)v{
    if(v==nil || v==[NSNull null]){
        return NO;
    }
    else
    {
        //v is a point and returns always true
        BOOL ret = [v boolValue];
        return ret;
    }
}

-(BOOL) isNull: (NSObject*) obj{
    if(obj == nil){
        return YES;
    }else if([obj isKindOfClass:[NSNull class]]){
        return YES;
    }else{
        return NO;
    }
}

- (int) getInt: (id)v{
    if(v==nil || v==[NSNull null])
        return 0;
    return [v intValue];
}

-(NSDate*) getDateTime:(id)v{
    
    if(v==[NSNull null]) return nil;
    dateFormatter.dateFormat = SERVICE_FPF_DATE_FORMAT;
    
    NSDate *data = [dateFormatter dateFromString:v];
    if (data==nil) {
        dateFormatter.dateFormat = SERVICE_FPF_DATE_FORMAT_WITHOUT_MILI;
        data = [dateFormatter dateFromString:v];
    }
    
    return data;
    
}
-(NSDate*) getDate:(id)v{
    
    if(v==[NSNull null]) return nil;
    dateFormatter.dateFormat = SERVICE_FPF_DATE_FORMAT;
    
    NSString* temp = [UTILS getTrimmedString:(NSString*)v];
    
    //2008-05-06 if it is in this format auto-corrects with time so it can be parsed correctly
    if(temp.length == 10){
        temp = [NSString stringWithFormat:@"%@ %@", temp, @"00:00:00"];
    }
    
    //9999-01-01 cannot be parsed
    if([temp characterAtIndex:0] == '9'){
        return [NSDate distantFuture];
    }
    
    //return [dateFormatter dateFromString:v];
    
    return [dateFormatter dateFromString:temp];
    //    return [[dateFormatter dateFromString:v] fixedTimeDate];
}

-(NSString*) getTrimmedString: (id)v{
    if(v==nil || v==[NSNull null])
        return nil;
    NSString* temp = [NSString stringWithString:v];
    NSString* ret = [temp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return ret;
}

-(NSString*) getTrimmedString:(id)v capitalize: (BOOL)capitalize removeSpaces: (BOOL) removeSpaces{
    if(v==nil || v==[NSNull null])
        return nil;
    NSString* temp = [UTILS getTrimmedString:v];
    if(capitalize){
        temp = [temp uppercaseString];
    }
    if(removeSpaces){
        temp = [temp stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    
    return temp;
}

@end
