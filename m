Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF27534B1E
	for <lists+linux-fpga@lfdr.de>; Thu, 26 May 2022 10:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236331AbiEZICB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 26 May 2022 04:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344941AbiEZIB7 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 26 May 2022 04:01:59 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BBB2DAB5;
        Thu, 26 May 2022 01:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653552118; x=1685088118;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ehhcr8dN1ah9KufS2J1UEiOkqJ2ds8j89R8gAdWwgPo=;
  b=HHj7zFAaADnA7e8wbfIeinBznZPqazNCtdiZMbwmOrOKgseSG8+FtMOi
   v/h6oYOI3L48QaJBa7c/frotQnRys26/N2lTzkVDLmnmyNZTA8STYqJJN
   BdOz735lFjshRAdyUCpMFlXPiBhGo8f9lJvR2TuaH28s+Lpj5aYOi/O3d
   M0rrkZlMLgkjqG7CLucOHESR/72R0JiBavG7Tp7e7QorIwhKy89y3K+Wb
   MfgFhcHL90Ye8VKjpSQ5N540lh9BmG/McGZon6rd8X4Yt0ArPGvLf+yyz
   ho8sSwOtCdw2jhdQYD2T01XxtCzljrEaJnZv4qbrGqHxfa2Cy6xayhi0B
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="254574758"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="254574758"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 01:01:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="718148414"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by fmsmga001.fm.intel.com with ESMTP; 26 May 2022 01:01:54 -0700
Date:   Thu, 26 May 2022 15:54:13 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, lee.jones@linaro.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, marpagan@redhat.com, lgoncalv@redhat.com,
        matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com
Subject: Re: [PATCH v21 1/5] mfd: intel-m10-bmc: Rename n3000bmc-secure driver
Message-ID: <20220526075413.GB148394@yilunxu-OptiPlex-7050>
References: <20220521003607.737734-1-russell.h.weight@intel.com>
 <20220521003607.737734-2-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521003607.737734-2-russell.h.weight@intel.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, May 20, 2022 at 05:36:03PM -0700, Russ Weight wrote:
> The n3000bmc-secure driver has changed to n3000bmc-sec-update. Update
> the name in the list of the intel-m10-bmc sub-drivers.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v21:
>   - No change
> v20:
>   - No change
> v19:
>   - No change
> v18:
>   - No change
> v17:
>   - This is a new patch to change in the name of the secure update
>     driver.
> ---
>  drivers/mfd/intel-m10-bmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
> index 8db3bcf5fccc..f4d0d72573c8 100644
> --- a/drivers/mfd/intel-m10-bmc.c
> +++ b/drivers/mfd/intel-m10-bmc.c
> @@ -26,7 +26,7 @@ static struct mfd_cell m10bmc_d5005_subdevs[] = {
>  static struct mfd_cell m10bmc_pacn3000_subdevs[] = {
>  	{ .name = "n3000bmc-hwmon" },
>  	{ .name = "n3000bmc-retimer" },
> -	{ .name = "n3000bmc-secure" },
> +	{ .name = "n3000bmc-sec-update" },

Acked-by: Xu Yilun <yilun.xu@intel.com>

Hi Lee:

Is it good to you? If yes, could I apply this patch to linux-fpga
and submit along with the other patches in this series?

Thanks,
Yilun

>  };
>  
>  static struct mfd_cell m10bmc_n5010_subdevs[] = {
> -- 
> 2.25.1
