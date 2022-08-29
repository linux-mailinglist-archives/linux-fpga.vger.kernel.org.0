Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFF45A4636
	for <lists+linux-fpga@lfdr.de>; Mon, 29 Aug 2022 11:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiH2JgL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 29 Aug 2022 05:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiH2JgK (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 29 Aug 2022 05:36:10 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3223A5B073;
        Mon, 29 Aug 2022 02:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661765769; x=1693301769;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WteHylslnq5xh8mQwwN4M/m2X56stAMvpStU/edN5Lk=;
  b=blll5zXM/WPWlMopt1j+MWwkfNswtoojNF95Acjc5as+dQwJ6rgXvzpZ
   uIDgFx2f9EpaeKfSd9jFP5EX/mTsGJEtsuW5Kr+sXvJjsJGqFJxMYy6Ea
   bH1xtCwoS2R1dtqPyD3SAyv+d+m6t/c7Tjv8mIGEJ0JEzIOcB0nXXv49t
   vN4aw2lY9NjXQ+augvXN+FbPHSqbx4MbIU/aVgarN9nf1vnSgi0dxY6/Q
   vLhq2xeRZy1oYcf+w/GUXNr4ZMTSHpK3nEWfO/a2owyhukJYYTKia5Cu1
   K5FckM1AXYth+UrY90rwbglFOgmlvD/GqKjC0/LEKKxbEv4YpNHFiGJ8+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="295630920"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="295630920"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 02:36:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="640872574"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga008.jf.intel.com with ESMTP; 29 Aug 2022 02:36:06 -0700
Date:   Mon, 29 Aug 2022 17:26:48 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Johannes Zink <j.zink@pengutronix.de>
Cc:     linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH 15/16] fpga: machxo2: extend erase timeout for machxo2
 FPGA
Message-ID: <YwyGWELZ7WfCE3FS@yilunxu-OptiPlex-7050>
References: <20220825141343.1375690-1-j.zink@pengutronix.de>
 <20220825141343.1375690-16-j.zink@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825141343.1375690-16-j.zink@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-08-25 at 16:13:42 +0200, Johannes Zink wrote:
> Measurements showed that some FPGAs take significantly longer than the
> default wait function supplied. The datasheet inidicates up to 30
> seconds erase times for some MachXO2 FPGAs, depending on the number of
> LUTs (and the corresponding configuration flash size).
> 
> Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
> ---
>  drivers/fpga/machxo2-common.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/fpga/machxo2-common.c b/drivers/fpga/machxo2-common.c
> index ccf9a50fc590..e8967cdee2c6 100644
> --- a/drivers/fpga/machxo2-common.c
> +++ b/drivers/fpga/machxo2-common.c
> @@ -17,6 +17,8 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/property.h>
> +#include <linux/iopoll.h>
> +#include <linux/time.h>
>  #include "machxo2-common.h"
>  
>  #define MACHXO2_LOW_DELAY_USEC          5
> @@ -24,6 +26,8 @@
>  #define MACHXO2_REFRESH_USEC            4800
>  #define MACHXO2_MAX_BUSY_LOOP           128
>  #define MACHXO2_MAX_REFRESH_LOOP        16
> +#define MACHXO2_MAX_ERASE_USEC          (30 * USEC_PER_SEC)
> +#define MACHXO2_ERASE_USEC_SLEEP        (20 * USEC_PER_MSEC)
>  
>  #define MACHXO2_PAGE_SIZE               16
>  #define MACHXO2_BUF_SIZE                (MACHXO2_PAGE_SIZE + 4)
> @@ -54,6 +58,18 @@
>  #define ISC_ERASE_FEATURE_ROW	BIT(17)
>  #define ISC_ERASE_UFM		BIT(19)
>  
> +static inline int machxo2_wait_until_not_busy_timeout(struct machxo2_common_priv *priv)
> +{
> +	int ret, pollret;
> +	u32 status = MACHXO2_BUSY;
> +
> +	pollret = read_poll_timeout(priv->get_status, ret,
> +				    (ret && ret != -EAGAIN) || !(status & MACHXO2_BUSY),
> +				    MACHXO2_ERASE_USEC_SLEEP, MACHXO2_MAX_ERASE_USEC,
> +				    true, priv, &status);

Why just taking care of erase timeout? I see the busy wait in many
places.

> +
> +	return ret ?: pollret;
> +}
>  
>  static inline u8 get_err(u32 status)
>  {
> @@ -114,6 +130,12 @@ static int machxo2_cleanup(struct fpga_manager *mgr)
>  	if (ret)
>  		goto fail;
>  
> +	ret = machxo2_wait_until_not_busy_timeout(priv);
> +	if (ret) {
> +		dev_err(&mgr->dev, "Erase operation failed (%d)", ret);
> +		goto fail;
> +	}
> +
>  	ret = machxo2_wait_until_not_busy(priv);

Is this line still needed?

>  	if (ret)
>  		goto fail;
> @@ -192,9 +214,11 @@ static int machxo2_write_init(struct fpga_manager *mgr,
>  	if (ret)
>  		goto fail;
>  
> -	ret = machxo2_wait_until_not_busy(priv);
> -	if (ret)
> +	ret = machxo2_wait_until_not_busy_timeout(priv);
> +	if (ret) {
> +		dev_err(&mgr->dev, "Erase operation failed (%d)", ret);
>  		goto fail;
> +	}
>  
>  	priv->get_status(priv, &status);
>  	if (status & MACHXO2_FAIL) {
> -- 
> 2.30.2
> 
