//
//  SearchByNameRequestClass.h
//  CheapestMedicine
//
//  Created by ShikshaInfotech on 21/06/14.
//  Copyright (c) 2014 ShikshaInfotech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseUrl.h"
#import "AFNetworking.h"

@protocol MedicineSearchDelegate <NSObject>

@optional
-(void)successJSONParsingMedicineSearch:(NSMutableDictionary *)responseDictionary;
-(void)failureJSONParsingMedicineSearchResult;
@end

@interface SearchByNameRequestClass : NSObject
{
    id MedicineSearchDelegate;
    BOOL checkStatus;
    
    NSMutableArray *fetchedReponseArray;
    
}
@property (nonatomic, retain) id MedicineSearchDelegate;

-(void)makeRequestForCheckingwithMedicineSearchtxt:(NSString*)usertext Value:(NSString *)val;

@end
