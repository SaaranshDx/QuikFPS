import json
import os
import sys
import time
import threading
import platform
import subprocess
import logging
from typing import Dict, List, Tuple, Any, Callable
from dataclasses import dataclass
import psutil
import winreg
import platform
import pathlib
import ctypes
from colorama import Fore, Back, Style, init
from pypresence import Presence
from pypresence.exceptions import DiscordNotFound


sys.stdout.reconfigure(encoding='utf-8')

#clear console
os.system("cls")
init(autoreset=True)

# create log file
log_file = pathlib.Path("quikfps.log")
if log_file.is_file():
    logging.info("Log intialised.")
else:
    with open("quikfps.log", "w") as file:
        file.write("logging initialised.\n")

# Logging setup
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('quikfps.log'),
    ]
)    

# OS check
if platform.system() != "Windows":
    print("OS not compatible.")
    logging.error("OS not compatible.")
    sys.exit()
else:
    logging.info("compatible OS detected.")

#log the os version
logging.info(f"Windows {platform.release()} detected.")

# log build number
windows_build_number = platform.win32_ver()

#build number var
build_num = windows_build_number[1]
logging.info(f"Windows build number: {build_num}")
if build_num == "26100.4946":
    logging.warning("this windows build is known to have issues with ssd please update to the latest version to avoid and potential damage.")
    ssd_warn_message = "this windows build is known to have issues with ssd please update to the latest version to avoid and potential damage."
    ssd_warn_message_title = "warning"
    ctypes.windll.user32.MessageBoxW(0, ssd_warn_message, ssd_warn_message_title, 1)

time.sleep(1)
os.system("cls")

import json
import re
import os

def update_local_version(file_path="version.json", target_version="v1.1"):
    """Update version.json to v1.1 if it's lower than that."""
    if not os.path.exists(file_path):
        print(f"[ERROR]❌ {file_path} not found.")
        return

    try:
        with open(file_path, "r") as f:
            data = json.load(f)
    except Exception as e:
        print(f"[ERROR]❌ Failed to read {file_path}: {e}")
        return

    current_version = str(data.get("version", "")).strip()
    print(f"[INFO]🧩 Current version: {current_version}")

    # Function to extract numbers for comparison
    def version_numbers(v):
        return [int(x) for x in re.findall(r'\d+', v)]

    # Compare versions
    if version_numbers(current_version) < version_numbers(target_version):
        data["version"] = target_version
        try:
            with open(file_path, "w") as f:
                json.dump(data, f, indent=4)
            print(f"[SUCCESS]✅ Updated version to {target_version}")
        except Exception as e:
            print(f"[ERROR]❌ Failed to update version.json: {e}")
    else:
        print("[INFO]📦 Version is already up to date or higher. Skipping update.")

update_local_version()


#banner

print("""
________        .__ __      _____              
\_____  \  __ __|__|  | ___/ ____\_____  ______
 /  / \  \|  |  \  |  |/ /\   __\\____ \/  ___/
/   \_/.  \  |  /  |    <  |  |  |  |_> >___ \ 
\_____\ \_/____/|__|__|_ \ |__|  |   __/____  >
       \__>             \/       |__|       \/  
""")
os.system("cls")
logging.info("app started.")

# Simple wrapper to show a Windows MessageBox (Unicode)
def show_msg(text: str, title: str = "QuikFPS", flags: int = 0) -> None:
    try:
        ctypes.windll.user32.MessageBoxW(0, str(text), str(title), int(flags))
    except Exception:
        # If MessageBox fails (non-Windows or ctypes issue), ignore silently
        pass

#py presence
try:
    # Replace with your application's client ID
    CLIENT_ID = "1423710939773145139"
    # Initialize the Presence client
    rpc = Presence(CLIENT_ID)
    rpc.connect()
    # Set the rich presence
    rpc.update(
        details="playing quikfps v1.1",         
        state="Optimising PC",                    
        large_image="quikfps",
        start=time.time(),                     
        buttons=[                              
            {"label": "Download Quikfps", "url": "https://quikfps.qzz.io/"},
        ]
    )

    print("Rich Presence is now active!")
except DiscordNotFound:
    print("Discord is not running. Skipping Rich Presence.")

