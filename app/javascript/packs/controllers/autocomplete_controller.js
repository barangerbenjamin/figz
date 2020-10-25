import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "start", "end" ];

  connect() {
    let autocompletes = [this.startTarget, this.endTarget];
    
    function initAutocomplete() {
      autocompletes.forEach((autocomplete) => {
        autocomplete = new google.maps.places.Autocomplete(
          autocomplete,
          { types: ["geocode"] }
        );
        autocomplete.setFields(["address_component"]);
      });
    }
    initAutocomplete();
  }
}