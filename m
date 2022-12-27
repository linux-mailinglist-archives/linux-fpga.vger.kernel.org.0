Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD08B656966
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Dec 2022 11:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiL0KW0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 27 Dec 2022 05:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiL0KWZ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 27 Dec 2022 05:22:25 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039E8BA8;
        Tue, 27 Dec 2022 02:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672136544; x=1703672544;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=DUk2wXSVpzmjwoMQxPiikpreZEIfF3QqjtVdTKA1MQ0=;
  b=j/LHcSFYYvSGaXzMJHzCdx3SUw94mS3B4fY4b6GvroR0VVIS/EahS+59
   /OQUbKFjTMHRhfXJoiJbPNUAsiGEKFyf02/6Qaza4CbPBlP7Bj4LxDRLk
   DHocjQ9/qdMBhAyQZ5kB/nTtTLq8w/1lcPbCgbDetBAgzLeVPsQ70EBnR
   DJiI80xg3w/w/hj56/MZxqR7hj9+55FI4a3XJZJo5Tx4/PfFyiXXmp2vJ
   P+OI/uAO/3rdPhdpnhO/Z8XeiITD1R4SsmR8gTjtuPIcidVhCPbxidUep
   lzjXx5fU06N9dMUIJMKTNM0E1D/eJTPZ2/N6x4c2LxJRu40BcyVThjPbC
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10572"; a="304182063"
X-IronPort-AV: E=Sophos;i="5.96,278,1665471600"; 
   d="scan'208";a="304182063"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 02:22:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10572"; a="630656448"
X-IronPort-AV: E=Sophos;i="5.96,278,1665471600"; 
   d="scan'208";a="630656448"
Received: from fichtl-mobl.ger.corp.intel.com ([10.251.219.96])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 02:22:19 -0800
Date:   Tue, 27 Dec 2022 12:22:17 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
cc:     Conor Dooley <conor.dooley@microchip.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        linux-fpga@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        system@metrotek.ru
Subject: Re: [PATCH v3 2/3] fpga: microchip-spi: rewrite status polling in
 a time measurable way
In-Reply-To: <20221227100450.2257-3-i.bornyakov@metrotek.ru>
Message-ID: <9581d578-b4c2-cfca-f750-53196bb3324@linux.intel.com>
References: <20221227100450.2257-1-i.bornyakov@metrotek.ru> <20221227100450.2257-3-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1741811003-1672136543=:1743"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1741811003-1672136543=:1743
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 27 Dec 2022, Ivan Bornyakov wrote:

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
> ---
>  drivers/fpga/microchip-spi.c | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
> index e72fedd93a27..8d1d9476d0cc 100644
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
> @@ -197,21 +198,16 @@ static int mpf_ops_parse_header(struct fpga_manager *mgr,
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

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1741811003-1672136543=:1743--