def cpu_tweaks():
    os.system("Cls")
    print(f"{Fore.GREEN} applying CPU tweaks")
    os.startfile(r"tweaks\cpu_optimise.bat")
    print(f"{Fore.GREEN} cpu tweaks applied")
    time.sleep(2)
    input("press enter to return to start")

    
def ram_tweaks():
    os.system("cls")
    print(F"{Fore.GREEN}applying ram tweaks")
    os.startfile(r"tweaks\ram.bat")
    print(f"{Fore.GREEN} ram tweaks applied")
    input("press enter to return to start")

def gpu_tweaks():
    os.system("cls")
    print(f"applying gpu tweaks")
    os.startfile(r"tweaks\gpu.bat")
    print(f"{Fore.GREEN}gpu tweaks applied")
    input("press enter to return to start")

def apply_all_optimizations():
    """Apply all system optimizations in the correct order"""
    os.system("cls")
    
    print(f"""
{Fore.CYAN}======================================================================================================================={Style.RESET_ALL}
{Fore.YELLOW}
                              _____      _ _    ____   ____   ___        _   _           _           
                             |  ___|   _| | |  |  _ \ / ___| / _ \ _ __ | |_(_)_ __ ___ (_)___  ___ 
                             | |_ | | | | | |  | |_) | |    | | | | '_ \| __| | '_ ` _ \| / __|/ _ \
                             |  _|| |_| | | |  |  __/| |___ | |_| | |_) | |_| | | | | | | \__ \  __/
                             |_|   \__,_|_|_|  |_|    \____| \___/| .__/ \__|_|_| |_| |_|_|___/\___|
                                                                   |_|                               
{Style.RESET_ALL}
{Fore.CYAN}======================================================================================================================={Style.RESET_ALL}
{Fore.MAGENTA}                        This will apply ALL optimizations to your system!
                        This process may take several minutes. Please be patient.
{Style.RESET_ALL}
{Fore.CYAN}======================================================================================================================={Style.RESET_ALL}
""")
    
    # Confirmation prompt
    confirm = input(f"{Fore.YELLOW}Are you sure you want to apply all tweaks? (yes/no): {Style.RESET_ALL}").strip().lower()
    
    if confirm not in ['yes', 'y']:
        print(f"{Fore.RED}Operation cancelled.{Style.RESET_ALL}")
        time.sleep(2)
        return
    
    os.system("cls")
    logging.info("Starting full system optimization")
    
    # Track progress
    total_steps = 14
    current_step = 0
    
    # Helper function to show progress
    def show_progress(step_name):
        nonlocal current_step
        current_step += 1
        os.system("cls")
        print(f"""
{Fore.CYAN}======================================================================================================================={Style.RESET_ALL}
{Fore.YELLOW}                                    Full PC Optimization in Progress...{Style.RESET_ALL}
                                        
                                        Step {current_step}/{total_steps}: {step_name}
                                        
{Fore.CYAN}======================================================================================================================={Style.RESET_ALL}
""")
        logging.info(f"Step {current_step}/{total_steps}: {step_name}")
    
    try:
        # 1. CPU Optimizations
        show_progress("Applying CPU optimizations")
        if os.path.exists(r"tweaks\cpu_optimise.bat"):
            subprocess.run(r"tweaks\cpu_optimise.bat", shell=True, capture_output=True)
        time.sleep(1)
        
        # 2. RAM Optimizations
        show_progress("Applying RAM optimizations")
        if os.path.exists(r"tweaks\ram.bat"):
            subprocess.run(r"tweaks\ram.bat", shell=True, capture_output=True)
        time.sleep(1)
        
        # 3. GPU Optimizations
        show_progress("Applying GPU optimizations")
        if os.path.exists(r"tweaks\gpu.bat"):
            subprocess.run(r"tweaks\gpu.bat", shell=True, capture_output=True)
        time.sleep(1)
        
        # 4. Visual Effects
        show_progress("Disabling visual effects")
        if os.path.exists(r"tweaks\visual_optimise.bat"):
            subprocess.run(r"tweaks\visual_optimise.bat", shell=True, capture_output=True)
        time.sleep(1)
        
        # 5. Background Services
        show_progress("Optimizing background services")
        if os.path.exists(r"tweaks\baground_optimisations.bat"):
            subprocess.run(r"tweaks\baground_optimisations.bat", shell=True, capture_output=True)
        time.sleep(1)
        
        # 6. Drive Optimizations
        show_progress("Optimizing drives")
        if os.path.exists(r"tweaks\optimise_drives.bat"):
            subprocess.run(r"tweaks\optimise_drives.bat", shell=True, capture_output=True)
        time.sleep(1)
        
        # 7. Network Optimizations
        show_progress("Optimizing network settings")
        if os.path.exists(r"tweaks\optimse_net.bat"):
            subprocess.run(r"tweaks\optimse_net.bat", shell=True, capture_output=True)
        if os.path.exists(r"tweaks\network_optimisation.bat"):
            subprocess.run(r"tweaks\network_optimisation.bat", shell=True, capture_output=True)
        time.sleep(1)
        
        # 8. Privacy Tweaks
        show_progress("Applying privacy optimizations")
        if os.path.exists(r"tweaks\privacy.bat"):
            subprocess.run(r"tweaks\privacy.bat", shell=True, capture_output=True)
        time.sleep(1)
        
        # 9. FSO Optimizations
        show_progress("Optimizing FSO")
        if os.path.exists(r"tweaks\fso.bat"):
            subprocess.run(r"tweaks\fso.bat", shell=True, capture_output=True)
        time.sleep(1)
        
        # 10. Variable Refresh Rate
        show_progress("Disabling variable refresh rate")
        if os.path.exists(r"tweaks\vrr.bat"):
            subprocess.run(r"tweaks\vrr.bat", shell=True, capture_output=True)
        time.sleep(1)
        
        # 11. Mouse Controller Optimizations
        show_progress("Optimizing mouse controller")
        if os.path.exists(r"tweaks\mouse_control_optimise.bat"):
            subprocess.run(r"tweaks\mouse_control_optimise.bat", shell=True, capture_output=True)
        time.sleep(1)
        
        # 12. USB Optimizations
        show_progress("Optimizing USB settings")
        if os.path.exists(r"tweaks\usb_mouse_optimisations.bat"):
            subprocess.run(r"tweaks\usb_mouse_optimisations.bat", shell=True, capture_output=True)
        time.sleep(1)
        
        # 13. Power Tweaks
        show_progress("Applying power optimizations")
        if os.path.exists(r"tweaks\power_tweaks.bat"):
            subprocess.run(r"tweaks\power_tweaks.bat", shell=True, capture_output=True)
        time.sleep(1)
        
        # 14. Disk Cleanup
        show_progress("Running disk cleanup")
        if os.path.exists("tweaks\\storage_cleanup.ps1"):
            subprocess.run(["powershell", "-ExecutionPolicy", "Bypass", "-File", 
                          "tweaks\\storage_cleanup.ps1"], capture_output=True)
        time.sleep(1)
        
        # Completion
        os.system("cls")
        print(f"""
{Fore.CYAN}======================================================================================================================={Style.RESET_ALL}
{Fore.GREEN}
                                    ____                      _      _       _ 
                                   / ___|___  _ __ ___  _ __ | | ___| |_ ___| |
                                  | |   / _ \| '_ ` _ \| '_ \| |/ _ \ __/ _ \ |
                                  | |__| (_) | | | | | | |_) | |  __/ ||  __/_|
                                   \____\___/|_| |_| |_| .__/|_|\___|\__\___(_)
                                                       |_|                      
{Style.RESET_ALL}
{Fore.CYAN}======================================================================================================================={Style.RESET_ALL}
{Fore.GREEN}
                            ✓ All optimizations have been applied successfully!
                            
                            Your system has been fully optimized for maximum performance.
                            
                            {Fore.YELLOW}IMPORTANT: It is recommended to restart your PC for all changes to take effect.{Style.RESET_ALL}
                            
{Fore.CYAN}======================================================================================================================={Style.RESET_ALL}
""")
        logging.info("Full system optimization completed successfully")
        
        # Ask if user wants to restart
        restart = input(f"\n{Fore.YELLOW}Would you like to restart now? (yes/no): {Style.RESET_ALL}").strip().lower()
        if restart in ['yes', 'y']:
            print(f"{Fore.GREEN}Restarting system in 10 seconds...{Style.RESET_ALL}")
            logging.info("System restart initiated by user")
            time.sleep(10)
            os.system("shutdown /r /t 0")
        else:
            print(f"{Fore.GREEN}Please remember to restart your PC later.{Style.RESET_ALL}")
            
    except Exception as e:
        os.system("cls")
        print(f"""
{Fore.RED}======================================================================================================================={Style.RESET_ALL}
{Fore.RED}
                                            ERROR OCCURRED!
                                            
                            An error occurred during optimization: {str(e)}
                            
                            Please check the log file for more details.
{Style.RESET_ALL}
{Fore.RED}======================================================================================================================={Style.RESET_ALL}
""")
        logging.error(f"Error during full system optimization: {str(e)}")
    
    input(f"\n{Fore.CYAN}Press Enter to return to main menu...{Style.RESET_ALL}")
    os.system("cls")

