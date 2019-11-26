
import UIKit

class  CSID_MyHelpsVC:  CSID_BaseViewController,UITextViewDelegate {

    let  CSID_Str_tishistr = "请详细描述你的建议，这将帮助我们持续进步！"
    var  CSID_textF_textVi : UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "帮助与反馈"
        // Do any additional setup after loading the view.
        self.view.backgroundColor =  CSID_BackgroundColor_dark
    
    CSID_Pri_creatUI()
    
    }
    
    func  CSID_Pri_creatUI(){
        
        self.view.addSubview(title1)
        title1.snp.makeConstraints { (ma) in
            ma.top.right.equalToSuperview()
            ma.left.equalTo(CSID_leftMargin_CP)
            ma.height.equalTo(40)
        }
        
        let topview = UIView(frame: .zero)
        self.view.addSubview(topview)
        
        topview.snp.makeConstraints { (ma) in
            ma.top.equalTo(title1.snp.bottom)
            ma.left.right.equalToSuperview()
            ma.height.equalTo(60)
        }
       
        
        let arrtext = ["产品建议","购买问题","内容建议"]
        let width_XJH = Int((CSID_WidthScreen-80)/3)
        
        for (inde,str) in arrtext.enumerated() {
            let new_btnAction = CSID_Btn_creatbtnAction()
            topview.addSubview(new_btnAction)
            new_btnAction.setTitle(str, for: .normal)
            new_btnAction.snp.makeConstraints { (ma) in
                ma.left.equalTo(20 + inde * (20+width_XJH))
                ma.centerY.equalToSuperview()
                ma.width.equalTo(width_XJH)
                ma.height.equalTo(25)
            }
        }
        
        //填写意见
        let tianLab = UILabel(Xframe: .zero, text: "填写意见", font: Font(font: 13), textColor: CSID_MainTextColor,alignment: .left)
            
        tianLab.backgroundColor = .clear
        self.view.addSubview(tianLab)
        tianLab.snp.makeConstraints { (ma) in
            ma.top.equalTo(topview.snp.bottom)
            ma.left.equalTo(CSID_leftMargin_CP)
            ma.height.equalTo(45)
        }
        
        ///textview
        CSID_textF_textVi = UITextView(frame: .zero)
        CSID_textF_textVi.text = CSID_Str_tishistr
        CSID_textF_textVi.font = Font(font: 12)
        CSID_textF_textVi.textColor = CSID_MainTextColor
        CSID_textF_textVi.delegate = self
        AddRadius(CSID_textF_textVi, rabF: 4)
        AddBorder(bordV: CSID_textF_textVi, bordColor: CSID_LineColor, bordWidth: 1)
        self.view.addSubview(CSID_textF_textVi)
        CSID_textF_textVi.snp.makeConstraints { (ma) in
            ma.top.equalTo(tianLab.snp.bottom)
            ma.left.right.equalToSuperview()
            ma.height.equalTo(130)
        }
        
        
        
        //提交
        let commit_btnAction_ = UIButton(Xframe: .zero, title: "提交",titleColor: .white)
        AddRadius(commit_btnAction_, rabF: 4)
        commit_btnAction_.backgroundColor = .blue
        commit_btnAction_.addTarget(self, action: #selector(CSID_Pri_commintingAction), for: .touchUpInside)
        self.view.addSubview(commit_btnAction_)
        
        commit_btnAction_.snp.makeConstraints { (ma) in
            ma.left.equalTo(40)
            ma.right.equalTo(-40)
            ma.height.equalTo(40)
            ma.top.equalTo(CSID_textF_textVi.snp.bottom).offset(30)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
    
    @objc func CSID_Pri_commintingAction(){
        
        
        if CSID_textF_textVi.text == CSID_Str_tishistr || CSID_textF_textVi.text.count < 1{
            CSID_showErrorWithText(text: "请输入你的建议后再提交", view: self.view)
            return
        }
        
        CSID_HUDShow()
        
        CSID_showSuccessWithText(text: "感谢你的反馈", view: self.view)
        self.perform(#selector(goLeftVC), with: nil, afterDelay: 2)
        
    }
    
    
    lazy var title1 : UILabel = {
        let label = UILabel(Xframe: .zero, text: "请选择产品建议", font:Font(font: 13) , textColor: CSID_MainTextColor, alignment: .left)
        
        return label
    }()
    
   func CSID_Btn_creatbtnAction() -> UIButton {
        
        let _btnAction = UIButton(frame: .zero)
        _btnAction.setTitleColor(CSID_SecondTextColor, for: .normal)
        _btnAction.setTitleColor(.blue, for: .selected)
    _btnAction.setBackgroundImage(UIImage(color: .gray, size: .zero), for: .normal)
        _btnAction.setBackgroundImage(UIImage(color: CSID_MainColor, size: .zero), for: .selected)
        _btnAction.titleLabel?.font = Font(font: 12)
        AddRadius(_btnAction, rabF: 4)
    _btnAction.addTarget(self, action: #selector(CSID_Pri_btnAction_ActionSelect), for: .touchUpInside)
        return _btnAction
    }
    
   @objc func CSID_Pri_btnAction_ActionSelect(sender:UIButton){
        
        sender.isSelected = !sender.isSelected
        
    }
}


