//
//  OXSingleton.h
//  UM
//
//  Created by susulo on 15/8/20.

//

//#ifndef UM_OXSingleton_h
//#define UM_OXSingleton_h


// .h文件
#define OXSingletonH() + (instancetype)sharedInstance;

// .m文件
#if __has_feature(objc_arc)

#define OXSingletonM() \
    static id _instace; \
\
    + (id)allocWithZone:(struct _NSZone *)zone \
    { \
        static dispatch_once_t onceToken; \
        dispatch_once(&onceToken, ^{ \
            _instace = [super allocWithZone:zone]; \
        }); \
        return _instace; \
    } \
\
    + (instancetype)sharedInstance \
    { \
        static dispatch_once_t onceToken; \
        dispatch_once(&onceToken, ^{ \
            _instace = [[self alloc] init]; \
        }); \
    return _instace; \
    } \
\
    - (id)copyWithZone:(NSZone *)zone \
    { \
        return _instace; \
    }\


#else

#define OXSingletonM() \
    static id _instace; \
\
    + (id)allocWithZone:(struct _NSZone *)zone \
    { \
        static dispatch_once_t onceToken; \
        dispatch_once(&onceToken, ^{ \
            _instace = [super allocWithZone:zone]; \
        }); \
        return _instace; \
    } \
\
    + (instancetype)sharedInstance \
    { \
        static dispatch_once_t onceToken; \
        dispatch_once(&onceToken, ^{ \
            _instace = [[self alloc] init]; \
        }); \
        return _instace; \
    } \
\
    - (id)copyWithZone:(NSZone *)zone \
    { \
        return _instace; \
    } \
\
    - (oneway void)release { } \
    - (id)retain { return self; } \
    - (NSUInteger)retainCount { return 1;} \
    - (id)autorelease { return self;}

#endif