def gernal_optimisae():
    os.system("cls")
    print(f"""
{Fore.CYAN}======================================================================================================================={Style.RESET_ALL}

{Fore.YELLOW}                                                _                             
                                  __ _  ___ _ __ _ __   __ _| |                            
                                 / _` |/ _ \ '__| '_ \ / _` | |                            
                                | (_| |  __/ |  | | | | (_| | |                            
                                 \__, |\___|_|  |_| |_|\__,_|_|          _   _             
                                 |___/ _ __ | |_(_)_ __ ___ (_)___  __ _| |_(_) ___  _ __  
                                 / _ \| '_ \| __| | '_ ` _ \| / __|/ _` | __| |/ _ \| '_ \ 
                                | (_) | |_) | |_| | | | | | | \__ \ (_| | |_| | (_) | | | |
                                 \___/| .__/ \__|_|_| |_| |_|_|___/\__,_|\__|_|\___/|_| |_|
                                      |_|  {Style.RESET_ALL}                                                
{Fore.CYAN}======================================================================================================================={Style.RESET_ALL}
                                        GERNAL TWEAKS:

                                    [1] disable visual effects 🌟          

                                    [2] optimise windows baground services ⚙️   

                                    [3] optimise drives 📦

                                    [4] optimise network 📡 

                                    [5] privacy optimisations 🔏

                                    [6] block windows update 🚫

                                    [7] optimise FSo 🔍

                                    [8] diable variable refresh rate 🖥️

{Fore.CYAN}======================================================================================================================={Style.RESET_ALL}

""")
    
    # MessageBoxW (Unicode) from user32: (hwnd, text, caption, flags)
    msgbox = ctypes.windll.user32.MessageBoxW
    gernal_optimisae_input = input("enter your choice:")

    if gernal_optimisae_input == "1":
            os.system("cls")
            print(f"{Fore.GREEN} applying visual effects optimisations")
            logging.info("applying visuals optimisations")
            os.startfile(r"tweaks\visual_optimise.bat")
            print(f"{Fore.GREEN} visual tweaks applied ")
            logging.info("visual effects applied")
            input("press enter to return to start")

    elif gernal_optimisae_input == "2":
        os.system("cls")
        print(f"{Fore.GREEN} optimiseing windows baground services")
        logging.info("applying ")
        os.startfile(r"tweaks\baground_optimisations.bat")
        print(f"{Fore.GREEN} backround windows baground services optimised")
        input("press enter to return to start")

    elif gernal_optimisae_input == "3":
        os.system("cls")
        print(f"optimising drives ")
        logging.info("optimising drivers")
        os.startfile(r"tweaks\optimise_drives.bat")
        print(F"{Fore.GREEN} drives optimisations done")    
        input("press enter to return to start")

    elif gernal_optimisae_input == "4":
        os.system("cls")
        print(f"{Fore.GREEN} optimising network")
        logging.info("optimising network")
        os.startfile(r"tweaks\optimse_net.bat")
        print(f"{Fore.GREEN} network optimisation done")
        input("press enter to return to start")

    elif gernal_optimisae_input == "5":
        os.system("cls")
        print(f"{Fore.GREEN} applying privacy tweaks")
        os.startfile(r"tweaks\privacy.bat")
        print(f"{Fore.GREEN} privacy tweaks done")    
        input("press enter to return to start")
    
    elif gernal_optimisae_input == "6":
        os.system("cls")
        print(f"{Fore.GREEN} starting windows update disable utility")
        os.startfile(r"tweaks\Windows_Update_Blocker_1.8.exe")
        print(f"..")
        input("press enter to return to start")

    elif gernal_optimisae_input == "7":
        print(F"{Fore.GREEN} optimising FSO")
        os.startfile(r"tweaks\fso.bat")
        print(F"{Fore.GREEN}fso optimisatons done")     
        input("press enter to return to start")

    elif gernal_optimisae_input == "8":
        print(F"{Fore.GREEN} disabling variable refresh rate")
        os.startfile(r"tweaks\vrr.bat")
        input("press enter to return to start")



