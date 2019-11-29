//
//  CSID_CallShowListModel.swift
//  CallShow
//
//  Created by MAC on 26/11/2019.
//  Copyright © 2019 www.xujiahuiCoin.com. All rights reserved.
//

import UIKit

class CSID_CallShowListModel: CSID_BaseModel {
    
    var relationId : String = ""
    var imageName : String = ""
    var imageUrl : String = ""
    var imageId : String = ""
    var smallImageId : String = ""
    var imageUrlSmall : String = ""
    var haveUp : Bool = true
    //后期添加
    var upCount : String = ""
    
    //---------------点赞 Model---------------------
   var createOn  : NSInteger = 0
   var delFlag  : NSInteger = 0
   var id  : String = ""
   var imgUrl  : String = ""
   var objectId  : String = ""
   var smallImageUrl  : String = ""
   var upType  : NSInteger = 252212 /// = 1;
}
