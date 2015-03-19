gulp = require('gulp')
gutil = require('gulp-util')
coffee = require('gulp-coffee')

handleErrors = (stream) ->
  stream.on 'error', ->
    gutil.log.apply(this, arguments)
    stream.end()

gulp.task 'coffee', ->
  gulp.src('./src/**/*.coffee')
      .pipe(handleErrors(coffee({bare: true})))
      .pipe(gulp.dest('./dist/'))

gulp.task 'watch', ->
  gulp.watch('./src/**/*.coffee', ['coffee'])

gulp.task('default', ['watch', 'coffee'])
