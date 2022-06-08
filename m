Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D268542E0B
	for <lists+linux-fpga@lfdr.de>; Wed,  8 Jun 2022 12:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236690AbiFHKjh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 8 Jun 2022 06:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238486AbiFHKjX (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 8 Jun 2022 06:39:23 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0F2311002;
        Wed,  8 Jun 2022 03:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654684735; x=1686220735;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mIAf68904yK5TA4/7pDwIQkOjWrI2K2wTX2UlDAKuYA=;
  b=PWdJQ8+DykFHI59p0yrVREDrRS93BXWX8m3P3hyStwWhnTisK+c+eTr2
   2EbsKynlvh+Bc8j+SeM9DwR3imN6HPcKuYxiUn1BJJTEepXA7UKLS+hVb
   hwiM+jhJ3DrCqpgx+vdeENNdM1OEcCrmRzpDDeMkDZjiungCSatoS080S
   mCH+5hZCxDyZDmt7cN8YzOnM93UQsjC6v02OuPVZr8t1QyKrSEBLknpr5
   kkYglqp0Achk3ciIL1BuVfJ4iBDcdJhDARcbBO0oYpDSUQlqCkFWyPlC1
   DNHd6fbwFCTGhmUYcIAXkCeSsx8mV2ViRfMMIHyYm4MSU9i2wzX49pFL9
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="277690947"
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="277690947"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 03:38:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="636741028"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by fmsmga008.fm.intel.com with ESMTP; 08 Jun 2022 03:38:52 -0700
Date:   Wed, 8 Jun 2022 18:30:58 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     tien.sung.ang@intel.com
Cc:     christophe.jaillet@wanadoo.fr, hao.wu@intel.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdf@kernel.org, trix@redhat.com
Subject: Re: [PATCH v2] fpga: altera-cvp: Truncated bitstream error support
Message-ID: <20220608103058.GG481269@yilunxu-OptiPlex-7050>
References: <20220603094911.GA238410@yilunxu-OptiPlex-7050>
 <20220607055530.3755617-1-tien.sung.ang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607055530.3755617-1-tien.sung.ang@intel.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jun 07, 2022 at 01:55:30PM +0800, tien.sung.ang@intel.com wrote:
> > But you are adding the logic in altera_cvp_write() to keep the
> > correctness. What's the difference adding it somewhere else? And as I
> > can see, preventing the writing at the very beginning is a much cleaner
> > way.
> 
> Though without doubt, your solution is doable, I have a 
> discussion with the Intel architect and they insisted that
> the device driver must not make such a decision. The decision to 
> drop or accept a transfer is up to the firmware. The firmware

Why dropping or accepting is forbidden, but padding is allowed? If the
decision is no operation to the data, then padding should also be
forbidden.

> insisted that the buffer be padded with whatever value. They

If I understand right, the 2 decisions are conflicted. On one hand,
the driver should not care about the data. On another hand, the
driver should still care about the data for some rule.

So please firstly reach your agreement before making patches.

> desire the transfer protocol to be obeyed to ensure, that 
> there is no hard dependencies on the device driver if they
> do one day change the 4kbytes to some other smaller value.
> 
> > > > If the image size is larger than 1 Page but is not aligned to 1 Page,
> > > > will the reprogramming still fail?
> > > Yes, the reconfiguration will fail. The above tear-down  is to prevent
> > > that CvP Hardware/firmware in the FPGA from entering into a dead-lock.
> 
> > So if the image size is not aligned to 1 Page, the reprogram should fail
> > anyway, is it? Then I really recommend you fail the reprogramming at the
> > very beginning.
> 
> Same reasoning as above. We don't want the driver to make this
> decision.
> 
> > > >> +		altera_cvp_send_block(conf, (const u32 *)conf->send_buf,
> > > >> +				      conf->priv->block_size);
> > > 
> > > >If the len equals block_size, is the copy still needed?
> > > Actually, not required. But to maintain a simple design, we use
> > > a common flow for all so you can skip the check.
> 
> > I don't think so. We should make the code reasonable. Blindly copy the
> > whole buffer impacts all normal cases, and makes people confused. The
> > code seems shorter now, but not simpler, it takes people more time to
> > figure out why.
> 
> Yes, it could look confusing to other programmers. And, yes, the 
> padding doesn't matter. Let me relook into this. As the driver is 
> already re-tested by the silicon validatioin. 
> I want to avoid making any change as it
> would meant another couple of weeks of re-testing. 
> Can this be accepted as it is?

Sorry, I can't. Some clarification is needed.

Thanks,
Yilun
