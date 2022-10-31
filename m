Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F21E612E9D
	for <lists+linux-fpga@lfdr.de>; Mon, 31 Oct 2022 02:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJaBZe (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 30 Oct 2022 21:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiJaBZd (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 30 Oct 2022 21:25:33 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C1565FD;
        Sun, 30 Oct 2022 18:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667179533; x=1698715533;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f640Ubf/vnDK3++Ta0iClrJQA/SD0Rx+i4b2hr4OLDs=;
  b=i/vbMTZ7b6Mg7OZ/8GroZAwk/BJzYtHe7/nF3z4ZlmreCKQT0TS9fxWK
   h9uGfaMzeHmSGa4Jl3/gP7K7Gh2//Cbro3bg7hsp7S2PtgCSXiInREriK
   zCD5iH5JVso8p67hnP+BrI3j1S6HMcx7dMGxQ9OHELTA1opcyCQf+DnXY
   EoZR8q2/lxI7Dhb6gKVzTDg5DUqIxPfwc3IDmI+Wb1s1xW0em0ND556qy
   qvXDRVv866rCq/jLYpQbj4Rr63N1zwQj49QivahRbvNRceA0NTwusIwyV
   v8dza5S39Y/z9qapkm/jsE5gGkN6BKTcqQFF/HAxZYdDrNmbRrA/XUfg6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="288509865"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="288509865"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2022 18:25:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="611326587"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="611326587"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga006.jf.intel.com with ESMTP; 30 Oct 2022 18:25:28 -0700
Date:   Mon, 31 Oct 2022 09:16:19 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     matthew.gerlach@linux.intel.com, hao.wu@intel.com,
        russell.h.weight@intel.com, basheer.ahmed.muddebihal@intel.com,
        trix@redhat.com, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net, jirislaby@kernel.org,
        geert+renesas@glider.be, niklas.soderlund+renesas@ragnatech.se,
        macro@orcam.me.uk, johan@kernel.org, lukas@wunner.de,
        ilpo.jarvinen@linux.intel.com, marpagan@redhat.com
Subject: Re: [PATCH v4 3/4] fpga: dfl: add basic support DFHv1
Message-ID: <Y18h4+ESJo+NQnOu@yilunxu-OptiPlex-7050>
References: <20221020212610.697729-1-matthew.gerlach@linux.intel.com>
 <20221020212610.697729-4-matthew.gerlach@linux.intel.com>
 <Y10l3NkIn0gsdVZq@yilunxu-OptiPlex-7050>
 <Y171ZEHpOydtR4dW@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y171ZEHpOydtR4dW@smile.fi.intel.com>
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-10-31 at 00:06:28 +0200, Andy Shevchenko wrote:
> On Sat, Oct 29, 2022 at 09:08:44PM +0800, Xu Yilun wrote:
> > On 2022-10-20 at 14:26:09 -0700, matthew.gerlach@linux.intel.com wrote:
> 
> > >  struct dfl_feature_info {
> > >  	u16 fid;
> > >  	u8 revision;
> > > +	u8 dfh_version;
> > >  	struct resource mmio_res;
> > >  	void __iomem *ioaddr;
> > >  	struct list_head node;
> > >  	unsigned int irq_base;
> > >  	unsigned int nr_irqs;
> > > +	unsigned int param_size;
> > > +	u64 params[];
> > >  };
> 
> ...
> 
> > > +	finfo = kzalloc(sizeof(*finfo) + dfh_psize, GFP_KERNEL);
> 
> 
> This probably may use something from overflow.h.
> 
> > The u64 flexible array in the structure, but seems dfh_get_psize could
> > not garantee 64bit aligned size.
> > 
> > What's the mandatory alignment of param data? If 64bit aligned, bit 33-34
> > of PARAM_HDR should be reserved. If 32bit aligned, finfo:params should be
> > u32[].
> 
> Isn't it guaranteed by the C standard / architecture ABI?

I'm referring to the malloc size of the structure. It reserved dfh_psize
bytes for this u64 array, but there is no garantee dfh_psize should be a
multiple of 8. So there may be memory leak when accessing the last
array element?

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
