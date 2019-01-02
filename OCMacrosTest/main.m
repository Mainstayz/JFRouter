//
//  main.m
//  OCMacrosTest
//
//  Created by zz on 2019/1/1.
//  Copyright © 2019 zz. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <objc/runtime.h>

#define JFROUTER_INITIALIZE_METHOD() \
+ (instancetype)routerHandle_initialize:(NSDictionary *)params
#define JFROUTER_SYNC_METHOD(return_type,name) \
+ (return_type)routerHandle_##name:(NSDictionary *)params
#define JFROUTER_ASYNC_METHOD(name,arg) \
+ (void)routerHandle_##name:(NSDictionary *)arg callback:(id)callback



@interface Person : NSObject
//JFROUTER_SYNC_METHOD(void, say, arg);
@end

@implementation Person
JFROUTER_INITIALIZE_METHOD(){
    Person *p = [Person new];
    NSLog(@"%@",params);
    return p;
}
JFROUTER_SYNC_METHOD(void, say) {
    NSLog(@"%@",params);
}
@end



// jiufuwallet://JFHomepageViewController/

#define __concat__(A,B) A##$##B

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
//        Method m = class_getInstanceMethod(object_getClass([Person class]), @selector(routerHandle_say:eat:xx:xx1:qwer:));
//        SEL methodName = method_getName(m);
//        NSLog(@"方法名：%@", NSStringFromSelector(methodName));
//
//        // 获取方法的参数类型
//        unsigned int argumentsCount = method_getNumberOfArguments(m);
//        char argName[512] = {};
//        for (unsigned int j = 0; j < argumentsCount; ++j) {
//            method_getArgumentType(m, j, argName, 512);
//
//            NSLog(@"第%u个参数类型为：%s", j, argName);
//            memset(argName, '\0', strlen(argName));
//        }
//
//        char returnType[512] = {};
//        method_getReturnType(m, returnType, 512);
//        NSLog(@"返回值类型：%s", returnType);
//
//        // type encoding
//        NSLog(@"TypeEncoding: %s", method_getTypeEncoding(m));
        
        
//        struct objc_method_description *description = method_getDescription(m);
//
//        printf("%s\n",description->types);
//        printf("%s",method_getTypeEncoding(m));
        // insert code here...
//        Person *person = [Person new];
//        [Person routerHandle_say_arg:]
//        [Person say]
        NSString *text = @"http://www.baidu.com/qwer?a=s://";
        NSURL *url = [NSURL URLWithString:@"http://www.baidu.com/goood?a=http://hao123.com/x?d=c"];
        NSURL *url1 = [NSURL URLWithString:@"http://www.baidu.com/?a=s"];
        NSURL *url2 = [NSURL URLWithString:@"http://www.baidu.com/qwer?a=s://"];
        NSURL *url3 = [NSURL URLWithString:@"http://www.baidu.com/qwer/ppouw?a=s"];
        
        NSURL *url4 = [NSURL URLWithString:@"//qwer/ppouw?a=s"];
        NSArray *array = [[url4 path] componentsSeparatedByString:@"/"];
        
        Class cls = NSClassFromString(@"qwert");
        Class cls1 = NSClassFromString(@"Person");
        
    }
    return 0;
}
