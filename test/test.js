QUnit.module('Dom');

QUnit.test('Instantiation', function(assert) {
  var fooId = document.getElementById('foo');
  var mrAndMsFoo = document.querySelectorAll('.foo');
  var body = document.body;
  assert.deepEqual(Dom(fooId).els[0], fooId, 'Instantiates correctly with one element');
  assert.deepEqual(Dom('#foo').els[0], fooId, 'Instantiates correctly with selector');
  assert.deepEqual(Dom('.foo').els, [].slice.call(mrAndMsFoo), 'Instantiates correctly with selector matching multiple elements');
});

QUnit.test('Extending', function(assert) {
  assert.equal(Dom.extend({test: 1}).test, 1, 'Correctly extends DOM');
  assert.equal(Dom.prototype.extend({test: 1}).test, 1, 'Correctly extends DOM prototype');
});

QUnit.test('Mapping', function(assert) {
  var foos = Dom('.foo');
  assert.deepEqual(foos.map(function(x) { return x; }), foos.els, 'Yields els when mapping with identity function');
});

QUnit.module('Dom.matches');

QUnit.test('Matching regular elements', function() {
  var alpha = document.getElementById('alpha');
  equal(Dom(alpha).matches('#alpha'), true, '[#alpha] matches #alpha');
  equal(Dom(alpha).matches('.item'), true, '[#alpha] matches .item');
  equal(Dom(alpha).matches('div'), true, '[#alpha] matches div');
  equal(Dom(alpha).matches('p'), false, '[#alpha] does not match p');
  equal(Dom(alpha).matches('.baz'), false, '[#alpha] does not match .baz');
  equal(Dom(alpha).matches('#alpha.item'), true, '[#alpha] matches #alpha.item');
  equal(Dom(alpha).matches('#alpha, foo'), true, '[#alpha] matches #alpha, foo');
  equal(Dom(alpha).matches('foo, .item'), true, '[#alpha] matches foo, .item');
});

QUnit.test('Matching orphaned elements', function() {
  var beta = document.createElement('div');
  beta.id = 'beta';
  beta.className = 'foo bar';
  equal(Dom(beta).matches('div'), true, '[#beta] matches div');
  equal(Dom(beta).matches('#beta'), true, '[#beta] matches #beta');
  equal(Dom(beta).matches('.bar'), true, '[#beta] matches .bar');
  equal(Dom(beta).matches('p'), false, '[#beta] does not match p');
  equal(Dom(beta).matches('.baz'), false, '[#beta] does not match .baz');
  equal(Dom(beta).matches('#beta.bar'), true, '[#alpha] matches #alpha.item');
  equal(Dom(beta).matches('#beta, qux'), true, '[#beta] matches #beta, qux');
  equal(Dom(beta).matches('.qux, .bar'), true, '[#alpha] matches .qux, .bar');
});
