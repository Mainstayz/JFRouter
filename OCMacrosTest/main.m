//
//  main.m
//  OCMacrosTest
//
//  Created by zz on 2019/1/1.
//  Copyright © 2019 zz. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <objc/runtime.h>

#define _SEL_MACRO(A) @selector(A)
#define _CONCAT_(A, B) A ## B

#define SEL_MACRO(A) \
        _SEL_MACRO(A)
#define CONCAT(A, B) \
        _CONCAT_(A, B)

#define ROUTER_PRE routerHandle
#define ROUTER_INITIALIZE_SWIFT initialize
#define ROUTER_INITIALIZE_OC initialize:
#define ROUTER_PRE_OC @"routerHandle"

// routerHandle_initialize
#define ROUTER_INITIALIZE_NAME CONCAT(CONCAT(ROUTER_PRE,_),ROUTER_INITIALIZE_OC)
#define ROUTER_INITIALIZE_NAME_SWIFT CONCAT(CONCAT(ROUTER_PRE,_),ROUTER_INITIALIZE_SWIFT)

// @selector(routerHandle_initialize:)
#define ROUTER_INITIALIZE_SEL SEL_MACRO(ROUTER_INITIALIZE_NAME)

// initialize OC version
#define _ROUTER_INITIALIZE_METHOD(A, B)\
    + (instancetype)A(nullable NSDictionary *)B
#define ROUTER_INITIALIZE_METHOD(arg) _ROUTER_INITIALIZE_METHOD(ROUTER_INITIALIZE_NAME,arg)

// initialize swift version
#define _ROUTER_INITIALIZE_METHOD_SWIFT(A, B)\
    @objc static func A(_ B:Dictionary<String,Any>?) -> Any?
#define ROUTER_INITIALIZE_METHOD_SWIFT(arg) _ROUTER_INITIALIZE_METHOD(ROUTER_INITIALIZE_NAME_SWIFT,arg)

// sync method - OC version
#define __ROUTER_SYNC_METHOD(return_type, pre, name, arg) \
+ (return_type)pre ## _ ## name:(nullable NSDictionary *)arg
#define _ROUTER_SYNC_METHOD(return_type, pre, name, arg) __ROUTER_SYNC_METHOD(return_type,pre,name,arg)
#define ROUTER_SYNC_METHOD(return_type, name, arg) _ROUTER_SYNC_METHOD(return_type,ROUTER_PRE,name,arg)

// sync method - Swift version
#define __ROUTER_SYNC_METHOD_SWIFT(return_type, pre, name, arg) \
@objc static func pre ## name(_ arg:Dictionary<String,Any>?) -> return_type?
#define _ROUTER_SYNC_METHOD_SWIFT(return_type, pre, name, arg) __ROUTER_SYNC_METHOD_SWIFT(return_type,pre,name,arg)
#define ROUTER_SYNC_METHOD_SWIFT(return_type, name, arg) _ROUTER_SYNC_METHOD_SWIFT(return_type,ROUTER_PRE,name,arg)

// aync method - OC version
#define __ROUTER_ASYNC_METHOD(pre, name, arg) \
+ (void) pre ## _ ## name:(NSDictionary *)arg callback:(nullable void(^)(id value))callback
#define _ROUTER_ASYNC_METHOD(pre, name, arg) __ROUTER_ASYNC_METHOD(pre,name,arg)
#define ROUTER_ASYNC_METHOD(name, arg) _ROUTER_ASYNC_METHOD(ROUTER_PRE,name,arg)

// aync method - Swift version
#define __ROUTER_ASYNC_METHOD_SWIFT(pre, name, arg) \
@objc static func pre ## _ ## name(_ arg:Dictionary<String,Any>?, callback:@escaping (_ value:Any)? -> Void) -> Void
#define _ROUTER_ASYNC_METHOD_SWIFT(pre, name, arg) __ROUTER_ASYNC_METHOD_SWIFT(pre,name,arg)
#define ROUTER_ASYNC_METHOD_SWIFT(name, arg) _ROUTER_ASYNC_METHOD_SWIFT(ROUTER_PRE,name,arg)

#define ROUTER_SCHEME \
+ (nonnull NSString *)scheme

#define ROUTER_SCHEME_SWIFT \
@objc static func scheme() -> String




@interface Person : NSObject
//JFROUTER_SYNC_METHOD(void, say, arg);
@end

@implementation Person
@end



// jiufuwallet://JFHomepageViewController/

int main(int argc, const char * argv[]) {
    @autoreleasepool {
    
        SEL s = @selector(ROUTER_INITIALIZE_NAME);
        SEL s1 = @selector(ROUTER_INITIALIZE_NAME_SWIFT);
        SEL s2 = ROUTER_INITIALIZE_SEL;
        
        


    
        
        
//        int ROUTER_INITIALIZE_NAME_OC = 1;
        
        
//        ROUTER_INITIALIZE_SEL;
        
        
        
//        、_ROUTER_INITIALIZE_SEL
//
//        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//        [dic addEntriesFromDictionary:nil];
//
//        NSLog(@"%@",dic);
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
//        NSString *text = @"http://www.baidu.com/qwer?a=s://";
//        NSURL *url = [NSURL URLWithString:@"http://www.baidu.com/goood?a=http://hao123.com/x?d=c"];
//        NSURL *url1 = [NSURL URLWithString:@"http://www.baidu.com/?a=s"];
//        NSURL *url2 = [NSURL URLWithString:@"http://www.baidu.com/qwer?a=s://"];
//        NSURL *url3 = [NSURL URLWithString:@"http://www.baidu.com/qwer/ppouw?a=s"];
//
//        NSURL *url4 = [NSURL URLWithString:@"//qwer/ppouw?a=s"];
//        NSArray *array = [[url4 path] componentsSeparatedByString:@"/"];
//
//        Class cls = NSClassFromString(@"qwert");
//        Class cls1 = NSClassFromString(@"Person");
        
    }
    return 0;
}
