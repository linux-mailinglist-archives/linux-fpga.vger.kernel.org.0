Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB9E5AC07B
	for <lists+linux-fpga@lfdr.de>; Sat,  3 Sep 2022 20:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbiICSCX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 3 Sep 2022 14:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbiICSCW (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 3 Sep 2022 14:02:22 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A274A838;
        Sat,  3 Sep 2022 11:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662228142; x=1693764142;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ww0ObHahV4z/QEThu9YFvc0tiIdhFo/C4S5cz0havSM=;
  b=KctiyX0FxHBEivMgA9m7x3tUyoIld0u2zTFMrPeazZVdhggZaLFOvcOt
   MAooR5zVXpvQmBDTF/SbDRYkjlVxFK5zP6fXpHpp9esRcsNb+2TxIrqLu
   9/7Bv0nysyOksovjBEuIthZ1R00KriKYLpaGOgKMtW6OPDRN4G8fiOPgm
   bDF+O1Lmzx/S3zJikKAgaYHKzK11Xa5VnRaiJEf4KQeITXtybvwI0ZKaD
   MpPGNJJTYcVxuPtT9VrguovC7sQ2JRJ+r22cAp/Boz9dJMOkvqkmvfYTT
   MyCEe3Ubl2XnA+I7Av36WcrkA/li9bVHB1yAtjlwV7HDGdwx4H4f78kIn
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10459"; a="382477247"
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="382477247"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 11:02:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="564299997"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga003.jf.intel.com with ESMTP; 03 Sep 2022 11:02:19 -0700
Date:   Sun, 4 Sep 2022 01:52:56 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>,
        Luwei Kang <luwei.kang@intel.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-fpga@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fpga: prevent integer overflow in
 dfl_feature_ioctl_set_irq()
Message-ID: <YxOUeHfaNYk7oQXt@yilunxu-OptiPlex-7050>
References: <YxBAtYCM38dM7yzI@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxBAtYCM38dM7yzI@kili>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-09-01 at 08:18:45 +0300, Dan Carpenter wrote:
> The "hdr.count * sizeof(s32)" multiplication can overflow on 32 bit
> systems leading to memory corruption.  Use array_size() to fix that.
> 
> Fixes: 322b598be4d9 ("fpga: dfl: introduce interrupt trigger setting API")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied to fpga for-next.

Thanks
Yilun

> ---
>  drivers/fpga/dfl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 5498bc337f8b..b9aae85ba930 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -1866,7 +1866,7 @@ long dfl_feature_ioctl_set_irq(struct platform_device *pdev,
>  		return -EINVAL;
>  
>  	fds = memdup_user((void __user *)(arg + sizeof(hdr)),
> -			  hdr.count * sizeof(s32));
> +			  array_size(hdr.count, sizeof(s32)));
>  	if (IS_ERR(fds))
>  		return PTR_ERR(fds);
>  
> -- 
> 2.35.1
> 
