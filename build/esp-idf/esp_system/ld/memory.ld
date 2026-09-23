/*
 * SPDX-FileCopyrightText: 2024 Espressif Systems (Shanghai) CO LTD
 *
 * SPDX-License-Identifier: Apache-2.0
 */
/**
 *                    ESP32-C61 Linker Script Memory Layout
 * This file describes the memory layout (memory blocks) by virtual memory addresses.
 * This linker script is passed through the C preprocessor to include configuration options.
 * Please use preprocessor features sparingly!
 * Restrict to simple macros with numeric values, and/or #if/#endif blocks.
 */
/*

 * Automatically generated file. DO NOT EDIT.

 * Espressif IoT Development Framework (ESP-IDF) 6.0.2 Configuration Header

 */
       
/* List of deprecated options */
/*
 * SPDX-FileCopyrightText: 2021-2024 Espressif Systems (Shanghai) CO LTD
 *
 * SPDX-License-Identifier: Apache-2.0
 */
/* CPU instruction prefetch padding size for flash mmap scenario */
/* Copy from esp_secure_boot.h */
/*
 * PMP region granularity size
 * Software may determine the PMP granularity by writing zero to pmp0cfg, then writing all ones
 * to pmpaddr0, then reading back pmpaddr0. If G is the index of the least-significant bit set,
 * the PMP granularity is 2^G+2 bytes.
 */
/* CPU instruction prefetch padding size for memory protection scenario */
/* Memory alignment size for PMS */
/*
 * IDRAM0_2_SEG_SIZE_DEFAULT is used when page size is 64KB
 */
MEMORY
{
  /**
   *  All these values assume the flash cache is on, and have the blocks this uses subtracted from the length
   *  of the various regions. The 'data access port' dram/drom regions map to the same iram/irom regions but
   *  are connected to the data port of the CPU and eg allow byte-wise access.
   */
  /* Flash mapped instruction data */
  irom_seg (RX) : org = 0x42000020, len = (0x8000 << 8) - 0x20
  /**
   * (0x20 offset above is a convenience for the app binary image generation.
   * Flash cache has 64KB pages. The .bin file which is flashed to the chip
   * has a 0x18 byte file header, and each segment has a 0x08 byte segment
   * header. Setting this offset makes it simple to meet the flash cache MMU's
   * constraint that (paddr % 64KB == vaddr % 64KB).)
   */
  /**
   * Shared data RAM, excluding memory reserved for ROM bss/data/stack.
   * Enabling Bluetooth & Trace Memory features in menuconfig will decrease the amount of RAM available.
   */
  sram_seg (RWX) : org = (0x40800000), len = 0x4083ea70 - (0x40800000)
  /* Flash mapped instruction data */
  drom_seg (R) : org = 0x42000020, len = (0x8000 << 8) - 0x20
  /* (See irom_seg for meaning of 0x20 offset in the above.) */
    /* PSRAM seg */
  ext_ram_seg(RWX) : org = 0x42000020, len = (0x8000 << 8) - 0x20
}
/* Heap ends at top of sram_seg */
_heap_end = 0x40000000;
REGION_ALIAS("iram_text_seg", sram_seg);
REGION_ALIAS("dram_seg", sram_seg);
  REGION_ALIAS("flash_text_seg", irom_seg);
  REGION_ALIAS("flash_rodata_seg", drom_seg);
ALIGN_VECTOR_TABLE = 0x100;
OFFSET_TEE = 0x2b0;
