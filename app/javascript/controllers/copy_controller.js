import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // 1. Define targets: the button for feedback and the content source.
  static targets = [ "source", "button" ]

  // 2. The core copy function, triggered by the data-action.
  copy() {
    // Get the text from the source target.
    const textToCopy = this.sourceTarget.textContent.trim();

    // Check if the browser supports the Clipboard API
    if (navigator.clipboard) {
        // Use the modern Clipboard API.
        navigator.clipboard.writeText(textToCopy).then(() => {
            this.showSuccess();
        }).catch(err => {
            console.error('Could not copy text: ', err);
        });
    } else {
        // Fallback for older browsers (less common now)
        alert("Clipboard API not supported. Please copy manually.");
    }
  }

  // 3. Helper to provide visual feedback to the user.
  showSuccess() {
    // Save original icon and text
    const originalContent = this.buttonTarget.innerHTML;

    // Change to success state
    this.buttonTarget.innerHTML = '<i class="bi bi-check-lg"></i> Copied!';
    this.buttonTarget.classList.remove('btn-secondary');
    this.buttonTarget.classList.add('btn-success');

    // Revert back after 2 seconds (2000ms)
    setTimeout(() => {
      this.buttonTarget.innerHTML = originalContent;
      this.buttonTarget.classList.remove('btn-success');
      this.buttonTarget.classList.add('btn-secondary');
    }, 2000);
  }
}
