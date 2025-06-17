// app/javascript/application.jsx
import React from 'react';
import { createRoot } from 'react-dom/client';
import Header from './components/Header';
import ItemGrid from './components/ItemGrid';
import CoordinateGrid from './components/CoordinateGrid';
import AddButton from './components/AddButton';
import HomePage from './components/HomePage';

document.addEventListener('DOMContentLoaded', () => {
  // Header component
  const headerContainer = document.getElementById('header-container');
  if (headerContainer) {
    try {
      const props = JSON.parse(headerContainer.dataset.props);
      const root = createRoot(headerContainer);
      root.render(<Header {...props} />);
    } catch (error) {
      console.error('Error rendering Header:', error);
    }
  }

  // ItemGrid component (for items and wishes)
  const itemGridContainer = document.getElementById('item-grid-container');
  if (itemGridContainer) {
    try {
      const props = JSON.parse(itemGridContainer.dataset.props);
      const root = createRoot(itemGridContainer);
      root.render(<ItemGrid {...props} />);
    } catch (error) {
      console.error('Error rendering ItemGrid:', error);
    }
  }

  // CoordinateGrid component
  const coordinateGridContainer = document.getElementById('coordinate-grid-container');
  if (coordinateGridContainer) {
    try {
      const props = JSON.parse(coordinateGridContainer.dataset.props);
      const root = createRoot(coordinateGridContainer);
      root.render(<CoordinateGrid {...props} />);
    } catch (error) {
      console.error('Error rendering CoordinateGrid:', error);
    }
  }

  // HomePage component
  const homePageContainer = document.getElementById('home-page');
  if (homePageContainer) {
    try {
      const props = homePageContainer.dataset.props ? JSON.parse(homePageContainer.dataset.props) : {};
      const root = createRoot(homePageContainer);
      root.render(<HomePage {...props} />);
    } catch (error) {
      console.error('Error rendering HomePage:', error);
    }
  }

  // AddButton component - bodyに直接マウント
  try {
    const addButtonDiv = document.createElement('div');
    addButtonDiv.id = 'add-button-floating';
    document.body.appendChild(addButtonDiv);
    const root = createRoot(addButtonDiv);
    root.render(<AddButton />);
  } catch (error) {
    console.error('Error rendering AddButton:', error);
  }
});