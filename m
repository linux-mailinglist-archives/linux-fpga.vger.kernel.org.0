Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86175B4C8A
	for <lists+linux-fpga@lfdr.de>; Sun, 11 Sep 2022 09:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiIKHtV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 11 Sep 2022 03:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIKHtU (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 11 Sep 2022 03:49:20 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9323A2CDFD;
        Sun, 11 Sep 2022 00:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662882559; x=1694418559;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7NjSn/qfT6dcyoL8X+C+RJaXir0Eb7/TA61vkNIVz0o=;
  b=iuwK+ZU52/Phe1d/gVIOusj+SRYVju9Dk+e0uCCiWMTnLXGXL6lTcI16
   tX+dPtNZ40z0it6SXS1NS0CZZ7168uNQU+8GNtHzIYzpCYRyrZy0BmLdS
   2aF1lwDOLFW1AVBWwlYOJGqEFFJF8Ev06Ft/wrQZrIARsW91cdiVgGwzz
   GFudXTm65iPUeZd8xATGpEUuw8v5sCZASV9fWgW7z9sTmaCLsYrR1vKCx
   BPKS++55gQlyNgA35kLhwjsiJ+q/G2rVGVjONRIJoGWRWS1yIQXFohF63
   PImngjy/fSN/TdrtgP72M0HLDHmgmMFN0jA5WgTcUEdglTH4E/JqRr0o+
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10466"; a="296439675"
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="296439675"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 00:49:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="677703199"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga008.fm.intel.com with ESMTP; 11 Sep 2022 00:49:16 -0700
Date:   Sun, 11 Sep 2022 15:39:45 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com, lee@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgoncalv@redhat.com, marpagan@redhat.com,
        matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com
Subject: Re: [PATCH v1 2/2] fpga: m10bmc-sec: d5005 bmc secure update driver
Message-ID: <Yx2QwSG52+Iq8Ysa@yilunxu-OptiPlex-7050>
References: <20220902165706.518074-1-russell.h.weight@intel.com>
 <20220902165706.518074-3-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902165706.518074-3-russell.h.weight@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-09-02 at 09:57:06 -0700, Russ Weight wrote:
> Add a driver name for the D5005 BMC secure update driver. Different
> driver names are used for the N3000 and D5005 devices because future
> changes will add conditional code based on the device type (N3000
> vs D5005). This change enables D5005 secure updates of BCM images,
> BMC firmware, static-region images, etc.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
>  drivers/fpga/intel-m10-bmc-sec-update.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
> index 72c677c910de..526c8cdd1474 100644
> --- a/drivers/fpga/intel-m10-bmc-sec-update.c
> +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
> @@ -605,6 +605,9 @@ static const struct platform_device_id intel_m10bmc_sec_ids[] = {
>  	{
>  		.name = "n3000bmc-sec-update",
>  	},
> +	{
> +		.name = "d5005bmc-sec-update",
> +	},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(platform, intel_m10bmc_sec_ids);

Applied to for-next.

Thanks,
Yilun

> -- 
> 2.25.1
> 
