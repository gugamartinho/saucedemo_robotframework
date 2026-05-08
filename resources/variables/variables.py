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

PAGE_LOGO = "css:.login_logo"

VALID_USER = _get_env("VALID_USER", "")
LOCKED_USER = "locked_out_user"
PERF_GLITCH_USER = "performance_glitch_user"
PASSWORD = _get_env("PASSWORD", "")

FIRST_NAME = "David"
LAST_NAME = "Martinho"
POSTAL_CODE = "2000-105"

BROWSER = "chrome"
HEADLESS = "false"

DEFAULT_TIMEOUT = "10s"
SHORT_TIMEOUT = "5s"
