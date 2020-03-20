import { Controller } from "stimulus";
import $ from 'jquery';
import Rails from '@rails/ujs';

export default class extends Controller {
  static targets = ['introduction', 'form', 'healthySickSelector', 'sickSelector',
                    'submitButtonHealthy', 'submitButtonSick',
                    'locationHint', 'healthy', 'fever', 'cough', 'longitude', 'latitude', 'accuracy'];

  connect() {}

  selectHealthy(e) {
    e.preventDefault();
    $(this.introductionTarget).hide();
    $(this.healthyTarget).val(true);
    $(this.healthySickSelectorTarget).hide();
    $(this.locationHintTarget).show();
    this.requestLocationAndSetInBackground();
  }

  selectSick(e) {
    e.preventDefault();
    $(this.introductionTarget).hide();
    $(this.healthyTarget).val(false);
    $(this.healthySickSelectorTarget).hide();
    $(this.sickSelectorTarget).show();
    this.requestLocationAndSetInBackground();
  }

  confirmSubmit(e) {
    e.preventDefault();
    $(this.sickSelectorTarget).hide();
    $(this.locationHintTarget).hide();
    $(this.locationStatus).show();

    // TODO: Check if has location
    this.submit();
  }

  requestLocationAndSetInBackground() {
    console.log($(this.submitButtonTarget));
    $(this.submitButtonHealthyTarget).prop('disabled', true);
    $(this.submitButtonHealthyTarget).html('Ortung läuft noch...');
    $(this.submitButtonSickTarget).prop('disabled', true);
    $(this.submitButtonSickTarget).html('Ortung läuft noch...');
    const geo = navigator.geolocation;

    const opts = {
      enableHighAccuracy: true, // FIXME
      timeout: 10 * 1000, // 10 seconds in ms
      maximumAge: 30 * 60 * 1000, // 30 minutes in ms
    };
    geo.getCurrentPosition(this.setLocation.bind(this), console.log);
  }

  setLocation(position) {
    // console.log(position);
    let anonymizedPosition = this.anonymizePosition(position);
    this.longitudeTarget.value = anonymizedPosition.longitude;
    this.latitudeTarget.value = anonymizedPosition.latitude;
    this.accuracyTarget.value = position.coords.accuracy;
    $(this.submitButtonHealthyTarget).prop('disabled', false);
    $(this.submitButtonHealthyTarget).html('Abschicken');
    $(this.submitButtonSickTarget).prop('disabled', false);
    $(this.submitButtonSickTarget).html('Abschicken');
  }

  submit() {
    Rails.fire(this.formTarget, 'submit');
  }

  anonymizePosition(position) {
    // (1 / 110574) is one kilometer
    // Multiple with a random number between -10 and +10
    let kilometerRadius = 10;
    let latitudeNoise = (Math.random() - 0.5) * (1 / 110574) * kilometerRadius;

    // (1 / 71952) is approx. one kilometer in longitude in Germany
    let longitudeNoise = (Math.random() - 0.5) * (1 / 71952) * kilometerRadius;

    return {
      latitude: position.coords.latitude + latitudeNoise,
      longitude: position.coords.longitude + longitudeNoise
    };
  }
}
