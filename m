Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728E2542755
	for <lists+linux-fpga@lfdr.de>; Wed,  8 Jun 2022 09:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiFHGzV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 8 Jun 2022 02:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347875AbiFHF6I (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 8 Jun 2022 01:58:08 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FBE1B781D;
        Tue,  7 Jun 2022 21:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654662310; x=1686198310;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7HhJfLtFr/RjjhFXAUcR5+dY7fCMgUryDbCuqE84jTs=;
  b=J3JGYRoT0cEzQQkEPrFs1eOGormoqsdy7MQCWEMlw2BzkihV0j64udVu
   ZNkFni26zeRg8NPgz1Nrd3FjNRN/pNTbxK1yV8yFSx2LScuDiAfNUCaPd
   aUEjBktHffFZ7FNBl7xMmVQjL9G9/D3aIOvoZ2Ys4PhaxAtm2OHRHbVql
   J6bvjPEnx93HzQBbQ3UJrhPQw+EPVc2C9JfrDfykA/vDbdRKXvNHNV+tV
   vI0QMV/fsECq6zyDxP9FCZTkxzW6n7guUG7/6f+KbYXZHAHkAXPA8vt6p
   GuR/RpN3zNYQjAY38PczL7R8xriSlyOxofvnnx4sgwC+1nxHHStN+ZAfi
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="277569589"
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="277569589"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 21:25:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="670339911"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Jun 2022 21:25:08 -0700
Date:   Wed, 8 Jun 2022 12:17:14 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     keliu <liuke94@huawei.com>
Cc:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: Directly use ida_alloc()/free()
Message-ID: <20220608041714.GA421343@yilunxu-OptiPlex-7050>
References: <20220527085915.2798928-1-liuke94@huawei.com>
 <20220528154355.GA183426@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220528154355.GA183426@yilunxu-OptiPlex-7050>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, May 28, 2022 at 11:43:55PM +0800, Xu Yilun wrote:
> On Fri, May 27, 2022 at 08:59:15AM +0000, keliu wrote:
> > Use ida_alloc()/ida_free() instead of deprecated
> > ida_simple_get()/ida_simple_remove() .
> > 
> > Signed-off-by: keliu <liuke94@huawei.com>
> 
> Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next.

Thanks,
Yilun

> 
> > ---
> >  drivers/fpga/dfl.c         | 4 ++--
> >  drivers/fpga/fpga-bridge.c | 6 +++---
> >  drivers/fpga/fpga-mgr.c    | 6 +++---
> >  drivers/fpga/fpga-region.c | 6 +++---
> >  4 files changed, 11 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> > index 599bb21d86af..2dff0c626cc6 100644
> > --- a/drivers/fpga/dfl.c
> > +++ b/drivers/fpga/dfl.c
> > @@ -342,7 +342,7 @@ static void release_dfl_dev(struct device *dev)
> >  	if (ddev->mmio_res.parent)
> >  		release_resource(&ddev->mmio_res);
> >  
> > -	ida_simple_remove(&dfl_device_ida, ddev->id);
> > +	ida_free(&dfl_device_ida, ddev->id);
> >  	kfree(ddev->irqs);
> >  	kfree(ddev);
> >  }
> > @@ -360,7 +360,7 @@ dfl_dev_add(struct dfl_feature_platform_data *pdata,
> >  	if (!ddev)
> >  		return ERR_PTR(-ENOMEM);
> >  
> > -	id = ida_simple_get(&dfl_device_ida, 0, 0, GFP_KERNEL);
> > +	id = ida_alloc(&dfl_device_ida, GFP_KERNEL);
> >  	if (id < 0) {
> >  		dev_err(&pdev->dev, "unable to get id\n");
> >  		kfree(ddev);
> > diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
> > index 16f2b164a178..727704431f61 100644
> > --- a/drivers/fpga/fpga-bridge.c
> > +++ b/drivers/fpga/fpga-bridge.c
> > @@ -342,7 +342,7 @@ fpga_bridge_register(struct device *parent, const char *name,
> >  	if (!bridge)
> >  		return ERR_PTR(-ENOMEM);
> >  
> > -	id = ida_simple_get(&fpga_bridge_ida, 0, 0, GFP_KERNEL);
> > +	id = ida_alloc(&fpga_bridge_ida, GFP_KERNEL);
> >  	if (id < 0) {
> >  		ret = id;
> >  		goto error_kfree;
> > @@ -375,7 +375,7 @@ fpga_bridge_register(struct device *parent, const char *name,
> >  	return bridge;
> >  
> >  error_device:
> > -	ida_simple_remove(&fpga_bridge_ida, id);
> > +	ida_free(&fpga_bridge_ida, id);
> >  error_kfree:
> >  	kfree(bridge);
> >  
> > @@ -407,7 +407,7 @@ static void fpga_bridge_dev_release(struct device *dev)
> >  {
> >  	struct fpga_bridge *bridge = to_fpga_bridge(dev);
> >  
> > -	ida_simple_remove(&fpga_bridge_ida, bridge->dev.id);
> > +	ida_free(&fpga_bridge_ida, bridge->dev.id);
> >  	kfree(bridge);
> >  }
> >  
> > diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> > index d49a9ce34568..2955a21beebe 100644
> > --- a/drivers/fpga/fpga-mgr.c
> > +++ b/drivers/fpga/fpga-mgr.c
> > @@ -622,7 +622,7 @@ fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *in
> >  	if (!mgr)
> >  		return ERR_PTR(-ENOMEM);
> >  
> > -	id = ida_simple_get(&fpga_mgr_ida, 0, 0, GFP_KERNEL);
> > +	id = ida_alloc(&fpga_mgr_ida, GFP_KERNEL);
> >  	if (id < 0) {
> >  		ret = id;
> >  		goto error_kfree;
> > @@ -661,7 +661,7 @@ fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *in
> >  	return mgr;
> >  
> >  error_device:
> > -	ida_simple_remove(&fpga_mgr_ida, id);
> > +	ida_free(&fpga_mgr_ida, id);
> >  error_kfree:
> >  	kfree(mgr);
> >  
> > @@ -785,7 +785,7 @@ static void fpga_mgr_dev_release(struct device *dev)
> >  {
> >  	struct fpga_manager *mgr = to_fpga_manager(dev);
> >  
> > -	ida_simple_remove(&fpga_mgr_ida, mgr->dev.id);
> > +	ida_free(&fpga_mgr_ida, mgr->dev.id);
> >  	kfree(mgr);
> >  }
> >  
> > diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> > index b0ac18de4885..18bcaa1926dd 100644
> > --- a/drivers/fpga/fpga-region.c
> > +++ b/drivers/fpga/fpga-region.c
> > @@ -202,7 +202,7 @@ fpga_region_register_full(struct device *parent, const struct fpga_region_info *
> >  	if (!region)
> >  		return ERR_PTR(-ENOMEM);
> >  
> > -	id = ida_simple_get(&fpga_region_ida, 0, 0, GFP_KERNEL);
> > +	id = ida_alloc(&fpga_region_ida, GFP_KERNEL);
> >  	if (id < 0) {
> >  		ret = id;
> >  		goto err_free;
> > @@ -234,7 +234,7 @@ fpga_region_register_full(struct device *parent, const struct fpga_region_info *
> >  	return region;
> >  
> >  err_remove:
> > -	ida_simple_remove(&fpga_region_ida, id);
> > +	ida_free(&fpga_region_ida, id);
> >  err_free:
> >  	kfree(region);
> >  
> > @@ -283,7 +283,7 @@ static void fpga_region_dev_release(struct device *dev)
> >  {
> >  	struct fpga_region *region = to_fpga_region(dev);
> >  
> > -	ida_simple_remove(&fpga_region_ida, region->dev.id);
> > +	ida_free(&fpga_region_ida, region->dev.id);
> >  	kfree(region);
> >  }
> >  
> > -- 
> > 2.25.1
