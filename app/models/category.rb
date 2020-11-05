class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '陶芸' },
    { id: 3, name: 'ガラス細工' },
    { id: 4, name: 'スポーツ' },
    { id: 5, name: 'グランピング' },
    { id: 6, name: '料理' },
    { id: 7, name: 'サイクリング' },
    { id: 8, name: '食事' },
    { id: 9, name: 'アクティビティ' },
    { id: 10, name: 'ハンドメイド' },
    { id: 11, name: 'その他' }
  ]
end
