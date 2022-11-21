Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE2A632402
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Nov 2022 14:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbiKUNjJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 21 Nov 2022 08:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbiKUNit (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 21 Nov 2022 08:38:49 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7B7C4C32;
        Mon, 21 Nov 2022 05:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669037889; x=1700573889;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=ylVbYkiOTQvprUwURTQdezD7NOZbrlKQRPgwOs4+59s=;
  b=MNV+rDaF8KYViYYFH5ir415KWylG/IW0psIOjUqVcuORMHEVyHYqJZa5
   qeUn4oWFg4rQorj5UOQ8QThefMk4Lao9c/fnTjqPlxbhW4y1M8Rum3i/r
   ZNPd6SFYVxtJw8oOnG+mpvYLR8iWIdHioT2yOgOAheOdD2E+pxQJojqjK
   1E40U4t7qGwFYa2M0Ze+lkt3QEf2rTQLxa2GQ/TGYP3fHQtumfAApYbg0
   9cHwfjbxb8B3Q4I/YhClp1zYiGBddPUojjkkaV3ecfTK2K6ff7ZVNtJYo
   BaAAQx1Bib/22zcuG79Zerqaz60FdmY6sEBszq6gcDv7ZSCLo0lK0VsIf
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="399844548"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="399844548"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 05:37:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="746912600"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="746912600"
Received: from ebarboza-mobl1.amr.corp.intel.com ([10.251.209.16])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 05:37:44 -0800
Date:   Mon, 21 Nov 2022 15:37:40 +0200 (EET)
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
In-Reply-To: <Y3eOzOmTeTKBoPrd@sirena.org.uk>
Message-ID: <a97ce076-4ca6-5f1b-eba4-4068dcb64b3d@linux.intel.com>
References: <20221117120515.37807-1-ilpo.jarvinen@linux.intel.com> <20221117120515.37807-8-ilpo.jarvinen@linux.intel.com> <Y3Y4vWr/CGbaH0HQ@sirena.org.uk> <a089f1a0-c0f4-e1a2-d084-fd83e28e7e33@linux.intel.com> <Y3ZTSSLUqHil4dfl@sirena.org.uk>
 <a82565d-c282-7ace-e759-6514c29cca1c@linux.intel.com> <Y3eOzOmTeTKBoPrd@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1434080405-1668781634=:3952"
Content-ID: <7913b34c-39a7-898d-2570-5d84cc798888@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1434080405-1668781634=:3952
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <b178e928-d026-5673-a03-df7fa0e0c419@linux.intel.com>

On Fri, 18 Nov 2022, Mark Brown wrote:

> On Fri, Nov 18, 2022 at 02:49:45PM +0200, Ilpo Järvinen wrote:
> > On Thu, 17 Nov 2022, Mark Brown wrote:
> 
> > > No, what I'm objecting to there is pretty much the same thing I'm
> > > saying here - this doesn't seem like it's a particularly generic
> > > implementation and I'm really not clear that there'd be anything
> > > meaningful left by the time the implementation assumptions are
> > > removed.
> 
> > That's probably because it sounds to me you're trying to extend its 
> > genericness beyond the domain where it's generic. That is, you're looking 
> > for genericness outside of IPs (that have their own driver each) in Intel 
> > FPGA domain.
> 
> This just says it's adding "indirect regmap support" - there's
> nothing here saying that it's some Intel specific thing but it's
> quite specific to some IPs. 

Yeah, but it's that way mainly because of your earlier comments. :-)

I tried to make it more "generic" to the extent possible because of your 
concern related to genericness and I therefore intentionally put the Intel 
specific numbers into the other change.

Previously you were against saying it clearly that it's Intel FPGA 
specific when Matthew proposed changing the name to not sound something 
too generic. If you're ok with that now, I'm happy to make such change.

> Perhaps you have some name for this
> interface?  You're only adding one user here which isn't helping
> make the case that this is something generic.
>
> > Please also keep in mind that we're talking about an FPGA device here, a 
> > device that is capable of implementing other devices that fall under 
> > various drivers/xx/. Obviously each would have a driver of their own so
> > there is no as strong only single device/driver mapping here as you might 
> > be thinking.
> 
> I can't tell what you're trying to say here.  Are you saying that
> this is somehow baked into some FPGA design so that it's memory
> mapped with only a few registers showing to the rest of the
> system rather than just having a substantial memory mapped
> window like is typically used for FPGAs, but someohow this
> register window stuff is implemented in the soft IP so people are
> just throwng vaugely similar interfaces into a random host mapped
> register layout?

What I tried to say the users are not expected to be nicely confined into 
drivers/mfd/ (and a single driver in there).

You didn't answer at all my question about where to place the code?
I'm repeating it with the context below since you cut it off:


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


-- 
 i.
--8323329-1434080405-1668781634=:3952--
