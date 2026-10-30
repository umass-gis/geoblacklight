import { Application } from "@hotwired/stimulus";
import "blacklight-range-limit"
import Chart from "chart.js"

const application = Application.start();

// Configure Stimulus development experience
application.debug = false;
window.Stimulus = application;

export { application };
