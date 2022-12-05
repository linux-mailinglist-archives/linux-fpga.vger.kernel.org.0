Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7B8642D4B
	for <lists+linux-fpga@lfdr.de>; Mon,  5 Dec 2022 17:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbiLEQkR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 5 Dec 2022 11:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbiLEQjY (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 5 Dec 2022 11:39:24 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194E9B1EC;
        Mon,  5 Dec 2022 08:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670258290; x=1701794290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=j9+STK0zi4B2lTIuMwhQZtGCC1nrqQHxIDObNGJfAso=;
  b=NJqRl810z2WCNxXqNSoxRKGKkfwPOMbP/NSI8G1eeF+dtsDWwDtatG+C
   xlQ67/TO/W7OZ9Jd/Ok4D+kkQXk/24GIJlTTKh4zX3E3sN01Hg9RgDlns
   pqgO8Di6Hrx6RSDcVUjejOKasmjxztuPedHHEBP3wWMXQ7I98O6zOC7IV
   Mapt0PWfbBfbpZTJy5lzlep+JQWZH1ELPsTavRRzCaqTNSbVlpI+EHg4m
   ubKOXTybsL/krnkRVWYJg/AScMinTt5asuSaZb3/5A6iQCzqK3eDvSkcI
   Nl1J6RY5H8VjJ2OpVS4xAA7jdRPLlbAlq+Gfx8ICGTnm+jHInZ3g8d48O
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="402670055"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="402670055"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 08:38:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="714459365"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="714459365"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga004.fm.intel.com with ESMTP; 05 Dec 2022 08:38:07 -0800
Date:   Tue, 6 Dec 2022 00:28:22 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-fpga@vger.kernel.org,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Marco Pagani <marpagan@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 7/9] mfd: intel-m10-bmc: Add PMCI driver
Message-ID: <Y44cJjKZvpL+SUHb@yilunxu-OptiPlex-7050>
References: <20221202100841.4741-1-ilpo.jarvinen@linux.intel.com>
 <20221202100841.4741-8-ilpo.jarvinen@linux.intel.com>
 <Y4ox5J0junaUYyT7@yilunxu-OptiPlex-7050>
 <855d463e-fb84-1910-f53-58e6b0a633a4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <855d463e-fb84-1910-f53-58e6b0a633a4@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-12-05 at 11:51:15 +0200, Ilpo Järvinen wrote:
> On Sat, 3 Dec 2022, Xu Yilun wrote:
> 
> > On 2022-12-02 at 12:08:39 +0200, Ilpo Järvinen wrote:
> > > +					  void __iomem *base,
> > > +					  struct regmap_config *cfg,
> > > +					  struct lock_class_key *lock_key,
> > > +					  const char *lock_name)
> > > +{
> > > +	struct indirect_ctx *ctx;
> > > +
> > > +	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> > > +	if (!ctx)
> > > +		return NULL;
> > > +
> > > +	ctx->base = base;
> > > +	ctx->dev = dev;
> > > +
> > > +	indirect_bus_clear_cmd(ctx);
> > > +
> > > +	return __devm_regmap_init(dev, &indirect_bus, ctx, cfg, lock_key, lock_name);
> > 
> > Sorry, I just can't remember why don't we just call devm_regmap_init() and
> > get rid of all lock stuff?
> 
> At this point, we're already entered into __-domain though a
> __regmap_lockdep_wrapper(). If I call devm_regmap_init() here, the 
> second call into the wrapper would create another key which doesn't seem 
> right.

I mean could we not define new regmap_init_xxx & __regmap_init_xxx
APIs? Just call devm_regmap_init() when we have prepared the context,
devm_regmap_init() will take care of the lock stuff.

Thanks,
Yilun
