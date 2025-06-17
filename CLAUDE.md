# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Tech Stack
- **Backend**: Ruby on Rails 8.0.2
- **Frontend**: React 19.1.0 with Webpack/Babel
- **Database**: SQLite3
- **CSS**: Tailwind CSS 4.1.10
- **Authentication**: OmniAuth with Google OAuth2

## Common Development Commands

### Start Development Environment
```bash
# With Docker (recommended)
docker-compose up

# Without Docker
bundle install
yarn install
bin/dev  # Starts Rails server, Webpack, and Tailwind watcher
```

### Database Operations
```bash
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed
```

### Running Tests
```bash
bin/rails test                # Run all tests
bin/rails test:system         # Run system tests only
bin/rails test test/models/   # Run specific test directory
```

### Build Commands
```bash
yarn build        # Build JavaScript assets
yarn build:watch  # Build JavaScript with watch mode
bin/rails tailwindcss:build  # Build CSS
```

### Rails Console
```bash
bin/rails console
```

## Architecture Overview

### React Integration
- React components are in `app/javascript/components/`
- Components are mounted via data attributes in Rails views
- Webpack bundles JSX files into `app/assets/builds/application.js`
- Entry point: `app/javascript/application.jsx`

### Authentication Flow
- Google OAuth2 via OmniAuth
- Sessions controller handles OAuth callbacks at `/auth/:provider/callback`
- User model stores Google UID and provider information

### Data Models
- **User**: Authenticated via Google OAuth
- **Item**: Wardrobe items with images via ActiveStorage
- **Category/Brand/Season**: Classification for items
- **Coordinate**: Outfit combinations
- **CoordinatedItem**: Join table for outfits
- **Wishes**: User wishlist items

### Asset Pipeline
- JavaScript: Webpack compiles JSX/JS files
- CSS: Tailwind CSS with cssbundling-rails
- Images: ActiveStorage for user uploads
- Propshaft serves compiled assets

### Development Workflow
The `bin/dev` command starts Foreman, which manages three processes:
1. Rails server on port 3000
2. Webpack watcher for JavaScript changes
3. Tailwind CSS watcher for style changes

Hot reloading is enabled for both JavaScript and CSS changes.