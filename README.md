# receipt printer

This simple yet surprisingly essential application is your best friend in a world where new import taxes appear as suddenly as Latvian summer rain. The app is designed to handle unexpected tax additions smoothly, so next time a *bureaucrat* wakes up with a brilliant tax idea, you’ll be ready! It even has clear calculation flows, so your accountant won’t lose sleep over mysterious rounding errors.

### Requirements

    Ruby 3.3+
    Rspec (for specs)
    Docker (optional) # to run docker-wrapped application/specs

### How to run it
#### Docker way:

    bin/docker-print examples/input1.txt
    # OR
    bin/docker-print examples/input2.txt
    # OR
    bin/docker-print examples/input3.txt

#### Local (ruby):

1. Load dependencies: `bundle install`

2. Run the app:
```bash
bin/print.rb examples/input1.txt
# OR
bin/print.rb examples/input2.txt
# OR
bin/print.rb examples/input3.txt
```

Example of output:

    1 book: 12.49
    1 music CD: 16.49
    1 chocolate bar: 0.85
    Sales Taxes: 1.50
    Total: 29.83

### Tests

Docker way:

    bin/docker-rspec
Local:

    bin/rspec

### Project structure

    receipt-printer/
    ├── bin/
    │   ├── print.rb           # script to run the app
    │   ├── docker-print.sh    # app wrapped in docker
    │   ├── rspec              # local test runner
    │   └── docker-rspec       # Tests wrapped in docker
    ├── lib/
    │   ├── invoice/           # classes related to generating invoices
    │   ├── tax/               # tax calculation classes
    │   └── invoice.rb         # main invoice class
    ├── spec/                  # tests (RSpec)
    ├── examples/              # Data examples (example1, example2, example 3)
    ├── Dockerfile
    ├── Dockerfile.test        # Dockerfile for running tests
    ├── Gemfile
    └── Gemfile.lock


### Architecture
- Invoice — Main class for storing and processing purchases.
- Item — Describes each product with its attributes.
- Tax classes — Implement specific tax logic with clear rules for calculation and rounding
- Receipt — Generates and outputs the final receipt
- TaxDetective — Determines applicable tax types for items (based on very simple word check)
