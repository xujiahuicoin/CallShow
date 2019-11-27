import UIKit
import SnapKit
class CSID_ContactTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        prepareUI()
        
    }
    
    //数据模型
    var contactArray : CSID_ContactModel? {
        didSet {
            //为当前子属性赋值
            selbtn.isSelected = contactArray!.selected
            nameLab.text = contactArray?.namestr
            let imgdata:Data = CSID_CallShowContact.getsTheAvatarBasedOnTheSpecifiedContactName(nameString: contactArray?.namestr ?? "")
            headImg.image = UIImage.init(data: imgdata)
        }
    }
    func prepareUI(){
        self.addSubview(headImg)
        self.addSubview(nameLab)
        self.addSubview(selbtn)
        self.addSubview(bottomLine)
        
        headImg.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(16)
            make.centerY.equalTo(self.snp.centerY)
            make.width.height.equalTo(56)
        }
        
        nameLab.snp.makeConstraints { (make) in
            make.left.equalTo(headImg.snp.right).offset(10)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        selbtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(-16)
            make.centerY.equalTo(self.snp.centerY)
            make.width.height.equalTo(25)
        }
        
        bottomLine.snp.makeConstraints { (make) in
            make.left.equalTo(nameLab.snp.left)
            make.right.equalTo(self)
            make.bottom.equalTo(self.snp.bottom)
            make.height.equalTo(1.5)
        }
    }
    
    // 头像
    lazy var headImg:UIImageView = {
        let img = UIImageView.init()
        img.contentMode = .scaleAspectFill
        CallShowRaise(img, rabF: 28)
        return img
    }()
    
    // 名字
    lazy var nameLab:UILabel = {
        let name = UILabel.init()
        name.font = UIFont.boldSystemFont(ofSize: 17)
        return name
    }()
    
    ///选择按钮
    lazy var selbtn: UIButton = {
        let selectButton = UIButton(type: UIButton.ButtonType.custom)
        selectButton.setBackgroundImage(UIImage.init(named: "call_show_normal"), for: .normal)
        selectButton.setBackgroundImage(UIImage.init(named: "call_show_selected"), for: .selected)
        selectButton.addTarget(self, action: "chooseClick:", for: UIControl.Event.touchUpInside)
        selectButton.sizeToFit()
        return selectButton
    }()
    
    // 名字
    lazy var bottomLine:UIView = {
        let line = UIView.init()
        line.backgroundColor = UIColor.init(red: 248, green: 248, blue: 248)
        return line
    }()
    
    var checkTitle: (_ isTitleClicked: Bool) -> Void = {_ in}
     // MARK: - 按钮的点击事件
        //选择按钮的点击
        @objc fileprivate func chooseClick(_ CellBtn: UIButton) {
            
            CellBtn.isSelected  = !CellBtn.isSelected
            contactArray?.selected = CellBtn.isSelected
            checkTitle(true)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
