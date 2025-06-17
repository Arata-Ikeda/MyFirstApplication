// app/javascript/components/Header.jsx
import React from 'react';

// ログアウトリンクのための特別なコンポーネント
// data-turbo-method="post" と同じことを実現する
const LogoutLink = ({ path, csrfToken }) => {
  const handleClick = (e) => {
    e.preventDefault(); // 通常のリンク遷移を止める
    const form = document.createElement('form');
    form.method = 'POST';
    form.action = path;
    
    const csrfInput = document.createElement('input');
    csrfInput.type = 'hidden';
    csrfInput.name = 'authenticity_token';
    csrfInput.value = csrfToken;
    form.appendChild(csrfInput);

    // RailsのDELETEメソッドを擬似的に送るための隠しフィールド
    const methodInput = document.createElement('input');
    methodInput.type = 'hidden';
    methodInput.name = '_method';
    methodInput.value = 'delete'; // `routes.rb` が `delete` なら `delete` に
    form.appendChild(methodInput);

    document.body.appendChild(form);
    form.submit();
  };

  return (
    <a href={path} onClick={handleClick} className="text-sm text-gray-600 hover:text-gray-900 transition-colors">
      ログアウト
    </a>
  );
};


const Header = ({ isLoggedIn, currentUser, paths, csrfToken }) => {
  return (
    <header className="fixed top-0 left-0 right-0 bg-white border-b border-gray-200 z-50">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex justify-between items-center h-16">
          {/* ロゴ部分 */}
          <div className="flex items-center">
            <a href={paths.root} className="text-xl font-semibold text-gray-900 tracking-tight hover:text-gray-700 transition-colors">
              StyleAssist 
            </a>
          </div>

          {/* ナビゲーション部分 */}
          <nav className="flex items-center">
            {isLoggedIn ? (
              <div className="flex items-center">
                {/* メインナビゲーション */}
                <div className="hidden md:flex items-center space-x-8 mr-8">
                  <a href={paths.items} className="text-sm font-medium text-gray-700 hover:text-gray-900 transition-colors">
                    Wardrobes
                  </a>
                  <a href={paths.coordinates} className="text-sm font-medium text-gray-700 hover:text-gray-900 transition-colors">
                    Coordinates
                  </a>
                  <a href={paths.wishes} className="text-sm font-medium text-gray-700 hover:text-gray-900 transition-colors">
                    Wishlist
                  </a>
                </div>

                {/* プロフィールセクション */}
                <div className="flex items-center space-x-4 pl-6 border-l border-gray-200">
                  <div className="flex items-center space-x-3">
                    {currentUser.iconUrl && (
                      <img
                        src={currentUser.iconUrl}
                        alt={currentUser.name}
                        className="w-7 h-7 rounded-full object-cover ring-2 ring-gray-100 hover:ring-gray-200 transition-all"
                      />
                    )}
                    <span className="hidden sm:block text-sm font-medium text-gray-900">
                      {currentUser.name}
                    </span>
                  </div>
                  <LogoutLink path={paths.logout} csrfToken={csrfToken} />
                </div>
              </div>
            ) : (
              <div className="flex items-center space-x-4">
                <a href={paths.login} className="text-sm font-medium text-gray-700 hover:text-gray-900 transition-colors">
                  Sign in
                </a>
                <a href={paths.login} className="bg-gray-900 text-white text-sm font-medium px-4 py-2 rounded-md hover:bg-gray-800 transition-all shadow-sm">
                  Get Started
                </a>
              </div>
            )}
          </nav>
        </div>
      </div>
    </header>
  );
};

export default Header;