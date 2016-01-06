//
//  CyCompoeController.m
//  CZ微博fan
//
//  Created by fan on 16/1/4.
//  Copyright © 2016年 cyfan. All rights reserved.
//

#import "CyCompoeController.h"
#import "CyTextView.h"
#import "CyComposeToolBar.h"
#import "CyPhotosView.h"

#import "CyComposeTool.h"

#import "MBProgressHUD+MJ.h"
@interface CyCompoeController ()<UITextViewDelegate,CyComposeToolBarProtocol,UIImagePickerControllerDelegate>

@property(nonatomic,strong) UIBarButtonItem *rightItem;
@property(nonatomic,strong) CyTextView *textView;
@property(nonatomic,strong) CyComposeToolBar *toolBar;
@property(nonatomic,strong) NSMutableArray *images;
@property(nonatomic,strong) CyPhotosView *photosView;
@end

@implementation CyCompoeController

-(NSMutableArray *)images{
    if (_images == nil) {
        _images = [NSMutableArray array];
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    [self setUpNavigationBar];
    
    [self setUpTextView];
    
    [self setUpToolBar];
    
    [self setUpPhotosView];
    // Do any additional setup after loading the view.
}

-(void)setUpPhotosView{
    
    CyPhotosView *photosView = [[CyPhotosView alloc] initWithFrame:CGRectMake(0, 70,self.view.bounds.size.width, self.view.bounds.size.height - 70)];
    _photosView = photosView;
    [_textView addSubview:photosView];
    
}

-(void)setUpToolBar{
    CGFloat y = self.view.bounds.size.height - 35;
    CyComposeToolBar *toolBar = [[CyComposeToolBar alloc] initWithFrame:CGRectMake(0, y, self.view.bounds.size.width, 35)];
    toolBar.delegate = self;
    [self.view addSubview:toolBar];
    
    _toolBar = toolBar;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}



#pragma mark - 点击toolBar子空间时
-(void)composeToolBar:(UIToolbar *)toolBar didClickedBtnIndex:(NSInteger)index{
    if (index == 0) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
        //设置相册类型
        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
        imagePicker.delegate = self;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

#pragma mark - UIImagePickerControllerDelegate 图片选择完成时调用
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
   
    UIImage *image = info[UIImagePickerControllerOriginalImage];

    
    [self.images addObject:image];
    
    self.photosView.image = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
    
}



#pragma mark - 改变键盘高度是改变TOOLBar高度
-(void)keyBoardFrame:(NSNotification *)note{
 
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] ;
    
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (frame.origin.y == self.view.bounds.size.height) {//键盘没有弹出时
        [UIView animateWithDuration:duration animations:^{
            _toolBar.transform = CGAffineTransformIdentity;
        }];
        
    }else{
        
        [UIView animateWithDuration:duration animations:^{
            _toolBar.transform = CGAffineTransformMakeTranslation(0, -frame.size.height);
        }];
    }
}



-(void)setUpTextView{
    
    CyTextView *textView = [[CyTextView alloc] initWithFrame:self.view.bounds];
    textView.placeHolder = @"小姑娘";
    [self.view addSubview:textView];
    
    //允许label可以垂直拖拽
    textView.alwaysBounceVertical = YES;
    
    //监听textView是否有值输入
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewValueChange) name:UITextViewTextDidChangeNotification object:nil];
    
    self.textView = textView;
    
    //设置代理，为的是拖拽时结束编辑
    self.textView.delegate = self;
}

//当拖拽时结束编辑
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.textView endEditing:YES];
}

//当textView有值输入时隐藏或者显示占位label
-(void)textViewValueChange{
    
    if (self.textView.text.length) {
        self.textView.hidePlaceHolderLabel = YES;
        self.rightItem.enabled = YES;
    }else{
        self.textView.hidePlaceHolderLabel = NO;
        self.rightItem.enabled = NO;
    }
    
}

#pragma mark - 视图注销是，移除监听
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -变为第一响应
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.textView becomeFirstResponder];
}

-(void)setUpNavigationBar{
    
    self.title = @"发微博";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"发送" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [rightBtn addTarget:self action:@selector(compose) forControlEvents:UIControlEventTouchUpInside];
    
    //没有设置大小即尺寸，就不会显示
    [rightBtn sizeToFit];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    self.rightItem = rightItem;
}

//发送微博
-(void)compose{
    
    if (self.images.count) {
        [self sendPictures];
    }else{
        [self sendTitle];
    }
    
}

//发送图片
-(void)sendPictures{
    
    UIImage *image = self.images[0];
    NSString *status = _textView.text.length?_textView.text : @"分享图片";
    
    _rightItem.enabled = NO;
    
  [CyComposeTool composeWithStatus:status image:image success:^{
      
      // 提示用户发送成功
      [MBProgressHUD showSuccess:@"发送成功"];

      self.rightItem.enabled = YES;
      [self dismissViewControllerAnimated:YES completion:nil];

      
  } failure:^(NSError *error) {
      NSLog(@"%@",error.description);
      [MBProgressHUD showSuccess:@"发送失败"];
      
      self.rightItem.enabled = YES;
  }];
 
}

//发送文字
-(void)sendTitle{
    NSLog(@"%@",_textView.text);
    
    [CyComposeTool composeWithStatus:_textView.text  success:^{
        
        // 提示用户发送成功
        [MBProgressHUD showSuccess:@"发送成功"];

        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    

    

}

//返回主视图
-(void)dismiss{
   // [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES ];
    //[self.navigationController dismissViewControllerAnimated:YES completion:nil];
}






@end
