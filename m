Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FAE5E75A7
	for <lists+linux-fpga@lfdr.de>; Fri, 23 Sep 2022 10:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiIWIXj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 23 Sep 2022 04:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiIWIXg (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 23 Sep 2022 04:23:36 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3950D11E5C5;
        Fri, 23 Sep 2022 01:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663921415; x=1695457415;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8wjyemK5gwgei+mgv8kiIJRrmNDzkRo2TJsHSll3itM=;
  b=HB1VXrb+1cEjGyHVRjIBnBcFPHIHOOZIMtXkqek6G5OOaUx9t/76crnT
   Pwrr5sTH4PGjOH7UJNvVKoqew+gUg+s8gGhK5sBdBg/NgTwCKgH8dHiQ8
   XbI6fkEuzHSq49JxPTwbrZVZhrJH3iUn3eGr7AsnXgq9bLaCch9Ty/Atp
   +Zt2ORjaffkAp5JgEgzzQ91ZDSIn2D1QAeSjxl8eLlmf7by4zAmCPelTN
   3BeXuKOMTVX5ZX4mzYge3b0Leg5F2YH6Phzv7aoO3c37ZDBkO77sRGb0E
   /wamhJ2PnjHM1ADf3m+/UE8EZHdw3u6mF6p+b3SVfeGijM6VLGyeqP13F
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="287658149"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="287658149"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 01:23:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="650871383"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga008.jf.intel.com with ESMTP; 23 Sep 2022 01:23:31 -0700
Date:   Fri, 23 Sep 2022 16:14:49 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com, dg@emlix.com,
        j.zink@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, system@metrotek.ru
Subject: Re: [PATCH v12 1/2] fpga: lattice-sysconfig-spi: add Lattice
 sysCONFIG FPGA manager
Message-ID: <Yy1q+XYOBlMzlrg6@yilunxu-OptiPlex-7050>
References: <20220919134750.25197-1-i.bornyakov@metrotek.ru>
 <20220919134750.25197-2-i.bornyakov@metrotek.ru>
 <Yy1RLvxTJhGUuJJ2@yilunxu-OptiPlex-7050>
 <20220923071638.45hylqvajn74j6mk@h-e2.ddg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923071638.45hylqvajn74j6mk@h-e2.ddg>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-09-23 at 10:16:38 +0300, Ivan Bornyakov wrote:
> On Fri, Sep 23, 2022 at 02:24:46PM +0800, Xu Yilun wrote:
> > On 2022-09-19 at 16:47:49 +0300, Ivan Bornyakov wrote:
> > > Add support to the FPGA manager for programming Lattice ECP5 FPGA over
> > > slave SPI sysCONFIG interface.
> > > 
> > > sysCONFIG interface core functionality is separate from both ECP5 and
> > > SPI specifics, so support for other FPGAs with different port types can
> > > be added in the future.
> > > 
> > > Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> > > ---
> > >  drivers/fpga/Kconfig                 |  11 +
> > >  drivers/fpga/Makefile                |   2 +
> > >  drivers/fpga/lattice-sysconfig-spi.c | 153 ++++++++++
> > >  drivers/fpga/lattice-sysconfig.c     | 408 +++++++++++++++++++++++++++
> > >  drivers/fpga/lattice-sysconfig.h     |  40 +++
> > >  5 files changed, 614 insertions(+)
> > >  create mode 100644 drivers/fpga/lattice-sysconfig-spi.c
> > >  create mode 100644 drivers/fpga/lattice-sysconfig.c
> > >  create mode 100644 drivers/fpga/lattice-sysconfig.h
> > > 
> > > diff --git a/drivers/fpga/lattice-sysconfig-spi.c b/drivers/fpga/lattice-sysconfig-spi.c
> > > new file mode 100644
> > > index 000000000000..d015b796adf7
> > > --- /dev/null
> > > +++ b/drivers/fpga/lattice-sysconfig-spi.c
> > > 
> > > ... snip ...
> > > 
> > > +static int sysconfig_isc_enable(struct sysconfig_priv *priv)
> > > +{
> > > +	u8 isc_enable[] = SYSCONFIG_ISC_ENABLE;
> > > +	u32 status;
> > > +	int ret;
> > > +
> > > +	ret = sysconfig_cmd_write(priv, isc_enable, sizeof(isc_enable));
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = sysconfig_poll_status(priv, &status);
> > > +	if (ret || (status & SYSCONFIG_STATUS_FAIL))
> > > +		return ret ? : -EFAULT;
> > 
> > If (ret == 0 && status == SYSCONFIG_STATUS_FAIL), still return 0?
> > 
> 
> No, -EFAULT should be returned in that case. Am I overlooked something?

My mistake, it's good.

Thanks,
Yilun

> 
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int sysconfig_isc_erase(struct sysconfig_priv *priv)
> > > +{
> > > +	u8 isc_erase[] = SYSCONFIG_ISC_ERASE;
> > > +	u32 status;
> > > +	int ret;
> > > +
> > > +	ret = sysconfig_cmd_write(priv, isc_erase, sizeof(isc_erase));
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = sysconfig_poll_status(priv, &status);
> > > +	if (ret || (status & SYSCONFIG_STATUS_FAIL))
> > 
> > Same concern.
> > 
> > > +		return ret ? : -EFAULT;
> > > +
> > > +	return 0;
> > > +}
> 
