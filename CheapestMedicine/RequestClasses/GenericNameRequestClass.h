//
//  GenericNameRequestClass.h
//  CheapestMedicine
//
//  Created by ShikshaInfotech on 21/06/14.
//  Copyright (c) 2014 ShikshaInfotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseUrl.h"
#import "AFNetworking.h"

@protocol GenericSearchDelegate <NSObject>

@optional
-(void)successJSONParsingGenericSearch:(NSMutableDictionary *)responseDictionary;
-(void)failureJSONParsingGenericSearchResult;
@end

@interface GenericNameRequestClass : NSObject
{
    id GenericSearchDelegate;
    BOOL checkStatus;
    
    NSMutableArray *fetchedReponseArray;
    
}
@property (nonatomic, retain) id GenericSearchDelegate;


-(void)makeRequestForCheckingwithGenericSearchtxt:(NSString*)usertext Value:(NSString *)val;
@end
