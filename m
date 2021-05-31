Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6C43963DC
	for <lists+linux-fpga@lfdr.de>; Mon, 31 May 2021 17:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbhEaPgz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 31 May 2021 11:36:55 -0400
Received: from mga06.intel.com ([134.134.136.31]:47883 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234711AbhEaPfH (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 31 May 2021 11:35:07 -0400
IronPort-SDR: MRhNoDeaZ3M6byZYBEIXjtDK0vcSF/OUogrPkDg1boQXkxp5x+XmlWkd/Ah9HJucmHS4JZG8jz
 udMUTIrh4GPQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10001"; a="264564698"
X-IronPort-AV: E=Sophos;i="5.83,237,1616482800"; 
   d="scan'208";a="264564698"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 08:30:29 -0700
IronPort-SDR: bQn/gIvI2MF98x7vzRjc5HHVFHDdN6jpENbX8KEFORwK6E+PgEPdVxX2F7tlCPjnfyKOSjtXZj
 KARmZ8iD6jQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,237,1616482800"; 
   d="scan'208";a="635189851"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by fmsmga005.fm.intel.com with ESMTP; 31 May 2021 08:30:26 -0700
Date:   Mon, 31 May 2021 23:24:57 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org, trix@redhat.com,
        lgoncalv@redhat.com, hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com
Subject: Re: [PATCH v4 0/3] fpga: Use standard class dev_release function
Message-ID: <20210531152457.GB1929215@yilunxu-OptiPlex-7050>
References: <20210528215755.839712-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528215755.839712-1-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, May 28, 2021 at 02:57:52PM -0700, Russ Weight wrote:
> The FPGA framework has a convention of using managed resource
> functions to allow parent drivers to manage the data structures
> allocated by the class drivers. They use an empty *_dev_release()
> function to satisfy the class driver.
> 
> This is inconsistent with linux driver model.
> 
> These changes remove the managed resource functions and populate
> the class dev_release callback functions. They also merge the
> create and register functions into a single register function for
> each of the fpga-mgr, fpga-region, and fpga-bridge class drivers.
> 
> For more context, refer to this email thread:
> 
> https://marc.info/?l=linux-fpga&m=162127412218557&w=2
> 
> I turned on the configs assocated with each of the modified files,
> but I must have been missing some dependencies, because not all
> of them compiled. I did a run-time test specifically with the
> dfl-fme infrastructure. This would have exercised the region,
> bridge, and fpga-mgr frameworks.
> 
> Changelog v3 -> v4:
>   - Added the compat_id parameter to fpga_mgr_register() and
>     devm_fpga_mgr_register() to ensure that the compat_id is set before
>     the device_register() call.
>   - Added the compat_id parameter to fpga_bridge_register() to ensure

A typo                             ... fpga_region_register() ...

Thanks,
Yilun

>     that the compat_id is set before the device_register() call.
>   - Modified the dfl_fpga_feature_devs_enumerate() function to restore
>     the fpga_region_register() call to the correct location.
> 
> Changelog v2 -> v3:
>   - Cleaned up comment headers for fpga_mgr_register(), fpga_bridge_register(),
>     and fpga_region_register().
>   - Fixed error return on ida_simple_get() failure for fpga_mgr_register(),
>     fpga_bridge_register(), and fpga_region_register().
>   - Fixed error return value for fpga_bridge_register(): ERR_PTR(ret) instead
>     of NULL.
> 
> Changelog v1 -> v2:
>   - Restored devm_fpga_mgr_register() functionality to the fpga-mgr
>     class driver, adapted for the combined create/register functionality.
>   - All previous callers of devm_fpga_mgr_register() will continue to call
>     devm_fpga_mgr_register().
>   - replaced unnecessary ternary operators in return statements with
>     standard if conditions.
> 
> Russ Weight (3):
>   fpga: mgr: Use standard dev_release for class driver
>   fpga: bridge: Use standard dev_release for class driver
>   fpga: region: Use standard dev_release for class driver
> 
>  drivers/fpga/altera-cvp.c           |  12 +-
>  drivers/fpga/altera-fpga2sdram.c    |  12 +-
>  drivers/fpga/altera-freeze-bridge.c |  10 +-
>  drivers/fpga/altera-hps2fpga.c      |  12 +-
>  drivers/fpga/altera-pr-ip-core.c    |   9 +-
>  drivers/fpga/altera-ps-spi.c        |  10 +-
>  drivers/fpga/dfl-fme-br.c           |  10 +-
>  drivers/fpga/dfl-fme-mgr.c          |  12 +-
>  drivers/fpga/dfl-fme-region.c       |  12 +-
>  drivers/fpga/dfl.c                  |  12 +-
>  drivers/fpga/fpga-bridge.c          | 119 +++++---------------
>  drivers/fpga/fpga-mgr.c             | 168 ++++++++--------------------
>  drivers/fpga/fpga-region.c          | 106 ++++--------------
>  drivers/fpga/ice40-spi.c            |  10 +-
>  drivers/fpga/machxo2-spi.c          |  10 +-
>  drivers/fpga/of-fpga-region.c       |  10 +-
>  drivers/fpga/socfpga-a10.c          |  16 +--
>  drivers/fpga/socfpga.c              |  10 +-
>  drivers/fpga/stratix10-soc.c        |  15 +--
>  drivers/fpga/ts73xx-fpga.c          |  10 +-
>  drivers/fpga/xilinx-pr-decoupler.c  |  17 +--
>  drivers/fpga/xilinx-spi.c           |  12 +-
>  drivers/fpga/zynq-fpga.c            |  16 +--
>  drivers/fpga/zynqmp-fpga.c          |  10 +-
>  include/linux/fpga/fpga-bridge.h    |  12 +-
>  include/linux/fpga/fpga-mgr.h       |  19 ++--
>  include/linux/fpga/fpga-region.h    |  13 +--
>  27 files changed, 210 insertions(+), 474 deletions(-)
> 
> -- 
> 2.25.1
