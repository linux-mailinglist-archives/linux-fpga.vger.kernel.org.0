Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0302B4FB17B
	for <lists+linux-fpga@lfdr.de>; Mon, 11 Apr 2022 03:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238883AbiDKBqc (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 10 Apr 2022 21:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbiDKBqb (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 10 Apr 2022 21:46:31 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EFBBC88;
        Sun, 10 Apr 2022 18:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649641459; x=1681177459;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MD7Q42ZDoqyehGhEpCAOlWo7PUck1hpDtCMUuvaoFGc=;
  b=MoagKVTstWYjEzC/Lam5BlWX7zH5eFMaz6egQ/MlGQvXOt5FfSfqBtsV
   7toVcuHWGvAMlIsI6xnzTGdJAVFh2XWF7iPv46yimEedJeDG4pHjy4fYY
   0khK9IB71d+hPcCy8zgA6GSqd9ylHLOtssNugJhnPzkCO/cbQy95nNH3M
   dawIIUJ+WPT0OE4VdvHjclrjLi5/DsTKwYYXo5eEFxunkghc0He5QtGqj
   TpAUPNLfhh50FhFgr4H3gjy9PJoEpVx1nDDyuq9GveeIarlViXpm+ezhs
   B3G/NoxIYHTh0wuaMBLJLpx2BA4Al5lEOinNOPU88HOEH/rF28waXZwWg
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="241946643"
X-IronPort-AV: E=Sophos;i="5.90,250,1643702400"; 
   d="scan'208";a="241946643"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2022 18:44:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,250,1643702400"; 
   d="scan'208";a="571899959"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga008.jf.intel.com with ESMTP; 10 Apr 2022 18:44:16 -0700
Date:   Mon, 11 Apr 2022 09:36:50 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        conor.dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, system@metrotek.ru,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v9 1/3] fpga: fpga-mgr: support bitstream offset in image
  buffer
Message-ID: <20220411013650.GA271264@yilunxu-OptiPlex-7050>
References: <20220407133658.15699-1-i.bornyakov@metrotek.ru>
 <20220407133658.15699-2-i.bornyakov@metrotek.ru>
 <20220409050423.GA265355@yilunxu-OptiPlex-7050>
 <20220409123851.tcjflctnuurag2yb@x260>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409123851.tcjflctnuurag2yb@x260>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, Apr 09, 2022 at 03:38:51PM +0300, Ivan Bornyakov wrote:
> On Sat, Apr 09, 2022 at 01:04:23PM +0800, Xu Yilun wrote:
> > On Thu, Apr 07, 2022 at 04:36:56PM +0300, Ivan Bornyakov wrote:
> > > 
> > > ... snip ...
> > > 
> > > @@ -148,12 +149,10 @@ static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
> > >  	int ret;
> > >  
> > >  	mgr->state = FPGA_MGR_STATE_WRITE_INIT;
> > > -	if (!mgr->mops->initial_header_size)
> > > -		ret = fpga_mgr_write_init(mgr, info, NULL, 0);
> > > -	else
> > > -		ret = fpga_mgr_write_init(
> > > -		    mgr, info, buf, min(mgr->mops->initial_header_size, count));
> > > +	if (mgr->mops->initial_header_size)
> > > +		count = min(mgr->mops->initial_header_size, count);
> > >  
> > > +	ret = fpga_mgr_write_init(mgr, info, buf, count);
> > 
> > Here we pass the whole buffer for write_init(). Maybe it works for mapped buf,
> > but still doesn't work for sg buf.
> > 
> > It is also inefficient if we change to map and copy all sg buffers just for
> > write_init().
> > 
> > We could discuss on the solution.
> > 
> > My quick mind is we introduce an optional fpga_manager_ops.parse_header()
> > callback, and a header_size (dynamic header size) field in
> > fpga_image_info. FPGA core starts with mapping a buf of initial_header_size
> > for parse_header(), let the drivers decide the dynamic header_size.
> > 
> > The parse_header() could be called several times with updated dynamic
> > header_size, if drivers doesn't get enough buffer for final decision and
> > return -EAGAIN.
> > 
> > Then write_init() be called with the final dynamic header size.
> > 
> > For mapped buffer, just passing the whole buffer for write_init() is
> > fine.
> > 
> 
> Ok, that's sounds reasonable. Should we pass PAGE_SIZE of a buffer to
> the parse_header() if initial_header_size is not set? The other option

I think it is not necessary, no initial_header_size means no need to
parse image header.

> would be to make initial_header_size to be mandatory for usage of
> parse_header().

That's a good idea. If parse_header() is provided, initial_header_size
is mandatory.

Thanks,
Yilun

> 
> > > 
> > > ... snip ...
> > > 
> > > @@ -98,6 +101,8 @@ struct fpga_image_info {
> > >  	struct sg_table *sgt;
> > >  	const char *buf;
> > >  	size_t count;
> > > +	size_t bitstream_start;
> > 
> > How about we name it header_size?
> > 
> > > +	size_t bitstream_size;
> > 
> > And how about data_size?
> > 
> 
> Sure, I don't mind.
