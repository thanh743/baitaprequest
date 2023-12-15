#import "PostRequest.h"

@implementation PostRequest

- (void)viewDidLoad {
    [super viewDidLoad];
    // Thực hiện các cài đặt cho view của bạn khi nó được load lần đầu tiên
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Tạo các thành phần khác như các nút, nhãn, v.v.
    UIButton *yourButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    // Thiết lập tiêu đề của button
    [yourButton setTitle:@"Click Me" forState:UIControlStateNormal];
    
    // Thiết lập kích thước và vị trí của button
    yourButton.frame = CGRectMake(50, 100, 300, 100);
    // Thiết lập màu nền của button
    [yourButton setBackgroundColor:[UIColor colorWithRed:0.5 green:0.8 blue:1.0 alpha:1.0]]; // Màu xanh dương nhạt
    
    // Thiết lập màu viền của button và độ đậm của viền
    yourButton.layer.borderColor = [UIColor blackColor].CGColor; // Màu đen
    yourButton.layer.borderWidth = 1.0; // Độ đậm
    
    // Đăng ký một hàm xử lý sự kiện khi button được nhấn
    [yourButton addTarget:self action:@selector(buttonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    // Thêm button vào view của UIViewController
    [self.view addSubview:yourButton];
}

-(void)validateRequest{
    NSString *imei = [];
    NSString *serial = [];
}
- (void)buttonTapped {
    NSLog(@"Button tapped!");
    // Thêm logic xử lý khi button được nhấn
}
@end
