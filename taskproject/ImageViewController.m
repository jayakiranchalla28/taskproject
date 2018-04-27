//
//  ImageViewController.m
//  taskproject
//
//  Created by wifin_imac on 4/2/18.
//  Copyright © 2018 wifin_imac. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()
{
    
    __weak IBOutlet UIScrollView *ImageScrollOntop;
    NSMutableArray * imagearray;
    __weak IBOutlet UIImageView *firstImage;
    
    __weak IBOutlet UIImageView *fourthImage;
    __weak IBOutlet UIImageView *thirdImage;
    __weak IBOutlet UIImageView *secondImage;
}
@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
    
    Webservice
    
http://www.chennaiconcierge.com/ws/get_valuepack_offer.php?city_id=2
    
    Imageurl
    
https://www.biglaundry.com/img/top-snip-1.png
https://www.biglaundry.com/img/top-snip-2.png
https://www.biglaundry.com/img/top-snip-3.png
https://www.biglaundry.com/img/top-snip-4.png
    
    */
    
    firstImage.image = [UIImage imageWithData:[self getDataFromUrl:@"https://www.biglaundry.com/img/top-snip-1.png"]];
    secondImage.image = [UIImage imageWithData:[self getDataFromUrl:@"https://www.biglaundry.com/img/top-snip-2.png"]];
    
     thirdImage.image = [UIImage imageWithData:[self getDataFromUrl:@"https://www.biglaundry.com/img/top-snip-3.png"]];
     fourthImage.image = [UIImage imageWithData:[self getDataFromUrl:@"https://www.biglaundry.com/img/top-snip-4.png"]];
    
    
    
    

 
    
    imagearray = [NSMutableArray new];
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"http://www.chennaiconcierge.com/ws/get_valuepack_offer.php?city_id=4"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    if (!data.length)
    {
        
       
    }else{
        
        NSOperationQueue *myQueue = [[NSOperationQueue alloc] init];
        [myQueue addOperationWithBlock:^{
            
            // Background work
            NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:
                                      data options: 0 error: nil];
            NSArray  *  serverData = [jsonData valueForKey:@"details"];
            
            for (NSDictionary * iamgesDic in serverData){
                
                
                
                
                
                [imagearray addObject:[iamgesDic valueForKey:@"images"]];
                
                
            }
            
            
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setupScrollView:ImageScrollOntop];
            });
        }];
    }
    
    
    
    
    
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setupScrollView:(UIScrollView*)scrMain
{
    
    for (int i=0; i<imagearray.count; i++) {
        
        
        
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[imagearray objectAtIndex:i]]]];
        
        
       UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake((i)*self.view.frame.size.width, 0, self.view.frame.size.width, ImageScrollOntop.frame.size.height)];
        imgV.contentMode=UIViewContentModeScaleToFill;
        
        [imgV setImage:image];
        
        imgV.backgroundColor = [UIColor greenColor];
        
       
        [ImageScrollOntop addSubview:imgV];
    }
    [ImageScrollOntop setContentSize:CGSizeMake(self.view.frame.size.width*imagearray.count, ImageScrollOntop.frame.size.height)];
  
}

-(NSData*)getDataFromUrl:(NSString*)ImageUrl
{
    return  [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageUrl]];
}
- (IBAction)backaction:(id)sender {
    
    [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
    
    
}

@end
