import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["container"];

  connect() {
    this.index = this.containerTarget.children.length;
  }

  add(event) {
    event.preventDefault();
    const template = document.querySelector("#address-template").innerHTML;
    const newTemplate = template.replace(/TEMPLATE_RECORD/g, this.index);
    this.index++;
    this.containerTarget.insertAdjacentHTML("beforeend", newTemplate);
  }

  remove(event) {
    event.preventDefault();
    const wrapper = event.target.closest(".nested-fields");
    const destroyFlag = wrapper.querySelector("[name*='_destroy']");

    if (destroyFlag) {
      destroyFlag.value = "1";
      wrapper.style.display = "none";
    } else {
      wrapper.remove();
    }
  }
}
