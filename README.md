## Solid Smoke web app: movie reviews
Ruby on Rails, JS, jQuery, HTML (Haml), CSS (Sass) 

### Purpose 
Writing this app I could familiarize myself with Ruby on Rails framework and MVC concepts. 

### Features
* User authentication with Devise
* User can add a movie to db - movie info can be fetched from Open Movie Database
 * in production Paperclip uploads poster from url to Google Storage Service (poster url is provided from OMDb)
 * in development posters are stored locally
* User can write a review
* Review can be vote up or down (not by a review's author)
* Downvoted review is hidden
* User can write a comment about review
