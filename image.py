from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.keys import Keys
from selenium.common.exceptions import TimeoutException, NoSuchElementException
import time
import os

# Configuration
GALLERY_URL = "https://fotos.airsofthelden.com/optschernobyl"
START_IMAGE_ID = "7ab67f8d-f1bb-46c8-9de0-7d7dae88bf10"
TOTAL_IMAGES = 590
DOWNLOAD_DIR = os.path.join(os.getcwd(), "downloaded_images")

# Create download directory if it doesn't exist
os.makedirs(DOWNLOAD_DIR, exist_ok=True)

# Set up Chrome options
chrome_options = webdriver.ChromeOptions()
prefs = {
    "download.default_directory": DOWNLOAD_DIR,
    "download.prompt_for_download": False,
    "download.directory_upgrade": True,
    "safebrowsing.enabled": True
}
chrome_options.add_experimental_option("prefs", prefs)

# Initialize the driver
driver = webdriver.Chrome(options=chrome_options)
wait = WebDriverWait(driver, 10)

try:
    print(f"Starting download process...")
    print(f"Images will be saved to: {DOWNLOAD_DIR}")
    
    # Navigate to the starting URL
    driver.get("https://fotos.airsofthelden.com/optschernobyl")
    time.sleep(3)  # Wait for initial page load
    
    downloaded_count = 0
    
    for i in range(1, TOTAL_IMAGES + 1):
        try:
            print(f"\nProcessing image {i}/{TOTAL_IMAGES}...")
            
            # Wait for the image to be visible/loaded
            time.sleep(2)
            
            # Press 'D' key to download the current image
            body = driver.find_element(By.TAG_NAME, 'body')
            body.send_keys('d')
            print(f"  ✓ Download triggered for image {i}")
            
            # Wait a bit for download to start
            time.sleep(1.5)
            
            downloaded_count += 1
            
            # If this is not the last image, navigate to next
            if i < TOTAL_IMAGES:
                try:
                    # Find and click the next button
                    next_button = wait.until(EC.element_to_be_clickable(
                        (By.CSS_SELECTOR, "button.buttonNext___2mOCa[aria-label='next']")
                    ))
                    next_button.click()
                    print(f"  → Navigated to next image")
                    time.sleep(1)  # Wait for next image to load
                    
                except TimeoutException:
                    print(f"  ⚠ Next button not found. Trying alternative method...")
                    # Alternative: use right arrow key
                    body.send_keys(Keys.ARROW_RIGHT)
                    time.sleep(1)
            
        except Exception as e:
            print(f"  ✗ Error processing image {i}: {str(e)}")
            # Try to continue to next image
            try:
                body = driver.find_element(By.TAG_NAME, 'body')
                body.send_keys(Keys.ARROW_RIGHT)
                time.sleep(1)
            except:
                print(f"  ✗ Failed to navigate to next image. Stopping.")
                break
    
    print(f"\n{'='*60}")
    print(f"Download process completed!")
    print(f"Total images processed: {downloaded_count}/{TOTAL_IMAGES}")
    print(f"Images saved to: {DOWNLOAD_DIR}")
    print(f"{'='*60}")
    
    # Wait a bit for any pending downloads to complete
    print("\nWaiting 10 seconds for downloads to finish...")
    time.sleep(10)
    
except Exception as e:
    print(f"\n✗ An error occurred: {str(e)}")
    
finally:
    print("\nClosing browser...")
    driver.quit()
    print("Done!")