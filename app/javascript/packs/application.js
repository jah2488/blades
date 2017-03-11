/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

const merge       = require('webpack-merge')
const require_elm = (name) => { return require('../../assets/javascripts/elm/' + name); };

var Elm = merge(
  require_elm('Faction'),
  require_elm('District'),
  require_elm('Category'),
  require_elm('Game'),
  require_elm('Nav')
);

module.exports = Elm;
