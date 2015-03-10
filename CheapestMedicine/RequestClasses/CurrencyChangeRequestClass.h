//
//  CurrencyChangeRequestClass.h
//  CheapestMedicine
//
//  Created by ShikshaInfotech on 18/07/14.
//  Copyright (c) 2014 ShikshaInfotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseUrl.h"
#import "AFNetworking.h"

@protocol CurrencyChangeDelegate <NSObject>

@optional

-(void)successJSONParsingCurrencySearch:(NSMutableDictionary *)responseDictionary;
-(void)failureJSONParsingCurrencySearchResult;

@end

@interface CurrencyChangeRequestClass : NSObject
{
    id CurrencyChangeDelegate;
    BOOL checkStatus;
    
    NSMutableArray *fetchedReponseArray;
    
}
@property (nonatomic, strong)id CurrencyChangeDelegate;

-(void)makeRequestForCheckingwithCurrencyChange;


@end
