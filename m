Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C8E627494
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Nov 2022 03:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbiKNC1l (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 13 Nov 2022 21:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbiKNC1l (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 13 Nov 2022 21:27:41 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8396D5F5B;
        Sun, 13 Nov 2022 18:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668392860; x=1699928860;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=wj/jRasR/wJH8jBtPhs0HRU9RSSIACFbc8PFc8CwNPE=;
  b=STZem6L/BF/Q/7EnLF62Z/wt7zTNxXuDOiNXV30baGbaEHxxoIUM0XFZ
   L9Ho9AlsGS3SEVNVqhFii1tAz1qto1/epzWr59wvgahISWU61wJBiMXj+
   3Mm+7WOCUFDMZfRxY8VFfrz0YxZsOxaCZ88o1q1mEyIk+EjZ9c0TL5J4t
   oEV+bpWVaX69Rczd3i/J1dH9jUJaSQddO485DTUSOuO4vBQYO8/45ObkO
   j9n3vEMBTMLF9Vwmqu+J4maonaMHIvBdn03s6dwel9spKvTYJy831yTN5
   hn/Jx4yubfJjIxIlYd//ohR7ksVIqWRLu84Ax+Xt0HBd/Je9LKBJoAewy
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="310574979"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="310574979"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2022 18:27:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="669461886"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="669461886"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga008.jf.intel.com with ESMTP; 13 Nov 2022 18:27:37 -0800
Date:   Mon, 14 Nov 2022 10:18:14 +0800
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
Subject: Re: [PATCH 10/12] mfd: intel-m10-bmc: Add PMCI driver
Message-ID: <Y3GlZkqhh5SbQ33Y@yilunxu-OptiPlex-7050>
References: <20221108144305.45424-1-ilpo.jarvinen@linux.intel.com>
 <20221108144305.45424-11-ilpo.jarvinen@linux.intel.com>
 <Y24eF6OsRTFGcB/F@yilunxu-OptiPlex-7050>
 <ce691f6f-4519-5589-4a96-58f17476ee@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce691f6f-4519-5589-4a96-58f17476ee@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-11-11 at 15:16:42 +0200, Ilpo Järvinen wrote:
> On Fri, 11 Nov 2022, Xu Yilun wrote:
> > On 2022-11-08 at 16:43:03 +0200, Ilpo Järvinen wrote:
> 
> > > +static int pmci_probe(struct dfl_device *ddev)
> > > +{
> > > +	struct device *dev = &ddev->dev;
> > > +	struct pmci_device *pmci;
> > > +
> > > +	pmci = devm_kzalloc(dev, sizeof(*pmci), GFP_KERNEL);
> > > +	if (!pmci)
> > > +		return -ENOMEM;
> > > +
> > > +	pmci->m10bmc.dev = dev;
> > > +	pmci->dev = dev;
> > 
> > I don't see its usage.
> 
> It's used by dev_err() in patch 11/12.

I see. But is m10bmc.dev already good enough for the usage?

Thanks,
Yilun