#latency inmprove
def latency_optimisations():
    os.system("cls")
    print(f"""
{Fore.CYAN}======================================================================================================================={Style.RESET_ALL}

                                                              _                      _        
                             _ __ ___   ___  _   _ ___  ___  | |___      _____  __ _| | _____ 
                            | '_ ` _ \ / _ \| | | / __|/ _ \ | __\ \ /\ / / _ \/ _` | |/ / __|
                            | | | | | | (_) | |_| \__ \  __/ | |_ \ V  V /  __/ (_| |   <\__ \
                                                       |_| |_| |_|\___/ \__,_|___/\___|  \__| \_/\_/ \___|\__,_|_|\_\___/

{Fore.CYAN}======================================================================================================================={Style.RESET_ALL}
{Fore.BLACK}                                                    optimisations options:{Style.RESET_ALL}

 {Fore.GREEN}                                               [1] mouse contor optimisations
 
                                                [2] USB optimisations

                                                [3] precise mouse movement

                                                [4] disable mouse smoothing

                                                [5] Mouse data queue size optimisations

                                                [6] USB optimisations (usb bus)

{Fore.CYAN}======================================================================================================================={Style.RESET_ALL}
""")
    latency_optimisations_input = input(":")

    if latency_optimisations_input == "1":
        os.system("cls")
        print(f"{Fore.GREEN}applying mouse controler optimisations")
        logging.info("started mouse controler tweaks")
        os.startfile(r"tweaks\mouse_control_optimise.bat")
        os.system("cls")
        print(f"{Fore.GREEN}mouse optimisations applied")
        logging.info("mouse controler tweaks done")
        input("press enter to return to start")

    if latency_optimisations_input == "2":
        os.system("cls")
        print(f"{Fore.GREEN} applying usb optimisations")
        logging.info("started ussb optimisations")
        os.startfile(r"tweaks\mouse_control_optimise.bat")
        print(F"usb optimisations done")
        logging.info("usb optimisations done")
        input("press enter to return to start")

    if latency_optimisations_input == "3":
        os.system("cls")
        print(f"{Fore.GREEN} applying precise mouse movements")
        logging.info("applying precise mouse movents")
        os.startfile(r"tweaks\precise_mouse_movements.bat")
        logging.info("precise mouse movement tweaks applied")
        input("press enter to got to start")

    if latency_optimisations_input == "4":
        os.system("cls")
        print(f"{Fore.RED}WARNING: this tweak will break you laptop touch pad")
        print(f"{Fore.GREEN} disabling mouse smoothing")
        logging.info("disabling mouse smoothing")
        os.startfile(r"tweaks\mouse_smoothing_disable.bat")
        logging.info("mouse smoothing disabled")
        input("press enter to got to start")

    if latency_optimisations_input == "5":
        os.system("cls")
        print(f"{Fore.GREEN} applying mouse data queue optimisation")
        print(f"{Fore.YELLOW}WARNINIG this tweak may cause stutters on super low end pcs")
        logging.info("applying mouse data queue optimisation")
        os.startfile(r"tweaks\mouse_data_queue.bat")
        logging.info("mouse data queue optimisation applied")
        input("press enter to got to start")

    if latency_optimisations_input == "6":
        os.system("cls")
        print(f"{Fore.GREEN} applying usb optimisation")
        logging.info("applying usb optimisation")
        os.startfile(r"tweaks\usb_mouse_optimisations.bat")
        logging.info("USB optimisations done")
        input("press enter to got to start")


