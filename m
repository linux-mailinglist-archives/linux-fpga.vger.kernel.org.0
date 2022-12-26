Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8152E656162
	for <lists+linux-fpga@lfdr.de>; Mon, 26 Dec 2022 10:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbiLZJHD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 26 Dec 2022 04:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbiLZJG5 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 26 Dec 2022 04:06:57 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A526245;
        Mon, 26 Dec 2022 01:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672045616; x=1703581616;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9VwFcHjI2djGRZ7ATPeTvKkkTknomx6yyxv7AqlnT7I=;
  b=QKzhdydFHTqJ7/AHCnHVqNq1ClsKtDDMp83lIikjD3gxOu7E/82UVNz3
   WSmWuGY/cKZb9bn/5oV2R0TWMcr1VKKsn7GkVnVGL81Em9JK9KmoPR+Td
   HidziDwhKQztNFzm33/G8kpP/Q7Kx35DiJ3NboyrK0mGqqLnXF4x25OBu
   uDpUQimMMsSPIrqwbKsTg0Dvp4owT2kf2BdzbGKcaXxe2RBU2ru4SDpG+
   OXtPss2Za0gMeW20cpHEq8TAiXLjXwSUGcu2f1uSlGEjs3IxrbN42b92r
   YbzQbkpr8n+Ws7RcPDNEjBiMxEmPVUzkci9pIkgqiDPLbOnNGn55Pgxyy
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10571"; a="318213971"
X-IronPort-AV: E=Sophos;i="5.96,275,1665471600"; 
   d="scan'208";a="318213971"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 01:06:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10571"; a="826835213"
X-IronPort-AV: E=Sophos;i="5.96,275,1665471600"; 
   d="scan'208";a="826835213"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga005.jf.intel.com with ESMTP; 26 Dec 2022 01:06:53 -0800
Date:   Mon, 26 Dec 2022 16:56:49 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     linux-fpga@vger.kernel.org, conor.dooley@microchip.com,
        mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: Re: [PATCH] fpga: microchip-spi: move SPI I/O buffers out of stack
Message-ID: <Y6lh0e+Jz5Y6ehwc@yilunxu-OptiPlex-7050>
References: <20221223123854.8023-1-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223123854.8023-1-i.bornyakov@metrotek.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-12-23 at 15:38:54 +0300, Ivan Bornyakov wrote:
> As spi-summary doc says:
>  > I/O buffers use the usual Linux rules, and must be DMA-safe.
>  > You'd normally allocate them from the heap or free page pool.
>  > Don't use the stack, or anything that's declared "static".
> 
> Replace spi_write() with spi_write_then_read(), which is dma-safe for
> on-stack buffers. Use allocated buffers for transfers used in
> spi_sync_transfer().
> 
> Although everything works OK with stack-located I/O buffers, better
> follow the doc to be safe.
> 
> While at it, replace busy loop in mpf_poll_status() routine with
> read_poll_timeout() macro. Original busy loop is not too reliable, as it
> takes different times on different systems.

Yes, I see there are several intents in this patch, spi dma safe fix, busy
loop change, coding style ...

Could you help split them, one change for each patch?

