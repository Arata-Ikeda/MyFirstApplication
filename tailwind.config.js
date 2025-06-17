/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js',
    './app/javascript/**/*.jsx',
    './app/javascript/components/**/*.jsx'
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}