#repair util
def repair_system():
    os.system("cls")
    print(f"""

                                                                          _      
                                                     _ __ ___ _ __   __ _(_)_ __ 
                                                    | '__/ _ \ '_ \ / _` | | '__|
                                                    | | |  __/ |_) | (_| | | |   
                                                    |_|  \___| .__/ \__,_|_|_|   
                                                             |_|                 
{Fore.CYAN}======================================================================================================================={Style.RESET_ALL}
{Fore.BLUE}                                                REPAIR TOOL: {Style.RESET_ALL}
{Fore.GREEN}                                        [1] restore pc
                                        [2] DISM restor health
                                        [3] SFC scan
                                        {Fore.RED}[4] BSOD memory flush (DANGEROUSE!!) {Style.RESET_ALL}
 {Fore.GREEN}                                       [5] reset network
                                        [6] CHKDSK check
                                        [7] microsoft store repair
                                        [8] Registry Permissions Repair
                                             {Style.RESET_ALL}
{Fore.CYAN}======================================================================================================================={Style.RESET_ALL}

""")
    repair_input = input(":")

    #restore point utility
    if repair_input == "1":
        os.system("cls")
        print("running restore utility...")
        logging.info("running restore utility...")
        os.startfile("C:\\Windows\\System32\\rstrui.exe")
        os.system("cls")
        print("restore utility opened.")
        logging.info("restore utility opened.")
        input("press enter to return to stats...")

    #dism scan
    elif repair_input == "2":
        os.system("cls")
        print("running DISM restore health...")
        logging.info("running DISM restore health...")
        os.system(r"tweaks\repair_DISM.bat")
        print("DISM restore health complete.")
        logging.info("DISM restore health complete.")
        input("press enter to return to stats...")    

    #sfc scan
    elif repair_input == "3":
        os.system("cls")
        print("running SFC scan...")
        logging.info("running SFC scan...")
        os.system(r"tweaks\repair_SFC.bat")    
        print("SFC scan complete.")
        logging.info("SFC scan complete.")
        input("press enter to return to stats...")

    #bsod memory flush
    elif repair_input == "4":
        os.system("cls")
        print("running BSOD memory flush...")
        logging.info("running BSOD memory flush...")
        os.system(r"tweaks\repair_BSOD.bat")    
        print("BSOD memory flush complete.")
        logging.info("BSOD memory flush complete.")
        input("press enter to return to stats...")    

    #network reset
    elif repair_input == "5":
        os.system("cls")
        print("running network reset...")
        logging.info("running network reset...")
        os.system(r"tweaks\repair_network.bat")
        print("network reset complete.")
        logging.info("network reset complete.")
        input("press enter to return to stats...")
        
        #check disk
    elif repair_input == "6":
        os.system("cls")
        print("running CHKDSK check...")
        logging.info("running CHKDSK check...")
        os.system(r"tweaks\repair_CHKDSK.bat")
        print("CHKDSK check complete.")
        logging.info("CHKDSK check complete.")
        input("press enter to return to stats...")

    #microsoft store repair
    elif repair_input == "7":
        os.system("cls")
        print("running microsoft store repair...")
        logging.info("running microsoft store repair...")
        os.system(r"tweaks\repair_microsoft_store.bat")
        print("microsoft store repair complete.")
        logging.info("microsoft store repair complete.")
        input("press enter to return to stats...")

