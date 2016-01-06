//
//  CyCaptureController.m
//  CZ微博fan
//
//  Created by fan on 16/1/5.
//  Copyright © 2016年 cyfan. All rights reserved.
//

#import "CyCaptureController.h"
#import <AVFoundation/AVFoundation.h>

@interface CyCaptureController ()<AVCaptureMetadataOutputObjectsDelegate>
/*
 * 抽象的硬件设备
 */
@property(nonatomic,strong) AVCaptureDevice *device;

/*
 *  代表输入设备，配置抽象硬件设备的port
 */
@property(nonatomic,strong) AVCaptureInput *input;

/*
 *  代表输出数据，管理着输出一个movie和图像
 */
@property(nonatomic,strong) AVCaptureOutput *output;
/*
 *AVCaptureSession协调着input和output的数据传输
 */
@property(nonatomic,strong) AVCaptureSession *session;


@property (nonatomic, strong)NSString *resultUrl;//扫描到的结果；

@property (nonatomic, strong)UIImageView * codeBoundImageView;//四角图片
@property (nonatomic, strong)UIImageView * imageView;

@property (nonatomic, strong)NSTimer *timer;


@property (nonatomic,strong) UIView *preView;
@end

@implementation CyCaptureController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:view];
    
    self.preView = view;
    
    //添加二维码边框
    UIImage *image = [UIImage imageNamed:@"qrcode_border"];
    //转化成可拉伸的图片
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(25, 25, 26, 26)];
    
    UIImageView *border = [[UIImageView alloc] initWithImage:image];
    
    //方形，计算宽度，x = y = 70；
    
    NSInteger w = [[UIScreen mainScreen] bounds].size.width - 70 *2;
    
    border.frame = CGRectMake(70, 70+ 70, w, w);
    self.codeBoundImageView = border;
    
    //动画view
    UIImageView *inamationView = [[UIImageView alloc] initWithFrame:border.bounds];
    [border addSubview:inamationView];
    border.clipsToBounds = YES;
    [inamationView setImage:[UIImage imageNamed:@"qrcode_scanline_qrcode"]];
    self.imageView = inamationView;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(changeImage:) userInfo:nil repeats:YES];
    
}

-(void)changeImage:(NSTimer *)timer{
    //改变frame，用以产生动画
    
    self.imageView.frame = CGRectOffset(self.imageView.frame, 0, 1.5);
    
    if (self.imageView.frame.origin.y >= self.codeBoundImageView.frame.size.height - 10) {
        self.imageView.frame = CGRectOffset(self.codeBoundImageView.bounds, 0, -self.codeBoundImageView.frame.size.height);
    }
    
}

//开启二维码捕捉
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self startReading];
}

//关闭二维码
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self stopReading];
}

-(void)startReading{
    //获取设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    self.device = device;
    
    NSError *error = nil;
    
    //创建连接通道
    //AVCaptureInput是其父类,但是他有几个系统的子类,为什么选这个
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    self.input = input;
    
    if (error) {
        NSLog(@"%@",error);
    }
    
    
    
    //创建输出通道
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    
     // 设置输出的代理
    dispatch_queue_t dispatchQueue ;
    dispatchQueue = dispatch_queue_create("help", NULL);
    
    [output setMetadataObjectsDelegate:self queue:dispatchQueue];
    self.output = output;
    
    //创建session
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    [session addInput:input];
    [session addOutput:output];
    self.session = session;
    //设置AVMetadataObjectMachineReadableCodeObject的可输出元数据类型，一定要将output添加到session后在设置
    
   [output setMetadataObjectTypes:[NSArray arrayWithObjects:AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeQRCode, nil]];
    
//    //取出所有的支持的类型
//    NSMutableArray *result =[NSMutableArray arrayWithArray:self.output.availableMetadataObjectTypes];
//    //移除掉面部识别功能
//    [result removeObject:AVMetadataObjectTypeFace];
//
//[output setMetadataObjectTypes:result];
    
    //设置预览效果
    AVCaptureVideoPreviewLayer *layer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_session];
    
    [layer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [layer setFrame:self.view.layer.bounds];
    
    [self.preView.layer addSublayer:layer];
    
    //绘制一张不透明，周围半透明的图片
    //创建一张画布
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, [UIScreen mainScreen].scale);
    //拿到画笔
    CGContextRef context = UIGraphicsGetCurrentContext();
    //先将整个图片涂成半透明
    CGContextSetRGBFillColor(context, 0, 0, 0, .7f);
    CGContextAddRect(context, self.view.bounds);
    CGContextFillPath(context);
    
    //将中间涂成完全不透明的区域
    CGContextSetRGBFillColor(context, 1, 1, 1, 1.f);
    CGContextAddRect(context, self.codeBoundImageView.frame);
    CGContextFillPath(context);
    
    //绘图完成，生成图片；
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //创建一个用于遮罩的mask层,mask层自身不显示，但是影响到把mask层作为属性的layer显示，mask的每一点的透明度反作用到layer
    CALayer *mask = [[CALayer alloc] init];
    mask.bounds = self.preView.bounds;
    mask.position = self.preView.center;
    mask.contents = (__bridge id)image.CGImage;
    layer.mask = mask;
    layer.masksToBounds = YES;
    
    
    [self.session startRunning];
    
}

-(void)stopReading{
    [self.session stopRunning];
    
    if (self.resultUrl) {
        //用webView展示内容
        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewVC"];
        [vc setValue:self.resultUrl forKey:@"urlString"];
        if (self.navigationController.viewControllers.count == 1) {
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        
    }

}

#pragma mark - delegate
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    id object = metadataObjects.firstObject;
    if ([object isKindOfClass:
         //机器可识别的code对象
         [AVMetadataMachineReadableCodeObject class]]) {
        AVMetadataMachineReadableCodeObject *obj = (AVMetadataMachineReadableCodeObject *)object;
        NSLog(@"%@", obj.stringValue);
        self.resultUrl = obj.stringValue;
    }
    
    
    //在主线程中更新UI
    [self performSelectorOnMainThread:@selector(stopRunning) withObject:nil waitUntilDone:YES];
    
    
}



@end
