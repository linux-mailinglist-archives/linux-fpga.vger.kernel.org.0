Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA39B26EA73
	for <lists+linux-fpga@lfdr.de>; Fri, 18 Sep 2020 03:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbgIRB2h (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 17 Sep 2020 21:28:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:31387 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbgIRB2h (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 17 Sep 2020 21:28:37 -0400
IronPort-SDR: bENhyfamvJAALxABDCmkJ28Tl6aADDH08k6vGAbJMWRQSKrX7YNfyF81or0lUqM1s06Vf5kNKI
 +vvB72D1/oBA==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="177926061"
X-IronPort-AV: E=Sophos;i="5.77,273,1596524400"; 
   d="scan'208";a="177926061"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 18:28:27 -0700
IronPort-SDR: hbfJtyZL8si0WExW5zdNVpNj2DyDYa6EOcoDY9ZAxiYGuIhE2+QY+gfaisjNBM/7oc1f1Q5KpK
 eA0NhXiIVZPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,273,1596524400"; 
   d="scan'208";a="483981100"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga005.jf.intel.com with ESMTP; 17 Sep 2020 18:28:24 -0700
Date:   Fri, 18 Sep 2020 09:23:58 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Tom Rix <trix@redhat.com>,
        Russ Weight <russell.h.weight@intel.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgoncalv@redhat.com, hao.wu@intel.com, matthew.gerlach@intel.com,
        yilun.xu@intel.com
Subject: Re: [PATCH v2 1/1] fpga: dfl: afu: harden port enable logic
Message-ID: <20200918012358.GC13851@yilunxu-OptiPlex-7050>
References: <20200917183219.3603-1-russell.h.weight@intel.com>
 <7f181203-c164-4e6e-c710-1096b0aa13b8@redhat.com>
 <20200917213850.GA30570@archbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917213850.GA30570@archbook>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> > >  /**
> > >   * __afu_port_enable - enable a port by clear reset
> > >   * @pdev: port platform device.
> > > @@ -32,7 +35,7 @@
> > >   *
> > >   * The caller needs to hold lock for protection.
> > >   */
> > > -void __afu_port_enable(struct platform_device *pdev)
> > > +int __afu_port_enable(struct platform_device *pdev)
> > >  {
> > >  	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> > >  	void __iomem *base;
> > > @@ -41,7 +44,7 @@ void __afu_port_enable(struct platform_device *pdev)
> > >  	WARN_ON(!pdata->disable_count);
> > >  
> > >  	if (--pdata->disable_count != 0)
> > > -		return;
> > > +		return 0;
> > Is this really a success ? Maybe -EBUSY ?
> Seems like if it's severe enough for a warning you'd probably want to
> return an error.

This code is to handle the port enable/disable request from multiple
users. This is a voting mechanism, the port would not be physically
enabled if there is still an disable vote. The --diable_count != 0 works
for this purpose. So I think it should be OK here since the voting
mechanism is working as expected.

Thanks,
Yilun