#what tf u will see

try:
    while True:
        # Show stats until user enters something
        try:
            cpu_usage = psutil.cpu_percent(interval=0.2)
            ram_usage = psutil.virtual_memory().percent
            time.sleep(0.5)  # Add a small delay
        except Exception as e:
            logging.error(f"Error getting system stats: {e}")
            cpu_usage = "N/A"
            ram_usage = "N/A"
            
        os.system("cls")
        time.sleep(0.1)  # Add a small delay after clearing
        print(f"""
{Fore.MAGENTA}
                                       ________        .__ __      _____              
                                       \_____  \  __ __|__|  | ___/ ____\_____  ______
                                        /  / \  \|  |  \  |  |/ /\   __\\____ \/  ___/
                                       /   \_/.  \  |  /  |    <  |  |  |  |_> >___ \ 
                                       \_____\ \_/____/|__|__|_ \ |__|  |   __/____  >
                                              \__>             \/       |__|       \/  

{Style.RESET_ALL}                                            CPU: {cpu_usage}%   RAM: {ram_usage}%   GPU: N/A

{Fore.CYAN}=======================================================================================================================

{Style.RESET_ALL}                                                select an category below 

                [1] General performace optimisation 🔧  [2] Power tweaks ⚡  [3] mouse optimisation 🖱️ 

                        [4] GPU optimisation 🎨  [5] CPU optimisation 🔲 [6] RAM optimistaion 💾

                        [7] Disk optimisations 🗃️  [8] Network optimistaion 📡  [9] Optimise full pc 🧼

{Fore.CYAN}=======================================================================================================================
{Style.RESET_ALL}
                            [R] repair 🛠️ [S] system info 📜 [P] change log 🪵  [X] exit ❌

{Fore.CYAN}=======================================================================================================================

{Fore.MAGENTA}                                                    version 1.1 (beta){Style.RESET_ALL}


                                        """)
            
        time.sleep(0.2)
        
        # Get user input
        user_input = input("\nEnter your choice: ").strip().lower()
        if user_input.lower() == "x":
            os.system("cls")
            print("Exiting...")
            rpc.clear()
            sys.exit()
        elif user_input.lower() == "s":
            os.system("cls")
            print(f"""
                                           _                   _        __       
                             ___ _   _ ___| |_ ___ _ __ ___   (_)_ __  / _| ___  
                            / __| | | / __| __/ _ \ '_ ` _ \  | | '_ \| |_ / _ \ 
                            \__ \ |_| \__ \ ||  __/ | | | | | | | | | |  _| (_) |
                            |___/\__, |___/\__\___|_| |_| |_| |_|_| |_|_|  \___/ 
                                 |___/                                           

{Fore.CYAN}======================================================================================================================={Style.RESET_ALL}
                                                    SYSTEM INFO:
                            [OS INFORMATION]                        
                            WINDOWS VERSION: {build_num}
                            WINDOWS EDITION: {platform.win32_edition()}
                            WINDOWS RELEASE: {platform.release()}
                            OS ARCHITECTURE: {platform.machine()}
                            [MACHINE INFORMATION]
                            PROCESSOR: {platform.processor()}
                            RAM: {round(psutil.virtual_memory().total / (1024 ** 3))} GB
                            STORAGE: {round(psutil.disk_usage('/').total / (1024 ** 3))} GB
                            GPU: N/A
                            UPTIME: {round((time.time() - psutil.boot_time()) / 3600, 2)} hours
{Fore.CYAN}======================================================================================================================={Style.RESET_ALL}




""")    
            input("Press Enter to return to stats...")
            os.system("cls")
            #system info

        #change logs
        elif user_input.lower() == "p":
            os.system("cls")
            print(f"""

                                          _                              _             
                                      ___| |__   __ _ _ __   __ _  ___  | | ___   __ _ 
                                     / __| '_ \ / _` | '_ \ / _` |/ _ \ | |/ _ \ / _` |
                                    | (__| | | | (_| | | | | (_| |  __/ | | (_) | (_| |
                                     \___|_| |_|\__,_|_| |_|\__, |\___| |_|\___/ \__, |
                                                            |___/                |___/ 
{Fore.CYAN}======================================================================================================================={Style.RESET_ALL}
{Fore.BLUE}                                                CHANGE LOG: {Style.RESET_ALL}
{Fore.GREEN}                                        [1] added new gui
                                        [2] fixed resources restoration bug
                                        [3] fixed fiveM not working
                                        [4] added discord rich presence
                                        [5] repair category
                                        [6] added auto start on boot
                                        [7] added proper logging
                                        [8] reduced startup time
                                        [9] removed tweaks_post.json
                                        [10] removed rich text render to save resources
                                        [11] removed keyboard navigation to save resources   
                                             {Style.RESET_ALL}           
{Fore.CYAN}======================================================================================================================={Style.RESET_ALL}


""")
            input("press enter to return to stats...")
            os.system("cls")


        elif user_input.lower() == "r":
            os.system("cls")
            repair_system()


        # power tweaks
        elif user_input.strip() == "2":
            os.system("cls")
            logging.info("power tweaks started")
            print(f"""

                                             _ __   _____      _____ _ __                              
                                            | '_ \ / _ \ \ /\ / / _ \ '__|                             
                                            | |_) | (_) \ V  V /  __/ |                                
                                            | .__/ \___/ \_/\_/ \___|_|  _           _   _             
                                            |_|__  _ __ | |_(_)_ __ ___ (_)___  __ _| |_(_) ___  _ __  
                                             / _ \| '_ \| __| | '_ ` _ \| / __|/ _` | __| |/ _ \| '_ \ 
                                            | (_) | |_) | |_| | | | | | | \__ \ (_| | |_| | (_) | | | |
                                             \___/| .__/ \__|_|_| |_| |_|_|___/\__,_|\__|_|\___/|_| |_|
                                                  |_|                                                  
{Fore.CYAN}======================================================================================================================={Style.RESET_ALL}

{Fore.BLUE}applying power tweaks {Style.RESET_ALL}








{Fore.CYAN}======================================================================================================================={Style.RESET_ALL}
""")       
            time.sleep(3)
            os.system("cls")
            subprocess.run(r"tweaks\power_tweaks.bat")
            logging.info("power tweaks applied.")
            os.system("cls")
            print(f"""
                                         _ __   _____      _____ _ __                              
                                        | '_ \ / _ \ \ /\ / / _ \ '__|                             
                                        | |_) | (_) \ V  V /  __/ |                                
                                        | .__/ \___/ \_/\_/ \___|_|  _           _   _             
                                        |_|__  _ __ | |_(_)_ __ ___ (_)___  __ _| |_(_) ___  _ __  
                                         / _ \| '_ \| __| | '_ ` _ \| / __|/ _` | __| |/ _ \| '_ \ 
                                        | (_) | |_) | |_| | | | | | | \__ \ (_| | |_| | (_) | | | |
                                         \___/| .__/ \__|_|_| |_| |_|_|___/\__,_|\__|_|\___/|_| |_|
                                              |_|                                                  
{Fore.CYAN}======================================================================================================================={Style.RESET_ALL}

{Fore.BLUE}applying power tweaks {Style.RESET_ALL}
{Fore.GREEN}power tweaks applied {Style.RESET_ALL}










{Fore.CYAN}======================================================================================================================={Style.RESET_ALL}





""")    
            input("press enter to return to stats...")
            os.system("cls")

