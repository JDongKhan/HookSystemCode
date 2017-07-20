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

@property (nonatomic, assign, readonly) objc_property_t property;

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, strong, readonly) id  value;
@property (nonatomic, strong, readonly) NSString *typeEncoding;
@property (nonatomic, assign, readonly) SEL getter;
@property (nonatomic, assign, readonly) SEL setter;

- (instancetype)initWithProperty:(objc_property_t )property object:(NSObject *)obj;

@end

@interface JDVar : NSObject
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, strong, readonly) id value;
@property (nonatomic, copy, readonly) NSString *type;
@property (nonatomic, copy) NSString *typeEncoding;
- (instancetype)initWithVar:(Ivar)var object:(NSObject *)obj;

@end

@interface JDMethod : NSObject
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, assign, readonly) SEL sel;//方法名称
@property (nonatomic, assign, readonly) IMP imp; // 方法的具体的实现的指针
@property (nonatomic, copy, readonly) NSString *type; // 参数和返回类型的描述字串
@property (nonatomic, strong, readonly) NSString *returnTypeEncoding;
@property (nonatomic, strong, readonly) NSArray<NSString *> *argumentTypeEncodings;

- (instancetype)initWithMethod:(Method)method;

@end


@interface JDClass : NSObject

@property (nonatomic, strong) JDClass *superCode;

@property (nonatomic, copy) NSString *className;
@property (nonatomic, strong) NSArray<JDProperty *> *propertys;
@property (nonatomic, strong) NSArray<JDVar *> *vars;
@property (nonatomic, strong) NSArray<JDMethod *> *methods;
@end

@interface JDHookCode : NSObject

//hook某个类
+ (JDClass *)hookClass:(NSObject *)obj;
//hook某个类以及这个类的父类、祖父类
+ (JDClass *)hookClassWithSuper:(NSObject *)obj;
@end
