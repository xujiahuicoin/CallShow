import UIKit
import Contacts
import Kingfisher
class CSID_CallShowContact: NSObject {
    ///1.获取授权状态
    class func obtainAuthorizationStatus() {
        //CNContactStore 通讯录对象
        let status = CNContactStore.authorizationStatus(for: .contacts)        //2.判断如果是未决定状态,则请求授权
        if status == .notDetermined {
            //创建通讯录对象
            let store = CNContactStore()
            //请求授权
            store.requestAccess(for: .contacts, completionHandler: { (isRight : Bool,error : Error?) in
                if isRight {
                    print("授权成功")
                   
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "shouquanNotificationCenter"), object: self)
                    
                } else {
                    print("授权失败")
                }
            })
        }
    }
    
    /// 获取联系人信息
    class func GetContactInformation() -> NSMutableDictionary{
        CSID_CallShowContact.obtainAuthorizationStatus()
        let dataDic:NSMutableDictionary = NSMutableDictionary.init()
        let nameArr = NSMutableArray.init()
        let imageArr = NSMutableArray.init()
        //1.获取授权状态
        let status = CNContactStore.authorizationStatus(for: .contacts)
//        2.判断当前授权状态
        guard status == .authorized
            else { return dataDic}
        //3.创建通讯录对象
        let store = CNContactStore()
        //4.从通讯录中获取所有联系人
        //获取Fetch,并且指定之后要获取联系人中的什么属性
        let keys = [CNContactFamilyNameKey, CNContactGivenNameKey, CNContactPhoneNumbersKey,CNContactImageDataKey]
        //创建请求对象   需要传入一个(keysToFetch: [CNKeyDescriptor]) 包含'CNKeyDescriptor'类型的数组
        let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
        //遍历所有联系人
        //需要传入一个CNContactFetchRequest
        do {
            try store.enumerateContacts(with: request, usingBlock: {(contact : CNContact, stop : UnsafeMutablePointer<ObjCBool>) -> Void in
            //1.获取姓名
            let firstName = contact.givenName
            let lastName = contact.familyName
            let nameString:String = lastName+firstName
            let nodata:Data = backImageViewWith(string: nameString, color: .red)
            nameArr.add(nameString)
            let img:Data = contact.imageData ?? nodata
            imageArr.add(img)
                dataDic.setValue(nameArr, forKey: "name")
                dataDic.setValue(imageArr, forKey: "image")
            })
            
        } catch {
            print(error)
        }
        return dataDic
}
    
    /// 根据指定联系人名字获取头像
    class func getsTheAvatarBasedOnTheSpecifiedContactName(nameString:String) -> Data {
        var imageData:Data!
        //1.获取授权状态
        let status = CNContactStore.authorizationStatus(for: .contacts)
        //2.判断当前授权状态
        guard status == .authorized else { return imageData}
        //创建通讯录对象
        let store = CNContactStore()
        //获取Fetch,并且指定要获取联系人中的什么属性
        let keys = [CNContactFamilyNameKey, CNContactGivenNameKey, CNContactPhoneNumbersKey,CNContactImageDataKey,CNContactThumbnailImageDataKey,CNContactImageDataAvailableKey]
        //创建请求对象，需要传入一个(keysToFetch: [CNKeyDescriptor]) 包含'CNKeyDescriptor'类型的数组
        let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
        //遍历所有联系人
        do {
            try store.enumerateContacts(with: request, usingBlock: {
                (contact : CNContact, stop : UnsafeMutablePointer<ObjCBool>) -> Void in
                let mutableContact = contact.mutableCopy() as! CNMutableContact
                //获取姓名
                let lastName = mutableContact.familyName
                let firstName = mutableContact.givenName
                let name:String = lastName+firstName
                
                   //判断是否符合要求
                   if nameString == name{
                    let nodata:Data = backImageViewWith(string: nameString, color: .red)
                    imageData = contact.imageData ?? nodata
                   }
            })
        } catch {
            print(error)
        }
        return imageData
    }
    
    /// 生成图片
    class func backImageViewWith(string:String,color:UIColor) ->Data{
        let imgView:UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        let titleLab:UILabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        let sub1:String = String(string.prefix(1))
        titleLab.text = sub1
        titleLab.textAlignment = .center
        titleLab.font = UIFont.boldSystemFont(ofSize: 23)
        titleLab.textColor = .white
        titleLab.backgroundColor = .red
        CallShowRaise(titleLab, rabF: 25)
        imgView.addSubview(titleLab)
        let img:UIImage = getImageFromView(view: imgView)
        let data : Data = img.pngData()!
        return data
    }
    
    // 将某个view 转换成图像
    class func getImageFromView(view:UIView) ->UIImage{
        UIGraphicsBeginImageContext(view.bounds.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

    /* 指定联系人设置
     imageStr 更换的图片
     nameArr 联系人数组
     */
    class func specifyContactSettings(imageData:Data,nameArr:Array<String>) {
        if imageData == nil{
            print("图片不能为空")
            return;
        }
        CSID_CallShowContact.obtainAuthorizationStatus()
        //1.获取授权状态
        let status = CNContactStore.authorizationStatus(for: .contacts)
        //2.判断当前授权状态
        guard status == .authorized else { return }
        //创建通讯录对象
        let store = CNContactStore()
        //获取Fetch,并且指定要获取联系人中的什么属性
        let keys = [CNContactFamilyNameKey, CNContactGivenNameKey, CNContactPhoneNumbersKey,CNContactImageDataKey,CNContactThumbnailImageDataKey,CNContactImageDataAvailableKey]
        //创建请求对象，需要传入一个(keysToFetch: [CNKeyDescriptor]) 包含'CNKeyDescriptor'类型的数组
        let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
        //遍历所有联系人
        do {
            try store.enumerateContacts(with: request, usingBlock: {
                (contact : CNContact, stop : UnsafeMutablePointer<ObjCBool>) -> Void in
                let mutableContact = contact.mutableCopy() as! CNMutableContact
                //获取姓名
                let lastName = mutableContact.familyName
                let firstName = mutableContact.givenName
                let name:String = lastName+firstName
                
                for nameString:String in nameArr {
                   //判断是否符合要求
                   if nameString == name{
                    mutableContact.imageData = imageData
                    
                    //修改联系人请求
                    let request = CNSaveRequest()
                    request.update(mutableContact)
                    do {
                           //修改联系人
                           try store.execute(request)
                            return;
                       } catch {
                           print(error)
                       }
                   }
                }
            })
        } catch {
            print(error)
        }
    }
    
    /* 全部联系人设置
    imgName 更换的图片
     */
    class func AllContactSettings(imageData:Data) {
        if imageData == nil{
            print("图片不能为空")
            return;
        }
        CSID_CallShowContact.obtainAuthorizationStatus()
        //1.获取授权状态
        let status = CNContactStore.authorizationStatus(for: .contacts)
        //2.判断当前授权状态
        guard status == .authorized else { return }
        //创建通讯录对象
        let store = CNContactStore()
                    
        //获取Fetch,并且指定要获取联系人中的什么属性
        let keys = [CNContactFamilyNameKey, CNContactGivenNameKey, CNContactPhoneNumbersKey,CNContactImageDataKey]
        //创建请求对象，需要传入一个(keysToFetch: [CNKeyDescriptor]) 包含'CNKeyDescriptor'类型的数组
        let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                    
        //遍历所有联系人
        do {
            try store.enumerateContacts(with: request, usingBlock: {
                (contact : CNContact, stop : UnsafeMutablePointer<ObjCBool>) -> Void in
                let mutableContact = contact.mutableCopy() as! CNMutableContact
                mutableContact.imageData = imageData
                //修改联系人请求
                let request = CNSaveRequest()
                request.update(mutableContact)
                do {
                    //修改联系人
                    try store.execute(request)
                } catch {
                    print(error)
                }
            })
        } catch {
            print(error)
        }
    }
    
    
}