#network optimisations
        elif user_input == "8":
            os.system("cls")
            print(f"{Fore.GREEN}starting network optimisations")
            os.system(r"tweaks\network_optimisation.bat")
            print(f"{Fore.RED}NOTE: restart the utility to fix text")
            logging.info("restart the utility to fix the text bug")
            print(f"{Fore.GREEN} network optimisations applied")
            logging.info("network optimisations done")
            input("press enter to return to start")
            
#disk optimisations            
        elif user_input == "7":
            os.system("cls")
            print(f"{Fore.GREEN}running disk optimisation")
            logging.info("starting disk optimisations")
            try:
                if os.path.exists("tweaks\\storage_cleanup.ps1"):
                    result = subprocess.run(["powershell", "-ExecutionPolicy", "Bypass", "-File", "tweaks\\storage_cleanup.ps1"], capture_output=True, text=True)
                    if result.returncode == 0:
                        print(f"{Fore.GREEN} disk optimisations done")
                        logging.info("disk optimisations completed successfully")
                    else:
                        print(f"{Fore.RED} Error during disk optimization: {result.stderr}")
                        logging.error(f"Disk optimization failed: {result.stderr}")
                else:
                    print(f"{Fore.RED} Error: storage_cleanup.ps1 script not found")
                    logging.error("storage_cleanup.ps1 script not found")
            except Exception as e:
                print(f"{Fore.RED} Error: {str(e)}")
                logging.error(f"Error during disk optimization: {str(e)}")
            input("press enter to go to start")

#latency optimisations
        elif user_input == "3":
            latency_optimisations()

#apply_all_optimizations
        elif user_input == "9":
            apply_all_optimizations()

#gernal tweaks
        elif user_input == "1":
            os.system("cls")
            gernal_optimisae()

        elif user_input == "5":
            os.system("Cls")  
            cpu_tweaks()       

        elif user_input == "6":
            os.system("cls")
            ram_tweaks()    

        elif user_input == "4":
            gpu_tweaks()                   

except KeyboardInterrupt:
    print("\nExiting...")
    try:
        rpc.clear()
    except:
        pass
    logging.info("app closed by user.")
    sys.exit()

