Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A39228274
	for <lists+linux-fpga@lfdr.de>; Tue, 21 Jul 2020 16:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbgGUOma (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 21 Jul 2020 10:42:30 -0400
Received: from mga04.intel.com ([192.55.52.120]:32252 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728683AbgGUOma (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 21 Jul 2020 10:42:30 -0400
IronPort-SDR: f7l48v/t0vRGC26k/oAYB/GQUGHeruOEAg7FClHtsrajoc1wCjLPk4WeS2QHkt2KshV+0I5USq
 Wk6GJRt+G1OA==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="147639368"
X-IronPort-AV: E=Sophos;i="5.75,379,1589266800"; 
   d="scan'208";a="147639368"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 07:42:29 -0700
IronPort-SDR: VVg7SHcLurUlkmvMCGEi8FybhB5mQgwZofa3BGh4QK5aFh2ggw1dsxxRk89g/wOTq3FgDSoMUd
 18iFfS4TwrTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,379,1589266800"; 
   d="scan'208";a="462096473"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga005.jf.intel.com with ESMTP; 21 Jul 2020 07:42:26 -0700
Date:   Tue, 21 Jul 2020 22:39:18 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgoncalv@redhat.com,
        Wu Hao <hao.wu@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH 2/2] fpga: dfl: create a dfl bus type to support DFL
  devices
Message-ID: <20200721143918.GA20733@yilunxu-OptiPlex-7050>
References: <1594791498-14495-1-git-send-email-yilun.xu@intel.com>
 <1594791498-14495-3-git-send-email-yilun.xu@intel.com>
 <0776e674-d94d-da97-342a-b043c5dc24f3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0776e674-d94d-da97-342a-b043c5dc24f3@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

> > +static int dfl_devs_init(struct platform_device *pdev)
> > +{
> > +	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
> > +	struct dfl_feature *feature;
> > +	struct dfl_device *dfl_dev;
> > +
> > +	dfl_fpga_dev_for_each_feature(pdata, feature) {
> > +		if (feature->ioaddr || feature->priv)
> > +			continue;
> > +
> > +		dfl_dev = dfl_dev_add(pdata, feature);
> > +		if (IS_ERR(dfl_dev)) {
> > +			dfl_devs_uinit(pdata);
> > +			return PTR_ERR(dfl_dev);
> What happens to dfl_dev's that were successful. Need a clean up ?

Yes, the already added dfl devices under this pdev will be unregistered
in function dfl_devs_uinit()

> > +		}
> > +
> > +		feature->priv = dfl_dev;
> > +	}
> > +
> > +	return 0;
> > +}
