import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  /**
   * Submits the form when the 'Enter' key is pressed,
   * unless the 'Shift' key is also held down.
   */
  submitOnEnter(event) {
    // 1. Check if the pressed key is 'Enter'
    if (event.key === 'Enter') {
      // 2. Allow Shift+Enter to create a new line (standard behavior)
      if (event.shiftKey) {
        return;
      }

      // 3. Prevent the default 'new line' action for Enter
      event.preventDefault();

      // 4. Submit the form element that this controller is attached to
      this.element.requestSubmit();
    }
  }
}
