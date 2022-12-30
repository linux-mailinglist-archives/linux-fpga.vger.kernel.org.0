Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492AD6595FF
	for <lists+linux-fpga@lfdr.de>; Fri, 30 Dec 2022 08:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbiL3Hxg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 30 Dec 2022 02:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234521AbiL3Hxf (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 30 Dec 2022 02:53:35 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C83E101CE;
        Thu, 29 Dec 2022 23:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672386814; x=1703922814;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=YyVqNVBwJftkdK1pN7st5AJ5/f39dEx8duN3uP+aAUI=;
  b=M/vIwaNkqLlWyRyPl2vGYjm/6A/altS7cSbujuGBQfZLL+T8SlOsvWuI
   fHU7e56diX4dHwLOup9JVydC7FdHzQQFgka2vPh8SDicErzh6ADiApMWk
   itAeto3BDKDD3gyVch8lmrxXm76EQD03AY7fbk33czvWIMAvbFE2GDUD5
   5iSKsLHACEzsfb78WgincPQEmX4Wgq/0ErVA8I4JjeLPJwIwDHtDdjgC6
   42PPz+0XYIbtNr4GyVwF8y19NiTOF7WA4Pj/GXcf+/DyRNnTmz1QcXQGt
   Tc2rd4mgEGeoQSmgVhBJc73yAzBqv2NNa/tFFVgAbyDaJiUwzLSLtp+EW
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="322413447"
X-IronPort-AV: E=Sophos;i="5.96,286,1665471600"; 
   d="scan'208";a="322413447"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 23:53:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="982599073"
X-IronPort-AV: E=Sophos;i="5.96,286,1665471600"; 
   d="scan'208";a="982599073"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga005.fm.intel.com with ESMTP; 29 Dec 2022 23:53:31 -0800
Date:   Fri, 30 Dec 2022 15:43:23 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     linux-fpga@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: Re: [PATCH v4 2/3] fpga: microchip-spi: rewrite status polling in a
 time measurable way
Message-ID: <Y66Wmxh0vWBMNMBU@yilunxu-OptiPlex-7050>
References: <20221229104604.2496-1-i.bornyakov@metrotek.ru>
 <20221229104604.2496-3-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221229104604.2496-3-i.bornyakov@metrotek.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-12-29 at 13:46:03 +0300, Ivan Bornyakov wrote:
> Original busy loop with retries count in mpf_poll_status() is not too
> reliable, as it takes different times on different systems. Replace it
> with read_poll_timeout() macro.
> 
> While at it, fix polling stop condition to met function's original
> intention declared in the comment. The issue with original polling stop
> condition is that it stops if any of mask bits is set, while intention
> was to stop if all mask bits is set. This was not noticible because only
> MPF_STATUS_READY is passed as mask argument and it is BIT(1).
> 
> Fixes: 5f8d4a900830 ("fpga: microchip-spi: add Microchip MPF FPGA manager")
> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

> ---
>  drivers/fpga/microchip-spi.c | 32 +++++++++++++++++---------------
>  1 file changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
> index e72fedd93a27..995b1964e0fe 100644
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
> @@ -194,24 +195,25 @@ static int mpf_ops_parse_header(struct fpga_manager *mgr,
>  	return 0;
>  }
>  
> -/* Poll HW status until busy bit is cleared and mask bits are set. */
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
> +	/*
> +	 * Busy poll HW status. Polling stops if any of the following
> +	 * conditions are met:
> +	 *  - timeout is reached
> +	 *  - mpf_read_status() returns an error
> +	 *  - busy bit is cleared AND mask bits are set
> +	 */
> +	ret = read_poll_timeout(mpf_read_status, status,
> +				(status < 0) ||
> +				((status & (MPF_STATUS_BUSY | mask)) == mask),
> +				0, MPF_STATUS_POLL_TIMEOUT, false, priv);
> +	if (ret < 0)
> +		return ret;
>  
> -	return -EBUSY;
> +	return status;
>  }
>  
>  static int mpf_spi_write(struct mpf_priv *priv, const void *buf, size_t buf_size)
> -- 
> 2.39.0
> 
> 
