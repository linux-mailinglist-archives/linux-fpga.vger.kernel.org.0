Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93335511B9
	for <lists+linux-fpga@lfdr.de>; Mon, 20 Jun 2022 09:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238464AbiFTHm3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 20 Jun 2022 03:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237888AbiFTHm2 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 20 Jun 2022 03:42:28 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8A1FD15;
        Mon, 20 Jun 2022 00:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655710947; x=1687246947;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=afrJTMQEPzFgwJo2gc0m4jjaI4R+MO4SngaxX75mOmk=;
  b=d6urbr3QwU6tkkrTegj75ZyIe+KeMGd868XpFCZ42gf42mckXYv/xbB9
   hvgm9eMBJ4TiM4xolKsuKONnMXe1i8fS3OSXHlOuvoGZ67psD+lQEOQkP
   wes4Tc/ku5MEdvXQhn4DPTzawMuZ+ZTj2cH4smYzruimyBMkX+1wnH29u
   wMNfr5mSsbmTWu1XyN8rOho8l/kagy1LFcmYpKlfzZXdGXHzpWAcA6VUj
   5uEoVX2B7YzYEXLrK7PhM1O/GHeC8SE3NnbFoBCFoObz4f31ucVWUMSG2
   sh1jc2rhcXfVECMq/l2qiOVcMMem84wUhkFz6t31bQlBqH/E0SlCS9SdK
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="268548831"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="268548831"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 00:42:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="676419073"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Jun 2022 00:42:18 -0700
Date:   Mon, 20 Jun 2022 15:34:12 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     "Manne, Nava kishore" <nava.kishore.manne@amd.com>
Cc:     Nava kishore Manne <nava.manne@xilinx.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "hao.wu@intel.com" <hao.wu@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, git <git@xilinx.com>
Subject: Re: [PATCH v2 3/3] fpga: region: Add runtime PM support
Message-ID: <20220620073412.GA1319418@yilunxu-OptiPlex-7050>
References: <20220523134517.4056873-1-nava.manne@xilinx.com>
 <20220523134517.4056873-4-nava.manne@xilinx.com>
 <DM6PR12MB3993A1FF3517D99AC9A1C21CCDB09@DM6PR12MB3993.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR12MB3993A1FF3517D99AC9A1C21CCDB09@DM6PR12MB3993.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jun 20, 2022 at 05:38:13AM +0000, Manne, Nava kishore wrote:
> Ping!

Sorry I missed this one. Will try to catch up.

Thanks,
Yilun

> 
> > -----Original Message-----
> > From: Nava kishore Manne <nava.manne@xilinx.com>
> > Sent: Monday, May 23, 2022 7:15 PM
> > To: mdf@kernel.org; hao.wu@intel.com; yilun.xu@intel.com;
> > trix@redhat.com; robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > Michal Simek <michals@xilinx.com>; Nava kishore Manne
> > <navam@xilinx.com>; linux-fpga@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; git <git@xilinx.com>
> > Subject: [PATCH v2 3/3] fpga: region: Add runtime PM support
> > 
> > Add support to handle FPGA/PL power domain. With this patch, the PL
> > power domain will be turned on before loading the bitstream into the
> > targeted region and turned off while removing/unloading the bitstream from
> > the targeted region using overlays. This can be achieved by adding the
> > runtime PM support to the fpga regions.
> > 
> > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > ---
> > Changes for v2:
> >               - Updated commit message.
> >               - Updated runtime PM handling logic to fix the PM ref count
> >                 imbalance issues.
> > 
> >  drivers/fpga/of-fpga-region.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
> > index ae82532fc127..f14bb5916d97 100644
> > --- a/drivers/fpga/of-fpga-region.c
> > +++ b/drivers/fpga/of-fpga-region.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/of_platform.h>
> >  #include <linux/slab.h>
> >  #include <linux/spinlock.h>
> > +#include <linux/pm_runtime.h>
> > 
> >  static const struct of_device_id fpga_region_of_match[] = {
> >  	{ .compatible = "fpga-region", },
> > @@ -301,10 +302,17 @@ static int of_fpga_region_notify_pre_apply(struct
> > fpga_region *region,
> >  		return -EINVAL;
> >  	}
> > 
> > +	ret = pm_runtime_resume_and_get(dev->parent);
> > +	if (ret < 0) {
> > +		fpga_image_info_free(info);
> > +		return ret;
> > +	}
> > +
> >  	region->info = info;
> >  	ret = fpga_region_program_fpga(region);
> >  	if (ret) {
> >  		/* error; reject overlay */
> > +		pm_runtime_put_sync(dev->parent);
> >  		fpga_image_info_free(info);
> >  		region->info = NULL;
> >  	}
> > @@ -324,10 +332,13 @@ static int of_fpga_region_notify_pre_apply(struct
> > fpga_region *region,  static void of_fpga_region_notify_post_remove(struct
> > fpga_region *region,
> >  					      struct of_overlay_notify_data
> > *nd)  {
> > +	struct device *dev = &region->dev;
> > +
> >  	fpga_bridges_disable(&region->bridge_list);
> >  	fpga_bridges_put(&region->bridge_list);
> >  	fpga_image_info_free(region->info);
> >  	region->info = NULL;
> > +	pm_runtime_put_sync(dev->parent);
> >  }
> > 
> >  /**
> > @@ -411,6 +422,8 @@ static int of_fpga_region_probe(struct
> > platform_device *pdev)
> >  		goto eprobe_mgr_put;
> >  	}
> > 
> > +	pm_runtime_enable(&pdev->dev);
> > +
> >  	of_platform_populate(np, fpga_region_of_match, NULL, &region-
> > >dev);
> >  	platform_set_drvdata(pdev, region);
> > 
> > @@ -430,6 +443,7 @@ static int of_fpga_region_remove(struct
> > platform_device *pdev)
> > 
> >  	fpga_region_unregister(region);
> >  	fpga_mgr_put(mgr);
> > +	pm_runtime_disable(region->dev.parent);
> > 
> >  	return 0;
> >  }
> > --
> > 2.25.1
