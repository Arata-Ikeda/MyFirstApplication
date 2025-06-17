import React, { useState, useRef, useEffect } from 'react';

const AddButton = () => {
  const [isOpen, setIsOpen] = useState(false);
  const dropdownRef = useRef(null);
  const timeoutRef = useRef(null);

  const handleMouseEnter = () => {
    if (timeoutRef.current) {
      clearTimeout(timeoutRef.current);
    }
    setIsOpen(true);
  };

  const handleMouseLeave = () => {
    timeoutRef.current = setTimeout(() => {
      setIsOpen(false);
    }, 200); // 200ms の遅延を追加
  };

  useEffect(() => {
    return () => {
      if (timeoutRef.current) {
        clearTimeout(timeoutRef.current);
      }
    };
  }, []);

  const menuItems = [
    {
      label: 'アイテムを追加',
      href: '/items/new',
      icon: '👕'
    },
    {
      label: 'コーディネートを追加',
      href: '/coordinates/new',
      icon: '👗'
    },
    {
      label: 'ウィッシュリストに追加',
      href: '/wishes/new',
      icon: '💝'
    }
  ];

  return (
    <div 
      className="fixed bottom-6 right-6 z-50" 
      ref={dropdownRef}
      onMouseEnter={handleMouseEnter}
      onMouseLeave={handleMouseLeave}
    >
      <button
        className="w-16 h-16 bg-gray-900 hover:bg-gray-800 text-white rounded-full flex items-center justify-center shadow-lg transition-all duration-200 hover:scale-105"
      >
        <svg 
          className={`w-8 h-8 transition-transform ${isOpen ? 'rotate-45' : ''}`}
          fill="none" 
          stroke="currentColor" 
          viewBox="0 0 24 24"
        >
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 4v16m8-8H4" />
        </svg>
      </button>

      {isOpen && (
        <div className="absolute right-0 bottom-full mb-2 w-56 bg-white rounded-md shadow-lg ring-1 ring-black ring-opacity-5">
          <div className="py-1" role="menu">
            {menuItems.map((item, index) => (
              <a
                key={index}
                href={item.href}
                className="flex items-center px-4 py-3 text-sm text-gray-700 hover:bg-gray-50 transition-colors"
                role="menuitem"
              >
                <span className="text-lg mr-3">{item.icon}</span>
                <span>{item.label}</span>
              </a>
            ))}
          </div>
        </div>
      )}
    </div>
  );
};

export default AddButton;