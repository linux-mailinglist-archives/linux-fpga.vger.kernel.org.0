Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C94562F558
	for <lists+linux-fpga@lfdr.de>; Fri, 18 Nov 2022 13:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbiKRMt6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 18 Nov 2022 07:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiKRMtz (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 18 Nov 2022 07:49:55 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1228531DDF;
        Fri, 18 Nov 2022 04:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668775794; x=1700311794;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=101JCNOmfjFNZE6Vdf4PLvdcCrwB9ugWNwgQuAeA6CU=;
  b=R3fiueQ/mVLgWtzQuQl7IA5HABt5GnNms2TuH/FPwgWk1V6a2DOP6cC2
   L23KW+pwTlRy8XmiOV8b10pH5ZXJvaD2Chr6sLGsppI2g4892+Tqs3Piv
   FfCGki5+Zx4du1tW+PjZHQsp7KsDERMVbS8BRnI4QHVJUtjmGsE7TGk/t
   77vGLfUI47bqm307E0+GMV6lErZ6c28ctjOIsmFuocNvDL9jCtR2tTKzu
   VwzWAG2qutBTCbhy8nDrEvRZ4C04KSjcfpmtVc5Uhof+4EXAboP+nki4G
   en9aZlJKG5comgYjv9QiUlghN7cQHZSbNW8MTl49nWH4uA+JLbkriI680
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="300664445"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="300664445"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 04:49:53 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="640201003"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="640201003"
Received: from amulyuko-mobl1.ccr.corp.intel.com ([10.252.35.83])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 04:49:49 -0800
Date:   Fri, 18 Nov 2022 14:49:45 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
cc:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Marco Pagani <marpagan@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 07/11] regmap: indirect: Add indirect regmap support
In-Reply-To: <Y3ZTSSLUqHil4dfl@sirena.org.uk>
Message-ID: <a82565d-c282-7ace-e759-6514c29cca1c@linux.intel.com>
References: <20221117120515.37807-1-ilpo.jarvinen@linux.intel.com> <20221117120515.37807-8-ilpo.jarvinen@linux.intel.com> <Y3Y4vWr/CGbaH0HQ@sirena.org.uk> <a089f1a0-c0f4-e1a2-d084-fd83e28e7e33@linux.intel.com> <Y3ZTSSLUqHil4dfl@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1759585579-1668700911=:1636"
Content-ID: <7a7d1d-cd7f-846d-9aac-e6a5aea7cfd3@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1759585579-1668700911=:1636
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <465e8cc8-4c79-132c-3198-41d33e1417b9@linux.intel.com>

On Thu, 17 Nov 2022, Mark Brown wrote:

> On Thu, Nov 17, 2022 at 04:35:23PM +0200, Ilpo Järvinen wrote:
> > On Thu, 17 Nov 2022, Mark Brown wrote:
> > > On Thu, Nov 17, 2022 at 02:05:11PM +0200, Ilpo Järvinen wrote:

> > > > +	ret = readl_poll_timeout(ctx->base + ctx->indirect_cfg->ack_offset, ack,
> > > > +				 (ack & ctx->indirect_cfg->ack_mask) == ctx->indirect_cfg->ack_mask,
> > > > +				 ctx->indirect_cfg->sleep_us, ctx->indirect_cfg->timeout_us);
> 
> > > This all looks very specific to one particular implementation,
> > > requiring a particular set of memory mapped registers and
> > > operations - things like the initial read of the command for
> > > example. It's not clear to me how much reuse this is likely to
> > > see outside of the one driver you're trying to add - if you want
> > > to implement something device specific you can just provide
> > > the custom operations in the device's regmap configuration rather
> > > than having to provide a bus.  Why add a bus?
> 
> > The point of not doing it in a particular driver is that the users will 
> > be spread around more than into a single driver. This is a generic 
> > mechanism for accessing registers of IPs on Intel FPGA. The point being 
> > that IPs can use this common mechanism rather than each coming up their 
> > own way.
> 
> You're saying that this is generic but it's really not looking
> very generic at all, like I say there's a bunch of assumptions in
> the code that look entirely specific to your implementation here.
> Any abstraction and reusability seems extremely unclear, I'm not
> seeing what this is doing that is diffrent to the driver using
> this providing it's own register read and write operations.
>
> > Mark Brown objected earlier naming it something related to Intel FPGAs [1]
> > but I certainly know it still fixes the operations like you note even if 
> > the offsets and values are now "customizable" (they weren't in the 
> > earliest versions of this patch).
> 
> > [1] https://lore.kernel.org/all/YqB9O8HhZV2tXo8g@sirena.org.uk/T/#m75d4abdfd00f05866d837246ddc357a8af53cf99
> 
> No, what I'm objecting to there is pretty much the same thing I'm
> saying here - this doesn't seem like it's a particularly generic
> implementation and I'm really not clear that there'd be anything
> meaningful left by the time the implementation assumptions are
> removed.

That's probably because it sounds to me you're trying to extend its 
genericness beyond the domain where it's generic. That is, you're looking 
for genericness outside of IPs (that have their own driver each) in Intel 
FPGA domain.

Whether that is "generic" enough to reside in drivers/base/regmap can
of course be debated but lets say I put it into drivers/mfd/ along with 
the code currently using it. By doing that, we'll postpone this discussion 
to the point when the first driver using it outside of drivers/mfd/ comes 
by. At that point, having the indirect code in drivers/mfd/ is shown to 
be a wrong choice.

It's of course nothing that couldn't be fixed by patches moving the code 
around to some more preferred location. And that location likely turns out 
to be drivers/base/regmap, no? Or do you have a better place for it in 
that case?

Please also keep in mind that we're talking about an FPGA device here, a 
device that is capable of implementing other devices that fall under 
various drivers/xx/. Obviously each would have a driver of their own so
there is no as strong only single device/driver mapping here as you might 
be thinking.


-- 
 i.
--8323329-1759585579-1668700911=:1636--
