Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69118503739
	for <lists+linux-fpga@lfdr.de>; Sat, 16 Apr 2022 16:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbiDPO6G (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 16 Apr 2022 10:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbiDPO57 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 16 Apr 2022 10:57:59 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E1565A2;
        Sat, 16 Apr 2022 07:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650120927; x=1681656927;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6moqOpRJJ723BsXosSP1zdZ3z05mUbEX035K/K5GSBs=;
  b=gl0EuehdspkhCnxwRVuHnsmgL/rK8NbXsHTQuqNOL8JSepa04EVRyj0r
   Dz4/9QZdEP6rmvAHLpoWcDhG9H/ClbHp4Sb2xMfiv4yMXGyB0vHcQJuQ4
   7a6eR2KQ0BTkLlOOALLZtGcpNOKYc25L+WR6TOOEoQwjA7/oX2+0bv7Uv
   /qqZJuytXsftPSvXCM+bTALwBlQERQairLDUJmcW0Ok/3Z175XQv19xV+
   fmSZmEKsaUALYFWb+XjnDUjrzSm3d9f2ZlEwRaHlKeKYb9K2iDp4aBrc7
   5g5fUmRb7yKiF323d3EEj/IxfrN9jaJByJpIwe1B9Bp187LzcajT0gNB5
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="245185209"
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="245185209"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2022 07:55:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="553573287"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga007.jf.intel.com with ESMTP; 16 Apr 2022 07:55:23 -0700
Date:   Sat, 16 Apr 2022 22:47:52 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tianfei Zhang <tianfei.zhang@intel.com>
Cc:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        linux-fpga@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH v2] uio: dfl: add HSSI feature id
Message-ID: <20220416144752.GA301222@yilunxu-OptiPlex-7050>
References: <20220412062353.53984-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412062353.53984-1-tianfei.zhang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Apr 12, 2022 at 02:23:53AM -0400, Tianfei Zhang wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Add the feature id of the OFS HSSI (High Speed Serial Interface)
> subsystem to table of ids supported by the uio_dfl driver. HSSI
> subsystem consists of harden/soft Ethernet MAC to support various
> ethernet usages and PCS/FEC/PMA direct modes for non-ethernet usages.
> 
> We leverage the uio_dfl driver to access the HSSI subsystem on user space,
> because the HSSI subsystem was designed for specific purposes and does

Could you explain what's the main difference between this MAC and other
MACs, which prevents it from fitting into net kernel subsystem?

For FME_FEATURE_ID_ETH_GROUP, it is not designed as the full functional
ethernet controller. It is specially developed for the Intel N3000 NIC.
Since it is an FPGA based card, it is designed for the users to runtime
reload part of the MAC layer logic developed by themselves, while the ETH
GROUP is another part of the MAC which is not expected to be reloaded by
customers, but it provides some configurations for software to work with
the user logic.

And what's the difference for the FME_FEATURE_ID_OFS_HSSI?

Thanks,
Yilun

> not fit into the standard MAC and net kernel subsystems.
> 
> The Feature ID table of DFL can be found:
> https://github.com/OPAE/dfl-feature-id
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> ---
> v2: add HSSI introduction and the git repo of Feature ID table.
> ---
>  drivers/uio/uio_dfl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/uio/uio_dfl.c b/drivers/uio/uio_dfl.c
> index 89c0fc7b0cbc..660e1d0bf6b9 100644
> --- a/drivers/uio/uio_dfl.c
> +++ b/drivers/uio/uio_dfl.c
> @@ -45,9 +45,11 @@ static int uio_dfl_probe(struct dfl_device *ddev)
>  }
>  
>  #define FME_FEATURE_ID_ETH_GROUP	0x10
> +#define FME_FEATURE_ID_OFS_HSSI		0x15
>  
>  static const struct dfl_device_id uio_dfl_ids[] = {
>  	{ FME_ID, FME_FEATURE_ID_ETH_GROUP },
> +	{ FME_ID, FME_FEATURE_ID_OFS_HSSI },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(dfl, uio_dfl_ids);
> -- 
> 2.26.2
