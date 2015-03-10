//
//  SearchByNameViewController.m
//  CheapestMedicine
//
//  Created by ShikshaInfotech on 21/06/14.
//  Copyright (c) 2014 ShikshaInfotech. All rights reserved.
//

#import "SearchByNameViewController.h"

@interface SearchByNameViewController ()

@end

@implementation SearchByNameViewController
@synthesize titleString;
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
    // Do any additional setup after loading the view from its nib.
    self.title=self.titleString;
    count=0;
    relatedSearchArray=[[NSMutableArray alloc]init];
    priceArray=[[NSMutableArray alloc]init];
    mainRelatedSearchArray=[[NSMutableArray alloc]init];
    mainPriceArray=[[NSMutableArray alloc]init];
    checkNetwork=[[NetworkChecking alloc]init];
    medicineSearchIdArray =[[NSMutableArray alloc] init];
    relatedSearchIdArray=[[NSMutableArray alloc]init];
    finalPriceArray=[[NSMutableArray alloc]init];
    relatedPriceArray=[[NSMutableArray alloc] init];
    [self makeRequestForAdmob];
    [self hideBanners];
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        
        [medicineSearchTableView registerNib:[UINib nibWithNibName:@"MedicineSearch_iPad" bundle:nil] forCellReuseIdentifier:@"cell"];
    }
    else{
        
        [medicineSearchTableView registerNib:[UINib nibWithNibName:@"MedicineSearch" bundle:nil] forCellReuseIdentifier:@"cell"];
    }
    strMedicine = @"MedicineSearch";
    
    defaults=[NSUserDefaults standardUserDefaults];
    [self makeRequestForCurrencyCheck];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    spinnerView.hidden=YES;
    if ([searchMedicine.text length]==0) {
        searchSegment.hidden=YES;
        medicineSearchTableView.hidden=YES;
    }
    else{
        searchSegment.hidden=NO;
        medicineSearchTableView.hidden=NO;
    }
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    count=0;
    [mainRelatedSearchArray removeAllObjects];
    [mainPriceArray removeAllObjects];
    [relatedSearchArray removeAllObjects];
    [priceArray removeAllObjects];
    [medicineSearchIdArray removeAllObjects];
    [relatedSearchIdArray removeAllObjects];
    
    if ([searchMedicine.text length]==0) {
        searchSegment.hidden=YES;
        
        medicineSearchTableView.hidden=YES;
    }
    else{
        searchSegment.hidden=NO;
        medicineSearchTableView.hidden=NO;
    }
    
    [searchBar setShowsCancelButton:YES animated:YES];
    [searchBar resignFirstResponder];
    [self makeRequestForMedicineSearchByName];
   
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    if ([searchMedicine.text length]==0) {
        searchSegment.hidden=YES;
        medicineSearchTableView.hidden=YES;
    }
    else{
        searchSegment.hidden=NO;
        medicineSearchTableView.hidden=NO;
        
    }
    spinnerView.hidden=YES;
    [searchBar setText:@""];
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    
}
-(void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller
{
    if ([searchMedicine.text length]==0) {
        searchSegment.hidden=YES;
        medicineSearchTableView.hidden=YES;
    }
    else{
        searchSegment.hidden=NO;
        medicineSearchTableView.hidden=NO;
        
    }
    controller.active = YES;
    
    [self.view addSubview:controller.searchBar];
    [self.view bringSubviewToFront:controller.searchBar];
}

- (void)searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView {
    
    if ([searchMedicine.text length]==0) {
        searchSegment.hidden=YES;
        
        medicineSearchTableView.hidden=YES;
    }
    else{
        searchSegment.hidden=NO;
        medicineSearchTableView.hidden=NO;
        
    }
}

- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
    controller.active=NO;
    if ([searchMedicine.text length]==0) {
        searchSegment.hidden=YES;
        
        medicineSearchTableView.hidden=YES;
    }
    else{
        searchSegment.hidden=NO;
        
        medicineSearchTableView.hidden=NO;
        
    }
    
    [self.view addSubview:controller.searchBar];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    //if we only try and resignFirstResponder on textField or searchBar,
    //the keyboard will not dissapear (at least not on iPad)!
    [self performSelector:@selector(searchBarCancelButtonClicked) withObject:searchMedicine afterDelay: 0.1];
    return YES;
}

