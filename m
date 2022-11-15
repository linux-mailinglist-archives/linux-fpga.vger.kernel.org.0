Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDEB9628FBC
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Nov 2022 03:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiKOCFH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Nov 2022 21:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbiKOCFG (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Nov 2022 21:05:06 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DFB1181E;
        Mon, 14 Nov 2022 18:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668477905; x=1700013905;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=zBTPI59Z1Wg7KdrzSEDraD/WWdbBNLSCrf8ib4MKfPQ=;
  b=LCTemBs/CwkZzBUpzfe3f/W66fj4Dmx28HheXFPLraHiUSkU5T4X/edd
   u0HrCLuS3tvamvN4UI6TBvHItfyYErbRu3BmuTQBdAf7RPCAj8Fz/wUP+
   9/LXGmGLa7YuzHWbNlpmE27dxl9lzPg4asD2wnFhTpb16KV8sgQxyObT+
   fdTLe11AHQUwOjZeTWfpUpR9TZ28jthOqj51OpMzPvLyI9StgjpdyNCvi
   MLZg/v7+EPeagH85jzoZYUSIg2Mfl2y6rYqaWwbTE4NzEJ+vLt1v98haw
   VnuYgW+NSX1ZJ/pEMbrwmjxv/6lIkHTBEkjs+MK4t3tio2gb5xPu38Zk4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="374267287"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="374267287"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 18:05:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="967805419"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="967805419"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga005.fm.intel.com with ESMTP; 14 Nov 2022 18:05:01 -0800
Date:   Tue, 15 Nov 2022 09:55:37 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-fpga@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/12] mfd: intel-m10-bmc: Create m10bmc_platform_info
 for type specific info
Message-ID: <Y3LxmUpqycBoZctF@yilunxu-OptiPlex-7050>
References: <20221108144305.45424-1-ilpo.jarvinen@linux.intel.com>
 <20221108144305.45424-3-ilpo.jarvinen@linux.intel.com>
 <Y24gJ7fIsUPmhzY2@yilunxu-OptiPlex-7050>
 <752a1dc-fae6-4431-41cf-a6deaf157ad3@linux.intel.com>
 <Y3Gg29pGm4DwjOgI@yilunxu-OptiPlex-7050>
 <30c62175-e96f-3911-8176-cac3d4928eb5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30c62175-e96f-3911-8176-cac3d4928eb5@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-11-14 at 17:17:06 -0800, Russ Weight wrote:
