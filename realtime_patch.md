# Install the PREEMPT Real-Time Patch

Make sure you've already cloned the WSL Github repo. See instructions in [WSL USB Linux Kernel Setup](./README.md). 

 Add Realtime PREEMPT Patch for a Realtime WSL Kernel
   For certain applications, enabling RealTime functionality in your WSL environment can be beneficial, especially if your software will be deployed into realtime environments.

   This section provides instructions for retrieving and applying the correct PREEMPT Realtime patch for the kernel version you're compiling.

   > **NOTE:** Always review scripts before executing them on your system. The script used here is located at `./scripts/get_rt_patch.sh`. Feel free to modify it as needed.

   #### Steps:
   1. Copy the script `get_rt_patch.sh` into your Linux kernel build directory where you git cloned the WSL Linux kernel:
      ```bash
      cp ./scripts/get_rt_patch.sh ~/WSL2-Linux-Kernel/get_rt_patch.sh
      ```

   2. Make the script executable:
      ```bash
      chmod +x ~/WSL2-Linux-Kernel/get_rt_patch.sh
      ```

   3. Execute the script to retrieve the appropriate RT patch:
      ```bash
      cd ~/WSL2-Linux-Kernel
      ./get_rt_patch.sh
      ```

   4. Follow the prompts displayed by the script to confirm the patch download. Use `ls` to see the downloaded patch file (either .xz or .gz)

   ---

   ### Key Notes:
   - The script will:
   1. Retrieve the kernel version you're compiling.
   2. Search for the appropriate RT patch in the `https://www.kernel.org/pub/linux/kernel/projects/rt/` directory.
   3. Prompt you to confirm before downloading the patch.
   
Once downloaded, unzip the downloaded patch (it will download either an xz or gz file).
   For the .xz unzip with :
   ```bash
   xz -d patch-name # i.e. xz -d patch-6.6.36-rt35.patch.xz 
   ```
   For the .gz patch file, use:
   ```bash
   gunzip patch-6.6.36-rt35.patch.gz
   ```

Once you've unzipped, you can test the patch with:
   ```bash
   patch -p1 --dry-run < patch-6.6.36-rt35.patch
   ```
Once you've tested the dry run, apply it to the kernel source with:
   ```bash
   patch -p1 < patch-file-name
   ```

Proceed with setting up the Kernel Configuration in [WSL USB Linux Kernel Setup](./README.md) `Section 1)` `Step 3`