-(void)searchBarCancelButtonClicked
{
    if ([searchMedicine.text length]==0) {
        searchSegment.hidden=YES;
        
        medicineSearchTableView.hidden=YES;
    }
    
}
-(void)makeRequestForMedicineSearchByName{
    spinnerView.hidden=NO;
    int points = [[defaults objectForKey:@"Count"]intValue];
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
//    else if (points <=20){
//        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"You can't search for medicine because your points are very low.To increase your points click on the ads" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//        spinnerView.hidden=YES;
//        
//        [self makeRequestForAdmob];
//        [self showsBanner];
//    }
    else
    {
        SearchByNameRequestClass *nameSearch = [[SearchByNameRequestClass alloc]init];
        nameSearch.MedicineSearchDelegate = self;
        [nameSearch makeRequestForCheckingwithMedicineSearchtxt:searchMedicine.text Value:[NSString stringWithFormat:@"%i",count]];
    }
}

- (void)adViewWillLeaveApplication:(GADBannerView *)adView{
    [self hideBanners];
    int i= (int)[[[NSUserDefaults standardUserDefaults] valueForKey:@"Count"] integerValue];
    
    if (i<99 ) {
        i = i+2;
        NSString *strCount=[NSString stringWithFormat:@"%i",i];
        [[NSUserDefaults standardUserDefaults]setObject:strCount forKey:@"Count"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Congratulations your points is increased by 2" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        alert.tag=6;
        [alert show];
    }
    else{
        
    }
}

-(void)successJSONParsingMedicineSearch:(NSMutableDictionary *)responseDictionary
{
    spinnerView.hidden=YES;
    
    NSMutableDictionary *mutDict_responseDictionary = [[NSMutableDictionary alloc]initWithDictionary:responseDictionary];
    
    if ([[mutDict_responseDictionary valueForKey:@"result"]isEqualToString:@"success"])
    {
        
        if ([[mutDict_responseDictionary objectForKey:@"medicine_search"] count]==0) {
            
            if (searchMedicine.text.length>1) {
                spinnerView.hidden=YES;
            }
            
            else if ([searchMedicine.text isEqual:@"y"]||[searchMedicine.text isEqual:@"u"]||[searchMedicine.text isEqual:@"x"]||[searchMedicine.text isEqual:@"w"]) {
                spinnerView.hidden=YES;
            }
            else{
                
                spinnerView.hidden=YES;
            }
            spinnerView.hidden=YES;        }
        else{
            for (int i=0; i<[[[mutDict_responseDictionary objectForKey:@"medicine_search"]objectForKey:@"medicine_details"] count]; i++) {
                [mainRelatedSearchArray addObject:[[[[mutDict_responseDictionary objectForKey:@"medicine_search"]objectForKey:@"medicine_details"] objectAtIndex:i] objectForKey:@"medicine_name"]];
                
                //price
                [mainPriceArray addObject:[[[[mutDict_responseDictionary objectForKey:@"medicine_search"]objectForKey:@"medicine_details"] objectAtIndex:i] objectForKey:@"price"]];
                [medicineSearchIdArray addObject:[[[[mutDict_responseDictionary objectForKey:@"medicine_search"]objectForKey:@"medicine_details"] objectAtIndex:i] objectForKey:@"id"]];
            }
        }
        
        if ([mutDict_responseDictionary objectForKey:@"medicine_relative"]) {
            if ([[mutDict_responseDictionary objectForKey:@"medicine_relative"] count]==0) {
                UIAlertView *alert_medicineSearch = [[UIAlertView alloc]initWithTitle:@"" message:@"No results found for this serach criteria" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert_medicineSearch show];
            }
            else{
                NSMutableArray *mutarr_Count;
                mutarr_Count = nil;
                mutarr_Count = [[NSMutableArray alloc]init];
                [mutarr_Count removeAllObjects];
                for (int i =0; i<[[[mutDict_responseDictionary objectForKey:@"medicine_relative"]objectForKey:@"medicine_details"] count]; i++)
                {
                    [mutarr_Count addObject:[[[mutDict_responseDictionary objectForKey:@"medicine_relative"]objectForKey:@"medicine_details"] objectAtIndex:i]];
                }
                
                
                [relatedSearchIdArray removeAllObjects];
                [relatedSearchArray removeAllObjects];
                [priceArray removeAllObjects];
                
                for (int i=0; i<[mutarr_Count count]; i++) {
                    
                    [relatedSearchArray addObject:[[mutarr_Count objectAtIndex:i] objectForKey:@"medicine_name"]];
                    [priceArray addObject:[[mutarr_Count objectAtIndex:i] objectForKey:@"price"]];
                    [relatedSearchIdArray addObject:[[mutarr_Count objectAtIndex:i] objectForKey:@"id"]];
                    
                }
            }
        }
    }
  
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
    
    [medicineSearchTableView reloadData];
}


-(void)failureJSONParsingMedicineSearchResult
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Warning!" message:@"server is not responding" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    alert.tag=7;
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ((alertView.tag==7)&&(buttonIndex==0)) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        
    }
}
-(IBAction)changeSegment:(id)sender{
    
    if (searchSegment.selectedSegmentIndex==0) {
        strMedicine=@"MedicineSearch";
        spinnerView.hidden=YES;
        [medicineSearchTableView reloadData];
        
        
        if ([mainRelatedSearchArray count]==0) {
            UIAlertView *alert_medicineSearch = [[UIAlertView alloc]initWithTitle:@"Info" message:@"No results found for this serach criteria" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert_medicineSearch show];
        }
        
    }
    
    else if (searchSegment.selectedSegmentIndex==1) {
        strMedicine=@"RelatedSearch";
        spinnerView.hidden=YES;
        [medicineSearchTableView reloadData];
        
        
        if ([relatedSearchArray count]==0) {
            UIAlertView *alert_medicineSearch = [[UIAlertView alloc]initWithTitle:@"Info" message:@"No results found for this serach criteria" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert_medicineSearch show];
        }
        
    }
}

