Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9485B4C96
	for <lists+linux-fpga@lfdr.de>; Sun, 11 Sep 2022 10:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiIKIO0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 11 Sep 2022 04:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIKIOZ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 11 Sep 2022 04:14:25 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D183ED68;
        Sun, 11 Sep 2022 01:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662884064; x=1694420064;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1Z2dBzAu07oRdKDsfU/Mjkd7mvup6KYmOABUCmSZYLI=;
  b=gqpwlZJvzbcZxqzaBs43xDjSgSSfpfpjiKajCgBpPa+1VGADYpxE6Jk8
   Prv/DOTsXGyK97V4MbB+mG8w0KO/tmjo1N/5b5H5NJWTcq7B43otQT+82
   FDr09hMvmOhB2pycGeJPKVBx+YmVIGWZNGeylatbShIgddh0WXS3kOKTn
   ut4ExbkC9oxgHsg+IOe303k3plTXlghR5kBXLneGD3r7DXxe2wA+9ec1G
   MLP/RVRhsF7yA7up8Uk+SsSzTAvOqIrKCJYw9cLRofrfVRe9UW7XgMpnW
   ACAeeRCguAME82iYGBk4R8y5Ku25r6IMNEePs+y5iJ46J098dzFa/zKog
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10466"; a="295288059"
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="295288059"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 01:14:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="677708059"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga008.fm.intel.com with ESMTP; 11 Sep 2022 01:14:19 -0700
Date:   Sun, 11 Sep 2022 16:04:47 +0800
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
        niklas.soderlund+renesas@ragnatech.se, phil.edworthy@renesas.com,
        macro@orcam.me.uk, johan@kernel.org, lukas@wunner.de,
        Basheer Ahmed Muddebihal 
        <basheer.ahmed.muddebihal@linux.intel.com>
Subject: Re: [PATCH v1 2/5] fpga: dfl: Move the DFH definitions
Message-ID: <Yx2Wn7LR6O6ilXae@yilunxu-OptiPlex-7050>
References: <20220906190426.3139760-1-matthew.gerlach@linux.intel.com>
 <20220906190426.3139760-3-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906190426.3139760-3-matthew.gerlach@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-09-06 at 12:04:23 -0700, matthew.gerlach@linux.intel.com wrote:
> From: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
> 
> Moving the DFH register offset and register definitions from
> drivers/fpga/dfl.h to include/linux/dfl.h.  These definitions
> need to be accessed by dfl drivers that are outside of
> drivers/fpga.
> 
> Signed-off-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
>  drivers/fpga/dfl.h  | 22 ++--------------------
>  include/linux/dfl.h | 23 ++++++++++++++++++++++-
>  2 files changed, 24 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 06cfcd5e84bb..d4dfc03a0b61 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -2,7 +2,7 @@
>  /*
>   * Driver Header File for FPGA Device Feature List (DFL) Support
>   *
> - * Copyright (C) 2017-2018 Intel Corporation, Inc.
> + * Copyright (C) 2017-2022 Intel Corporation, Inc.
>   *
>   * Authors:
>   *   Kang Luwei <luwei.kang@intel.com>
> @@ -17,6 +17,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/cdev.h>
>  #include <linux/delay.h>
> +#include <linux/dfl.h>
>  #include <linux/eventfd.h>
>  #include <linux/fs.h>
>  #include <linux/interrupt.h>
> @@ -53,28 +54,9 @@
>  #define PORT_FEATURE_ID_UINT		0x12
>  #define PORT_FEATURE_ID_STP		0x13
>  
> -/*
> - * Device Feature Header Register Set
> - *
> - * For FIUs, they all have DFH + GUID + NEXT_AFU as common header registers.
> - * For AFUs, they have DFH + GUID as common header registers.
> - * For private features, they only have DFH register as common header.
> - */
> -#define DFH			0x0
> -#define GUID_L			0x8
> -#define GUID_H			0x10
> -#define NEXT_AFU		0x18
> -
> -#define DFH_SIZE		0x8
> -
>  /* Device Feature Header Register Bitfield */
> -#define DFH_ID			GENMASK_ULL(11, 0)	/* Feature ID */
>  #define DFH_ID_FIU_FME		0
>  #define DFH_ID_FIU_PORT		1
> -#define DFH_REVISION		GENMASK_ULL(15, 12)	/* Feature revision */
> -#define DFH_NEXT_HDR_OFST	GENMASK_ULL(39, 16)	/* Offset to next DFH */
> -#define DFH_EOL			BIT_ULL(40)		/* End of list */
> -#define DFH_TYPE		GENMASK_ULL(63, 60)	/* Feature type */
>  #define DFH_TYPE_AFU		1
>  #define DFH_TYPE_PRIVATE	3
>  #define DFH_TYPE_FIU		4
> diff --git a/include/linux/dfl.h b/include/linux/dfl.h
> index 431636a0dc78..b5accdcfa368 100644
> --- a/include/linux/dfl.h
> +++ b/include/linux/dfl.h
> @@ -2,7 +2,7 @@
>  /*
>   * Header file for DFL driver and device API
>   *
> - * Copyright (C) 2020 Intel Corporation, Inc.
> + * Copyright (C) 2020-2022 Intel Corporation, Inc.
>   */
>  
>  #ifndef __LINUX_DFL_H
> @@ -11,6 +11,27 @@
>  #include <linux/device.h>
>  #include <linux/mod_devicetable.h>
>  
> +/*
> + * Device Feature Header Register Set
> + *
> + * For FIUs, they all have DFH + GUID + NEXT_AFU as common header registers.
> + * For AFUs, they have DFH + GUID as common header registers.
> + * For private features, they only have DFH register as common header.
> + */
> +#define DFH			0x0
> +#define GUID_L			0x8
> +#define GUID_H			0x10
> +#define NEXT_AFU		0x18

Now these macros are accessible in global kernel, should we add the
DFL_ or DFH_ prefix for them?

Thanks,
Yilun

> +
> +#define DFH_SIZE		0x8
> +
> +/* Device Feature Header Register Bitfield */
> +#define DFH_ID			GENMASK_ULL(11, 0)	/* Feature ID */
> +#define DFH_REVISION		GENMASK_ULL(15, 12)	/* Feature revision */
> +#define DFH_NEXT_HDR_OFST	GENMASK_ULL(39, 16)	/* Offset to next DFH */
> +#define DFH_EOL			BIT_ULL(40)		/* End of list */
> +#define DFH_TYPE		GENMASK_ULL(63, 60)	/* Feature type */
> +
>  /**
>   * enum dfl_id_type - define the DFL FIU types
>   */
> -- 
> 2.25.1
> 
