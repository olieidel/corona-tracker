import { Controller } from "stimulus";


export default class extends Controller {
  connect() {
    if (navigator.serviceWorker) {
      navigator.serviceWorker.register('/serviceworker.js', { scope: './' })
        .then(function(reg) {
          console.log('[Page] Service worker registered!');
          window.serviceWorkerRegistration = reg;
          window.testPushSubscribe = function() {
            reg.pushManager.subscribe({
              userVisibleOnly: true,
              applicationServerKey: this.urlB64ToUint8Array(this.data.get('applicationServerKey'))
            });
          }.bind(this);
        }.bind(this));
    }
  }

  urlB64ToUint8Array(base64String) {
    const padding = '='.repeat((4 - base64String.length % 4) % 4);
    const base64 = (base64String + padding)
          .replace(/\-/g, '+')
          .replace(/_/g, '/');

    const rawData = window.atob(base64);
    const outputArray = new Uint8Array(rawData.length);

    for (let i = 0; i < rawData.length; ++i) {
      outputArray[i] = rawData.charCodeAt(i);
    }
    return outputArray;
  }
}
