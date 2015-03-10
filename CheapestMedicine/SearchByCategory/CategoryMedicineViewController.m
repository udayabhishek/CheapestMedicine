//
//  CategoryMedicineViewController.m
//  CheapestMedicine
//
//  Created by ShikshaInfotech on 24/06/14.
//  Copyright (c) 2014 ShikshaInfotech. All rights reserved.
//

#import "CategoryMedicineViewController.h"

@interface CategoryMedicineViewController ()
{
    int numOfPages;
}
@end

@implementation CategoryMedicineViewController
@synthesize medicineString;
@synthesize categoryTableView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"List Of Medicines";
    medicineNameArray =[[NSMutableArray alloc]init];
    priceArray=[[NSMutableArray alloc]init];
    medicineIdArray=[[NSMutableArray alloc]init];
    checkNetwork=[[NetworkChecking alloc]init];
    finalPriceArray=[[NSMutableArray alloc]init];
    pageValue=[[NSString alloc]init];
    pageValue=@"0";
    hasnext=[[NSString alloc]init];
    spinnerView.hidden=YES;
    defaults=[[NSUserDefaults alloc]init];
    [self makeRequestForCurrencyCheck];

    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        
        [self.categoryTableView registerNib:[UINib nibWithNibName:@"MedicineSearch_iPad" bundle:nil] forCellReuseIdentifier:@"Cell"];

    }
    else
    {
        [self.categoryTableView registerNib:[UINib nibWithNibName:@"MedicineSearch" bundle:nil] forCellReuseIdentifier:@"Cell"];
    }
    
    [self makeRequestForSendingCategoryDetails];
    
}

-(void)makeRequestForCurrencyCheck{
    
    spinnerView.hidden=NO;
    if (![checkNetwork reachable])
    {
       
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@""
                              message:@"Unable to reach the network"
                              delegate:nil
                              cancelButtonTitle:@"Dismiss"
                              otherButtonTitles:nil, nil];
        [alert show];
        spinnerView.hidden=YES;
    }
    else{
        CurrencyChangeRequestClass *currency=[[CurrencyChangeRequestClass alloc]init];
        currency.CurrencyChangeDelegate=self;
        [currency makeRequestForCheckingwithCurrencyChange];
    }
    
}
-(void)successJSONParsingCurrencySearch:(NSMutableDictionary *)responseDictionary
{
    spinnerView.hidden=YES;
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"currency"]isEqualToString:@"EUR"]) {
        
        
        curr=[[[[responseDictionary objectForKey:@"results"] objectForKey:@"INR-EUR"] objectForKey:@"val"] floatValue];
    
    }
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"currency"]isEqualToString:@"USD"]) {
        curr=  [[[[responseDictionary objectForKey:@"results"] objectForKey:@"INR-USD"] objectForKey:@"val"] floatValue];
    }
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"currency"]isEqualToString:@"PHP"]) {
        curr= [[[[responseDictionary objectForKey:@"results"] objectForKey:@"INR-PHP"] objectForKey:@"val"] floatValue] ;
    }
 [self.categoryTableView reloadData];
}
-(void)failureJSONParsingCurrencySearchResult
{
    
    spinnerView.hidden=YES;
    
    
}

