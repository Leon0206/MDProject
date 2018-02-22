//
//  XYBaseModuleView.m
//  XYReactivePageKit
//
//  Created by lizitao on 2018/2/1.
//

#import "XYBaseModuleView.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "XYBaseModuleViewDelegate.h"
#import "UIView+ResizeFrame.h"

@interface XYBaseModuleView ()<XYBaseModuleViewDelegate>

@end

@implementation XYBaseModuleView

- (instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        _heightSignal = [RACSubject subject];
    }
    return self;
}

- (void)setModuleIndex:(NSUInteger)moduleIndex
{
    _moduleIndex = moduleIndex;
    [[[[RACObserve(self, height) distinctUntilChanged] skip:1] deliverOnMainThread] subscribeNext:^(id x) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.heightSignal sendNext:[NSNumber numberWithInteger:moduleIndex]];
        });
    }];
}

/***须子类重写***/
- (void)loadModuleViewData:(id)model
{
}

/***须子类重写***/
- (void)layoutModuleViewWithWidth:(CGFloat)width
{ 
}

@end