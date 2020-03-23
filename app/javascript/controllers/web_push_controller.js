import { Controller } from "stimulus";
import Rails from "@rails/ujs";


export default class extends Controller {
  static targets = ['subscribeButton']

  connect() {}

  get pushManager() {
    return window.serviceWorkerRegistration.pushManager;
  }

  subscribe() {
    this.pushManager.subscribe({
      userVisibleOnly: true,
      applicationServerKey: this.urlB64ToUint8Array(this.data.get('applicationServerKey'))
    }).then(pushSubscription => {
      const pushSubscriptionObj = pushSubscription.toJSON();
      const formData = new FormData();

      formData.append('auth', pushSubscriptionObj['keys']['auth']);
      formData.append('p256dh', pushSubscriptionObj['keys']['p256dh']);
      formData.append('endpoint', pushSubscriptionObj['endpoint']);

      if (pushSubscriptionObj['expirationTime'])
        formData.append('expires_at', pushSubscriptionObj['expirationTime']);

      formData.append('latitude', window.anonymizedPosition.latitude);
      formData.append('longitude', window.anonymizedPosition.longitude);

      Rails.ajax({
        url: '/web_push_subscribers',
        type: 'post',
        data: formData,
        success: this.success.bind(this),
        error: this.error.bind(this)
      });
    }).catch(() => this.error());
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

  refreshSubscriptionState() {
    this.pushManager.getSubscription().then(pushSubscription => {
      if (pushSubscription)
        this.success();
    });
  }

  setButtonText(text) {
    $(this.subscribeButtonTarget).html(text);
  }

  deactivateButton() {
    $(this.subscribeButtonTarget).prop('disabled', true);
    $(this.subscribeButtonTarget).addClass('text-gray-600');
    $(this.subscribeButtonTarget).addClass('cursor-not-allowed');
  }

  success() {
    this.deactivateButton();
    this.setButtonText('Subscribed!');
  }

  error() {
    this.deactivateButton();
    this.setButtonText('Error');
  }
}
