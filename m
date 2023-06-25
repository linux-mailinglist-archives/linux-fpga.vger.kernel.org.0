Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3B773CF71
	for <lists+linux-fpga@lfdr.de>; Sun, 25 Jun 2023 10:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjFYIke (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 25 Jun 2023 04:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbjFYIk2 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 25 Jun 2023 04:40:28 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31567E79;
        Sun, 25 Jun 2023 01:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687682427; x=1719218427;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cRVFCF4mtNPdsbtTnxitA36EVp3W2SMrxezjERCImME=;
  b=GZzZe2ZJ4bBf0M3FXktEr1bTiUi41r+tt2YBblzHqtdxxsqRWSjd86cK
   HkA25UgRVNMnNTLXLLRd+8bTJTEcyoK3ZPr3k0yxpJlnuOFH/9TBpBhu8
   q7rVA8QTSVNIxIlMIbh9BooizTUrJ0xxkt6iDHiLUNkE6UWvJc/08Ot5X
   3uudfRE7UknfhLusZj5WdT9XFphurmg8xhlRQBFZUyt98NElf5j4G2wxw
   StlMlk08VJqjjBHX08p2M610AFsWNcRNB/CLkcwomufLo4bsESafR2mue
   hOXRCY+x5+ulFJdAicoHA8US9vzBh5/hI14HtXtS9AwCJh7PfaMZy08Nx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="364489985"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="364489985"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 01:40:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="781065373"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="781065373"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga008.fm.intel.com with ESMTP; 25 Jun 2023 01:40:24 -0700
Date:   Sun, 25 Jun 2023 16:39:17 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     "Manne, Nava kishore" <nava.kishore.manne@amd.com>
Cc:     "mdf@kernel.org" <mdf@kernel.org>,
        "hao.wu@intel.com" <hao.wu@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
Subject: Re: [RFC PATCH] fpga: fpga-bridge: Add manual set option via sysfs
Message-ID: <ZJf9NSGaNkrXJUCe@yilunxu-OptiPlex-7050>
References: <20230525095438.2766625-1-nava.kishore.manne@amd.com>
 <DM6PR12MB3993C315D875CE44CA1A0B29CD5DA@DM6PR12MB3993.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR12MB3993C315D875CE44CA1A0B29CD5DA@DM6PR12MB3993.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-06-21 at 04:00:53 +0000, Manne, Nava kishore wrote:
> Ping!
> 
> > -----Original Message-----
> > From: Manne, Nava kishore <nava.kishore.manne@amd.com>
> > Sent: Thursday, May 25, 2023 3:25 PM
> > To: mdf@kernel.org; hao.wu@intel.com; yilun.xu@intel.com;
> > trix@redhat.com; Manne, Nava kishore <nava.kishore.manne@amd.com>;
> > linux-kernel@vger.kernel.org; linux-fpga@vger.kernel.org
> > Subject: [RFC PATCH] fpga: fpga-bridge: Add manual set option via sysfs
> > 
> > This patch is intended for manual testing only.

Debug interfaces should be in debugfs. But before that, I'm not
convinced why we need this interface. Even with DEBUG or debugfs we try
best not to break the system. But this bridge enable/disable interface
will break the functionality of FPGA region silently.

Thanks
Yilun

> > It is provide an option to manually test bridges.
> > 
> > Enabling bridge (!0 values are handled)
> > br1# echo 1 > /sys/class/fpga_bridge/<bridge>/set
> > 
> > Disable bridge
> > br1# echo 0 > /sys/class/fpga_bridge/<bridge>/set
> > 
> > Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> > ---
> >  .../ABI/testing/sysfs-class-fpga-bridge       |  9 ++++++
> >  drivers/fpga/fpga-bridge.c                    | 30 +++++++++++++++++++
> >  2 files changed, 39 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-class-fpga-bridge
> > b/Documentation/ABI/testing/sysfs-class-fpga-bridge
> > index 312ae2c579d8..e157eb737bfb 100644
> > --- a/Documentation/ABI/testing/sysfs-class-fpga-bridge
> > +++ b/Documentation/ABI/testing/sysfs-class-fpga-bridge
> > @@ -9,3 +9,12 @@ Date:		January 2016
> >  KernelVersion:	4.5
> >  Contact:	Alan Tull <atull@opensource.altera.com>
> >  Description:	Show bridge state as "enabled" or "disabled"
> > +
> > +What:		/sys/class/fpga_bridge/<bridge>/set
> > +Date:		May 2023
> > +KernelVersion:	6.4
> > +Contact:	Nava kishore Manne <nava.kishore.manne@amd.com>
> > +Description:	Manual set bridge state (0-disable, !0 enable).
> > +		Enabling this option requires that the module is
> > +		compiled with #define DEBUG which is enabled by default
> > +		when CONFIG_DEBUG_KERNEL is setup.
> > diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c index
> > a6c25dee9cc1..54d15b709b10 100644
> > --- a/drivers/fpga/fpga-bridge.c
> > +++ b/drivers/fpga/fpga-bridge.c
> > @@ -13,6 +13,12 @@
> >  #include <linux/slab.h>
> >  #include <linux/spinlock.h>
> > 
> > +/* For enabling manual bridge set(enable/disable) function */ #ifdef
> > +CONFIG_DEBUG_KERNEL #undef DEBUG #define DEBUG #endif
> > +
> >  static DEFINE_IDA(fpga_bridge_ida);
> >  static struct class *fpga_bridge_class;
> > 
> > @@ -307,9 +313,33 @@ static ssize_t state_show(struct device *dev,  static
> > DEVICE_ATTR_RO(name);  static DEVICE_ATTR_RO(state);
> > 
> > +#ifdef DEBUG
> > +static ssize_t set_store(struct device *dev,
> > +			 struct device_attribute *attr,
> > +			 const char *buf, size_t count)
> > +{
> > +	struct fpga_bridge *bridge = to_fpga_bridge(dev);
> > +	long enable;
> > +	int ret;
> > +
> > +	ret = kstrtol(buf, 16, &enable);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (bridge->br_ops && bridge->br_ops->enable_set)
> > +		enable = bridge->br_ops->enable_set(bridge, !!enable);
> > +
> > +	return count;
> > +}
> > +static DEVICE_ATTR_WO(set);
> > +#endif
> > +
> >  static struct attribute *fpga_bridge_attrs[] = {
> >  	&dev_attr_name.attr,
> >  	&dev_attr_state.attr,
> > +#ifdef DEBUG
> > +	&dev_attr_set.attr,
> > +#endif
> >  	NULL,
> >  };
> >  ATTRIBUTE_GROUPS(fpga_bridge);
> > --
> > 2.25.1
> 
