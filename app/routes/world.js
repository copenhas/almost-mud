export default Ember.Route.extend({
  model: function(params) {
    return this.store.find('world', params.world_name);
  }
});