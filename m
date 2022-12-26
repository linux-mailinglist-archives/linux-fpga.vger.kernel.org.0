Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAD8656497
	for <lists+linux-fpga@lfdr.de>; Mon, 26 Dec 2022 19:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiLZSYP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 26 Dec 2022 13:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiLZSYO (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 26 Dec 2022 13:24:14 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A546A25D7;
        Mon, 26 Dec 2022 10:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672079053; x=1703615053;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4PC/rO7q4a/aiRxZxAXzbYiW0GcNhwpPNQ+hpbSkUY0=;
  b=ZGP+WiS6bSsFMGcocZMGcJkuGUSf2DWRjj6q6yKZjMaf+G3+uw5bADaW
   mlJqcKmGWzLjv0uxIR0wyfrxkVfoKth7yE4MG00EnQPY1vwonicG3l+q4
   gyssqr3KCz2LQU77msaWtiYFSK2KP8sKjkaiU06qxZa0XUxZamg4SaLJR
   KwV4n/s/b8zey992s0wkRW8czB92V//IGlV2Hq2egKL25S3dPPBe3WZCi
   w+3G0a/HTA8nWqSi0NGrOsU1ZYS7jQiAWChEgfiNDAfulRuWf9MiqoStV
   g/zdWD/HdL/RtIqIWVedBnfH1MlUGWRCzyxTZr4jGy4hao2SYdxjTcRpf
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10572"; a="347790819"
X-IronPort-AV: E=Sophos;i="5.96,276,1665471600"; 
   d="scan'208";a="347790819"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 10:24:13 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10572"; a="721309772"
X-IronPort-AV: E=Sophos;i="5.96,276,1665471600"; 
   d="scan'208";a="721309772"
Received: from ptelkov-mobl2.ccr.corp.intel.com ([10.249.41.4])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 10:24:09 -0800
Date:   Mon, 26 Dec 2022 20:24:06 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
cc:     Conor Dooley <conor.dooley@microchip.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        linux-fpga@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        system@metrotek.ru
Subject: Re: [PATCH v2 2/3] fpga: microchip-spi: rewrite status polling in
 a time measurable way
In-Reply-To: <20221226142326.8111-3-i.bornyakov@metrotek.ru>
Message-ID: <5386279-3ce-fa0-ed5-494cb12ae6d@linux.intel.com>
References: <20221226142326.8111-1-i.bornyakov@metrotek.ru> <20221226142326.8111-3-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, 26 Dec 2022, Ivan Bornyakov wrote:

> Original busy loop with retries count in mpf_poll_status() is not too
> reliable, as it takes different times on different systems. Replace it
> with read_poll_timeout() macro.
> 
> Fixes: 5f8d4a900830 ("fpga: microchip-spi: add Microchip MPF FPGA manager")
> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> ---
>  drivers/fpga/microchip-spi.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
> index e72fedd93a27..f3ddfab87499 100644
> --- a/drivers/fpga/microchip-spi.c
> +++ b/drivers/fpga/microchip-spi.c
> @@ -6,6 +6,7 @@
>  #include <asm/unaligned.h>
>  #include <linux/delay.h>
>  #include <linux/fpga/fpga-mgr.h>
> +#include <linux/iopoll.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/spi/spi.h>
> @@ -33,7 +34,7 @@
>  
>  #define	MPF_BITS_PER_COMPONENT_SIZE	22
>  
> -#define	MPF_STATUS_POLL_RETRIES		10000
> +#define	MPF_STATUS_POLL_TIMEOUT		(2 * USEC_PER_SEC)
>  #define	MPF_STATUS_BUSY			BIT(0)
>  #define	MPF_STATUS_READY		BIT(1)
>  #define	MPF_STATUS_SPI_VIOLATION	BIT(2)
> @@ -197,21 +198,17 @@ static int mpf_ops_parse_header(struct fpga_manager *mgr,
>  /* Poll HW status until busy bit is cleared and mask bits are set. */
>  static int mpf_poll_status(struct mpf_priv *priv, u8 mask)
>  {
> -	int status, retries = MPF_STATUS_POLL_RETRIES;
> +	int ret, status;
>  
> -	while (retries--) {
> -		status = mpf_read_status(priv);
> -		if (status < 0)
> -			return status;
> -
> -		if (status & MPF_STATUS_BUSY)
> -			continue;
> -
> -		if (!mask || (status & mask))
> -			return status;
> -	}
> +	ret = read_poll_timeout(mpf_read_status, status,
> +				(status < 0) ||
> +				(!(status & MPF_STATUS_BUSY) &&
> +				 (!mask || (status & mask))),

I'm just noting that this code does not match function's comment 
(neither pre nor post diff code). The comment claims "mask bits are set" 
but the code tests "any mask bit set". 

However, currently it causes no issue because only MPF_STATUS_READY is 
passed and it's BIT(1).

I think the condition matching to the comment would be this (IMHO, it is 
also slightly simpler because !mask doesn't need to be special cased):

((status & (MPF_STATUS_BUSY | mask)) == mask)

(But not necessarily to be changed in this patch.)

-- 
 i.

> +				0, MPF_STATUS_POLL_TIMEOUT, false, priv);
> +	if (ret < 0)
> +		return ret;
>  
> -	return -EBUSY;
> +	return status;
>  }
>  
>  static int mpf_spi_write(struct mpf_priv *priv, const void *buf, size_t buf_size)
> 

