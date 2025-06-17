import React, { useState } from 'react';
import ItemCard from './ItemCard';

const ItemGrid = ({ items, categories = [], currentCategory = null, type = 'item', onPurchaseClick }) => {
  const [selectedCategory, setSelectedCategory] = useState(currentCategory);

  const filteredItems = selectedCategory
    ? items.filter(item => item.category.id === parseInt(selectedCategory))
    : items;

  const getTitle = () => {
    switch (type) {
      case 'wish': return 'Wishlist';
      case 'purchased': return 'Purchased Items';
      default: return 'Wardrobe';
    }
  };

  const getDescription = () => {
    switch (type) {
      case 'wish':
        return `${filteredItems.length}個のアイテムがウィッシュリストにあります`;
      case 'purchased':
        return `ウィッシュリストから購入済みにした${filteredItems.length}個のアイテム`;
      default:
        return `${filteredItems.length}個のアイテムを所有しています`;
    }
  };

  return (
    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
      {/* ヘッダーセクション */}
      <div className="mb-8">
        <h1 className="text-3xl font-bold text-gray-900 mb-2">
          {getTitle()}
        </h1>
        <p className="text-gray-600">
          {getDescription()}
        </p>
      </div>

      {/* カテゴリフィルター */}
      {categories.length > 0 && (
        <div className="mb-6">
          <div className="flex flex-wrap gap-2">
            <button
              onClick={() => setSelectedCategory(null)}
              className={`px-4 py-2 rounded-full text-sm font-medium transition-colors ${
                !selectedCategory
                  ? 'bg-gray-900 text-white'
                  : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
              }`}
            >
              すべて
            </button>
            {categories.map((category) => (
              <button
                key={category.id}
                onClick={() => setSelectedCategory(category.id.toString())}
                className={`px-4 py-2 rounded-full text-sm font-medium transition-colors ${
                  selectedCategory === category.id.toString()
                    ? 'bg-gray-900 text-white'
                    : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
                }`}
              >
                {category.name}
              </button>
            ))}
          </div>
        </div>
      )}

      {/* アイテムグリッド */}
      {filteredItems.length > 0 ? (
        <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 gap-6">
          {filteredItems.map((item) => (
            <ItemCard 
              key={item.id} 
              item={item} 
              type={type}
              onPurchaseClick={onPurchaseClick}
            />
          ))}
        </div>
      ) : (
        <div className="text-center py-12">
          <p className="text-gray-500">
            {selectedCategory 
              ? 'このカテゴリにアイテムはありません'
              : 'アイテムがありません'
            }
          </p>
        </div>
      )}
    </div>
  );
};

export default ItemGrid;