import { Controller } from "stimulus";
import $ from 'jquery';
import Rails from '@rails/ujs';

export default class extends Controller {
  static targets = ['form', 'healthySickSelector', 'sickSelector', 'locationHint', 'locationStatus',
                    'healthy', 'fever', 'cough', 'lon', 'lat', 'accuracy'];

  connect() {}

  selectHealthy(e) {
    e.preventDefault();
    $(this.healthyTarget).val(true);
    $(this.healthySickSelectorTarget).hide();
    $(this.locationHintTarget).show();
  }

  selectSick(e) {
    e.preventDefault();
    $(this.healthyTarget).val(false);
    $(this.healthySickSelectorTarget).hide();
    $(this.sickSelectorTarget).show();
  }

  confirmSubmit(e) {
    e.preventDefault();
    $(this.sickSelectorTarget).hide();
    $(this.locationHintTarget).hide();
    $(this.locationStatus).show();
    this.requestLocation(this.submit);
  }

  requestLocation(onSuccess) {
    $(this.locationStatusTarget).show();
    const geo = navigator.geolocation;

    const opts = {
      enableHighAccuracy: true, // FIXME
      timeout: 10 * 1000, // 10 seconds in ms
      maximumAge: 30 * 60 * 1000, // 30 minutes in ms
    };
    geo.getCurrentPosition(onSuccess.bind(this), console.log);
  }

  submit(position) {
    // console.log(position);
    this.lonTarget.value = position.coords.longitude;
    this.latTarget.value = position.coords.latitude;
    this.accuracyTarget.value = position.coords.accuracy;
    Rails.fire(this.formTarget, 'submit');
  }
}
