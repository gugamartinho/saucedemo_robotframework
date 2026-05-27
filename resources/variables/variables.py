import os
from pathlib import Path

from dotenv import load_dotenv

ROOT = Path(__file__).resolve().parents[2]
DOTENV_PATH = ROOT / ".env"
load_dotenv(dotenv_path=DOTENV_PATH, override=False)


def _get_env(name: str, default: str) -> str:
    value = os.getenv(name)
    return value if value is not None else default


BASE_URL = "https://www.saucedemo.com"
INVENTORY_URL = f"{BASE_URL}/inventory.html"
CART_URL = f"{BASE_URL}/cart.html"
CHECKOUT_STEP1_URL = f"{BASE_URL}/checkout-step-one.html"
CHECKOUT_STEP2_URL = f"{BASE_URL}/checkout-step-two.html"
CHECKOUT_DONE_URL = f"{BASE_URL}/checkout-complete.html"

VALID_USER = _get_env("VALID_USER", "")
LOCKED_USER = "locked_out_user"
PASSWORD = _get_env("PASSWORD", "")

BROWSER = "chrome"
HEADLESS = "true"

DEFAULT_TIMEOUT = "10s"
SHORT_TIMEOUT = "5s"
