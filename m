Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0737360C254
	for <lists+linux-fpga@lfdr.de>; Tue, 25 Oct 2022 05:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiJYDnq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 24 Oct 2022 23:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiJYDnq (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 24 Oct 2022 23:43:46 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C38510C4E2;
        Mon, 24 Oct 2022 20:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666669425; x=1698205425;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MHvKxeNndGHz3FlXa05Nzdv5fq4aMqS678E2a8lqyi0=;
  b=Y0zeatbekMEtoTc7P8znMv7Wq3wRef4CHvu7aLbdhq5H7JukuJp6PK1Z
   litnVl7QVuMbsixxmvZdC04XDRHLlkaE7zTseNLtNtObUH7jwXKrOQ/28
   fW5SS181eZAevo8nzG8NzwuDQXDdcn4ltLcLrQJZt8JF63f49mFWOkl5C
   OOaRDSVyPmuO3FYfFIxYgG0iJ8l+xSCo0lWjSAWoc2V3rK2A2/7nWlNC5
   vD7G4cefL7QPvlbZcIhVPgEjk4YCAT0ODTUdS7wQuRUvlAvWsnFkyWjFv
   Q4y9OPzkImAKCCODkE/tN7jzup9o7tcpBZLNdpPUmqR1312/Dk0acFYFD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="369648150"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="369648150"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 20:43:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="876659766"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="876659766"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga006.fm.intel.com with ESMTP; 24 Oct 2022 20:43:42 -0700
Date:   Tue, 25 Oct 2022 11:34:39 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com, dg@emlix.com,
        j.zink@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, system@metrotek.ru
Subject: Re: [PATCH v19 1/2] fpga: lattice-sysconfig-spi: add Lattice
 sysCONFIG FPGA manager
Message-ID: <Y1dZT5Ta7AcMKeH5@yilunxu-OptiPlex-7050>
References: <20221019091015.22678-1-i.bornyakov@metrotek.ru>
 <20221019091015.22678-2-i.bornyakov@metrotek.ru>
 <Y1Cp3UV7cyFR5KQ4@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1Cp3UV7cyFR5KQ4@yilunxu-OptiPlex-7050>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-10-20 at 09:52:29 +0800, Xu Yilun wrote:
> On 2022-10-19 at 12:10:14 +0300, Ivan Bornyakov wrote:
> > Add support to the FPGA manager for programming Lattice ECP5 FPGA over
> > slave SPI sysCONFIG interface.
> > 
> > sysCONFIG interface core functionality is separate from both ECP5 and
> > SPI specifics, so support for other FPGAs with different port types can
> > be added in the future.
> > 
> > Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>

[...]
 
> > +static int sysconfig_spi_bitstream_burst_init(struct sysconfig_priv *priv)
> > +{
> > +	const u8 lsc_bitstream_burst[] = SYSCONFIG_LSC_BITSTREAM_BURST;
> > +	struct spi_device *spi = to_spi_device(priv->dev);
> > +	struct spi_transfer xfer = {};
> > +	struct spi_message msg;
> > +	size_t buf_len;
> > +	void *buf;
> > +	int ret;
> > +
> > +	buf_len = sizeof(lsc_bitstream_burst);
> > +
> > +	buf = kmalloc(buf_len, GFP_KERNEL);
> > +	if (!buf)
> > +		return -ENOMEM;
> > +
> > +	memcpy(buf, lsc_bitstream_burst, buf_len);

Could you help fix this lkp issue and I could re-apply the patch?

  config: arm-randconfig-c034-20221024 (attached as .config)
  compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0

  If you fix the issue, kindly add following tag where applicable
  | Reported-by: kernel test robot <lkp@intel.com>

  cocci warnings: (new ones prefixed by >>)
  >> drivers/fpga/lattice-sysconfig-spi.c:33:7-14: WARNING opportunity for kmemdup


Thanks,
Yilun
