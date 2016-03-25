//
//  ScenicLocationViewController.m
//  MyTravel
//
//  Created by brother on 15/10/18.
//  Copyright © 2015年 young. All rights reserved.
//

#import "ScenicLocationViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "JGScenic.h"
#import "AppDelegate.h"
#import "JGScenicAnnoation.h"

@interface ScenicLocationViewController ()<CLLocationManagerDelegate,MKMapViewDelegate>
@property (strong, nonatomic) MKMapView *myMapK;
@property (nonatomic,strong)CLLocationManager * manger;
@property (nonatomic,strong)UISegmentedControl * segment;
@property (nonatomic,strong)JGScenicAnnoation * scenicAnn;
@property (nonatomic,strong)CLGeocoder * gecoder;
@property (nonatomic,strong)NSMutableString * locationStr;
@property (nonatomic,strong)CLLocation * location;
@end

@implementation ScenicLocationViewController

- (CLGeocoder*)gecoder{
    if (_gecoder == nil) {
        _gecoder = [[CLGeocoder alloc]init];
    }
    return _gecoder;
}


- (void)dealloc{
//    [super dealloc];
    NSLog(@"对象销毁");
    self.gecoder = nil;
    self.myMapK = nil;
    self.manger = nil;
}

- (void)createSegmentedControl{
    
    CGFloat segmentY = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    
    UISegmentedControl * segment = [[UISegmentedControl alloc]initWithFrame:CGRectMake(0, segmentY, self.view.frame.size.width, 40)];
    [segment insertSegmentWithTitle:@"标准模式" atIndex:0 animated:YES];
    [segment insertSegmentWithTitle:@"卫星模式" atIndex:1 animated:YES];
    [segment insertSegmentWithTitle:@"云图模式" atIndex:2 animated:YES];
    segment.tintColor = [UIColor orangeColor];
    [segment addTarget:self action:@selector(segmentIndexDidChange) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segment];
    self.segment = segment;
}

- (void)segmentIndexDidChange{
    if (self.segment.selectedSegmentIndex == 0) {
        self.myMapK.mapType = MKMapTypeStandard;
    }else if(self.segment.selectedSegmentIndex == 1)
    { self.myMapK.mapType = MKMapTypeSatellite;}
    else{
        self.myMapK.mapType = MKMapTypeHybrid;
    }
}

- (CLLocationManager*)manger{
    if (_manger == nil) {
        _manger = [[CLLocationManager alloc]init];
        _manger.delegate = self;
    }
    return _manger;
}

- (void)createAlertViewWith:(NSString *)string{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:string delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [self.view addSubview:alert];
    [alert show];
    [alert removeFromSuperview];
}



- (void)viewDidLoad {
    [super viewDidLoad];
//    [self createSegmentedControl];
    JGScenic * scenic = [[JGScenic alloc]init];
    scenic.s_address = self.address;
    
    self.myMapK = [[MKMapView alloc]initWithFrame:self.view.frame];
    
    [self.view addSubview:self.myMapK];
    scenic.block = ^(CGFloat la,CGFloat lo){
        CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(la, lo);
        self.scenicAnn = [[JGScenicAnnoation alloc]initWithCoordinate:coord title:self.shopName subtitle:self.address icon:@"dianpu.png"];
        self.myMapK.layer.zPosition = -1;
          MKCoordinateRegion region = MKCoordinateRegionMake(coord, MKCoordinateSpanMake(0.01, 0.01));
        [self.myMapK setRegion:region];
        self.myMapK.centerCoordinate = coord;
        self.myMapK.delegate = self;
        [self.myMapK addAnnotation:self.scenicAnn];
    };
   [self.myMapK addAnnotation:self.scenicAnn];
    
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    static NSString * ID = @"good";
    MKAnnotationView * view1 = [mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    if (view1 == nil) {
        view1 = [[MKAnnotationView alloc]init];
        view1.canShowCallout = YES;
        UIButton * button = [UIButton buttonWithType:UIButtonTypeInfoDark];
        view1.leftCalloutAccessoryView = button;
    }
    view1.annotation = self.scenicAnn;
    view1.image = [UIImage imageNamed:@"category_3-1"];
    return view1;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
