//
//  CategoryRequestClass.h
//  CheapestMedicine
//
//  Created by ShikshaInfotech on 21/06/14.
//  Copyright (c) 2014 ShikshaInfotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseUrl.h"
#import "AFNetworking.h"

@protocol CategorySearchDelegate <NSObject>

@optional
-(void)successJSONParsingCategorySearch:(NSMutableDictionary *)responseDictionary;
-(void)failureJSONParsingCategorySearchResult;
@end

@interface CategoryRequestClass : NSObject
{
    id CategorySearchDelegate;
    BOOL checkStatus;
    
    NSMutableArray *fetchedReponseArray;
    
}
@property (nonatomic, retain) id CategorySearchDelegate;


-(void)makeRequestForCheckingListOfCategories;
@end