> 
> 
> On 11/13/22 17:58, Xu Yilun wrote:
> > On 2022-11-11 at 13:49:38 +0200, Ilpo Järvinen wrote:
> >> On Fri, 11 Nov 2022, Xu Yilun wrote:
> >>
> >>> On 2022-11-08 at 16:42:55 +0200, Ilpo Järvinen wrote:
> >>>> BMC type specific info is currently set by a switch/case block. The
> >>>> size of this info is expected to grow as more dev types and features
> >>>> are added which would have made the switch block bloaty.
> >>>>
> >>>> Store type specific info into struct and place them into .driver_data
> >>>> instead because it makes things a bit cleaner.
> >>>>
> >>>> Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> >>>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> >>>> ---
> >>>>  drivers/mfd/intel-m10-bmc.c       | 50 +++++++++++++++++--------------
> >>>>  include/linux/mfd/intel-m10-bmc.h | 14 +++++++++
> >>>>  2 files changed, 41 insertions(+), 23 deletions(-)
> >>>>
> >>>> diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
> >>>> index ee167c5dcd29..762808906380 100644
> >>>> --- a/drivers/mfd/intel-m10-bmc.c
> >>>> +++ b/drivers/mfd/intel-m10-bmc.c
> >>>> @@ -156,15 +156,17 @@ static int check_m10bmc_version(struct intel_m10bmc *ddata)
> >>>>  static int intel_m10_bmc_spi_probe(struct spi_device *spi)
> >>>>  {
> >>>>  	const struct spi_device_id *id = spi_get_device_id(spi);
> >>>> +	const struct intel_m10bmc_platform_info *info;
> >>>>  	struct device *dev = &spi->dev;
> >>>> -	struct mfd_cell *cells;
> >>>>  	struct intel_m10bmc *ddata;
> >>>> -	int ret, n_cell;
> >>>> +	int ret;
> >>>>  
> >>>>  	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
> >>>>  	if (!ddata)
> >>>>  		return -ENOMEM;
> >>>>  
> >>>> +	info = (struct intel_m10bmc_platform_info *)id->driver_data;
> >>>> +	ddata->info = info;
> >>> Where to use the ddata->info?
> >> In patch 5/12 there are many these constructs:
> >> const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
> >>
> >> Now that I look though, this particular line is altered by the split patch 
> >> 4/12 so it would be not strictly necessary to do it here. I'd prefer, 
> >> however, still to add it here even if it's technically not used until 
> >> after the split 5/12 patch because it very much logically belongs to this 
> >> change.
> > It's good to me.
> >
> >>>>  	ddata->dev = dev;
> >>>>  
> >>>>  	ddata->regmap =
> >>>> @@ -183,24 +185,8 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
> >>>>  		return ret;
> >>>>  	}
> >>>>  
> >>>> -	switch (id->driver_data) {
> >>>> -	case M10_N3000:
> >>>> -		cells = m10bmc_pacn3000_subdevs;
> >>>> -		n_cell = ARRAY_SIZE(m10bmc_pacn3000_subdevs);
> >>>> -		break;
> >>>> -	case M10_D5005:
> >>>> -		cells = m10bmc_d5005_subdevs;
> >>>> -		n_cell = ARRAY_SIZE(m10bmc_d5005_subdevs);
> >>>> -		break;
> >>>> -	case M10_N5010:
> >>>> -		cells = m10bmc_n5010_subdevs;
> >>>> -		n_cell = ARRAY_SIZE(m10bmc_n5010_subdevs);
> >>>> -		break;
> >>>> -	default:
> >>>> -		return -ENODEV;
> >>>> -	}
> >>>> -
> >>>> -	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, cells, n_cell,
> >>>> +	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO,
> >>>> +				   info->cells, info->n_cells,
> >>>>  				   NULL, 0, NULL);
> >>>>  	if (ret)
> >>>>  		dev_err(dev, "Failed to register sub-devices: %d\n", ret);
> >>>> @@ -208,10 +194,28 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
> >>>>  	return ret;
> >>>>  }
> >>>>  
> >>>> +static const struct intel_m10bmc_platform_info m10bmc_m10_n3000 = {
> >>>> +	.type = M10_N3000,
> >>> Is the type enum still useful? Found no usage.
> >> There's no use within context of this patch series. However, I think there 
> >> might have been something depending on it in the changes that are not part 
> >> of this series so I left it in place for now.
> > I'm not sure how it would be used later. This patch is to eliminate the
> > "switch (board type) case" block, but similar code is still to be added
> > later?
> 
> Unfortunately, these will be needed later. Consider the following (future)
> function that has to account for a field that was moved from one register
> to another:
> 
>     static int
>     m10bmc_sec_status(struct m10bmc_sec *sec, u32 *status)
>     {
>             u32 reg_offset, reg_value;
>             int ret;
> 
>             reg_offset = (sec->type == N6000BMC_SEC) ?
>                     auth_result_reg(sec->m10bmc) : doorbell_reg(sec->m10bmc);
> 
>             ret = m10bmc_sys_read(sec->m10bmc, reg_offset, &reg_value);
>             if (ret)
>                     return ret;
> 
>             *status = rsu_stat(reg_value);
> 
>             return 0;
>     }
> 
> With this patch-set, most conditionals are removed, but there will still
> be some cases where it is needed. If you prefer, we could wait and add

Why this condition can't be handled in the same manner? I actually hope
all board type difference been handled in the same way, either by the
core mfd driver or each subdev driver, but not a mix of the two.

Thanks,
Yilun

> the type in when we are ready to use it.
> 
> - Russ
> 
> >
> > Thanks,
> > Yilun
> 
