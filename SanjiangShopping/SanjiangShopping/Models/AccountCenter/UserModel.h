//
//  UserModel.h
//  SanjiangShopping
//
//  Created by 薛纪杰 on 11/16/15.
//  Copyright © 2015 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "BaseModel.h"

@interface UserModel : BaseModel <NSCoding>
- (instancetype)initWithCoder:(NSCoder *)aDecoder;
@end
