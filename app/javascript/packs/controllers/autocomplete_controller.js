import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "startLocation" ]

  greet() {
    console.log('Hi from stimulus')
  }
}

// let autocomplete;
//   function initAutocomplete() {
//     autocomplete = new google.maps.places.Autocomplete(
//       document.getElementById("route_start_location"),
//       { types: ["geocode"] }
//     );

//     autocomplete.setFields(["address_component"]);
//     autocomplete.addListener("place_changed", fillInAddress);
//   }

//   function fillInAddress() {
//     const place = autocomplete.getPlace();
//   }

//   document.addEventListener('DOMContentLoaded', () => {
//     initAutocomplete()
//   })