> 
> Fixes: 5f8d4a900830 ("fpga: microchip-spi: add Microchip MPF FPGA manager")
> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> ---
>  drivers/fpga/microchip-spi.c | 145 +++++++++++++++++++----------------
>  1 file changed, 80 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
> index 7436976ea904..dfb4e071db86 100644
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
> @@ -33,7 +34,6 @@
>  
>  #define	MPF_BITS_PER_COMPONENT_SIZE	22
>  
> -#define	MPF_STATUS_POLL_RETRIES		10000
>  #define	MPF_STATUS_BUSY			BIT(0)
>  #define	MPF_STATUS_READY		BIT(1)
>  #define	MPF_STATUS_SPI_VIOLATION	BIT(2)
> @@ -42,46 +42,55 @@
>  struct mpf_priv {
>  	struct spi_device *spi;
>  	bool program_mode;
> +	u8 *tx;
> +	u8 *rx;

u8 tx  __aligned(ARCH_KMALLOC_MINALIGN);
u8 rx;

Is that OK?

>  };
>  
> -static int mpf_read_status(struct spi_device *spi)
> +static int mpf_read_status(struct mpf_priv *priv)
>  {
> -	u8 status = 0, status_command = MPF_SPI_READ_STATUS;
> -	struct spi_transfer xfers[2] = { 0 };
> -	int ret;
> -
>  	/*
>  	 * HW status is returned on MISO in the first byte after CS went
>  	 * active. However, first reading can be inadequate, so we submit
>  	 * two identical SPI transfers and use result of the later one.
>  	 */
> -	xfers[0].tx_buf = &status_command;
> -	xfers[1].tx_buf = &status_command;
> -	xfers[0].rx_buf = &status;
> -	xfers[1].rx_buf = &status;
> -	xfers[0].len = 1;
> -	xfers[1].len = 1;
> -	xfers[0].cs_change = 1;
> +	struct spi_transfer xfers[2] = {
> +		{
> +			.tx_buf = priv->tx,
> +			.rx_buf = priv->rx,
> +			.len = 1,
> +			.cs_change = 1,
> +		}, {
> +			.tx_buf = priv->tx,
> +			.rx_buf = priv->rx,
> +			.len = 1,
> +		},
> +	};
> +	u8 status;
> +	int ret;
>  
> -	ret = spi_sync_transfer(spi, xfers, 2);
> +	*priv->tx = MPF_SPI_READ_STATUS;
> +
> +	ret = spi_sync_transfer(priv->spi, xfers, 2);
> +	if (ret)
> +		return ret;
> +
> +	status = *priv->rx;
>  
>  	if ((status & MPF_STATUS_SPI_VIOLATION) ||
>  	    (status & MPF_STATUS_SPI_ERROR))
> -		ret = -EIO;
> +		return -EIO;
>  
> -	return ret ? : status;
> +	return status;
>  }
>  
>  static enum fpga_mgr_states mpf_ops_state(struct fpga_manager *mgr)
>  {
>  	struct mpf_priv *priv = mgr->priv;
> -	struct spi_device *spi;
>  	bool program_mode;
>  	int status;
>  
> -	spi = priv->spi;
>  	program_mode = priv->program_mode;
> -	status = mpf_read_status(spi);
> +	status = mpf_read_status(priv);
>  
>  	if (!program_mode && !status)
>  		return FPGA_MGR_STATE_OPERATING;
> @@ -186,51 +195,47 @@ static int mpf_ops_parse_header(struct fpga_manager *mgr,
>  }
>  
>  /* Poll HW status until busy bit is cleared and mask bits are set. */
> -static int mpf_poll_status(struct spi_device *spi, u8 mask)
> +static int mpf_poll_status(struct mpf_priv *priv, u8 mask)
>  {
> -	int status, retries = MPF_STATUS_POLL_RETRIES;
> -
> -	while (retries--) {
> -		status = mpf_read_status(spi);
> -		if (status < 0)
> -			return status;
> +	int ret, status;
>  
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
> +				0, 2 * USEC_PER_SEC, false, priv);

use a MACRO for timeout value.

Thanks,
Yilun

> +	if (ret < 0)
> +		return ret;
>  
> -	return -EBUSY;
> +	return status;
>  }
>  
> -static int mpf_spi_write(struct spi_device *spi, const void *buf, size_t buf_size)
> +static int mpf_spi_write(struct mpf_priv *priv, const void *buf, size_t buf_size)
>  {
> -	int status = mpf_poll_status(spi, 0);
> +	int status = mpf_poll_status(priv, 0);
>  
>  	if (status < 0)
>  		return status;
>  
> -	return spi_write(spi, buf, buf_size);
> +	return spi_write_then_read(priv->spi, buf, buf_size, NULL, 0);
>  }
>  
> -static int mpf_spi_write_then_read(struct spi_device *spi,
> +static int mpf_spi_write_then_read(struct mpf_priv *priv,
>  				   const void *txbuf, size_t txbuf_size,
>  				   void *rxbuf, size_t rxbuf_size)
>  {
>  	const u8 read_command[] = { MPF_SPI_READ_DATA };
>  	int ret;
>  
> -	ret = mpf_spi_write(spi, txbuf, txbuf_size);
> +	ret = mpf_spi_write(priv, txbuf, txbuf_size);
>  	if (ret)
>  		return ret;
>  
> -	ret = mpf_poll_status(spi, MPF_STATUS_READY);
> +	ret = mpf_poll_status(priv, MPF_STATUS_READY);
>  	if (ret < 0)
>  		return ret;
>  
> -	return spi_write_then_read(spi, read_command, sizeof(read_command),
> +	return spi_write_then_read(priv->spi, read_command, sizeof(read_command),
>  				   rxbuf, rxbuf_size);
>  }
>  
> @@ -242,7 +247,6 @@ static int mpf_ops_write_init(struct fpga_manager *mgr,
>  	const u8 isc_en_command[] = { MPF_SPI_ISC_ENABLE };
>  	struct mpf_priv *priv = mgr->priv;
>  	struct device *dev = &mgr->dev;
> -	struct spi_device *spi;
>  	u32 isc_ret = 0;
>  	int ret;
>  
> @@ -251,9 +255,7 @@ static int mpf_ops_write_init(struct fpga_manager *mgr,
>  		return -EOPNOTSUPP;
>  	}
>  
> -	spi = priv->spi;
> -
> -	ret = mpf_spi_write_then_read(spi, isc_en_command, sizeof(isc_en_command),
> +	ret = mpf_spi_write_then_read(priv, isc_en_command, sizeof(isc_en_command),
>  				      &isc_ret, sizeof(isc_ret));
>  	if (ret || isc_ret) {
>  		dev_err(dev, "Failed to enable ISC: spi_ret %d, isc_ret %u\n",
> @@ -261,7 +263,7 @@ static int mpf_ops_write_init(struct fpga_manager *mgr,
>  		return -EFAULT;
>  	}
>  
> -	ret = mpf_spi_write(spi, program_mode, sizeof(program_mode));
> +	ret = mpf_spi_write(priv, program_mode, sizeof(program_mode));
>  	if (ret) {
>  		dev_err(dev, "Failed to enter program mode: %d\n", ret);
>  		return ret;
> @@ -272,13 +274,32 @@ static int mpf_ops_write_init(struct fpga_manager *mgr,
>  	return 0;
>  }
>  
> +static int mpf_spi_frame_write(struct mpf_priv *priv, const char *buf)
> +{
> +	struct spi_transfer xfers[2] = {
> +		{
> +			.tx_buf = priv->tx,
> +			.len = 1,
> +		}, {
> +			.tx_buf = buf,
> +			.len = MPF_SPI_FRAME_SIZE,
> +		},
> +	};
> +	int ret;
> +
> +	ret = mpf_poll_status(priv, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	*priv->tx = MPF_SPI_FRAME;
> +
> +	return spi_sync_transfer(priv->spi, xfers, ARRAY_SIZE(xfers));
> +}
> +
>  static int mpf_ops_write(struct fpga_manager *mgr, const char *buf, size_t count)
>  {
> -	u8 spi_frame_command[] = { MPF_SPI_FRAME };
> -	struct spi_transfer xfers[2] = { 0 };
>  	struct mpf_priv *priv = mgr->priv;
>  	struct device *dev = &mgr->dev;
> -	struct spi_device *spi;
>  	int ret, i;
>  
>  	if (count % MPF_SPI_FRAME_SIZE) {
> @@ -287,19 +308,8 @@ static int mpf_ops_write(struct fpga_manager *mgr, const char *buf, size_t count
>  		return -EINVAL;
>  	}
>  
> -	spi = priv->spi;
> -
> -	xfers[0].tx_buf = spi_frame_command;
> -	xfers[0].len = sizeof(spi_frame_command);
> -
>  	for (i = 0; i < count / MPF_SPI_FRAME_SIZE; i++) {
> -		xfers[1].tx_buf = buf + i * MPF_SPI_FRAME_SIZE;
> -		xfers[1].len = MPF_SPI_FRAME_SIZE;
> -
> -		ret = mpf_poll_status(spi, 0);
> -		if (ret >= 0)
> -			ret = spi_sync_transfer(spi, xfers, ARRAY_SIZE(xfers));
> -
> +		ret = mpf_spi_frame_write(priv, buf + i * MPF_SPI_FRAME_SIZE);
>  		if (ret) {
>  			dev_err(dev, "Failed to write bitstream frame %d/%zu\n",
>  				i, count / MPF_SPI_FRAME_SIZE);
> @@ -317,12 +327,9 @@ static int mpf_ops_write_complete(struct fpga_manager *mgr,
>  	const u8 release_command[] = { MPF_SPI_RELEASE };
>  	struct mpf_priv *priv = mgr->priv;
>  	struct device *dev = &mgr->dev;
> -	struct spi_device *spi;
>  	int ret;
>  
> -	spi = priv->spi;
> -
> -	ret = mpf_spi_write(spi, isc_dis_command, sizeof(isc_dis_command));
> +	ret = mpf_spi_write(priv, isc_dis_command, sizeof(isc_dis_command));
>  	if (ret) {
>  		dev_err(dev, "Failed to disable ISC: %d\n", ret);
>  		return ret;
> @@ -330,7 +337,7 @@ static int mpf_ops_write_complete(struct fpga_manager *mgr,
>  
>  	usleep_range(1000, 2000);
>  
> -	ret = mpf_spi_write(spi, release_command, sizeof(release_command));
> +	ret = mpf_spi_write(priv, release_command, sizeof(release_command));
>  	if (ret) {
>  		dev_err(dev, "Failed to exit program mode: %d\n", ret);
>  		return ret;
> @@ -361,6 +368,14 @@ static int mpf_probe(struct spi_device *spi)
>  	if (!priv)
>  		return -ENOMEM;
>  
> +	priv->tx = devm_kmalloc(dev, 1, GFP_KERNEL);
> +	if (!priv->tx)
> +		return -ENOMEM;
> +
> +	priv->rx = devm_kmalloc(dev, 1, GFP_KERNEL);
> +	if (!priv->rx)
> +		return -ENOMEM;
> +
>  	priv->spi = spi;
>  
>  	mgr = devm_fpga_mgr_register(dev, "Microchip Polarfire SPI FPGA Manager",
> -- 
> 2.38.2
> 
> 
