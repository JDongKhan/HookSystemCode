//
//  JDHookCode.h
//  HookSystemCode
//
//  Created by 王金东 on 2016/7/19.
//  Copyright © 2016年 王金东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>


@interface JDProperty : NSObject

@property (nonatomic, assign, readonly) objc_property_t _Nullable property;

@property (nonatomic, copy, readonly) NSString * _Nullable name;
@property (nonatomic, strong, readonly) id _Nullable value;
@property (nonatomic, strong, readonly) NSString * _Nullable typeEncoding;
@property (nonatomic, assign, readonly) SEL _Nullable getter;
@property (nonatomic, assign, readonly) SEL _Nullable setter;

- (instancetype _Nullable )initWithProperty:(objc_property_t _Nullable )property object:(NSObject *_Nullable)obj;

@end

@interface JDVar : NSObject
@property (nonatomic, copy, readonly) NSString * _Nullable name;
@property (nonatomic, strong, readonly) id _Nullable value;
@property (nonatomic, copy, readonly) NSString * _Nullable type;
@property (nonatomic, copy) NSString * _Nullable typeEncoding;
- (instancetype _Nullable )initWithVar:(Ivar _Nullable )var object:(NSObject *_Nullable)obj;

@end

@interface JDMethod : NSObject
@property (nonatomic, strong, readonly) NSString * _Nullable name;
@property (nonatomic, assign, readonly) SEL _Nullable sel;//方法名称
@property (nonatomic, assign, readonly) IMP _Nullable imp; // 方法的具体的实现的指针
@property (nonatomic, copy, readonly) NSString * _Nullable type; // 参数和返回类型的描述字串
@property (nonatomic, strong, readonly) NSString * _Nullable returnTypeEncoding;
@property (nullable, nonatomic, strong, readonly) NSArray<NSString *> * argumentTypeEncodings;

- (instancetype _Nullable )initWithMethod:(Method _Nullable )method;

@end


@interface JDClass : NSObject

@property (nonatomic, strong) JDClass * _Nullable superCode;

@property (nonatomic, copy) NSString * _Nullable className;
@property (nonatomic, strong) NSArray<JDProperty *> * _Nullable propertys;
@property (nonatomic, strong) NSArray<JDVar *> * _Nullable vars;
@property (nonatomic, strong) NSArray<JDMethod *> * _Nullable methods;
@end

@interface JDHookCode : NSObject

//hook某个类
+ (JDClass *_Nullable)hookClass:(NSObject *_Nullable)obj;
//hook某个类以及这个类的父类、祖父类
+ (JDClass *_Nullable)hookClassWithSuper:(NSObject *_Nullable)obj;
@end
