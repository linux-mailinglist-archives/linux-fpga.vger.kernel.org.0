Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BB7536CC6
	for <lists+linux-fpga@lfdr.de>; Sat, 28 May 2022 14:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbiE1MLs (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 28 May 2022 08:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiE1MLr (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 28 May 2022 08:11:47 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB661CFE1;
        Sat, 28 May 2022 05:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653739906; x=1685275906;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8sRkxQT26PMQWck15dOVL/QQfNSeDKy0JdrBz9Xb2us=;
  b=Ro1kc9q5fXJ+WybXxayPLpv5pnqBj+XfuHgkDe/eT3uJDdK74N9YpxwG
   z72PptcWnLuqczT4pYAbZCm4Cp8tvJeCqpJ+iZPKYQE0LGt33ops8NXs/
   PvWiRWBYIc0NHW/uK1LCsy7HWoAlrHNf0QcBFRvul1KPA9yemQebKWGfM
   /PT0zh7xiAc4kAu9OiFS814Loj1k5zRQlnrm7zZdYPq3kdmugTozSW47n
   cpheL/tm0/BslsPqPkHWGXkoIjI9tsoLdnQCaqCcfEqdDmJMDC3rRJjzW
   dCeiyFXgiRFF1nMDdapLRjjid6TXy/LuBZchdCyBNmOKSjjy/IWbcJ02d
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="274765080"
X-IronPort-AV: E=Sophos;i="5.91,258,1647327600"; 
   d="scan'208";a="274765080"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2022 05:11:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,258,1647327600"; 
   d="scan'208";a="604384973"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga008.jf.intel.com with ESMTP; 28 May 2022 05:11:44 -0700
Date:   Sat, 28 May 2022 20:04:00 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     tien.sung.ang@intel.com
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dinh Nguyen <dinh.nguyen@intel.com>
Subject: Re: [PATCH] fpga: altera-cvp: allow interrupt to continue next time
Message-ID: <20220528120400.GA175058@yilunxu-OptiPlex-7050>
References: <20220518073844.2713722-1-tien.sung.ang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518073844.2713722-1-tien.sung.ang@intel.com>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, May 18, 2022 at 03:38:44PM +0800, tien.sung.ang@intel.com wrote:
> From: Dinh Nguyen <dinh.nguyen@intel.com>
> 
> CFG_READY signal/bit may time-out due to firmware not responding
> within the given time-out. This time varies due to numerous
> factors like size of bitstream and others.
> This time-out error does not impact the result of the CvP
> previous transactions. The CvP driver shall then, respond with

Do you mean the reprogramming is successful even if you find the time
out in write_complete()? Then return 0 is better?

And could you specify what the time-out mean on write_init() phase?

Thanks,
Yilun

> EAGAIN instead Time out error.
> 
> Signed-off-by: Dinh Nguyen <dinh.nguyen@intel.com>
> Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
> ---
>  drivers/fpga/altera-cvp.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> index 4ffb9da537d8..d74ff63c61e8 100644
> --- a/drivers/fpga/altera-cvp.c
> +++ b/drivers/fpga/altera-cvp.c
> @@ -309,10 +309,22 @@ static int altera_cvp_teardown(struct fpga_manager *mgr,
>  	/* STEP 15 - poll CVP_CONFIG_READY bit for 0 with 10us timeout */
>  	ret = altera_cvp_wait_status(conf, VSE_CVP_STATUS_CFG_RDY, 0,
>  				     conf->priv->poll_time_us);
> -	if (ret)
> +	if (ret) {
>  		dev_err(&mgr->dev, "CFG_RDY == 0 timeout\n");
> +		goto error_path;
> +	}
>  
>  	return ret;
> +
> +error_path:
> +	/* reset CVP_MODE and HIP_CLK_SEL bit */
> +	altera_read_config_dword(conf, VSE_CVP_MODE_CTRL, &val);
> +	val &= ~VSE_CVP_MODE_CTRL_HIP_CLK_SEL;
> +	val &= ~VSE_CVP_MODE_CTRL_CVP_MODE;
> +	altera_write_config_dword(conf, VSE_CVP_MODE_CTRL, val);
> +
> +	return -EAGAIN;
> +
>  }
>  
>  static int altera_cvp_write_init(struct fpga_manager *mgr,
> -- 
> 2.25.1
