import React from 'react';

const FormLayout = ({ title, subtitle, children, onSubmit, backPath, isSubmitting = false }) => {
  return (
    <div className="min-h-screen bg-gray-50 py-8">
      <div className="max-w-2xl mx-auto px-4 sm:px-6 lg:px-8">
        {/* ヘッダー */}
        <div className="mb-8">
          <h1 className="text-3xl font-bold text-gray-900 mb-2">
            {title}
          </h1>
          {subtitle && (
            <p className="text-gray-600">
              {subtitle}
            </p>
          )}
        </div>

        {/* フォームカード */}
        <div className="bg-white shadow-sm rounded-lg">
          <div className="px-6 py-8">
            {children}
          </div>
        </div>

        {/* 戻るボタン */}
        {backPath && (
          <div className="mt-6">
            <a 
              href={backPath}
              className="inline-flex items-center text-sm text-gray-600 hover:text-gray-900 transition-colors"
            >
              <svg className="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M10 19l-7-7m0 0l7-7m-7 7h18" />
              </svg>
              戻る
            </a>
          </div>
        )}
      </div>
    </div>
  );
};

export default FormLayout;