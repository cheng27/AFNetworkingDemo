//
//  HttpSessionViewController.m
//  01-AFNetworking
//
//  Created by qingyun on 15/12/22.
//  Copyright © 2015年 阿六. All rights reserved.
//

#import "HttpSessionViewController.h"
#import <AFHTTPSessionManager.h>

@interface HttpSessionViewController ()
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation HttpSessionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)GET:(id)sender {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *parameters = @{@"foo":@"bar"};
    [manager GET:@"http://afnetworking.sinaapp.com/request_get.json" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
- (IBAction)POST:(id)sender {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *urlStr = @"http://afnetworking.sinaapp.com/request_post_body_json.json";
    NSDictionary *parameters = @{@"foo":@"bar"};
    
    [manager POST:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
- (IBAction)multiPartUpload:(id)sender {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://afnetworking.sinaapp.com/upload2server.json"  parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSURL *file1URL = [NSURL fileURLWithPath:@"/Users/qingyun/Desktop/1.jpg"];
        [formData appendPartWithFileURL:file1URL name:@"image" fileName:@"xxx.jpg" mimeType:@"image/jpeg" error:nil];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _progressView.progress = uploadProgress.fractionCompleted;
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
