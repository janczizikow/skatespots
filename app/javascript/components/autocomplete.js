import places from "places.js";

const autocomplete = (element, type = 'city') => {
  if (element) {
    places({
      container: element,
      type: type,
      templates: {
        value: function(suggestion) {
          return suggestion.name;
        }
      }
    });
  }
};

export default autocomplete;
