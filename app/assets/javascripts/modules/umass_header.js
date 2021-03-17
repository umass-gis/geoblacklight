/**
*  umass_header.js
*
**/

document.addEventListener('DOMContentLoaded', function (event) {
  console.log('DOM fully loaded and parsed')

  document.getElementById('umass--global--navigation--navicon').addEventListener('click', umassMenu)

  function umassMenu () {
    document.getElementById('umass--global--header').classList.toggle('overlay-active')
    document.getElementById('umass--global--navigation--links').classList.toggle('is-active')
    document.getElementById('umass--global--navigation--navicon').classList.toggle('is-active')
  }
})