#pragma mark-UITableViewDelegateMethods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([strMedicine isEqualToString:@"MedicineSearch"]) {
        return mainRelatedSearchArray.count;
    }
    else if ([strMedicine isEqualToString:@"RelatedSearch"]){
        
        return relatedSearchArray.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        return 150;
    }
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = (MedicineSearchTableViewCell *)[cell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Cellbg_iPad"]];
    }
    else
    {
        cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Cellbg"]];
        cell.relatedSearch.adjustsFontSizeToFitWidth=YES;
        cell.priceLabel.adjustsFontSizeToFitWidth=YES;
    }
    if ([strMedicine isEqualToString:@"MedicineSearch"]) {
        
        if (mainRelatedSearchArray.count) {
        
            cell.relatedSearch.text=[mainRelatedSearchArray objectAtIndex:indexPath.row];
            
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"currency"]isEqualToString:@"PHP"]) {
                for (int i=0; i<[mainPriceArray count];i++) {
                    
                    NSString *tae=[NSString stringWithFormat:@"%@" ,[mainPriceArray objectAtIndex:i] ];
                    
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
                
                for (int i=0; i<[mainPriceArray count];i++) {
                    
                    NSString *tae=[NSString stringWithFormat:@"%@" ,[mainPriceArray objectAtIndex:i] ];
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
                for (int i=0; i<[mainPriceArray count];i++) {
                    
                    NSString *tae=[NSString stringWithFormat:@"%@",[mainPriceArray objectAtIndex:i]];
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
                cell.priceLabel.text=[mainPriceArray objectAtIndex:indexPath.row];
                if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
                {
                    cell.priceImageView.image=[UIImage imageNamed:@"INR_ipad"];
                }
                else{
                    cell.priceImageView.image=[UIImage imageNamed:@"INR"];
                }
                
            }
            
            if (indexPath.row == [mainRelatedSearchArray count] - 1)
            {
                
                [self reloadData];
            }
            
            
        }
        else{
            
            
        }
    }
    else if ([strMedicine isEqualToString:@"RelatedSearch"]){
        
        if (relatedSearchArray.count) {
            
            
            cell.relatedSearch.text=[relatedSearchArray objectAtIndex:indexPath.row];
            
            
            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"currency"]isEqualToString:@"PHP"]) {
                
                for (int i=0; i<[priceArray count];i++) {
                    
                    NSString *tae=[NSString stringWithFormat:@"%@" ,[priceArray objectAtIndex:i] ];
                    
                    float a;
                    a=[tae floatValue]*curr;
                    
                    NSString *finalString=[NSString stringWithFormat:@"%.3f",a];
                    [finalPriceArray addObject:finalString];
                    cell.priceLabel.text=[finalPriceArray objectAtIndex:indexPath.row];
                    
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
                    
                }
                
            }
            else if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"currency"]isEqualToString:@"EUR"]){
                for (int i=0; i<[priceArray count];i++) {
                    
                    NSString *tae=[NSString stringWithFormat:@"%@" ,[priceArray objectAtIndex:i] ];
                    float a;
                    a=[tae floatValue]*curr;
                    
                    NSString *finalString=[NSString stringWithFormat:@"%.3f",a];
                    
                    [finalPriceArray addObject:finalString];
                    
                    cell.priceLabel.text=[finalPriceArray objectAtIndex:indexPath.row];
                    
                }
                
            }
            else {
                
                cell.priceLabel.text=[priceArray objectAtIndex:indexPath.row];
            }
            
            
            if (indexPath.row == [relatedSearchArray count] - 1)
            {
                
                [self reloadData];
            }
            
        }
        else{
            
            
        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailNameViewController *detail;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        detail=[[DetailNameViewController alloc]initWithNibName:@"DetailNameViewController_iPad" bundle:nil];
        
    }
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if (IS_IPHONE_5){
            detail=[[DetailNameViewController alloc]initWithNibName:@"DetailNameViewController" bundle:nil];
            
        }
        else{
            detail=[[DetailNameViewController alloc]initWithNibName:@"DetailNameViewController_iPhone" bundle:nil];
            
        }
    }
    
    if ([strMedicine isEqualToString:@"MedicineSearch"]) {
        
        detail.medicineIdString=[medicineSearchIdArray objectAtIndex:indexPath.row];
        
        
        
    }
    else if ([strMedicine isEqualToString:@"RelatedSearch"]){
        detail.medicineIdString=[relatedSearchIdArray objectAtIndex:indexPath.row];
        
    }
    
    [self.navigationController pushViewController:detail animated:YES];
    
    
    
}

