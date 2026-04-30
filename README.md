# Robot Framework + Selenium Automation Portfolio

UI automation project using **Robot Framework** and **Selenium**, demonstrating keyword-driven testing against the [SauceDemo](https://www.saucedemo.com) e-commerce application.

## Tech Stack

| Tool | Purpose |
|------|---------|
| [Robot Framework](https://robotframework.org/) | Keyword-driven test framework |
| [SeleniumLibrary](https://robotframework.org/SeleniumLibrary/) | Browser automation |
| [Selenium](https://www.selenium.dev/) | WebDriver |
| [Python](https://www.python.org/) | Runtime |
| [GitHub Actions](https://github.com/features/actions) | CI/CD pipeline |

## Project Structure

```
robotframework-saucedemo/
├── resources/
│   ├── pages/                    # Page Object resources
│   │   ├── login_page.robot
│   │   ├── inventory_page.robot
│   │   ├── cart_page.robot
│   │   └── checkout_page.robot
│   ├── keywords/
│   │   └── common.robot          # Shared keywords
│   └── variables/
│       └── variables.robot       # Global variables
├── tests/
│   ├── login_tests.robot
│   ├── inventory_tests.robot
│   ├── cart_tests.robot
│   └── checkout_tests.robot
├── results/                      # Generated test reports (git ignored)
├── .github/workflows/
│   └── robot.yml                 # CI/CD pipeline
└── requirements.txt              # Python dependencies
```

---

## Environment Setup

### 1. Install Python

Go to [python.org](https://www.python.org/downloads/) and download **Python 3.14**.

During installation on Windows, check **"Add Python to PATH"**.

Verify:
```bash
python --version    # Should show 3.14.x
pip --version
```

### 2. Install Google Chrome

Make sure Google Chrome is installed. Download from [google.com/chrome](https://www.google.com/chrome/).

### 3. Clone the repository

```bash
git clone https://github.com/gugamartinho/saucedemo_robotframework.git
cd robotframework-saucedemo
```

### 4. Create and activate a virtual environment (recommended)

**Windows:**
```bash
python -m venv .venv
.venv\Scripts\activate
```

### 5. Install dependencies

```bash
pip install -r requirements.txt
```

---

## Running Tests

### Run all tests
```bash
robot --outputdir results tests/
```

### Run in headless mode (no browser window)
```bash
robot --variable HEADLESS:true --outputdir results tests/
```

### Run a specific test file
```bash
robot --outputdir results tests/login_tests.robot
robot --outputdir results tests/inventory_tests.robot
robot --outputdir results tests/cart_tests.robot
robot --outputdir results tests/checkout_tests.robot
```

### Run tests in parallel (using Pabot)
```bash
pabot --outputdir results tests/
```

### Run tests in parallel with specific number of workers
```bash
pabot --processes 4 --outputdir results tests/
```

### Run tests in parallel with headless mode
```bash
pabot --processes 4 --variable HEADLESS:true --outputdir results tests/
```

### Run tests by tag
```bash
robot --include smoke --outputdir results tests/
robot --include regression --outputdir results tests/
robot --include negative --outputdir results tests/
robot --exclude wip --outputdir results tests/
```

### Run a specific test by name
```bash
robot --test "Login With Valid Credentials" --outputdir results tests/
robot --test "Complete Full Checkout Flow" --outputdir results tests/
```

## Test Coverage

| Suite | Tests | Tags |
|-------|-------|------|
| Login | Valid login, locked user, invalid credentials, empty username, empty password | login, smoke, negative |
| Inventory | Product count, add to cart, multiple items, sort A-Z, Z-A, price asc/desc, logout | inventory, sorting, cart |
| Cart | Empty cart, add items, remove item, proceed to checkout | cart, smoke |
| Checkout | Full E2E flow, missing fields (3), cancel, order summary | checkout, e2e, negative |

**Total: 23 tests**

### Available Tags
| Tag | Description |
|-----|-------------|
| `smoke` | Critical path tests |
| `e2e` | Full end-to-end flows |
| `negative` | Error and validation tests |
| `login` | Login related tests |
| `inventory` | Product listing tests |
| `cart` | Shopping cart tests |
| `checkout` | Checkout flow tests |
| `sorting` | Product sorting tests |

---