-(void)makeRequestForSendingCategoryDetails{
    
    spinnerView.hidden=NO;
    //[self.categoryTableView reloadData];
    if (![checkNetwork reachable])
    {
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@""
                              message:@"Unable to reach the network"
                              delegate:nil
                              cancelButtonTitle:@"Dismiss"
                              otherButtonTitles:nil, nil];
        [alert show];
        spinnerView.hidden=YES;
    }
    else{
    CategorySearchRequestClass *category=[[CategorySearchRequestClass alloc]init];
    category.CategoryMedicineSearchDelegate=self;
//                for (int i=0; i<=20; i++) {
//           NSString *str=[NSString stringWithFormat:@"%d",i];
  [category makeRequestForCheckingWithCategoryMedicineSearchtxt:self.medicineString Value:[NSString stringWithFormat:@"%i",count]];
        
//                }
//        do{
//            int i=0;
//            NSString *str=[NSString stringWithFormat:@"%d",i];
//            [category makeRequestForCheckingWithCategoryMedicineSearchtxt:self.medicineString Value:str];
//            i++;
//        }while ([hasNext isEqualToString:@"1"]);
    }
}
-(void)successJSONParsingCategoryMedicineSearch:(NSMutableDictionary *)responseDictionary
{
   spinnerView.hidden=YES;
    if ([[responseDictionary valueForKey:@"result"] isEqualToString:@"success"]) {
        if ([responseDictionary objectForKey:@"medicine_details"]) {
            for (int i=0; i<[[responseDictionary objectForKey:@"medicine_details"] count]; i++) {
                
                [medicineNameArray addObject:[[[responseDictionary objectForKey:@"medicine_details"] objectAtIndex:i]objectForKey:@"medicine_name"]];
                [priceArray addObject:[[[responseDictionary objectForKey:@"medicine_details"] objectAtIndex:i]objectForKey:@"price"]];
                
            
                [medicineIdArray addObject:[[[responseDictionary objectForKey:@"medicine_details"] objectAtIndex:i]objectForKey:@"id"]];
            }
        }
//        if ([[responseDictionary valueForKey:@"hasNext"] isEqualToString:@"true"]) {
//            NSLog(@"has next:%@",hasNext);
//            hasNext=[responseDictionary valueForKey:@"page"];
//            NSLog(@"page no:%@",hasNext);
//        }
    }
//        else{
//    }
    NSLog(@"has next=%@",[responseDictionary valueForKey:@"hasNext"]);
     hasnext= [NSString stringWithFormat:@"%@",[responseDictionary valueForKey:@"hasNext"]];
    
//    if ([strtest isEqualToString:@"1"]) {
//                    pageValue=[responseDictionary valueForKey:@"page"];
//                    NSLog(@"page no:%@",pageValue);
//        [self makeRequestForSendingCategoryDetails];
//                }
    
    if (count==0) {
        if ([defaults objectForKey:@"Count"] ==nil)  {
            int value = 100;
            
            NSString *str_CountValue = [NSString stringWithFormat:@"%i", value];
            [defaults setObject:str_CountValue forKey:@"Count"];
            [defaults synchronize];
            
        }
        else{
            
            NSString *str_CountValue = [defaults objectForKey:@"Count"];
            int value = [str_CountValue intValue];
            value = value-1;
            str_CountValue = [NSString stringWithFormat:@"%i", value];
            [defaults setObject:str_CountValue forKey:@"Count"];
            [defaults synchronize];
        }
        
    }
    
    [self.categoryTableView reloadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([medicineNameArray count]) {

    return medicineNameArray.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        return 150;
    }
    else{
        return 120;
    }
    return 44;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell==nil) {
        cell=(MedicineSearchTableViewCell *)[cell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        
    }
    
    
    
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Cellbg_iPad"]];
    }
    else
    {
        cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Cellbg"]];
        cell.relatedSearch.adjustsFontSizeToFitWidth=YES;
    }
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"currency"]isEqualToString:@"PHP"]) {
        for (int i=0; i<[priceArray count];i++) {
            
            NSString *tae=[NSString stringWithFormat:@"%@" ,[priceArray objectAtIndex:i] ];
            
            float a;
            
            a=[tae floatValue]*curr;
           
            NSString *finalString=[NSString stringWithFormat:@"%.3f",a];
            
            [finalPriceArray addObject:finalString];
            cell.priceLabel.text=[finalPriceArray objectAtIndex:indexPath.row];
            if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
            {
                cell.priceImageView.image=[UIImage imageNamed:@"PHP_ipad"];
            }
            else{
                cell.priceImageView.image=[UIImage imageNamed:@"PHP"];
            }
 }
           }
    else if([[[NSUserDefaults standardUserDefaults]valueForKey:@"currency"]isEqualToString:@"USD"])
    {
        for (int i=0; i<[priceArray count];i++) {
            
            NSString *tae=[NSString stringWithFormat:@"%@" ,[priceArray objectAtIndex:i] ];
            float a;
            a=[tae floatValue]*curr;
            NSString *finalString=[NSString stringWithFormat:@"%.3f",a];
            
            [finalPriceArray addObject:finalString];
            
            cell.priceLabel.text=[finalPriceArray objectAtIndex:indexPath.row];
            if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
            {
                cell.priceImageView.image=[UIImage imageNamed:@"USD_ipad"];
            }
            else{
                cell.priceImageView.image=[UIImage imageNamed:@"USD"];
            }

        }
        
    }
    else if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"currency"]isEqualToString:@"EUR"]){
        for (int i=0; i<[priceArray count];i++) {
            
            NSString *tae=[NSString stringWithFormat:@"%@",[priceArray objectAtIndex:i]];
            float a;
            a=[tae floatValue]*curr;
            NSString *finalString=[NSString stringWithFormat:@"%.3f",a];
            
            [finalPriceArray addObject:finalString];
            
            cell.priceLabel.text=[finalPriceArray objectAtIndex:indexPath.row];
            if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
            {
                cell.priceImageView.image=[UIImage imageNamed:@"EUR_ipad"];
            }
            else{
                cell.priceImageView.image=[UIImage imageNamed:@"EUR"];
            }

        }
        }
    else {
        cell.priceLabel.text=[priceArray objectAtIndex:indexPath.row];
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            cell.priceImageView.image=[UIImage imageNamed:@"INR_ipad"];
        }
        else{
            cell.priceImageView.image=[UIImage imageNamed:@"INR"];
        }

        
    }
    if (indexPath.row == [medicineNameArray count] - 1)
    {
        
        [self reloadData];
    }
    cell.relatedSearch.text=[medicineNameArray objectAtIndex:indexPath.row];
//   [tableView reloadData];
    //[categoryTableView reloadData];
    return cell;
    
}
- (void)reloadData{
    if ([hasnext isEqualToString:@"1"]) {
    count=count+1;
    [self makeRequestForSendingCategoryDetails];
    }
    else{
        
    }
    // [medicineSearchTableView reloadData];
    
}
-(void)tableView: (UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([medicineIdArray count]>0)
    {
        MedicineDetailsViewController *detailMedicine;
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            detailMedicine=[[MedicineDetailsViewController alloc]initWithNibName:@"MedicineDetailsViewController_iPad" bundle:nil];
        }
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
            if (IS_IPHONE_5)
            {
                detailMedicine=[[MedicineDetailsViewController alloc]initWithNibName:@"MedicineDetailsViewController" bundle:nil];
        
            }
            else
            {
                detailMedicine=[[MedicineDetailsViewController alloc]initWithNibName:@"MedicineDetailsViewController_iPhone" bundle:nil];
            }
        
        }
        detailMedicine.medicineIdString=[medicineIdArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:detailMedicine animated:YES];
    }
    //[tableView reloadData];
    
}
-(void)failureJSONParsingCategoryMedicineSearchResult
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Warning!" message:@"server is not responding" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    alert.tag=123;
    [alert show];
    spinnerView.hidden=YES;
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ((buttonIndex==0)&&(alertView.tag=123)) {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
