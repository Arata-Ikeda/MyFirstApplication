import React from 'react';

const HomePage = ({ isLoggedIn = false }) => {
  return (
    <div className="min-h-screen bg-white">
      {/* Hero Section */}
      <div className="relative">
        <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-16">
          <div className="text-center">
            <h1 className="text-4xl md:text-6xl font-bold text-gray-800 mb-6">
              Style<span className="bg-gradient-to-r from-purple-400 to-pink-400 bg-clip-text text-transparent">Assist</span>
            </h1>
            <p className="text-lg md:text-xl text-gray-600 mb-8 max-w-2xl mx-auto">
              毎日のコーディネートをもっと楽しく。あなたのワードローブを整理して、お気に入りのスタイルを見つけよう。
            </p>
            {isLoggedIn ? (
              <div className="flex flex-col sm:flex-row gap-4 justify-center">
                <a href="/items" className="bg-gradient-to-r from-purple-400 to-pink-400 text-white px-6 py-3 rounded-lg font-medium hover:from-purple-500 hover:to-pink-500 transition-colors">
                  ワードローブを見る
                </a>
                <a href="/coordinates" className="border border-gray-300 text-gray-700 px-6 py-3 rounded-lg font-medium hover:bg-gray-50 transition-colors">
                  コーディネートを作る
                </a>
              </div>
            ) : (
              <div className="flex justify-center">
                <a href="/auth/google_oauth2" className="bg-gradient-to-r from-purple-400 to-pink-400 text-white px-6 py-3 rounded-lg font-medium hover:from-purple-500 hover:to-pink-500 transition-colors">
                  Googleでサインイン
                </a>
              </div>
            )}
          </div>
        </div>
      </div>

      {/* Features Section */}
      <div className="py-16 bg-gray-50">
        <div className="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center mb-12">
            <h2 className="text-3xl font-bold text-gray-800 mb-4">3つの便利な機能</h2>
            <p className="text-gray-600">あなたのファッションライフをサポートします</p>
          </div>
          
          <div className="grid md:grid-cols-3 gap-8">
            {/* Wardrobe Management */}
            <div className="bg-white p-6 rounded-lg shadow-sm border hover:shadow-md transition-shadow">
              <div className="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center mb-4">
                <svg className="w-6 h-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                </svg>
              </div>
              <h3 className="text-xl font-semibold text-gray-800 mb-3">ワードローブ管理</h3>
              <p className="text-gray-600 mb-4">
                服をデジタルで整理して、ブランドやカテゴリーで分類できます。
              </p>
              {isLoggedIn && (
                <a href="/items" className="text-blue-600 hover:text-blue-800 font-medium">
                  アイテムを見る →
                </a>
              )}
            </div>

            {/* Coordinate Creation */}
            <div className="bg-white p-6 rounded-lg shadow-sm border hover:shadow-md transition-shadow">
              <div className="w-12 h-12 bg-pink-100 rounded-lg flex items-center justify-center mb-4">
                <svg className="w-6 h-6 text-pink-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z" />
                </svg>
              </div>
              <h3 className="text-xl font-semibold text-gray-800 mb-3">コーディネート作成</h3>
              <p className="text-gray-600 mb-4">
                アイテムを組み合わせて、お気に入りのコーディネートを記録できます。
              </p>
              {isLoggedIn && (
                <a href="/coordinates" className="text-pink-600 hover:text-pink-800 font-medium">
                  コーディネートを見る →
                </a>
              )}
            </div>

            {/* Wishlist */}
            <div className="bg-white p-6 rounded-lg shadow-sm border hover:shadow-md transition-shadow">
              <div className="w-12 h-12 bg-yellow-100 rounded-lg flex items-center justify-center mb-4">
                <svg className="w-6 h-6 text-yellow-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M11.049 2.927c.3-.921 1.603-.921 1.902 0l1.519 4.674a1 1 0 00.95.69h4.915c.969 0 1.371 1.24.588 1.81l-3.976 2.888a1 1 0 00-.363 1.118l1.518 4.674c.3.922-.755 1.688-1.538 1.118l-3.976-2.888a1 1 0 00-1.176 0l-3.976 2.888c-.783.57-1.838-.197-1.538-1.118l1.518-4.674a1 1 0 00-.363-1.118l-3.976-2.888c-.784-.57-.38-1.81.588-1.81h4.914a1 1 0 00.951-.69l1.519-4.674z" />
                </svg>
              </div>
              <h3 className="text-xl font-semibold text-gray-800 mb-3">ウィッシュリスト</h3>
              <p className="text-gray-600 mb-4">
                欲しいアイテムをリストで管理して、購入計画を立てられます。
              </p>
              {isLoggedIn && (
                <a href="/wishes" className="text-yellow-600 hover:text-yellow-800 font-medium">
                  ウィッシュリストを見る →
                </a>
              )}
            </div>
          </div>
        </div>
      </div>

      {/* CTA Section */}
      <div className="py-16 bg-white border-t">
        <div className="max-w-4xl mx-auto text-center px-4 sm:px-6 lg:px-8">
          <h3 className="text-2xl font-bold text-gray-800 mb-4">
            今すぐStyleAssistを始めよう
          </h3>
          <p className="text-gray-600 mb-8">
            あなたのワードローブを整理して、毎日のコーディネートをもっと楽しく。
          </p>
          {isLoggedIn ? (
            <a href="/items" className="bg-gradient-to-r from-purple-400 to-pink-400 text-white px-8 py-3 rounded-lg font-medium hover:from-purple-500 hover:to-pink-500 transition-colors">
              アイテムを追加する
            </a>
          ) : (
            <a href="/auth/google_oauth2" className="bg-gradient-to-r from-purple-400 to-pink-400 text-white px-8 py-3 rounded-lg font-medium hover:from-purple-500 hover:to-pink-500 transition-colors">
              Googleでサインイン
            </a>
          )}
        </div>
      </div>
    </div>
  );
};

export default HomePage;