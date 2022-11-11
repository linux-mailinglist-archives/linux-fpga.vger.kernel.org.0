Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384956259DA
	for <lists+linux-fpga@lfdr.de>; Fri, 11 Nov 2022 12:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbiKKLts (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 11 Nov 2022 06:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbiKKLtq (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 11 Nov 2022 06:49:46 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82EB27FDB;
        Fri, 11 Nov 2022 03:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668167385; x=1699703385;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3WTKB0gRWInX7CZNTxACY+0jeVyHwA/nR2n3yesvK8c=;
  b=nlsHp3HeOE4q1qPnReH/CgEhjeZTp3Ip4fFj/BiahORs2nyF7VTAk5n0
   vGzedo7phJvl9/oNjoGakqRlQzJJVpJB0g4A2xUVGQ7bB8YallYlACT1x
   N+/kCY88bpWl4+P/CMdL27tAd8f5JoaiJ3tYHl9qF095UyXQqzeanQvpw
   +8Y5DL4B/T7i9ldKwwQDHhXD+K8ZBQFnYpf/GRNiLjjPwBhuw9voRUoHE
   QqKLqge3MCC3VDB7rKmU0XzztGCE5vgMOz9TumfNSMI1BtAEwnHsx7t9L
   FU7wRNqByh0ePycMT8p+hCGYdc1Ie9zamNHCeNP5uu/7C3ilUFsWdJjJ2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="397877451"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="397877451"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 03:49:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="706521314"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="706521314"
Received: from iglushko-mobl1.ger.corp.intel.com ([10.249.44.68])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 03:49:41 -0800
Date:   Fri, 11 Nov 2022 13:49:38 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Xu Yilun <yilun.xu@intel.com>
cc:     linux-fpga@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
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
In-Reply-To: <Y24gJ7fIsUPmhzY2@yilunxu-OptiPlex-7050>
Message-ID: <752a1dc-fae6-4431-41cf-a6deaf157ad3@linux.intel.com>
References: <20221108144305.45424-1-ilpo.jarvinen@linux.intel.com> <20221108144305.45424-3-ilpo.jarvinen@linux.intel.com> <Y24gJ7fIsUPmhzY2@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-512111020-1668167385=:1606"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-512111020-1668167385=:1606
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Fri, 11 Nov 2022, Xu Yilun wrote:

> On 2022-11-08 at 16:42:55 +0200, Ilpo Järvinen wrote:
> > BMC type specific info is currently set by a switch/case block. The
> > size of this info is expected to grow as more dev types and features
> > are added which would have made the switch block bloaty.
> > 
> > Store type specific info into struct and place them into .driver_data
> > instead because it makes things a bit cleaner.
> > 
> > Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  drivers/mfd/intel-m10-bmc.c       | 50 +++++++++++++++++--------------
> >  include/linux/mfd/intel-m10-bmc.h | 14 +++++++++
> >  2 files changed, 41 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
> > index ee167c5dcd29..762808906380 100644
> > --- a/drivers/mfd/intel-m10-bmc.c
> > +++ b/drivers/mfd/intel-m10-bmc.c
> > @@ -156,15 +156,17 @@ static int check_m10bmc_version(struct intel_m10bmc *ddata)
> >  static int intel_m10_bmc_spi_probe(struct spi_device *spi)
> >  {
> >  	const struct spi_device_id *id = spi_get_device_id(spi);
> > +	const struct intel_m10bmc_platform_info *info;
> >  	struct device *dev = &spi->dev;
> > -	struct mfd_cell *cells;
> >  	struct intel_m10bmc *ddata;
> > -	int ret, n_cell;
> > +	int ret;
> >  
> >  	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
> >  	if (!ddata)
> >  		return -ENOMEM;
> >  
> > +	info = (struct intel_m10bmc_platform_info *)id->driver_data;
> > +	ddata->info = info;
> 
> Where to use the ddata->info?

In patch 5/12 there are many these constructs:
const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;

Now that I look though, this particular line is altered by the split patch 
4/12 so it would be not strictly necessary to do it here. I'd prefer, 
however, still to add it here even if it's technically not used until 
after the split 5/12 patch because it very much logically belongs to this 
change.

> >  	ddata->dev = dev;
> >  
> >  	ddata->regmap =
> > @@ -183,24 +185,8 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
> >  		return ret;
> >  	}
> >  
> > -	switch (id->driver_data) {
> > -	case M10_N3000:
> > -		cells = m10bmc_pacn3000_subdevs;
> > -		n_cell = ARRAY_SIZE(m10bmc_pacn3000_subdevs);
> > -		break;
> > -	case M10_D5005:
> > -		cells = m10bmc_d5005_subdevs;
> > -		n_cell = ARRAY_SIZE(m10bmc_d5005_subdevs);
> > -		break;
> > -	case M10_N5010:
> > -		cells = m10bmc_n5010_subdevs;
> > -		n_cell = ARRAY_SIZE(m10bmc_n5010_subdevs);
> > -		break;
> > -	default:
> > -		return -ENODEV;
> > -	}
> > -
> > -	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, cells, n_cell,
> > +	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO,
> > +				   info->cells, info->n_cells,
> >  				   NULL, 0, NULL);
> >  	if (ret)
> >  		dev_err(dev, "Failed to register sub-devices: %d\n", ret);
> > @@ -208,10 +194,28 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
> >  	return ret;
> >  }
> >  
> > +static const struct intel_m10bmc_platform_info m10bmc_m10_n3000 = {
> > +	.type = M10_N3000,
> 
> Is the type enum still useful? Found no usage.

There's no use within context of this patch series. However, I think there 
might have been something depending on it in the changes that are not part 
of this series so I left it in place for now.

-- 
 i.


> > +	.cells = m10bmc_pacn3000_subdevs,
> > +	.n_cells = ARRAY_SIZE(m10bmc_pacn3000_subdevs),
> > +};
> > +
> > +static const struct intel_m10bmc_platform_info m10bmc_m10_d5005 = {
> > +	.type = M10_D5005,
> > +	.cells = m10bmc_d5005_subdevs,
> > +	.n_cells = ARRAY_SIZE(m10bmc_d5005_subdevs),
> > +};
> > +
> > +static const struct intel_m10bmc_platform_info m10bmc_m10_n5010 = {
> > +	.type = M10_N5010,
> > +	.cells = m10bmc_n5010_subdevs,
> > +	.n_cells = ARRAY_SIZE(m10bmc_n5010_subdevs),
> > +};
> > +
> >  static const struct spi_device_id m10bmc_spi_id[] = {
> > -	{ "m10-n3000", M10_N3000 },
> > -	{ "m10-d5005", M10_D5005 },
> > -	{ "m10-n5010", M10_N5010 },
> > +	{ "m10-n3000", (kernel_ulong_t)&m10bmc_m10_n3000 },
> > +	{ "m10-d5005", (kernel_ulong_t)&m10bmc_m10_d5005 },
> > +	{ "m10-n5010", (kernel_ulong_t)&m10bmc_m10_n5010 },
> >  	{ }
> >  };
> >  MODULE_DEVICE_TABLE(spi, m10bmc_spi_id);
> > diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
> > index d77383a8a410..e58115f514b9 100644
> > --- a/include/linux/mfd/intel-m10-bmc.h
> > +++ b/include/linux/mfd/intel-m10-bmc.h
> > @@ -124,14 +124,28 @@ enum m10bmc_type {
> >  /* Address of 4KB inverted bit vector containing staging area FLASH count */
> >  #define STAGING_FLASH_COUNT	0x17ffb000
> >  
> > +/**
> > + * struct intel_m10bmc_platform_info - Intel MAX 10 BMC platform specific information
> > + * @type: the type of MAX10 BMC
> > + * @cells: MFD cells
> > + * @n_cells: MFD cells ARRAY_SIZE()
> > + */
> > +struct intel_m10bmc_platform_info {
> > +	enum m10bmc_type type;
> > +	struct mfd_cell *cells;
> > +	int n_cells;
> > +};
> > +
> >  /**
> >   * struct intel_m10bmc - Intel MAX 10 BMC parent driver data structure
> >   * @dev: this device
> >   * @regmap: the regmap used to access registers by m10bmc itself
> > + * @info: the platform information for MAX10 BMC
> >   */
> >  struct intel_m10bmc {
> >  	struct device *dev;
> >  	struct regmap *regmap;
> > +	const struct intel_m10bmc_platform_info *info;
> >  };
> >  
> >  /*
> > -- 
> > 2.30.2
> > 
> 

--8323329-512111020-1668167385=:1606--
