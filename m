Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5A2674997
	for <lists+linux-fpga@lfdr.de>; Fri, 20 Jan 2023 03:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjATCtr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 19 Jan 2023 21:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjATCtp (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 19 Jan 2023 21:49:45 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD4049567;
        Thu, 19 Jan 2023 18:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674182985; x=1705718985;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xOt/pIp29WBfj1lDuuLWsw+OLGGWhFf5vFZBAOjOoHI=;
  b=Zgb46PSiFryBiBetGnseg5E1U7ASywqa85T5F1/IVPs1glntg6GWBQ9M
   OQzkJE5zwaS1pnqeRQUaPLOuIGRfZLqxiS/xvj3HMVBmyvIZTy0w1X04j
   HZRMGOQUveYvSEqIRUJBx+WzBZzjaYDPRIm6FXfUOEijS5BViMVZM/dES
   bqyYhANs9xPg0DXRwasY2Ge0mD+lgj9RBebzP/ANRZ7TJGmVvSwgRd5NY
   hzrPcXG3YU2z4EAw4wt3ZlZDSs3CL+ZPUoAn0KOLKTfFsYDBemu8BwpFP
   Qg6Q7lk+lWHHgIERBn7uPRI9VwOvt3CJmaP9Hqbqhz3GCO+KXvXS36yVd
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="325531033"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="325531033"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 18:49:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="749213525"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="749213525"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Jan 2023 18:49:39 -0800
Date:   Fri, 20 Jan 2023 10:39:12 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     matthew.gerlach@linux.intel.com
Cc:     hao.wu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        andriy.shevchenko@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de, ilpo.jarvinen@linux.intel.com,
        marpagan@redhat.com, bagasdotme@gmail.com
Subject: Re: [PATCH v11 0/4] Enhance definition of DFH and use enhancements
 for UART driver
Message-ID: <Y8n+0OUxnDtDfJgG@yilunxu-OptiPlex-7050>
References: <20230115151447.1353428-1-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230115151447.1353428-1-matthew.gerlach@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-01-15 at 07:14:43 -0800, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> This patchset enhances the definition of the Device Feature Header (DFH) used by
> the Device Feature List (DFL) bus and then uses the new enhancements in a UART
> driver.
> 
> The enhancements to the DFH includes the introduction of parameter blocks.
> Like PCI capabilities, the DFH parameter blocks further describe
> the hardware to software. In the case of the UART, the parameter blocks
> provide information for the interrupt, clock frequency, and register layout.
> 
> Duplication of code parsing of the parameter blocks in multiple DFL drivers
> is a concern. Using swnodes was considered to help minimize parsing code 
> duplication, but their use did not help the problem. Furthermore the highly
> changeable nature of FPGAs employing the DFL bus makes the use of swnodes
> inappropriate. 
> 
> Patch 1 updates the DFL documentation to describe the added functionality to DFH.
> 
> Patch 2 adds the definitions for DFHv1.
> 
> Patch 3 adds basic support for DFHv1. It adds functionality to parse parameter blocks
> and adds the functionality to parse the explicit location of a feature's register set.
> 
> Patch 4 adds a DFL UART driver that makes use of the new features of DFHv1.

Looks good to me and see Greg has taken this patchset.

Thanks,
Yilun

> 
> Basheer Ahmed Muddebihal (1):
>   fpga: dfl: Add DFHv1 Register Definitions
> 
> Matthew Gerlach (3):
>   Documentation: fpga: dfl: Add documentation for DFHv1
>   fpga: dfl: add basic support for DFHv1
>   tty: serial: 8250: add DFL bus driver for Altera 16550.
> 
>  Documentation/fpga/dfl.rst         | 119 ++++++++++++++
>  drivers/fpga/dfl.c                 | 245 +++++++++++++++++++++++------
>  drivers/fpga/dfl.h                 |  43 +++++
>  drivers/tty/serial/8250/8250_dfl.c | 167 ++++++++++++++++++++
>  drivers/tty/serial/8250/Kconfig    |  12 ++
>  drivers/tty/serial/8250/Makefile   |   1 +
>  include/linux/dfl.h                |   8 +
>  7 files changed, 544 insertions(+), 51 deletions(-)
>  create mode 100644 drivers/tty/serial/8250/8250_dfl.c
> 
> -- 
> 2.25.1
> 
