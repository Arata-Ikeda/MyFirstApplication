import React from 'react';

const ItemCard = ({ item, type = 'item', onPurchaseClick }) => {
  const imageUrl = item.imageUrl || '/images/no_image_square.jpg';
  
  return (
    <div className="group relative">
      <a href={item.showPath} className="block">
        <div className="aspect-square overflow-hidden rounded-lg bg-gray-100">
          <img
            src={imageUrl}
            alt={item.name}
            className="h-full w-full object-cover object-center group-hover:opacity-75 transition-opacity"
          />
        </div>
        <div className="mt-3 space-y-1">
          <h3 className="text-sm font-medium text-gray-900">
            {item.brand?.name || '未設定'}
          </h3>
          <div className="flex items-center gap-2 flex-wrap">
            <span className="inline-flex items-center rounded-md bg-gray-100 px-2 py-1 text-xs font-medium text-gray-700">
              {item.category?.name || '未設定'}
            </span>
            <span className="inline-flex items-center rounded-md bg-blue-50 px-2 py-1 text-xs font-medium text-blue-700">
              {item.season?.name || '未設定'}
            </span>
            {type === 'purchased' && item.purchaseDate && (
              <span className="inline-flex items-center rounded-md bg-green-50 px-2 py-1 text-xs font-medium text-green-700">
                購入: {item.purchaseDate}
              </span>
            )}
          </div>
        </div>
      </a>
      
      {type === 'wish' && (
        <button
          onClick={(e) => {
            e.preventDefault();
            if (typeof window.handlePurchase === 'function') {
              window.handlePurchase(item);
            }
          }}
          className="absolute top-2 right-2 bg-white rounded-full p-2 shadow-sm hover:shadow-md transition-shadow"
          title="購入済みにする"
        >
          <svg className="w-5 h-5 text-gray-600 hover:text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M5 13l4 4L19 7" />
          </svg>
        </button>
      )}
    </div>
  );
};

export default ItemCard;