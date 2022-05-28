Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7AA536C40
	for <lists+linux-fpga@lfdr.de>; Sat, 28 May 2022 12:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbiE1KHV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 28 May 2022 06:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbiE1KHU (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 28 May 2022 06:07:20 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D466405;
        Sat, 28 May 2022 03:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653732438; x=1685268438;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vk11pF5m7jk0EFO6i9P65Kuhipa++erW84XfrVdODgY=;
  b=OOqxwvPP96DNVG1RjA5xoLXGjKsox44UG7B40dj0ugwtHg0URM25Ryw4
   ebjaV5CCx0tW8Fpm3F5ohGxVj0FepSIsN7e4pXO5ET6hSbxF8aWmtmCiJ
   f+l0RCgHCWTneljLWM9GnhoqIfJur4npFT+ljtCJKXeNbHfNvma9Cy5u8
   J6YKeZ5FG/dkLZ8GeMG9/y4qnupCH8BJ24nhCuc5dYLIO+Lq+etphmdxs
   o9KrJNyziXudUwCoG0etsxkcQGJ8qI+KyPrAGQgidc7roNo/jADezR4E0
   HvMP0u7G3yte1TMdNClr3H/H6FN9jG99U9y6Nff3Jw8ZrjhlZskEHXEar
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="256728506"
X-IronPort-AV: E=Sophos;i="5.91,258,1647327600"; 
   d="scan'208";a="256728506"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2022 03:07:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,258,1647327600"; 
   d="scan'208";a="604343567"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga008.jf.intel.com with ESMTP; 28 May 2022 03:07:16 -0700
Date:   Sat, 28 May 2022 17:59:33 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     tien.sung.ang@intel.com
Cc:     christophe.jaillet@wanadoo.fr, mdf@kernel.org, hao.wu@intel.com,
        trix@redhat.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fpga: altera-cvp: Truncated bitstream error support
Message-ID: <20220528095933.GB175008@yilunxu-OptiPlex-7050>
References: <6939d35f-36a0-568e-bfec-4dd2e3a48604@wanadoo.fr>
 <20220520013040.2920835-1-tien.sung.ang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520013040.2920835-1-tien.sung.ang@intel.com>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, May 20, 2022 at 09:30:40AM +0800, tien.sung.ang@intel.com wrote:
> From: Ang Tien Sung <tien.sung.ang@intel.com>
> 
> To support the error handling of a truncated bitstream sent.

A blank line here.

> The current AIB CvP firmware is not capable of handling a
> data stream smaller than 4096bytes. The firmware's limitation

So why don't you check the image size on write_init(), and just prevent
the DMA writing at the very beginning?

> causes a hung-up as it's DMA engine waits forever for the
> completion of the instructed 4096bytes.

A blank line here.

> To resolve this design limitation, both firmware and CvP
> driver made several changes. At the CvP driver, we just
> have to ensure that anything lesser than 4096bytes are
> padded with extra bytes. The CvP will then, initiate the
> tear-down by clearing the START_XFER and CVP_CONFIG bits.

The driver pads the data block to 4096 bytes, then why the CvP still
should fail the reprograming?

If the image size is larger than 1 Page but is not aligned to 1 Page,
will the reprogramming still fail?

> We should also check for CVP_ERROR during the CvP completion.
> A send_buf which is always 4096bytes is used to copy the
> data during every transaction.
> 
> Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
> ---
> changelog v2:
> * Alignment fix parameter 'conf' altera_cvp_send_block
> ---
>  drivers/fpga/altera-cvp.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> index 4ffb9da537d8..5169f9bcd726 100644
> --- a/drivers/fpga/altera-cvp.c
> +++ b/drivers/fpga/altera-cvp.c
> @@ -81,6 +81,7 @@ struct altera_cvp_conf {
>  	u8			numclks;
>  	u32			sent_packets;
>  	u32			vsec_offset;
> +	u8			*send_buf;
>  	const struct cvp_priv	*priv;
>  };
>  
> @@ -453,7 +454,11 @@ static int altera_cvp_write(struct fpga_manager *mgr, const char *buf,
>  		}
>  
>  		len = min(conf->priv->block_size, remaining);
> -		altera_cvp_send_block(conf, data, len);
> +		/* Copy the requested host data into the transmit buffer */
> +

This blank line is not needed.

> +		memcpy(conf->send_buf, data, len);

Any padding value is OK?

> +		altera_cvp_send_block(conf, (const u32 *)conf->send_buf,
> +				      conf->priv->block_size);

If the len equals block_size, is the copy still needed?

>  		data += len / sizeof(u32);
>  		done += len;
>  		remaining -= len;
> @@ -492,10 +497,13 @@ static int altera_cvp_write_complete(struct fpga_manager *mgr,
>  	if (ret)
>  		return ret;
>  
> -	/* STEP 16 - check CVP_CONFIG_ERROR_LATCHED bit */
> -	altera_read_config_dword(conf, VSE_UNCOR_ERR_STATUS, &val);
> -	if (val & VSE_UNCOR_ERR_CVP_CFG_ERR) {
> -		dev_err(&mgr->dev, "detected CVP_CONFIG_ERROR_LATCHED!\n");
> +	/*
> +	 * STEP 16 - If bitstream error (truncated/miss-matched),
> +	 * we shall exit here.
> +	 */
> +	ret = altera_read_config_dword(conf, VSE_CVP_STATUS, &val);
> +	if (ret || (val & VSE_CVP_STATUS_CFG_ERR)) {
> +		dev_err(&mgr->dev, "CVP_CONFIG_ERROR!\n");

So this new error checking covers the previous "latched error" case?

>  		return -EPROTO;
>  	}
>  
> @@ -661,6 +669,12 @@ static int altera_cvp_probe(struct pci_dev *pdev,
>  
>  	pci_set_drvdata(pdev, mgr);
>  
> +	/* Allocate the 4096 block size transmit buffer */
> +	conf->send_buf = devm_kzalloc(&pdev->dev, conf->priv->block_size, GFP_KERNEL);

If block_size == ALTERA_CVP_V1_SIZE, the copy is still needed?

> +	if (!conf->send_buf) {
> +		ret = -ENOMEM;
> +		goto err_unmap;
> +	}

Maybe it is better move the buffer allocation to write_init()

Thanks,
Yilun

>  	return 0;
>  
>  err_unmap:
> -- 
> 2.25.1
