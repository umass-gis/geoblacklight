pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"

pin "@github/auto-complete-element", to: "https://cdn.jsdelivr.net/npm/@github/auto-complete-element@3.8.0/+esm"
pin "@popperjs/core", to: "https://ga.jspm.io/npm:@popperjs/core@2.11.6/dist/esm/popper.js"
pin "bootstrap", to: "https://ga.jspm.io/npm:bootstrap@5.3.8/dist/js/bootstrap.esm.js"

pin "blacklight-range-limit", to: "blacklight-range-limit.js"
pin "chart.js", to: "https://ga.jspm.io/npm:chart.js@4.4.3/dist/chart.js"
