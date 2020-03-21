import { Controller } from "stimulus";
import $ from 'jquery';
import Rails from '@rails/ujs';

export default class extends Controller {
  static targets = ['introduction', 'form', 'healthySickSelector', 'sickSelector',
                    'submitButtonHealthy', 'submitButtonSick',
                    'locationHint', 'healthy', 'fever', 'cough', 'longitude', 'latitude', 'accuracy',
                    'locationError', 'locationErrorPermissionDenied', 'locationErrorPositionUnavailable',
                    'locationErrorTimeout'];

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

    this.submit();
  }

  requestLocationAndSetInBackground() {
    this.disableSubmitButtons();
    const geo = navigator.geolocation;

    // Note: Actually not using these options for now. See how far we
    // can get with default options (none) first.
    const opts = {
      enableHighAccuracy: true, // Results in slower position - consider not using
      timeout: 10 * 1000, // 10 seconds in ms
      maximumAge: 30 * 60 * 1000, // 30 minutes in ms
    };
    geo.getCurrentPosition(this.setLocation.bind(this), this.requestLocationError.bind(this));
  }

  setLocation(position) {
    // console.log(position);
    let anonymizedPosition = this.anonymizePosition(position);
    this.longitudeTarget.value = anonymizedPosition.longitude;
    this.latitudeTarget.value = anonymizedPosition.latitude;
    this.accuracyTarget.value = position.coords.accuracy;
    this.enableSubmitButtons();
  }

  requestLocationError(error) {
    $(this.sickSelectorTarget).hide();
    $(this.locationHintTarget).hide();

    let errorCodeToDomExplanation = {
      1: this.locationErrorPermissionDeniedTarget,
      2: this.locationErrorPositionUnavailableTarget,
      3: this.locationErrorTimeoutTarget
    };

    $(errorCodeToDomExplanation[error.code]).show();
    $(this.locationErrorTarget).show();
  }

  disableSubmitButtons() {
    function doDisable(button) {
      $(button).prop('disabled', true);
      $(button).prop('value', 'Moment, Ortung läuft noch...');
      $(button).addClass('cursor-not-allowed');
    }

    doDisable(this.submitButtonHealthyTarget);
    doDisable(this.submitButtonSickTarget);
  }

  enableSubmitButtons() {
    function doEnable(button) {
      $(button).prop('disabled', false);
      $(button).prop('value', 'Abschicken');
      $(button).removeClass('cursor-not-allowed');
    }

    doEnable(this.submitButtonHealthyTarget);
    doEnable(this.submitButtonSickTarget);
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
