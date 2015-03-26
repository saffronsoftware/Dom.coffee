QUnit.module('Dom.matches');

QUnit.test('Sanity checks', function() {
  equal(typeof Dom.matches, 'function', 'typeof is function');
});

QUnit.test('Regular elements match', function() {
  var alpha = document.getElementById('alpha');
  equal(Dom.matches(alpha, '#alpha'), true, '[#alpha] matches #alpha');
  equal(Dom.matches(alpha, '.item'), true, '[#alpha] matches .item');
  equal(Dom.matches(alpha, 'div'), true, '[#alpha] matches div');
  equal(Dom.matches(alpha, 'p'), false, '[#alpha] does not match p');
  equal(Dom.matches(alpha, '.baz'), false, '[#alpha] does not match .baz');
  equal(Dom.matches(alpha, '#alpha.item'), true, '[#alpha] matches #alpha.item');
  equal(Dom.matches(alpha, '#alpha, foo'), true, '[#alpha] matches #alpha, foo');
  equal(Dom.matches(alpha, 'foo, .item'), true, '[#alpha] matches foo, .item');
});

QUnit.test('Orphaned elements match', function() {
  var beta = document.createElement('div');
  beta.id = 'beta';
  beta.className = 'foo bar';
  equal(Dom.matches(beta, 'div'), true, '[#beta] matches div');
  equal(Dom.matches(beta, '#beta'), true, '[#beta] matches #beta');
  equal(Dom.matches(beta, '.bar'), true, '[#beta] matches .bar');
  equal(Dom.matches(beta, 'p'), false, '[#beta] does not match p');
  equal(Dom.matches(beta, '.baz'), false, '[#beta] does not match .baz');
  equal(Dom.matches(beta, '#beta.bar'), true, '[#alpha] matches #alpha.item');
  equal(Dom.matches(beta, '#beta, qux'), true, '[#beta] matches #beta, qux');
  equal(Dom.matches(beta, '.qux, .bar'), true, '[#alpha] matches .qux, .bar');
});
