Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C838C614309
	for <lists+linux-fpga@lfdr.de>; Tue,  1 Nov 2022 03:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiKACEx (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 31 Oct 2022 22:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiKACEx (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 31 Oct 2022 22:04:53 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DB562C2;
        Mon, 31 Oct 2022 19:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667268291; x=1698804291;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aCt6XUlU98NDB9OobTpbG9jY9vCxrYTtoNS5Y6y/56c=;
  b=ED9tKGUbJdyAu1C3soCbfUJG2tyR6w8Eau5UH2HjYtUU1/BTLKM6uboy
   SmF+cfrLY9+bWamJeNYPIrkebDU3M1P5QEwGBq1u9cymfYfWNNowhcQ55
   wZPIfotcjHK3OmbVnPiAh7tWa55M6WRGhvu6mF1JmMKVTt1HPTDNUKzIY
   dlZkKj0bjkXPAlFSw1/eeqQ0VZhgLbJ5MgJbx5S1zyPw+dEDLZhPbycmq
   w+ZxLCL8I8RZ8WmjtV1gXCElc8q87Nxa9bM69X9R4bn0W3JOIIM3kjbiu
   hdVhtfYMw0qhIf5ywLVyPT3Ik44hTqlERTC3eiybf/UREFH4WJaFhE/dY
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="310751480"
X-IronPort-AV: E=Sophos;i="5.95,229,1661842800"; 
   d="scan'208";a="310751480"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 19:04:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="776349365"
X-IronPort-AV: E=Sophos;i="5.95,229,1661842800"; 
   d="scan'208";a="776349365"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga001.fm.intel.com with ESMTP; 31 Oct 2022 19:04:23 -0700
Date:   Tue, 1 Nov 2022 09:55:13 +0800
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
Message-ID: <Y2B8gRnnkDQkdDeq@yilunxu-OptiPlex-7050>
References: <20221020212610.697729-1-matthew.gerlach@linux.intel.com>
 <20221020212610.697729-4-matthew.gerlach@linux.intel.com>
 <Y10l3NkIn0gsdVZq@yilunxu-OptiPlex-7050>
 <Y171ZEHpOydtR4dW@smile.fi.intel.com>
 <Y18h4+ESJo+NQnOu@yilunxu-OptiPlex-7050>
 <Y1/q/PDPNq7pNtda@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1/q/PDPNq7pNtda@smile.fi.intel.com>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-10-31 at 17:34:20 +0200, Andy Shevchenko wrote:
> On Mon, Oct 31, 2022 at 09:16:19AM +0800, Xu Yilun wrote:
> > On 2022-10-31 at 00:06:28 +0200, Andy Shevchenko wrote:
> > > On Sat, Oct 29, 2022 at 09:08:44PM +0800, Xu Yilun wrote:
> > > > On 2022-10-20 at 14:26:09 -0700, matthew.gerlach@linux.intel.com wrote:
> > > 
> > > > >  struct dfl_feature_info {
> > > > >  	u16 fid;
> > > > >  	u8 revision;
> > > > > +	u8 dfh_version;
> > > > >  	struct resource mmio_res;
> > > > >  	void __iomem *ioaddr;
> > > > >  	struct list_head node;
> > > > >  	unsigned int irq_base;
> > > > >  	unsigned int nr_irqs;
> > > > > +	unsigned int param_size;
> > > > > +	u64 params[];
> > > > >  };
> > > 
> > > ...
> > > 
> > > > > +	finfo = kzalloc(sizeof(*finfo) + dfh_psize, GFP_KERNEL);
> > > 
> > > 
> > > This probably may use something from overflow.h.
> > > 
> > > > The u64 flexible array in the structure, but seems dfh_get_psize could
> > > > not garantee 64bit aligned size.
> > > > 
> > > > What's the mandatory alignment of param data? If 64bit aligned, bit 33-34
> > > > of PARAM_HDR should be reserved. If 32bit aligned, finfo:params should be
> > > > u32[].
> > > 
> > > Isn't it guaranteed by the C standard / architecture ABI?
> > 
> > I'm referring to the malloc size of the structure. It reserved dfh_psize
> > bytes for this u64 array, but there is no garantee dfh_psize should be a
> > multiple of 8. So there may be memory leak when accessing the last
> > array element?
> 
> Have you looked at macros in the overflow.h? Would the use of it solve your
> concern?

Yes, struct_size() or array_size() specifies the element size & count,
which solve the concern at the root.

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
