Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8F565960E
	for <lists+linux-fpga@lfdr.de>; Fri, 30 Dec 2022 09:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbiL3ICD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 30 Dec 2022 03:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiL3ICC (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 30 Dec 2022 03:02:02 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8451BEB;
        Fri, 30 Dec 2022 00:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672387317; x=1703923317;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Oi/+rIcqkcv+04p/Hg1B3NjYbcWcYaKfRFTSbgBAmnU=;
  b=E+OA2B0jutpCkg6Zn8i/R8WQu4vshXtrHgYfhIzWP1n7VIA9fe0ryvlG
   1jRJ2J5C3omCQdDvz680SKxDwxplD0nIgSUbmDVT/G1qmHOdWzrfJNY8y
   uJpPbdi9Xqk9QFJnbaA3G6xW+D7dbHqZv3FiDVsa8SrJpP4GCZ2tbmuZ2
   HUfkNiz7ZWl8cHSoKKRFvGUMbeQl/HnFp9Rl/E6twpchR5CqIQSs0RwBq
   IVZSVIV+VVHXCjnvPJHgrNVO0JvLtvrFxWCmQlgrxV98QngY62xgZL618
   eWkn+fAjUP4oXRjXm6j4Ke8WHZK+rNEPxro/ay4h8vhzhUwMZLRzhZ/5e
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="319891596"
X-IronPort-AV: E=Sophos;i="5.96,286,1665471600"; 
   d="scan'208";a="319891596"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2022 00:01:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="653822337"
X-IronPort-AV: E=Sophos;i="5.96,286,1665471600"; 
   d="scan'208";a="653822337"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga002.jf.intel.com with ESMTP; 30 Dec 2022 00:01:53 -0800
Date:   Fri, 30 Dec 2022 15:51:45 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     linux-fpga@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: Re: [PATCH v4 3/3] fpga: microchip-spi: separate data frame write
 routine
Message-ID: <Y66YkbQwQl74lmWt@yilunxu-OptiPlex-7050>
References: <20221229104604.2496-1-i.bornyakov@metrotek.ru>
 <20221229104604.2496-4-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221229104604.2496-4-i.bornyakov@metrotek.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-12-29 at 13:46:04 +0300, Ivan Bornyakov wrote:
> mpf_ops_write() function writes bitstream data to the FPGA by a smaller
> frames. Introduce mpf_spi_frame_write() function which is for writing a
> single data frame and use it in mpf_ops_write().
> 
> No functional changes intended.
> 
> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

> ---
>  drivers/fpga/microchip-spi.c | 36 +++++++++++++++++++++++-------------
>  1 file changed, 23 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
> index 995b1964e0fe..8a541986f6f2 100644
> --- a/drivers/fpga/microchip-spi.c
> +++ b/drivers/fpga/microchip-spi.c
> @@ -280,9 +280,30 @@ static int mpf_ops_write_init(struct fpga_manager *mgr,
>  	return 0;
>  }
>  
> +static int mpf_spi_frame_write(struct mpf_priv *priv, const char *buf)
> +{
> +	struct spi_transfer xfers[2] = {
> +		{
> +			.tx_buf = &priv->tx,
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
> +	priv->tx = MPF_SPI_FRAME;
> +
> +	return spi_sync_transfer(priv->spi, xfers, ARRAY_SIZE(xfers));
> +}
> +
>  static int mpf_ops_write(struct fpga_manager *mgr, const char *buf, size_t count)
>  {
> -	struct spi_transfer xfers[2] = { 0 };
>  	struct mpf_priv *priv = mgr->priv;
>  	struct device *dev = &mgr->dev;
>  	int ret, i;
> @@ -293,19 +314,8 @@ static int mpf_ops_write(struct fpga_manager *mgr, const char *buf, size_t count
>  		return -EINVAL;
>  	}
>  
> -	xfers[0].tx_buf = &priv->tx;
> -	xfers[0].len = 1;
> -
>  	for (i = 0; i < count / MPF_SPI_FRAME_SIZE; i++) {
> -		xfers[1].tx_buf = buf + i * MPF_SPI_FRAME_SIZE;
> -		xfers[1].len = MPF_SPI_FRAME_SIZE;
> -
> -		ret = mpf_poll_status(priv, 0);
> -		if (ret >= 0) {
> -			priv->tx = MPF_SPI_FRAME;
> -			ret = spi_sync_transfer(priv->spi, xfers, ARRAY_SIZE(xfers));
> -		}
> -
> +		ret = mpf_spi_frame_write(priv, buf + i * MPF_SPI_FRAME_SIZE);
>  		if (ret) {
>  			dev_err(dev, "Failed to write bitstream frame %d/%zu\n",
>  				i, count / MPF_SPI_FRAME_SIZE);
> -- 
> 2.39.0
> 
> 
