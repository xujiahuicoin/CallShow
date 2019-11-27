import UIKit
import Contacts
class CSID_CallShowViewController:CSID_BaseViewController,UITableViewDataSource,UITableViewDelegate {
    /// 得到全部联系人列表
    var dataDic:NSMutableDictionary = NSMutableDictionary.init()
    // 排序后分组数据
    private var objectsArray : [[SortObjectModel]]?
    // 头部标题keys
    private var keysArray:[String]?
    var tabView : UITableView?
    var imageUrlString:String?
    @IBOutlet var xiaView: UIView!
    @IBOutlet weak var selectedLab: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    
    // 创建一个数组用来存储选中的 cell 的行
    var selectedIndexs: NSMutableArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "选择联系人"
        self.view.backgroundColor = RGB(248, g: 248, b: 248)
        self.bannerShow = false
        // 在右侧添加一个按钮
        let barButtonItem = UIBarButtonItem(title: "完成", style: UIBarButtonItem.Style.plain, target: self, action: #selector(selectedOver))
        barButtonItem.tintColor = .black
        self.navigationItem.rightBarButtonItem = barButtonItem
        
        self.dataDic = CSID_CallShowContact.GetContactInformation()
        self.setUpTabView()
        self.configData()
        self.view.addSubview(self.xiaView)
        self.xiaView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(self.view)
            make.height.equalTo(50)
        }
    }
    
    @objc func selectedOver() {
        if self.selectedIndexs.count >= 1{
            CSID_CallShowContact.specifyContactSettings(imageStr: self.imageUrlString ?? "", nameArr: self.selectedIndexs as! Array<String>)
            
            self.navigationController?.popViewController(animated: false)
            /// 来电秀设置成功
        }else{
            print("请选择联系人")
        }
    }
    
    
    //MARK: 建立主要视图
    func setUpTabView() -> Void {
        tabView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), style: .plain)
        tabView?.tableFooterView = UIView.init()
        tabView?.dataSource = self
        tabView?.delegate = self
        tabView?.rowHeight = 75
        tabView?.separatorStyle = .none
        tabView?.register(CSID_ContactTableViewCell.self, forCellReuseIdentifier: "twocell")
        self.view.addSubview(tabView!)
        
        tabView?.snp.makeConstraints({ (make) in
            make.left.right.top.bottom.equalTo(self.view)
        })

    }
    
    func configData(){
        //测试数据
        let testArray = self.dataDic["name"]
        if testArray != nil {
            //基于 UILocalizedIndexedCollation 调用其方法
            UILocalizedIndexedCollation.getCurrentKeysAndObjectsData(needSortArray: testArray as! NSArray) { (dataArray,titleArray) in
                self.objectsArray = dataArray
                self.keysArray    = titleArray
                self.tabView?.reloadData()
            }
        }
        
    }
    
    //MARK: tabView数据源及代理相关
    func numberOfSections(in tableView: UITableView) -> Int {
        return keysArray?.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectsArray?[section].count ?? 0
    }
    
    //MARK: 这是Setion标题 以及右侧索引数组设置
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView:UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 35))
        headerView.backgroundColor = UIColor.init(red: 248, green: 248, blue: 248)
        let titleLab:UILabel = UILabel.init(frame: CGRect(x: 16, y: 0, width: SCREEN_WIDTH, height: 35))
        titleLab.text = keysArray?[section]
        headerView.addSubview(titleLab)
        return headerView
    }

    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return keysArray
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView:UIView = UIView.init()
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "twocell"
        var cell:CSID_ContactTableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier) as! CSID_ContactTableViewCell
        if cell == nil {
            cell = CSID_ContactTableViewCell.init(style: .default, reuseIdentifier: identifier)
        }
        let name:String = objectsArray![indexPath.section][indexPath.row ].objValue!
        
        let model:CSID_ContactModel = CSID_ContactModel.init(name: name)
        cell.contactArray = model;
        self.selectedLab.text = "已选择"+String(self.selectedIndexs.count)+"位联系人"
        if self.selectedIndexs.contains(name){
            cell.selbtn.isSelected = true
        }else{
            cell.selbtn.isSelected = false
        }
        cell.checkTitle = {isTitleClicked in
            if self.selectedIndexs.contains(name){
                self.selectedIndexs.remove(name)
                self.selectedLab.text = "已选择"+String(self.selectedIndexs.count)+"位联系人"
                cell.selbtn.isSelected = false
            }else{
                self.selectedIndexs.add(name)
                cell.selbtn.isSelected = true
                self.selectedLab.text = "已选择"+String(self.selectedIndexs.count)+"位联系人"
            }
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CSID_ContactTableViewCell
        let name:String = objectsArray![indexPath.section][indexPath.row ].objValue!
        if self.selectedIndexs.contains(name){
            self.selectedIndexs.remove(name)
            self.selectedLab.text = "已选择"+String(self.selectedIndexs.count)+"位联系人"
            cell.selbtn.isSelected = false
        }else{
            self.selectedIndexs.add(name)
            cell.selbtn.isSelected = true
            self.selectedLab.text = "已选择"+String(self.selectedIndexs.count)+"位联系人"
        }
        self.tabView?.reloadRows(at: [indexPath], with: .automatic)
    }
    
    
    
    @IBAction func clickCancelButton(_ sender: UIButton) {
        self.selectedIndexs.removeAllObjects()
        self.tabView?.reloadData()
    }
    
}
