import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['lon', 'lat', 'accuracy'];

  connect() {
    // console.log('hello');
    // this.lonTarget.value = 123;
    // this.latTarget.value = 456;
  }

  request(e) {
    e.preventDefault();

    const geo = navigator.geolocation;

    const opts = {
      enableHighAccuracy: true, // FIXME
      timeout: 10 * 1000, // 10 seconds in ms
      maximumAge: 30 * 60 * 1000, // 30 minutes in ms
    };
    geo.getCurrentPosition(this.onSuccess.bind(this), console.log);
  }

  onSuccess(position) {
    console.log(position);
    this.lonTarget.value = position.coords.longitude;
    this.latTarget.value = position.coords.latitude;
    this.accuracyTarget.value = position.coords.accuracy;
  }
}
