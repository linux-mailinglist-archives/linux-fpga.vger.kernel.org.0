Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8ADE627472
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Nov 2022 03:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbiKNCIV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 13 Nov 2022 21:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiKNCIV (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 13 Nov 2022 21:08:21 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDEAE00B;
        Sun, 13 Nov 2022 18:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668391700; x=1699927700;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=NKqfqlFULkV8Q2z4VRHX+tuirm9OvbwAxEukolp0ARU=;
  b=kqNqfXo19VCPZJRNbzF0s2nVgZAw10WsiJIZ1AP2awyIQ5WqAYsECEBv
   ov3wBs/XzY1AbWLZ6pfpuDosD+6tJjUybU0xYQArCCpPpXG/f9EZxrnvs
   QPdMb4q6ZKvtoxxoPnw0vCfSLezRufb9bB2lqVpo7mvrntYcnH/VRYFXh
   lDt9w6SRNHoINQyCRDmEyC0bFGmDRqY80F3LXI+TpLskPaNAAA+XZhksl
   OKjNpOccqJxXDrDInfVoTGoa3w7jHZHODAYdjzR9Plp+k9t+z7owDkEEZ
   6vp/7wb1tJtIWiWhI5v7RX3Fcqr3I5ibpx5hGllERunUbGZtb5OFrRy3h
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="338645836"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="338645836"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2022 18:08:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="671380952"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="671380952"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga001.jf.intel.com with ESMTP; 13 Nov 2022 18:08:14 -0800
Date:   Mon, 14 Nov 2022 09:58:51 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-fpga@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/12] mfd: intel-m10-bmc: Create m10bmc_platform_info
 for type specific info
Message-ID: <Y3Gg29pGm4DwjOgI@yilunxu-OptiPlex-7050>
References: <20221108144305.45424-1-ilpo.jarvinen@linux.intel.com>
 <20221108144305.45424-3-ilpo.jarvinen@linux.intel.com>
 <Y24gJ7fIsUPmhzY2@yilunxu-OptiPlex-7050>
 <752a1dc-fae6-4431-41cf-a6deaf157ad3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <752a1dc-fae6-4431-41cf-a6deaf157ad3@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-11-11 at 13:49:38 +0200, Ilpo Järvinen wrote:
> On Fri, 11 Nov 2022, Xu Yilun wrote:
> 
> > On 2022-11-08 at 16:42:55 +0200, Ilpo Järvinen wrote:
> > > BMC type specific info is currently set by a switch/case block. The
> > > size of this info is expected to grow as more dev types and features
> > > are added which would have made the switch block bloaty.
> > > 
> > > Store type specific info into struct and place them into .driver_data
> > > instead because it makes things a bit cleaner.
> > > 
> > > Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> > > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > ---
> > >  drivers/mfd/intel-m10-bmc.c       | 50 +++++++++++++++++--------------
> > >  include/linux/mfd/intel-m10-bmc.h | 14 +++++++++
> > >  2 files changed, 41 insertions(+), 23 deletions(-)
> > > 
> > > diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
> > > index ee167c5dcd29..762808906380 100644
> > > --- a/drivers/mfd/intel-m10-bmc.c
> > > +++ b/drivers/mfd/intel-m10-bmc.c
> > > @@ -156,15 +156,17 @@ static int check_m10bmc_version(struct intel_m10bmc *ddata)
> > >  static int intel_m10_bmc_spi_probe(struct spi_device *spi)
> > >  {
> > >  	const struct spi_device_id *id = spi_get_device_id(spi);
> > > +	const struct intel_m10bmc_platform_info *info;
> > >  	struct device *dev = &spi->dev;
> > > -	struct mfd_cell *cells;
> > >  	struct intel_m10bmc *ddata;
> > > -	int ret, n_cell;
> > > +	int ret;
> > >  
> > >  	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
> > >  	if (!ddata)
> > >  		return -ENOMEM;
> > >  
> > > +	info = (struct intel_m10bmc_platform_info *)id->driver_data;
> > > +	ddata->info = info;
> > 
> > Where to use the ddata->info?
> 
> In patch 5/12 there are many these constructs:
> const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
> 
> Now that I look though, this particular line is altered by the split patch 
> 4/12 so it would be not strictly necessary to do it here. I'd prefer, 
> however, still to add it here even if it's technically not used until 
> after the split 5/12 patch because it very much logically belongs to this 
> change.

It's good to me.

> 
> > >  	ddata->dev = dev;
> > >  
> > >  	ddata->regmap =
> > > @@ -183,24 +185,8 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
> > >  		return ret;
> > >  	}
> > >  
> > > -	switch (id->driver_data) {
> > > -	case M10_N3000:
> > > -		cells = m10bmc_pacn3000_subdevs;
> > > -		n_cell = ARRAY_SIZE(m10bmc_pacn3000_subdevs);
> > > -		break;
> > > -	case M10_D5005:
> > > -		cells = m10bmc_d5005_subdevs;
> > > -		n_cell = ARRAY_SIZE(m10bmc_d5005_subdevs);
> > > -		break;
> > > -	case M10_N5010:
> > > -		cells = m10bmc_n5010_subdevs;
> > > -		n_cell = ARRAY_SIZE(m10bmc_n5010_subdevs);
> > > -		break;
> > > -	default:
> > > -		return -ENODEV;
> > > -	}
> > > -
> > > -	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, cells, n_cell,
> > > +	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO,
> > > +				   info->cells, info->n_cells,
> > >  				   NULL, 0, NULL);
> > >  	if (ret)
> > >  		dev_err(dev, "Failed to register sub-devices: %d\n", ret);
> > > @@ -208,10 +194,28 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
> > >  	return ret;
> > >  }
> > >  
> > > +static const struct intel_m10bmc_platform_info m10bmc_m10_n3000 = {
> > > +	.type = M10_N3000,
> > 
> > Is the type enum still useful? Found no usage.
> 
> There's no use within context of this patch series. However, I think there 
> might have been something depending on it in the changes that are not part 
> of this series so I left it in place for now.

I'm not sure how it would be used later. This patch is to eliminate the
"switch (board type) case" block, but similar code is still to be added
later?

Thanks,
Yilun
