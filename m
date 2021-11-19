Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA9745786C
	for <lists+linux-fpga@lfdr.de>; Fri, 19 Nov 2021 23:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbhKSWD2 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 19 Nov 2021 17:03:28 -0500
Received: from mail-pf1-f180.google.com ([209.85.210.180]:41689 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233337AbhKSWD2 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 19 Nov 2021 17:03:28 -0500
Received: by mail-pf1-f180.google.com with SMTP id g19so10450371pfb.8;
        Fri, 19 Nov 2021 14:00:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ggijRPDDjZPAsK7FXooPHxZqLE8dAs4DKChssROyTcQ=;
        b=2VKu3V7u+pIdihfDVc7T1kUxTnX+DfaOO/HOt1HqP9rkG3jbzI8UZE1Yll0e/iNzeq
         zEPi6dgpeQFEtCirU2K2daomxvAjTvPi1rNNp2hP3PPprppZ2AzWKcZlhzSO3vRVV05V
         NBODSY4hqVWtPV4GnNUlwRArjUBGvfaxFPJS5pOn/MUdxvf824fVokKHkv7FC9t1Db/9
         WmZCvm8L5PXj/gSPjMav2ghiPphuiY6j5lkUX9JVg5I03m24Me0yeXYSi1i/vlwZMNGw
         lw0PIx+gix6TaK9efczrhbdpRmKhYDFEcNVehgCREW5MNjNSr3bM5/WzcoI1yUUw3SHe
         +d5A==
X-Gm-Message-State: AOAM531+vfdD1s7zfKhrNf0oeEymXUDy1spgVBbEC7tsODo+sXgtfVnA
        PHM6yvXEuGgxyLZ5X9fGa9s=
X-Google-Smtp-Source: ABdhPJwT052WvkT1NvuImmCFPNUEPm5pR2ZNpF1ovKwHNtK9rTaGnW9QrKdDIOqPqlLMQ0rFkdnoMw==
X-Received: by 2002:a63:a12:: with SMTP id 18mr19349308pgk.171.1637359225752;
        Fri, 19 Nov 2021 14:00:25 -0800 (PST)
Received: from localhost (h67-204-187-10.bendor.broadband.dynamic.tds.net. [67.204.187.10])
        by smtp.gmail.com with ESMTPSA id t31sm481171pgl.47.2021.11.19.14.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 14:00:25 -0800 (PST)
Date:   Fri, 19 Nov 2021 14:00:23 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com, matthew.gerlach@intel.com
Subject: Re: [PATCH v14 0/3] fpga: Use standard class dev_release function
Message-ID: <YZgedxD8aejQmb6c@archbook>
References: <20211119015553.62704-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119015553.62704-1-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Russ,

On Thu, Nov 18, 2021 at 05:55:50PM -0800, Russ Weight wrote:
> The FPGA framework has a convention of using managed resource functions
> to allow parent drivers to manage the data structures allocated by the
> class drivers. They use an empty *_dev_release() function to satisfy the
> class driver.
> 
> This is inconsistent with linux driver model.
> 
> These changes remove the managed resource functions and populate the class
> dev_release callback functions. They also merge the create() and register()
> functions into a single register() or register_full() function for each of
> the fpga-mgr, fpga-region, and fpga-bridge class drivers.
> 
> The new *register_full() functions accept an info data structure to provide
> flexibility in passing optional parameters. The *register() functions
> support the legacy parameter list for users that don't require the use of
> optional parameters.
> 
> For more context, refer to this email thread:
> 
> https://marc.info/?l=linux-fpga&m=162127412218557&w=2
> 
> I turned on the configs assocated with each of the modified files, but I
> must have been missing some dependencies, because not all of them compiled.
> I did a run-time test specifically with the dfl-fme infrastructure. This
> would have exercised the region, bridge, and fpga-mgr frameworks.
> 
> Changelog v13 -> v14:
>   - Fixed typo/bug detected by kernel test robot <lkp@intel.com>: s/mgr/br/
> 
> Changelog v12 -> v13:
>   - Add Acked-by tag
> 
> Changelog v11 -> v12:
>   - Made the requisite changes to the new versal-fpga driver
> 
> Changelog v10 -> v11:
>   - Rebased to latest linux-next
>   - Resolved a single conflict in fpga-mgr.c with associated with  wrapper
>     function: fpga_mgr_state(mgr)
> 
> Changelog v9 -> v10:
>   - Fixed commit messages to reference register_full() instead of
>     register_simple().
>   - Removed the fpga_bridge_register_full() function, because there is
>     not need for it yet. Updated the documentation and commit message
>     accordingly.
>   - Updated documentation to reference the fpga_manager_info and
>     fpga_region_info structures.
> 
> Changelog v8 -> v9:
>   - Cleaned up documentation for the FPGA Manager, Bridge, and Region
>     register functions
>   - Renamed fpga_*_register() to fpga_*_register_full()
>   - Renamed fpga_*_register_simple() to fpga_*_register()
>   - Renamed devm_fpga_mgr_register() to devm_fpga_mgr_register_full()
>   - Renamed devm_fpga_mgr_register_simple() to devm_fpga_mgr_register()
> 
> Changelog v7 -> v8:
>   - Added reviewed-by tags.
>   - Updated Documentation/driver-api/fpga/ files: fpga-mgr.rst,
>     fpga-bridge.rst, and fpga-region.rst.
> 
> Changelog v6 -> v7:
>   - Update the commit messages to describe the new parameters for the
>     *register() functions and to mention the *register_simple() functions.
>   - Fix function prototypes in header file to rename dev to parent.
>   - Make use of the PTR_ERR_OR_ZERO() macro when possible.
>   - Some cleanup of comments.
>   - Update function definitions/prototypes to apply const to the new info
>     parameter.
>   - Verify that info->br_ops is non-null in the fpga_bridge_register()
>     function.
>   - Verify a non-null info pointer in the fpga_region_register() function.
> 
> Changelog v5 -> v6:
>   - Moved FPGA manager/bridge/region optional parameters out of the ops
>     structure and back into the FPGA class driver structure.
>   - Changed fpga_*_register() function parameters to accept an info data
>     structure to provide flexibility in passing optional parameters.
>   - Added fpga_*_register_simple() functions to support current parameters
>     for users that don't require use of optional parameters.
> 
> Changelog v4 -> v5:
>   - Rebased on top of recently accepted patches.
>   - Removed compat_id from the fpga_mgr_register() parameter list
>     and added it to the fpga_manager_ops structure. This also required
>     dynamically allocating the dfl-fme-ops structure in order to add
>     the appropriate compat_id.
>   - Created the fpga_region_ops data structure which is optionally passed
>     to fpga_region_register(). compat_id, the get_bridges() pointer, and
>     the priv pointer are included in the fpga_region_ops structure.
> 
> Changelog v3 -> v4:
>   - Added the compat_id parameter to fpga_mgr_register() and
>     devm_fpga_mgr_register() to ensure that the compat_id is set before
>     the device_register() call.
>   - Added the compat_id parameter to fpga_region_register() to ensure
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
>  Documentation/driver-api/fpga/fpga-bridge.rst |   6 +-
>  Documentation/driver-api/fpga/fpga-mgr.rst    |  38 +++-
>  Documentation/driver-api/fpga/fpga-region.rst |  12 +-
>  drivers/fpga/altera-cvp.c                     |  12 +-
>  drivers/fpga/altera-fpga2sdram.c              |  12 +-
>  drivers/fpga/altera-freeze-bridge.c           |  10 +-
>  drivers/fpga/altera-hps2fpga.c                |  12 +-
>  drivers/fpga/altera-pr-ip-core.c              |   7 +-
>  drivers/fpga/altera-ps-spi.c                  |   9 +-
>  drivers/fpga/dfl-fme-br.c                     |  10 +-
>  drivers/fpga/dfl-fme-mgr.c                    |  22 +-
>  drivers/fpga/dfl-fme-region.c                 |  17 +-
>  drivers/fpga/dfl.c                            |  12 +-
>  drivers/fpga/fpga-bridge.c                    | 122 +++-------
>  drivers/fpga/fpga-mgr.c                       | 215 ++++++++----------
>  drivers/fpga/fpga-region.c                    | 119 ++++------
>  drivers/fpga/ice40-spi.c                      |   9 +-
>  drivers/fpga/machxo2-spi.c                    |   9 +-
>  drivers/fpga/of-fpga-region.c                 |  10 +-
>  drivers/fpga/socfpga-a10.c                    |  16 +-
>  drivers/fpga/socfpga.c                        |   9 +-
>  drivers/fpga/stratix10-soc.c                  |  16 +-
>  drivers/fpga/ts73xx-fpga.c                    |   9 +-
>  drivers/fpga/versal-fpga.c                    |   9 +-
>  drivers/fpga/xilinx-pr-decoupler.c            |  17 +-
>  drivers/fpga/xilinx-spi.c                     |  11 +-
>  drivers/fpga/zynq-fpga.c                      |  16 +-
>  drivers/fpga/zynqmp-fpga.c                    |   9 +-
>  include/linux/fpga/fpga-bridge.h              |  30 ++-
>  include/linux/fpga/fpga-mgr.h                 |  62 +++--
>  include/linux/fpga/fpga-region.h              |  36 ++-
>  31 files changed, 386 insertions(+), 517 deletions(-)
> 
> -- 
> 2.25.1
> 

Patchset looks good to me, I'm currently travelling, will get around to
it next week.

- Moritz
