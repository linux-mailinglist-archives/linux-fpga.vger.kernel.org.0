Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009EA38F351
	for <lists+linux-fpga@lfdr.de>; Mon, 24 May 2021 20:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbhEXSxv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 24 May 2021 14:53:51 -0400
Received: from mga09.intel.com ([134.134.136.24]:33506 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233271AbhEXSxv (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 24 May 2021 14:53:51 -0400
IronPort-SDR: woZFdH35d8tuCZOs+Rf8fFEMTk7tmFBCsXNDqDp4oNv93d7A5p/88yKw+B4BBN2NZwC5J6DZzO
 ciYg4fShbOBA==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="202028569"
X-IronPort-AV: E=Sophos;i="5.82,325,1613462400"; 
   d="scan'208";a="202028569"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 11:52:21 -0700
IronPort-SDR: pIycpXzw3HJvecPoenq7jHCFl0Tek6ysoWKtcasxDuA0R/xhitmX3sXvURz5cDPI3RUoN5IxNG
 8bxOFKYKd/Jg==
X-IronPort-AV: E=Sophos;i="5.82,325,1613462400"; 
   d="scan'208";a="546467302"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.4]) ([10.212.182.29])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 11:52:20 -0700
Subject: Re: [PATCH v3 0/3] fpga: Use standard class dev_release function
To:     mdf@kernel.org, linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com, richard.gong@intel.com
References: <20210524185049.681683-1-russell.h.weight@intel.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <92f492d1-daaa-1eca-7dfe-c1d70b4e6a1e@intel.com>
Date:   Mon, 24 May 2021 11:52:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210524185049.681683-1-russell.h.weight@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

If you have a chance to review these patches, please provide review tags.

Thanks,
- Russ

On 5/24/21 11:50 AM, Russ Weight wrote:
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
>  drivers/fpga/altera-pr-ip-core.c    |   8 +-
>  drivers/fpga/altera-ps-spi.c        |  10 +-
>  drivers/fpga/dfl-fme-br.c           |  10 +-
>  drivers/fpga/dfl-fme-mgr.c          |  10 +-
>  drivers/fpga/dfl-fme-region.c       |  10 +-
>  drivers/fpga/dfl.c                  |  10 +-
>  drivers/fpga/fpga-bridge.c          | 119 +++++---------------
>  drivers/fpga/fpga-mgr.c             | 163 +++++++---------------------
>  drivers/fpga/fpga-region.c          | 103 ++++--------------
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
>  include/linux/fpga/fpga-mgr.h       |  17 ++-
>  include/linux/fpga/fpga-region.h    |  12 +-
>  27 files changed, 196 insertions(+), 470 deletions(-)
>

