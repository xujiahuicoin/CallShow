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
    var haveUp : Bool?
    //后期添加
    var upCount : String = ""
    
    //---------------点赞 Model---------------------
   var createOn  : NSInteger = 0 /// = 1574906091015;
   var delFlag  : NSInteger = 0 /// = 0;
   var id  : String = "" /// = "736d4278-1439-401e-8983-a442651bcc2b";
   var imgUrl  : String = "" /// = "http://img.cdn.wsljf.xyz/wallpaper/e01e5b30-d10d-4197-8848-4cc501106969.jpg";
   var objectId  : String = "" /// = "ba2c4526-c0de-411b-a83d-5fd02c357137";
   var smallImageUrl  : String = "" /// = "http://img.cdn.wsljf.xyz/wallpaper/9fa51df0-295f-4490-979c-9c0c176e5371.jpg";
   var upType  : NSInteger = 0 /// = 1;
}