- (void)reloadData{
    
    count=count+1;
    [self makeRequestForMedicineSearchByName];
    
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
    
}
-(void)failureJSONParsingCurrencySearchResult
{
    
    spinnerView.hidden=YES;
    
    
}
-(void)makeRequestForAdmob{
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        
        bannerView = [[GADBannerView alloc]
                      
                      initWithFrame:CGRectMake(10.0,
                                               
                                               self.view.frame.size.height -
                                               
                                               GAD_SIZE_728x90.height,
                                               
                                               GAD_SIZE_728x90.width,
                                               
                                               GAD_SIZE_728x90.height)];//Set Position
        
    }
    
    else{
        
        bannerView = [[GADBannerView alloc]
                      
                      initWithFrame:CGRectMake(0.0,
                                               
                                               self.view.frame.size.height -
                                               
                                               GAD_SIZE_320x50.height,
                                               
                                               GAD_SIZE_320x50.width,
                                               
                                               GAD_SIZE_320x50.height)];//Set Position
        
    }
    
    // Specify the ad's "unit identifier." This is your AdMob Publisher ID.
    
    bannerView.adUnitID =@"ca-app-pub-2781774783774395/7752176263";//Call your id
    bannerView.delegate=self;
    
    
    // Let the runtime know which UIViewController to restore after taking
    
    // the user wherever the ad goes and add it to the view hierarchy.
    
    bannerView.rootViewController = self;
    
    [self.view addSubview:bannerView];//Your attempt to add bannerview
    
    
    
    // Initiate a generic request to load it with an ad.
    
    [bannerView loadRequest:[GADRequest request]];
    
    
    
    
    
    ///////////////////////////////////////////////////////////////////////////////////
    
}

- (void)showsBanner {
    isGoogleAd =YES;
    if (isGoogleAd == YES) {
        [self googleAd];
    }
    else {
        [self hideBanners];
    }
    
}

- (void)googleAd {
    
    if (isGoogleAd == YES) {
        
        NSLog(@"Showing Google Banner");
        
        // googleAd ON
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1.0];
        [bannerView setAlpha:1.0];
        [UIView commitAnimations];
        
        // switch off GoogleAd to use as switch
        isGoogleAd = NO;
        
    } else {
        // do something else
        return;
    }
    
}

- (void)hideBanners {
    
    NSLog(@"Hiding Both Banners");
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0];
    [bannerView setAlpha:0];
    [UIView commitAnimations];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
