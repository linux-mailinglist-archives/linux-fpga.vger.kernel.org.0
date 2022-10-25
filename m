Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5952160C4B1
	for <lists+linux-fpga@lfdr.de>; Tue, 25 Oct 2022 09:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbiJYHDs (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 25 Oct 2022 03:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiJYHDr (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 25 Oct 2022 03:03:47 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3650FB56C8;
        Tue, 25 Oct 2022 00:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666681426; x=1698217426;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IdGt3/sVdQCrkszY6V9UyvuqPthfUwGWvmfdyyXo7/w=;
  b=h7cq5Lmiaor1uh87PYbicyG2gOym1MNG0UME2FspV0/+aeU6FUe+eiYl
   GcI9nPfZNrAQc6Z7rex9aR/WcD/WsWAggrE8e/KiCMyfYjzLC/xhQ4Z0h
   LT6n6oROc8lCR0zGJTJUjmtlB8QJneUuTQ8jqQQUEonqq2wSAG0hrbUEr
   ns7W7o8qHwxx5voAvgXgXmtJ/5SqwPkITqgPCMP6sEq5xVoUGU2XnjsBf
   /K/UD6MdbZaPtSbREob4mSBwDSJ4B/Kceyb8NqWV7JyI3fG8Onlq1Ecgd
   diguoO9oC6/xJAbMfks88zN0bVXYTANbT1t2aKQHaST3pVznXeumD7wJb
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="288002177"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="288002177"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 00:03:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="626328772"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="626328772"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga007.jf.intel.com with ESMTP; 25 Oct 2022 00:03:42 -0700
Date:   Tue, 25 Oct 2022 14:54:38 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com, dg@emlix.com,
        j.zink@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, system@metrotek.ru
Subject: Re: [PATCH v20 1/2] fpga: lattice-sysconfig-spi: add Lattice
 sysCONFIG FPGA manager
Message-ID: <Y1eILk6ArO5OVzwW@yilunxu-OptiPlex-7050>
References: <20221025053947.2737-1-i.bornyakov@metrotek.ru>
 <20221025053947.2737-2-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025053947.2737-2-i.bornyakov@metrotek.ru>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-10-25 at 08:39:46 +0300, Ivan Bornyakov wrote:
> Add support to the FPGA manager for programming Lattice ECP5 FPGA over
> slave SPI sysCONFIG interface.
> 
> sysCONFIG interface core functionality is separate from both ECP5 and
> SPI specifics, so support for other FPGAs with different port types can
> be added in the future.
> 
> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>

[...]

> +static int sysconfig_spi_bitstream_burst_init(struct sysconfig_priv *priv)
> +{
> +	const u8 lsc_bitstream_burst[] = SYSCONFIG_LSC_BITSTREAM_BURST;
> +	struct spi_device *spi = to_spi_device(priv->dev);
> +	struct spi_transfer xfer = {};
> +	struct spi_message msg;
> +	size_t buf_len;
> +	void *buf;
> +	int ret;
> +
> +	buf_len = sizeof(lsc_bitstream_burst);
> +
> +	buf = kmemdup(lsc_bitstream_burst, buf_len, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +

I removed the second blank line and applied this series to for-next.

Thanks,
Yilun
