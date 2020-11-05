class Job < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' }, { id: 2, name: 'IT・WEB' }, { id: 3, name: '出版・報道' },
    { id: 4, name: '医療・福祉' }, { id: 5, name: '教育・保育' }, { id: 6, name: '美容・ファッション・販売' },
    { id: 7, name: '旅行・ホテル・航空' }, { id: 8, name: '飲食' }, { id: 9, name: '運搬・運送' },
    { id: 10, name: '保安' }, { id: 11, name: '不動産・建築・インテリア' }, { id: 12, name: '事務' },
    { id: 13, name: '金融・コンサル' }, { id: 14, name: '国家・地方公務員' }, { id: 15, name: '法律・政治' },
    { id: 16, name: '学生' }, { id: 17, name: 'その他' }
  ]
end