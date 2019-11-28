import UIKit
import Photos
class CSID_ZxhPHAssetToImageTool: NSObject {
     @objc class func PHAssetToImage(asset:PHAsset) -> UIImage{
            var image = UIImage()
            
            // 新建一个默认类型的图像管理器imageManager
            let imageManager = PHImageManager.default()
            
            // 新建一个PHImageRequestOptions对象
            let imageRequestOption = PHImageRequestOptions()
            
            // PHImageRequestOptions是否有效
            imageRequestOption.isSynchronous = true
            
            // 缩略图的压缩模式设置为无
            imageRequestOption.resizeMode = .none
            
            // 缩略图的质量为高质量，不管加载时间花多少
            imageRequestOption.deliveryMode = .highQualityFormat
            
            // 按照PHImageRequestOptions指定的规则取出图片
            imageManager.requestImage(for: asset, targetSize: CGSize.init(width: 750, height: 1334), contentMode: .default, options: imageRequestOption, resultHandler: {
                (result, _) -> Void in
                image = result!
            })
            return image
            
        }
}
