Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14CD6595E6
	for <lists+linux-fpga@lfdr.de>; Fri, 30 Dec 2022 08:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbiL3HmH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 30 Dec 2022 02:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234765AbiL3Hl4 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 30 Dec 2022 02:41:56 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31196A451;
        Thu, 29 Dec 2022 23:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672386069; x=1703922069;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8wPdm2gQ9teAbmG18b2fI8r2C7mIaxNEPTgadQdH8cA=;
  b=QMffgqKrLt2j0F5Vsz5i+Qhz4chbZ51QWabfaovw8mEnc7Qv+IWYQwxA
   3SldKe2gwmXsQRhFgyMwWZBK3kBZd3213L1nhlW1NqzhrQq1N5KgKa+Kn
   EqQ6LpULpK055vNCFpJpj22iPu/I4y+91wZQrQlqi7fy3OVj1vFukpFKX
   L4+pCBiZNO1rLJz2rfI0MlJ/YfbSloC5GQ3OSGSH9JmVmD5ElnJbFt5EZ
   jw4jBzntcp+mGrN9Zkeo5/70vEwvv0hAiaeMi0co4FjxjvusJSj0Uj7Y1
   ZglzLHbAUl/EEFFFD8ismj/pp77mcaF/sIFW4h0VSX4LzIfNBA2wJ0NI8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="407438734"
X-IronPort-AV: E=Sophos;i="5.96,286,1665471600"; 
   d="scan'208";a="407438734"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 23:41:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="655799359"
X-IronPort-AV: E=Sophos;i="5.96,286,1665471600"; 
   d="scan'208";a="655799359"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga007.fm.intel.com with ESMTP; 29 Dec 2022 23:41:06 -0800
Date:   Fri, 30 Dec 2022 15:30:59 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     linux-fpga@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: Re: [PATCH v4 1/3] fpga: microchip-spi: move SPI I/O buffers out of
 stack
Message-ID: <Y66Ts4SIYBE8QFF8@yilunxu-OptiPlex-7050>
References: <20221229104604.2496-1-i.bornyakov@metrotek.ru>
 <20221229104604.2496-2-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221229104604.2496-2-i.bornyakov@metrotek.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-12-29 at 13:46:02 +0300, Ivan Bornyakov wrote:
> As spi-summary doc says:
>  > I/O buffers use the usual Linux rules, and must be DMA-safe.
>  > You'd normally allocate them from the heap or free page pool.
>  > Don't use the stack, or anything that's declared "static".
> 
> Replace spi_write() with spi_write_then_read(), which is dma-safe for
> on-stack buffers. Use allocated buffers for transfers used in

How about "Use cacheline aligned buffers for ..."

> spi_sync_transfer().
> 
> Although everything works OK with stack-located I/O buffers, better
> follow the doc to be safe.
> 
> Fixes: 5f8d4a900830 ("fpga: microchip-spi: add Microchip MPF FPGA manager")
> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/fpga/microchip-spi.c | 93 ++++++++++++++++++------------------
>  1 file changed, 47 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
> index 7436976ea904..e72fedd93a27 100644
> --- a/drivers/fpga/microchip-spi.c
> +++ b/drivers/fpga/microchip-spi.c
> @@ -42,46 +42,55 @@
>  struct mpf_priv {
>  	struct spi_device *spi;
>  	bool program_mode;
> +	u8 tx __aligned(ARCH_KMALLOC_MINALIGN);
> +	u8 rx __aligned(ARCH_KMALLOC_MINALIGN);

If the 2 buffers are used synchronously by dma, they could share a
cacheline. Just separate them from other members should be OK, like:

	u8 tx __aligned(ARCH_KMALLOC_MINALIGN);
	u8 rx;

>  };
>  
