import React from 'react';

const CoordinateGrid = ({ coordinates }) => {
  return (
    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
      {/* ヘッダーセクション */}
      <div className="mb-8">
        <h1 className="text-3xl font-bold text-gray-900 mb-2">
          Coordinates
        </h1>
        <p className="text-gray-600">
          {coordinates.length}個のコーディネートが登録されています
        </p>
      </div>

      {/* インスタグラム風グリッド */}
      {coordinates.length > 0 ? (
        <div className="grid grid-cols-3 sm:grid-cols-4 md:grid-cols-5 lg:grid-cols-6 gap-4">
          {coordinates.map((coordinate) => (
            <div key={coordinate.id} className="relative">
              <a
                href={coordinate.showPath}
                className="block relative aspect-[3/4] overflow-hidden bg-gray-100 mb-2"
                onMouseEnter={(e) => {
                  const img = e.currentTarget.querySelector('img');
                  const overlay = e.currentTarget.querySelector('.overlay');
                  const text = e.currentTarget.querySelector('.overlay-text');
                  
                  if (img) {
                    img.style.transform = 'scale(1.05)';
                    img.style.opacity = '0.9';
                  }
                  if (overlay) {
                    overlay.style.backgroundColor = 'rgba(0, 0, 0, 0.3)';
                  }
                  if (text) {
                    text.style.opacity = '1';
                  }
                }}
                onMouseLeave={(e) => {
                  const img = e.currentTarget.querySelector('img');
                  const overlay = e.currentTarget.querySelector('.overlay');
                  const text = e.currentTarget.querySelector('.overlay-text');
                  
                  if (img) {
                    img.style.transform = 'scale(1)';
                    img.style.opacity = '1';
                  }
                  if (overlay) {
                    overlay.style.backgroundColor = 'transparent';
                  }
                  if (text) {
                    text.style.opacity = '0';
                  }
                }}
              >
                <img
                  src={coordinate.imageUrl}
                  alt={`コーディネート ${coordinate.date}`}
                  className="w-full h-full object-cover"
                  style={{
                    transition: 'all 0.3s ease'
                  }}
                />
                {/* ホバー時のオーバーレイ（アイテム数のみ） */}
                <div 
                  className="overlay absolute inset-0 flex items-center justify-center pointer-events-none"
                  style={{
                    backgroundColor: 'transparent',
                    transition: 'background-color 0.3s ease'
                  }}
                >
                  <div 
                    className="overlay-text text-white text-center"
                    style={{
                      opacity: 0,
                      transition: 'opacity 0.3s ease'
                    }}
                  >
                    {coordinate.itemCount && (
                      <p className="text-sm font-medium">
                        {coordinate.itemCount}アイテム
                      </p>
                    )}
                  </div>
                </div>
              </a>
              
              {/* 写真の下の外側に日付表示 */}
              <div className="text-right text-xs text-gray-600 mt-1">
                {coordinate.date}
              </div>
            </div>
          ))}
        </div>
      ) : (
        <div className="text-center py-12">
          <p className="text-gray-500">
            まだコーディネートが登録されていません
          </p>
        </div>
      )}
    </div>
  );
};

export default CoordinateGrid;