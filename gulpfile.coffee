gulp = require('gulp')
gutil = require('gulp-util')
coffee = require('gulp-coffee')
async = require('async')
concat = require('gulp-concat')

handleErrors = (stream) ->
  stream.on 'error', ->
    gutil.log.apply(this, arguments)
    stream.end()

gulp.task 'coffee', ->
  async.series [
    (done) ->
      gulp.src('./src/**/*.coffee')
          .pipe(handleErrors(coffee({bare: true})))
          .pipe(gulp.dest('./compiled/'))
          .on('end', done)
    (done) ->
      gulp.src([
        './compiled/main.js'
        './compiled/matches.js'
        './compiled/checks.js'
        './compiled/html.js'
        './compiled/css.js'
        './compiled/events.js'
        './compiled/traversal.js'
        './compiled/defaultDisplay.js'
      ]).pipe(concat('Dom.js'))
        .pipe(gulp.dest('./dist'))
        .on('end', done)
  ]

gulp.task 'watch', ->
  gulp.watch('./src/**/*.coffee', ['coffee'])

gulp.task('default', ['watch', 'coffee'])
