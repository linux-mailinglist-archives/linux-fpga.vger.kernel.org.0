Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D16AB2BFE32
	for <lists+linux-fpga@lfdr.de>; Mon, 23 Nov 2020 03:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgKWCeI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 22 Nov 2020 21:34:08 -0500
Received: from mga05.intel.com ([192.55.52.43]:57533 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbgKWCeI (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 22 Nov 2020 21:34:08 -0500
IronPort-SDR: qfZlZVOrs6DMaO1ul1duv9WXjl5VO7XEvX1ZlWZb1ExceljQyqZpYPWLq7LSIePgumWEGI3NKE
 wzA6xaLq8cyg==
X-IronPort-AV: E=McAfee;i="6000,8403,9813"; a="256398230"
X-IronPort-AV: E=Sophos;i="5.78,361,1599548400"; 
   d="scan'208";a="256398230"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2020 18:34:07 -0800
IronPort-SDR: uX9/LfJ/tvobNnVhGIUmL5uJ2TL/nOpCEX8l6OPyJxxDeplYOcuFdLAliYMZ+JAMz87XPtil2x
 BQSzJU4sHicA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,361,1599548400"; 
   d="scan'208";a="361273622"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga004.fm.intel.com with ESMTP; 22 Nov 2020 18:34:04 -0800
Date:   Mon, 23 Nov 2020 10:29:47 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, krzk@kernel.org, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, hao.wu@intel.com,
        yilun.xu@intel.com
Subject: Re: [PATCH v13 0/6] add DFL bus support to MODULE_DEVICE_TABLE()
Message-ID: <20201123022947.GC12837@yilunxu-OptiPlex-7050>
References: <1605159759-3439-1-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605159759-3439-1-git-send-email-yilun.xu@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Moritz:

Do you have some suggestion on this patchset? In last pull request,
there are some comments, I explained for them and fixes some of them.
I'm wondering if they are ready now.

Thanks in advance,
Yilun

On Thu, Nov 12, 2020 at 01:42:33PM +0800, Xu Yilun wrote:
> Main changes from v1: 
> - A new patch (Patch #3) to fix the description.
> - Rename the dfl-bus.h to dfl.h
> - Updated the MAINTAINERS under FPGA DFL DRIVERS.
> - Improve comments and minor fixes.
> 
> Main changes from v2: 
> - Change the bus name from "dfl" to "fpga-dfl", also rename related
>   variables, functions ... 
> - Changes the data type of fpga_dfl_device_id.type from u8 to u16 
> - Explicitly defines the values of enum fpga_dfl_id_type
> - Delete the comments for the valid bits of type & feature_id
> - changes MODALIAS format for fpga dfl devices
> 
> Main changes from v3: 
> - Change the bus name back to "dfl".
> - Add 2 patches (#5, 6) for dfl drivers.
> - Delete the retimer FEC mode configuration via module_parameter for 
>   Patch #5
> - Merge the patch "Make m10_n3000_info static" (https://lore.kernel.org/linux-fpga/52d8411e-13d8-1e91-756d-131802f5f445@huawei.com/T/#t)
>   into Patch #5
> - Add static prefix for emif attributes macro for Patch #6
> 
> Main changes from v9:
> - Add the description for struct dfl_device_id in mod_devicetable.h
> - Move the dfl.h from include/linux/fpga to include/linux
> - some code refactor and minor fixes for dfl-n3000-nios
> 
> Main changes from v10:
> - use sysfs_emit instead of sprintf for both patches
> - rebase to 5.10-rc1
> 
> Main changes from v11:
> - Fix the type of driver_data from unsigned long to kernel_ulong_t
> - Fixed up header guards to match filename by Moritz
> - move the MODULE_DEVICE_TABLE() right after its definition
> 
> Main changes from v12:
> - For patch #5, fix the wrong use of logical'||', should use '|'
> 
> Xu Yilun (6):
>   fpga: dfl: fix the definitions of type & feature_id for dfl devices
>   fpga: dfl: move dfl_device_id to mod_devicetable.h
>   fpga: dfl: add dfl bus support to MODULE_DEVICE_TABLE()
>   fpga: dfl: move dfl bus related APIs to include/linux/dfl.h
>   fpga: dfl: add support for N3000 Nios private feature
>   memory: dfl-emif: add the DFL EMIF private feature driver
> 
>  .../ABI/testing/sysfs-bus-dfl-devices-emif         |  25 +
>  .../ABI/testing/sysfs-bus-dfl-devices-n3000-nios   |  47 ++
>  MAINTAINERS                                        |   3 +-
>  drivers/fpga/Kconfig                               |  11 +
>  drivers/fpga/Makefile                              |   2 +
>  drivers/fpga/dfl-n3000-nios.c                      | 588 +++++++++++++++++++++
>  drivers/fpga/dfl.c                                 |   4 +-
>  drivers/fpga/dfl.h                                 |  85 +--
>  drivers/memory/Kconfig                             |   9 +
>  drivers/memory/Makefile                            |   2 +
>  drivers/memory/dfl-emif.c                          | 207 ++++++++
>  include/linux/dfl.h                                |  86 +++
>  include/linux/mod_devicetable.h                    |  24 +
>  scripts/mod/devicetable-offsets.c                  |   4 +
>  scripts/mod/file2alias.c                           |  13 +
>  15 files changed, 1023 insertions(+), 87 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
>  create mode 100644 drivers/fpga/dfl-n3000-nios.c
>  create mode 100644 drivers/memory/dfl-emif.c
>  create mode 100644 include/linux/dfl.h
> 
> -- 
> 2.7.4
